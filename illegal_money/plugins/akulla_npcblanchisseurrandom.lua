local PLUGIN = PLUGIN
PLUGIN.name = "Blanchisseur d'argent sale spawn"
PLUGIN.author = "Akulla"
PLUGIN.description = "Blanchisseur d'argent sale spawn"
PLUGIN.HowMuchNPC = 1

local tbl = {
	{
		pos = Vector(0,0,0),
		ang = Angle(0,0,0),
	},
	{
		pos = Vector(1,1,1),
		ang = Angle(1,1,1),
	},
}

if SERVER then
	timer.Simple(15, function()
		for i=1,PLUGIN.HowMuchNPC do
			local id = math.random( #tbl )
			local newEnt = ents.Create("npc_blanchiment")
			newEnt:SetPos(tbl[id].pos)
			newEnt:SetAngles(tbl[id].ang)
			newEnt:Spawn()
			newEnt:Activate()

			table.remove(tbl, id)
		end
	end)
end