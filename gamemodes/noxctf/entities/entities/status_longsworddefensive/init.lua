AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:StatusShouldRemove(owner)
	return owner:GetVelocity():Length() > 20 or owner:InVehicle() or owner:GetActiveWeapon():GetClass() ~= "weapon_melee_longsword" or owner:IsFrozen() or owner:GetStatus("stun") or owner:GetStatus("stun_noeffect")
end

function ENT:StatusThink(owner)
	local eyepos = owner:EyePos()
	local ownerteam = owner:Team()
	for _, ent in pairs(ents.FindInSphere(eyepos + owner:GetAimVector() * 30, 15)) do
		if ent.Inversion and ent:GetTeamID() ~= ownerteam then
			owner:CustomGesture(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2)
			ent:EmitSound("npc/manhack/bat_away.wav", 80, math.Rand(95, 105))
			Invert(ent, owner)
		elseif ent.Deflectable and ent:GetTeamID() ~= ownerteam and ent:GetPhysicsObject():IsMoveable() then
			owner:CustomGesture(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2)
			ent:EmitSound("npc/manhack/bat_away.wav", 80, math.Rand(95, 105))
			ent:SetTeamID(ownerteam)
			ent:SetOwner(owner)
			ent:GetPhysicsObject():SetVelocityInstantaneous((ent:NearestPoint(eyepos) - eyepos):Normalize() * (ent:GetVelocity():Length() + 250))
		end
	end
	
	self:NextThink(CurTime())
	return true
end