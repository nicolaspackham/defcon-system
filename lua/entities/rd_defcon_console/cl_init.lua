include("shared.lua")
AddCSLuaFile()

function ENT:Draw()
	self:DrawModel()

	local DEFCON = RDV.DEFCON.GetDefcon()

	if not RDV.DEFCON.LIST[DEFCON] then
		return
	end

	local COLOR = RDV.DEFCON.LIST[DEFCON].Color
	local NAME = RDV.DEFCON.LIST[DEFCON].Name

    local pos = self:LocalToWorld(Vector(0, 0, 100))
    local ang = self:LocalToWorldAngles(Angle(0, 90, 90))

    cam.Start3D2D(self:LocalToWorld(Vector(0,0,self:OBBMaxs().z)) + Vector(0,0,10), ang, 0.1)

        draw.SimpleText((NAME or "N/A"), "RD_FONTS_CORE_OVERHEAD", 0, 0, COLOR, TEXT_ALIGN_CENTER)

    cam.End3D2D()
end