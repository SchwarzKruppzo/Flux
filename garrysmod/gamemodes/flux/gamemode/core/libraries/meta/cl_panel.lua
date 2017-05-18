--[[
	Flux © 2016-2017 TeslaCloud Studios
	Do not share or re-distribute before
	the framework is publicly released.
--]]

local panelMeta = FindMetaTable("Panel")

-- Seriously, Newman? I have to write this myself?
function panelMeta:UnDraggable()
	self.m_DragSlot = nil
end

function panelMeta:SafeRemove()
	self:SetVisible(false)
	self:Remove()
end