AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:StatusInitialize()
	self:SetModel("models/w_nox_longbow.mdl")
end

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.WeaponStatus = self
end