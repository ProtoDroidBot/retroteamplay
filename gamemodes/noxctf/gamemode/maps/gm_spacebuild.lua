hook.Add("InitPostEntity", "Adding", function()
	hook.Remove("InitPostEntity", "Adding")

	for _, ent in pairs(ents.FindByClass("func_smokevolume")) do
		ent:Remove()
	end
end)
