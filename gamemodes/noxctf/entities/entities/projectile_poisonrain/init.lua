AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)

	self.CounterSpell = COUNTERSPELL_DESTROY

	self:PhysicsInitSphere(4)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCustomCollisionCheck(true)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetBuoyancyRatio(0.00001)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:Wake()
	end

	self.DeathTime = CurTime() + 3
end

function ENT:Think()
	if self.DeathTime <= CurTime() then
		self:Remove()
	elseif self.PhysicsData then
		self:Explode(self.PhysicsData.HitPos, self.PhysicsData.HitNormal)
	end
end

function ENT:PhysicsCollide(data, physobj)
	self.PhysicsData = data
	self:NextThink(CurTime())
end

function ENT:Explode(hitpos, hitnormal)
	if self.Exploded then return end

	self.Exploded = true
	self.DeathTime = -10

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	local tr = util.TraceLine({start = hitpos, endpos = hitpos + Vector(0, 0, 1300), mask = MASK_SOLID_BRUSHONLY, filter=filt})
	
	if IsIndoors(tr.HitPos) then return end

	local ent = ents.Create("poisonrain")
	if ent:IsValid() then
		ent:SetPos(tr.HitPos + tr.HitNormal * 16)
		ent:SetOwner(owner)
		ent:SetTeamID(owner:GetTeamID())
		ent:Spawn()
	end
	self:NextThink(CurTime())
end
