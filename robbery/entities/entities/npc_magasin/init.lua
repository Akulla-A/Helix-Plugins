AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Think()
	if not self.FearChar then
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
			if v:IsPlayer() and team.GetName(v:Team()) ~= "Police" and v:GetActiveWeapon().CW20Weapon then
				if v:GetEyeTrace().Entity == self then
					self.FearChar = v
					self:AlertSound()
                    self:EmitSound("ambient/alarms/alarm1.wav")
					self.FearTime = CurTime()
					v:Notify("Utilisez la caisse pour prendre de l'argent")
					break
				end
			end
		end
	else
		self:SetSequence( 80 )

		if self.FearTime + 300 < CurTime() then
			self:StopSound( "ambient/alarms/alarm1.wav" )
			self.FearChar = nil
			self.FearTime = nil
		end
	end
end

function ENT:Use(ply)
	if team.GetName(ply:Team()) == "Police" then
		if IsValid(self.FearChar) then
			ply:ChatNotify("Description du braqueur : "..self.FearChar:GetCharacter():GetDescription())
		else
			ply:ChatNotify("Le braqueur à quitté la ville")
		end
		self:StopSound( "ambient/alarms/alarm1.wav" )
		self.FearChar = nil
	end
end