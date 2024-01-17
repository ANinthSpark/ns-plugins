PLUGIN.name = "WeaponDisplay"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Display equipped and holstered primary weapons on characters backs."

if CLIENT then
    validHoldTypeList = validHoldTypeList or {}
    validHoldTypeList = {
        ["smg"] = true,
        ["ar2"] = true,
        ["shotgun"] = true, 
        ["rpg"] = true,
        ["crossbow"] = true
    }

    function PLUGIN:PostPlayerDraw(ply)
        for _indx, targetPly in pairs(player.GetAll()) do
            if !IsValid(targetPly) or !targetPly:Alive() then return end
            if targetPly == LocalPlayer() and !targetPly:ShouldDrawLocalPlayer() then break end
            
            targetPly.attachedWeapons = targetPly.attachedWeapons or {}

            local weaponBone = targetPly:LookupBone("ValveBiped.Bip01_Spine2")
            local weaponBoneMatrix = targetPly:GetBoneMatrix(weaponBone)
            weaponBoneMatrix:Translate(Vector(0, -4, 0))
            weaponBoneMatrix:Rotate(Angle(345, 185, 0))

            
            for _indx2, item in pairs(targetPly:GetWeapons()) do
                if validHoldTypeList[item:GetHoldType()] and targetPly:GetActiveWeapon():GetClass() ~= item:GetClass() then
                    local weaponProp = ClientsideModel(item:GetModel(), RENDERGROUP_OPAQUE)
                    weaponProp:SetRenderOrigin(weaponBoneMatrix:GetTranslation())
                    weaponProp:SetRenderAngles(weaponBoneMatrix:GetAngles())
                    weaponProp:SetParent(targetPly, weaponBone)
                    weaponProp:DrawModel()

                    table.insert(targetPly.attachedWeapons, weaponProp)
                end
            end
            clearWeaponSet(targetPly)
        end
    end

    function clearWeaponSet(ply)
        if ply == nil then return end
        if ply.attachedWeapons == nil or table.IsEmpty(ply.attachedWeapons) then return end
    
        for _indx, weapon in pairs(ply.attachedWeapons) do
            weapon:Remove()
        end
        table.Empty(ply.attachedWeapons)
    end
end