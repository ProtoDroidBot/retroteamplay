AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:DrawShadow(false)
	self:Fire("Kill", "", 10)
	
end

function ENT:Think()
end

