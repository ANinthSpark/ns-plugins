PLUGIN.name = "Reisepass"
PLUGIN.author = "Nordkat"
PLUGIN.desc = "Present personal identification for any reason."

nut.util.include("cl_vgui.lua")
reisepass = reisepass or {}

reisepass.InfoTable = {
    "pass_fullname",
    "pass_age", 
    "pass_height", 
    "pass_weight",
    "pass_religion",
    "pass_hair",
    "pass_eyes",
    "pass_occupation",
    "pass_origin"
}

function PLUGIN:PlayerLoadedChar(client, id)
    if client == nil then return end
    local plyChar = client:getChar()
    if plyChar == nil then return end

    if !plyChar:getData("is_pass_new") and plyChar:getData("is_pass_new") ~= nil then return end
    plyChar:setData("is_pass_new", true)

    netstream.Start(client, "setupReisepass", client)
end

if CLIENT then
    netstream.Hook("openReisepass", function(ply)
        reisepassMenu(ply)
	end)

    netstream.Hook("setupReisepass", function(ply)
        reisepassInformationEntry(ply)
	end)
end

if SERVER then
    netstream.Hook("submitReisepassInfo", function(_, ply, charProperties)
        if ply == nil or charProperties == nil then return end
        local plyChar = ply:getChar()
        if plyChar == nil then return end

        if !plyChar:getData("is_pass_new") then return end

        plyChar:setData(reisepass.InfoTable[1], plyChar:getName())
        for ind, prop in pairs(charProperties) do
            plyChar:setData(reisepass.InfoTable[ind + 1], tostring(prop))
        end

        plyChar:getInv():add("reisepass", 1)
        ply:notify("Your new Reisepass has been made and given to you!")

        plyChar:setData("is_pass_new", false)
    end)
end