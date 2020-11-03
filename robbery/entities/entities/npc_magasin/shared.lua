ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Vendeur"
ENT.Author = "Akulla"
ENT.Category = "Akulla - Helix"
ENT.Spawnable       = true
ENT.AdminSpawnable  = true
ENT.AdminOnly = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/suits/male_02_closed_tie.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetNPCState(NPC_STATE_SCRIPT)
        self:SetSolid(SOLID_BBOX)
        self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
        self:SetUseType(SIMPLE_USE)
        self:DropToFloor()
	    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

        self:SetMaxYawSpeed(90)
    else
    	self:DrawModel()
    end
end