PLUGIN.name = "WeaponDegrade"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Weapon use degrades overtime without proper maintenance."

nut.config.add("weaponDegrade_weaponJamMultiplier", 15, "The multiplier for how rare a weapon jam will occur. 10-20 is a good starting point.", nil, {data = {min = 1, max = 50}, category = "WeaponDegrade"})

weaponDegrade = weaponDegrade or {}
weaponDegrade.defaultJamMultiplier = 15

if SERVER then 
    function PLUGIN:EntityFireBullets(attackingEnt, bulletData)
        if attackingEnt == nil or !attackingEnt:IsPlayer() then return end
        local currentWeapon = attackingEnt:GetActiveWeapon()
        if currentWeapon == nil then return end

        if currentWeapon.isJammed ~= nil and currentWeapon.isJammed then 
            currentWeapon:SetClip1(0) 
            attackingEnt:notify("You must clean your weapon before use.")
            return false 
        end


        local defaultDegradeCount = currentWeapon:GetMaxClip1() * (nut.config.get("weaponDegrade_jamRarityMultiplier") or weaponDegrade.defaultJamMultiplier)
        currentWeapon.degradeCount = currentWeapon.degradeCount or defaultDegradeCount

        if currentWeapon.degradeCount > 0 and !currentWeapon.isJammed then
            currentWeapon.degradeCount = currentWeapon.degradeCount - 1
        end

        if math.random(1, currentWeapon.degradeCount) == 1 and currentWeapon.degradeCount < (defaultDegradeCount/2) then
            currentWeapon.isJammed = true
            currentWeapon.clipBeforeJam = currentWeapon:Clip1()
            currentWeapon:SetClip1(0)

            attackingEnt:notify("Your weapon is jammed and requires cleaning.")
            attackingEnt:Say("/me squeezes the trigger and jams their weapon.")
            return false
        end
        
        return true
    end
end

nut.command.add("cleanweapon", {
    adminOnly = false,
    onRun = function(targetPly, arguments)
        if targetPly == nil then return end
        local currentWeapon = targetPly:GetActiveWeapon()
        if currentWeapon == nil then return end

        targetPly:EmitSound("weapons/357/357_reload3.wav", 50, 100)
        targetPly:setAction("Cleaning weapon...", 2, function()
            if currentWeapon.isJammed then
                currentWeapon:SetClip1(currentWeapon.clipBeforeJam or 0)
                currentWeapon.isJammed = false
            end
            currentWeapon.degradeCount = currentWeapon:GetMaxClip1() * (nut.config.get("weaponDegrade_jamRarityMultiplier") or weaponDegrade.defaultJamMultiplier)

            targetPly:EmitSound("weapons/357/357_reload4.wav", 50, 100)
            targetPly:Say("/me unjams their weapon.")
        end)
    end
})