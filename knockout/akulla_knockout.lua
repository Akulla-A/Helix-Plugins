local PLUGIN = PLUGIN
PLUGIN.name = "Knockout"
PLUGIN.author = "Akulla"
PLUGIN.description = "Chances de mettre à terre"

local PLAYER = FindMetaTable("Player")

if SERVER then
	function PLUGIN:ScalePlayerDamage(ply, hitgroup, dmginfo)
		local headhit = false

		if hitgroup == HITGROUP_GENERIC then
			if (dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_CLUB)) then
				local plypos = dmginfo:GetDamagePosition()
				local plyang = ply:EyeAngles():Forward()
				local obbpos, obbang = ply:GetBonePosition( 6 )
				local obbmin, obbmax = ply:GetHitBoxBounds( 0,0 )
				if (util.IntersectRayWithOBB( plypos, plyang, obbpos, obbang, obbmin - Vector(15,15,15), obbmax + Vector(15,15,15))) then 
					headhit = true
				end
			end
		elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
            char:AddBoost("legShoot","stm",-100)   
            char:AddBoost("legShoot","stamina",-120)

			timer.Simple(60, function()
				char:RemoveBoost("legShoot", "stm")
				char:RemoveBoost("legShoot", "stamina")
			end)
		elseif hitgroup == HITGROUP_HEAD or headhit then
			if math.random(0,100) > 50 then
				ply:SetRagdolled(true, 30, 30)
			end
		end
	end
end