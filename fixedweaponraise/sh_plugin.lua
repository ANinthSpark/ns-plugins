PLUGIN.name = "FixedWeaponRaise"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Automatically raise weapons while avoiding strange cases."

if SERVER then
    function PLUGIN:PlayerSwitchWeapon(ply, _oldWeapon, newWeapon)
        if ply == nil or newWeapon == nil then return end
        if nut.config.get("wepAlwaysRaised") then return end

        local weaponClass = newWeapon:GetClass()
        if weaponClass ~= "nut_hands" and weaponClass ~= "nut_keys" then
            timer.Simple(1, function()
                ply:setWepRaised(true)
            end)
        end
    end

    function PLUGIN:KeyPress(ply, key)
        if ply == nil or key == nil then return end
        if key == IN_RELOAD then
            ply:setWepRaised(true)
        end
    end
end