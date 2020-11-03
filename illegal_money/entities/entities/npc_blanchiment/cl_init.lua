include("shared.lua")

function ENT:Draw()
    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < 600 * 600 then
        local pos, _ = self:GetBonePosition(8)
        cam.Start3D2D(pos + Vector(0,0,20), Angle( 0, LocalPlayer():EyeAngles().y - 90, 90), .1)
            surface.SetFont("ixBigFont")
            local w, h = surface.GetTextSize("Blanchisseur d'argent sale")

            draw.RoundedBox(8, -10 -w/2 ,-10 - h/2,w + 20,h + 20,Color(40,40,40,180))
            draw.SimpleTextOutlined( "Blanchisseur d'argent sale", "ixBigFont", 0,0, Color(255,255,255), TEXT_ALIGN_CENTER, 1, 3, Color(40,40,40,120) )
        cam.End3D2D()
    end
    self:DrawModel()
end