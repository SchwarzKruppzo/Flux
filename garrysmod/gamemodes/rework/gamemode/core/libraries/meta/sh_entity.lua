--[[ 
	Rework © 2016 TeslaCloud Studios
	Do not share, re-distribute or sell.
--]]

local entMeta = FindMetaTable("Entity");

--[[
	We store the original function here so we can override it from the player metaTable,
	which derives from the entity metaTable. This way we don't have to check if the entity is
	player every time the function is called.
--]]
entMeta.rwSetModel = entMeta.rwSetModel or entMeta.SetModel;