local PLUGIN = PLUGIN
PLUGIN.name = "Level System"
PLUGIN.author = "Akulla"
PLUGIN.description = "Player can get levels."

local PLAYER = FindMetaTable("Player")

function PLAYER:GetNextLevel(lvl)
	return lvl^2
end

function PLUGIN:CanPlayerJoinClass(client, class, info)
	local level = ply:GetData("akulla_level", 1)
	
	if class.level and class.level > level then
		client:Notify("Vous n'êtes pas niveau "..level)
		return false
	end
end

if SERVER then
	function PLAYER:Akulla_AddXP(amt)
		local level = self:GetData("akulla_level", 1)
		local xp = self:GetData("akulla_xp", 0) + amt
		if GetNextLevel(level) <= xp then
			self:SetData("akulla_xp", xp - GetNextLevel(level))
			self:SetData("akulla_level", level + 1)
		else
			self:SetData("akulla_xp", xp)
		end
	end

	function PLUGIN:PlayerLoadedCharacter(client)
		timer.Create("Akulla_GiveXP_"..client:SteamID64(), 300, 0, function()
			if IsValid(client) and IsValid(client:GetCharacter()) then
				client:Akulla_AddXP(1)
			end
		end)
	end

	function PLUGIN:OnCharacterCreated(client, char)
		char:SetData("akulla_level", 1)
		char:SetData("akulla_xp", 0)
	end

	function PLUGIN:PlayerDisconnected(ply)
		timer.Remove("Akulla_GiveXP_"..ply:SteamID64())
	end
end