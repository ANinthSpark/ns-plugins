PLUGIN.name = "AutoRank"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Seamelessly promote, demote and recruit people."

nut.config.add("autoRank_kickedFaction", 1, "Where a player should be placed when kicked out of their faction. ex: Police->Citizens.", nil, {data = {min = 1, max = 100}, category = "AutoRank"})


function PLUGIN:PlayerLoadedChar(client, id)
    if client == nil then return end
    local plyChar = client:getChar()
    if plyChar == nil then return end

    if plyChar:getData("charFullDefaultName") ~= nil then return end
    plyChar:setData("charFullDefaultName", plyChar:getName())
end



function arTransferPlayer(plyChar, factionAbbreviation)
    if plyChar == nil or factionAbbreviation == nil then return end

    if plyChar:getData("rankIndex") == nil or plyChar:getData("rankFaction") == "NONE" then
        plyChar:setData("rankIndex", 1)
    end

    plyChar:setData("rankFaction", factionAbbreviation)
    local newRank = SCHEMA.masterRankTable[plyChar:getData("rankFaction")][plyChar:getData("rankIndex")]

    plyChar:setName(newRank.." "..plyChar:getData("charFullDefaultName"))
end

function arKickoutPlayer(plyChar)
    if plyChar == nil then return end
    local kickedFaction = nut.config.get("autoRank_kickedFaction")

    if plyChar:getData("rankFaction") == "NONE" or plyChar:getFaction() == kickedFaction then return end
    plyChar:setFaction(kickedFaction)

    plyChar:setData("rankIndex", 1)
    plyChar:setData("rankFaction", "NONE")
    
    plyChar:setName(plyChar:getData("charFullDefaultName"))
end


nut.command.add("charpromote", {
    adminOnly = true,
    syntax = "<string target> <number ranks>",
    onRun = function(client, arguments)
        local targetPly = nut.command.findPlayer(client, arguments[1])
        if targetPly == nil or arguments[2] == nil then return end
        local targetChar = targetPly:getChar()
        if targetChar == nil then return end

        local oldRankIndx = targetChar:getData("rankIndex")
        arguments[2] = tonumber(arguments[2])

        
        if oldRankIndx == nil then return end
        if targetChar:getData("rankFaction") == "NONE" then return end

        if arguments[2] < 1 then targetPly:notify("Use a positive or non-zero number.") return end
        if oldRankIndx + arguments[2] > #SCHEMA.masterRankTable[targetChar:getData("rankFaction")] then targetPly:notify("Too high of a promotion. There is no rank for that number.") return end


        local oldRank = SCHEMA.masterRankTable[targetChar:getData("rankFaction")][oldRankIndx]
        local newRank = SCHEMA.masterRankTable[targetChar:getData("rankFaction")][oldRankIndx + arguments[2]]
        local originalName = targetChar:getData("charFullDefaultName")

        targetChar:setData("rankIndex", oldRankIndx+arguments[2])
        targetChar:setName(newRank.." "..originalName)
        targetPly:notify("Congratulations, " ..oldRank.." "..originalName.. "! You have been promoted to " ..newRank or "N/a".. ".")
    end
})

nut.command.add("chardemote", {
    adminOnly = true,
    syntax = "<string target> <number ranks>",
    onRun = function(client, arguments)
        local targetPly = nut.command.findPlayer(client, arguments[1])
        if targetPly == nil or arguments[2] == nil then return end
        local targetChar = targetPly:getChar()
        if targetChar == nil then return end

        local oldRankIndx = targetChar:getData("rankIndex")
        arguments[2] = tonumber(arguments[2])


        if oldRankIndx == nil then return end
        if targetChar:getData("rankFaction") == "NONE" then return end

        if arguments[2] < 1 then targetPly:notify("Use a positive or non-zero number.") return end
        if oldRankIndx - arguments[2] < 1 then targetPly:notify("Too low of a promotion. There is no rank for that number.") return end


        local oldRank = SCHEMA.masterRankTable[targetChar:getData("rankFaction")][oldRankIndx]
        local newRank = SCHEMA.masterRankTable[targetChar:getData("rankFaction")][oldRankIndx - arguments[2]]
        local originalName = targetChar:getData("charFullDefaultName")

        targetChar:setData("rankIndex", oldRankIndx-arguments[2])
        targetChar:setName(newRank.." "..originalName)
        targetPly:notify("Unfortunately, " ..oldRank.." "..originalName.. ". You have been demoted to " ..newRank or "N/a".. ".")
    end
})

nut.command.add("charkickout", {
    adminOnly = true,
    syntax = "<string target>",
    onRun = function(client, arguments)
        local targetPly = nut.command.findPlayer(client, arguments[1])
        if targetPly == nil then return end

        local targetChar = targetPly:getChar()
        if targetChar == nil then return end

        arKickoutPlayer(targetChar)
        targetPly:notify("Unfortunately, " ..targetChar:getName().. ". You have been kicked out.")
    end
})

hook.Add("arTransferPlayer", "arTransferHook", arTransferPlayer)
hook.Add("arKickoutPlayer", "arKickoutHook", arKickoutPlayer)