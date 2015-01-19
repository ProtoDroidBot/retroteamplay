include("shared.lua")

function ENT:StatusInitialize()
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		owner:SetNoDraw(true)
	end
end

function ENT:StatusOnRemove(owner)
	owner:SetNoDraw(false)
end

function ENT:StatusThink(owner)
	local ct = CurTime()
	if 0 < owner:Health() then
		local rag = owner:GetRagdollEntity()
		if rag and rag:IsValid() then
			rag:SetColor(owner:GetColor())
			local endtime = self:GetDieTime()
			if endtime - 0.65 <= ct then
				local delta = math.max(0.01, endtime - ct)
				for i = 0, rag:GetPhysicsObjectCount() do
					local translate = owner:TranslatePhysBoneToBone(i)
					if 0 < translate then
						local pos, ang = owner:GetBonePosition(translate)
						if pos and ang then
							local phys = rag:GetPhysicsObjectNum(i)
							if phys and phys:IsValid() then
								phys:Wake()
								phys:ComputeShadowControl({secondstoarrive = delta, pos = pos, angle = ang, maxangular = 1000, maxangulardamp = 10000, maxspeed = 5000, maxspeeddamp = 1000, dampfactor = 0.85, teleportdistance = 100, deltatime = FrameTime()})
							end
						end
					end
				end
			else
				rag:GetPhysicsObject():Wake()
				rag:GetPhysicsObject():ComputeShadowControl({secondstoarrive = 0.05, pos = owner:GetPos() + Vector(0,0,16), angle = rag:GetPhysicsObject():GetAngles(), maxangular = 2000, maxangulardamp = 10000, maxspeed = 5000, maxspeeddamp = 1000, dampfactor = 0.85, teleportdistance = 200, deltatime = FrameTime()})
			end
		end
	end

	self:NextThink(ct)
	return true
end

function ENT:Draw()
end
