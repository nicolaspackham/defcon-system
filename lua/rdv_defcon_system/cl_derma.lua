local COL_WHITE = Color(255,255,255)

net.Receive("RD_DEFCON_MENU", function()
    local FRAME = vgui.Create("EpsilonUI.Frame")
    FRAME:SetSize(ScrW() * 0.2, ScrH() * 0.3)
    FRAME:Center()
    FRAME:SetVisible(true)
    FRAME:MakePopup()
    FRAME:SetTitle("Defcon")

    local w, h = FRAME:GetSize()

    local SCROLL = vgui.Create("DScrollPanel", FRAME)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(0, h * 0.01, 0, h * 0.01)

    local SEQ = table.IsSequential(RDV.DEFCON.LIST)

    local SORT = SEQ and ipairs or pairs

    for k, v in SORT(RDV.DEFCON.LIST) do
        local box_color = v.Color

        local LABEL = SCROLL:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.15)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.01, 0, w * 0.01, h * 0.01)
        LABEL:SetMouseInputEnabled(true)
        LABEL:SetCursor("hand")

        LABEL.Paint = function(self, w, h)
            surface.SetDrawColor(box_color)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(COL_WHITE)
            surface.DrawOutlinedRect(0, 0, w, h)

            if v.Name then
                draw.SimpleText(v.Name, "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.5, COL_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        LABEL.DoClick = function()
            net.Start("RDV.DEFCON.CHANGE")
                net.WriteUInt(k, 8)
            net.SendToServer()
        end
    end
end)