AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Use(ply)
	if ply:IM_GetMoney() <= 0 then
		ply:Notify("Aucun argent sale sur vous")
		return
	end

	ply:SetAction("Votre argent sale est en cours de blanchiement...", 20)

	ply:DoStaredAction(self, function()
		ply:Notify("L'argent est en cours de blanchiement")
		ply:SetAction(nil)
		ply:IM_Transfer()
	end,
	20,
	function()
		ply:Notify("Le blanchiement a été annulé")
		ply:SetAction(nil)
	end)
end