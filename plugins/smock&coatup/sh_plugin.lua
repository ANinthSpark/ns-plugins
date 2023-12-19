PLUGIN.name = "Smock&CoatUp"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Seamlessly equip smock and coat versions of uniforms."

nut.config.add("smock&CoatUp_allowSmock", true, "If a player can equip smock at any time.", nil, {category = "Smock&CoatUp"})
nut.config.add("smock&CoatUp_allowCoat", true, "If a player can equip a coat at any time.", nil, {category = "Smock&CoatUp"})


nut.command.add("smock", {
    adminOnly = false,
    onRun = function(targetPly, arguments)
        if targetPly == nil then return end
        local targetChar = targetPly:getChar()
        if targetChar == nil then return end

        if !nut.config.get("smock&CoatUp_allowSmock") then targetPly:notify("Applying a smock is currently disabled.") return end
        local currentModel = targetChar:getModel()
        local reversedSmockTable = table.Flip(SCHEMA.smockCompatableModels)

        targetPly:EmitSound("weapons/357/357_spin1.wav", 45, 105)
        targetPly:setAction("Applying smock...", 1.5, function()
            if SCHEMA.smockCompatableModels[currentModel] ~= nil then              
                targetChar:setModel(SCHEMA.smockCompatableModels[currentModel])
                targetPly:Say("/me pulls out a smock and equips it.")
            elseif reversedSmockTable[currentModel] ~= nil then
                targetChar:setModel(reversedSmockTable[currentModel])
                targetPly:Say("/me takes off the smock and stores it.")
            else
                targetPly:notify("This model doesn't support a smock.")
                return
            end

            targetPly:EmitSound("physics/cardboard/cardboard_box_break3.wav", 45, 110)
        end)
    end
})

nut.command.add("coat", {
    adminOnly = false,
    onRun = function(targetPly, arguments)
        if targetPly == nil then return end
        local targetChar = targetPly:getChar()
        if targetChar == nil then return end

        if !nut.config.get("smock&CoatUp_allowCoat") then targetPly:notify("Applying a coat is currently disabled.") return end
        local currentModel = targetChar:getModel()
        local reversedCoatTable = table.Flip(SCHEMA.coatCompatableModels)

        targetPly:EmitSound("weapons/357/357_spin1.wav", 45, 105)
        targetPly:setAction("Applying coat...", 2.5, function()
            if SCHEMA.coatCompatableModels[currentModel] ~= nil then
                targetChar:setModel(SCHEMA.coatCompatableModels[currentModel])
                targetPly:Say("/me pulls out a coat and equips it.")
            elseif reversedCoatTable[currentModel] ~= nil then
                targetChar:setModel(reversedCoatTable[currentModel])
                targetPly:Say("/me takes off the coat and stores it.")
            else
                targetPly:notify("This model doesn't support a coat.")
                return
            end

            targetPly:EmitSound("physics/cardboard/cardboard_box_break3.wav", 45, 110)
        end)
    end
})