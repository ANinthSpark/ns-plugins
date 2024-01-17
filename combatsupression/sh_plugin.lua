PLUGIN.name = "CombatSuppression"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Audio and visual effects when being suppressed during combat."

if SERVER then
    function PLUGIN:EntityFireBullets(attackingEnt, bulletData)
        if attackingEnt == nil or bulletData == nil then return end
        local aimTrace = util.TraceLine( {
            start = attackingEnt:EyePos(),
            endpos = attackingEnt:EyePos() + attackingEnt:EyeAngles():Forward() * 16384,
            filter = attackingEnt
        } )

        local targetedEnts = ents.FindInSphere(aimTrace.HitPos, 128)
        for _indx, target in pairs(targetedEnts) do
            if target ~= nil and target:IsPlayer() then
                netstream.Start(target, "beginSuppressionEffect")
            end
        end
    end
end

if CLIENT then
    netstream.Hook("beginSuppressionEffect", function()
        local ply = LocalPlayer()
        if ply == nil then return end

        ply.isSuppressed = true
        ply.suppressedTime = CurTime()

        timer.Simple(1.5, function()
            ply.isSuppressed = false
        end)
    end)

    function PLUGIN:RenderScreenspaceEffects()
        local ply = LocalPlayer()
        if ply == nil then return end
        
        if !ply.isSuppressed or ply.suppressedTime == nil then return end
        SuppresionLerp = Lerp(CurTime() - ply.suppressedTime, 0.5, 0)

        DrawBokehDOF(SuppresionLerp * 2, 5, 1)
        util.ScreenShake(ply:GetPos(), 0.5, 0.5, 0.5, 128)
    end
end