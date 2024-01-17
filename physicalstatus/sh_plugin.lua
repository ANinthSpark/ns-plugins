PLUGIN.name = "PhysicalStatus"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Display the physical status of characters."

nut.config.add("physicalStatus_maxFootsteps", 1000, "How many footsteps till the player is considered degraded and filthy.", nil, {data = {min = 100, max = 50000}, category = "PhysicalStatus"})

physicalStatus = physicalStatus or {}
physicalStatus.defaultDegradeNumber = 500


PLUGIN.statusList = {
    "fresh and spoteless",
    "alright and clean",
    "worn and dirty",
    "degraded and filthy"
}

PLUGIN.statusColors = {
    Color(104, 207, 81),
    Color(235, 237, 81),
    Color(209, 119, 23),
    Color(173, 24, 24)
}

PLUGIN.statusDegradeTypes = {
    [MAT_CONCRETE] = 2,
    [MAT_WOOD] = 2,
    [MAT_SAND] = 4,
    [MAT_SNOW] = 4,
    [MAT_DIRT] = 4,
    [MAT_FOLIAGE] = 4,
    [MAT_GRASS] = 4,
    [MAT_FLESH] = 6
}

function PLUGIN:DrawCharInfo(ply, char, info)
    if ply == nil then return end

    local charStatus = ply:GetNWInt("charPhysicalStatus") or 1
    if self.statusList[charStatus] == nil or self.statusColors[charStatus] == nil then return end
    
    info[#info + 1] = {"Appears to be " ..self.statusList[charStatus], self.statusColors[charStatus]}
end

if SERVER then 
    function PLUGIN:PlayerFootstep(ply, pos)
        local plyChar = ply:getChar()
        if plyChar == nil then return end
        local maxFootsteps_Config = nut.config.get("physicalStatus_maxFootsteps")

        if ply:GetNWInt("charPhysicalStatus") == nil then
            ply:SetNWInt("charPhysicalStatus", 1)
        end
        plyChar.physicalDegradeCount = plyChar.physicalDegradeCount or (maxFootsteps_Config or physicalStatus.defaultDegradeNumber)


        local groundTrace = util.TraceLine( {
            start = pos,
            endpos = pos - Vector(0, 0, 30),
            filter = ply
        } )
        if groundTrace.MatType == nil then return end

        if plyChar.physicalDegradeCount <= 0 then 
            if ply.isNotifiedAboutStatus then return end

            ply:notify("Your clothing and equipment require cleaning.")
            ply.isNotifiedAboutStatus = true
            return
        end

        local degradeSurfaceNumber = 1
        if table.HasValue(self.statusDegradeTypes, groundTrace.MatType) then degradeSurfaceNumber = self.statusDegradeTypes[groundTrace.MatType] end
        plyChar.physicalDegradeCount = plyChar.physicalDegradeCount - degradeSurfaceNumber --self.statusDegradeTypes[groundTrace.MatType] or 1

        local charStatus = ply:GetNWInt("charPhysicalStatus")
        if plyChar.physicalDegradeCount < math.Round(maxFootsteps_Config * (1.0 - 0.25 * ply:GetNWInt("charPhysicalStatus"))) and charStatus < #self.statusList then
            ply:SetNWInt("charPhysicalStatus", charStatus + 1)
            ply:notify("Your clothing and equipment are accumulating dirt.")
        end
    end
end

nut.command.add("cleanself", {
    adminOnly = false,
    onRun = function(targetPly, arguments)
        if targetPly == nil then return end
        targetChar = targetPly:getChar()
        if targetChar == nil then return end

        targetPly:EmitSound("physics/wood/wood_strain2.wav", 50, 100)
        targetPly:setAction("Cleaning self...", 2, function()
            targetChar.physicalDegradeCount = nut.config.get("physicalStatus_maxFootsteps") or physicalStatus.defaultDegradeNumber
            targetPly:SetNWInt("charPhysicalStatus", 1)
        end)
    end
})