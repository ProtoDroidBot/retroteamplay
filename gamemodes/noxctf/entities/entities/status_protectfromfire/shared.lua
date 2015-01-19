ENT.Type = "anim"
ENT.Base = "status__base"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.StartSound = Sound("nox/protecton.ogg")
ENT.EndSound = Sound("nox/protectoff.ogg")
ENT.StatusImage = "spellicons/protectfromfire.png"


function ENT:ProcessDamage(attacker, inflictor, dmginfo)
	if dmginfo:GetDamageType() == DMGTYPE_FIRE then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.6666)
	end
end
