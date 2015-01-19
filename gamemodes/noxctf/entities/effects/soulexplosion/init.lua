function EFFECT:Init(data)
	
	local pos = data:GetOrigin()
	local ent = data:GetEntity()

	self.Emitter = ParticleEmitter( pos )
	
	if IsValid(ent) then
		
		local c = ent:GetPlayerColor() * 100
	
		for i=1, math.random(23,40) do
			local particle = self.Emitter:Add("sprites/glow04_noz", self:GetPos() + VectorRand() * math.Rand(-10, 10) + vector_up*i*.5)
			particle:SetVelocity(VectorRand() * math.Rand(100, 200) + vector_up * math.random(340,800))
			particle:SetStartSize(11*i)
			particle:SetEndSize(0)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(30)
			particle:SetColor(c.r,c.g,c.b)
			particle:SetDieTime(math.Rand(1.2, 1.6))
			particle:SetGravity(Vector(0,0,-1300))
			particle:SetAirResistance(110)
			particle:SetCollide(true)
			particle:SetBounce(1)
			particle:SetRoll(math.Rand(-180, 180))
			particle:SetRollDelta(math.Rand(-4, 4))
		end
	
		--self.Emitter:Finish()
		
	end
end
	
function EFFECT:Think()
	return false
end

function EFFECT:Render()
end