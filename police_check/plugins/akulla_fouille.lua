local PLUGIN = PLUGIN
PLUGIN.name = "Fouille"
PLUGIN.author = "Akulla"
PLUGIN.description = "Fouiller un joueur"

if SERVER then
	local COMMAND = {
		OnRun = function(self, client)
			if not client:IsPolice() then ix.util.Notify("Vous devez être policier pour cela", client) return end
			local tr = client:GetEyeTrace()
			local ent = tr.Entity

			if ent:IsPlayer() and ent:GetPos():DistToSqr(client:GetPos()) < 400 * 400 then
				ix.storage.Open(client, ent:GetCharacter():GetInventory(), {
					name = "Inventaire",
					entity = ent,
					searchText = "Vous fouillez cette personne",
					searchTime = 5
				})

				ent:SetAction("Vous vous faites fouiller", 5)
			end
		end,
		description = "Fouiller la personne en face de vous"
	}
	ix.command.Add("Fouille", COMMAND)
end