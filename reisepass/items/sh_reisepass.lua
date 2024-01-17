ITEM.name = "Reisepass"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Documents"
ITEM.price = 5
ITEM.permit = "lit"

function ITEM:getDesc()
	return "A German passport containing the identity and physical characteristics of an individual."
end

ITEM.functions.view = {
	name = "View",
	tip = "useTip",
	icon = "icon16/note.png",
	onRun = function(item)
		if item == nil then return false end
		local itemPly = item:getOwner()
		if itemPly == nil then return false end


		item.player:EmitSound("ambient/materials/shuffle1.wav", 70, 150)
		netstream.Start(item.player, "openReisepass", item.player, getPlyReisepassTable(itemPly:getChar()))

		return false
	end,
}

ITEM.functions.present = {
	name = "Present",
	tip = "useTip",
	icon = "icon16/note_go.png",
	onRun = function(item)
		if item == nil then return false end
		local itemPly = item:getOwner()
		if itemPly == nil then return false end


		local tr = util.TraceLine({
			start = itemPly:EyePos(),
			endpos = itemPly:EyePos() + itemPly:EyeAngles():Forward() * 72,
			filter = itemPly
		})
		if !IsValid(tr.Entity) or !tr.Entity:IsPlayer() then return false end


		item.player:EmitSound("ambient/materials/shuffle1.wav", 70, 150)
		netstream.Start(tr.Entity, "openReisepass", item.player, getPlyReisepassTable(itemPly:getChar()))

		return false
	end,
}

function getPlyReisepassTable(plyChar)
	if plyChar == nil then return end

	local plyReisepassInfo = {}
	for indx, _prop in pairs(reisepass.InfoTable) do
		table.insert(plyReisepassInfo, plyChar:getData(reisepass.InfoTable[indx]))
	end

	return plyReisepassInfo
end
