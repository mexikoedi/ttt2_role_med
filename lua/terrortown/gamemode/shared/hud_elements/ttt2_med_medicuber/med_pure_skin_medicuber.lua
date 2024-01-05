AddCSLuaFile() -- adding this file for download, the rest is hud stuff and set up for the medigun
local base = "pure_skin_element"
DEFINE_BASECLASS(base)
HUDELEMENT.Base = base
if CLIENT then
    local pad = 14
    local uber_color = Color(170, 0, 0)
    local const_defaults = {
        basepos = {
            x = 0,
            y = 0
        },
        size = {
            w = 321,
            h = 60
        },
        minsize = {
            w = 200,
            h = 60
        }
    }

    function HUDELEMENT:PreInitialize()
        BaseClass.PreInitialize(self)
        huds.GetStored("pure_skin"):ForceElement(self.id)
        -- set as fallback default, other skins have to be set to true!
        self.disabledUnlessForced = false
    end

    function HUDELEMENT:Initialize()
        self.pad = pad
        self.basecolor = self:GetHUDBasecolor()
        BaseClass.Initialize(self)
    end

    -- parameter overwrites
    function HUDELEMENT:IsResizable()
        return true, true
    end

    -- parameter overwrites end
    function HUDELEMENT:GetDefaults()
        const_defaults["basepos"] = {
            x = math.Round(ScrW() * 0.5 - self.size.w * 0.5),
            y = ScrH() - self.pad - self.size.h - 50
        }
        return const_defaults
    end

    function HUDELEMENT:ShouldDraw()
        local client = LocalPlayer()
        if client:IsSpec() and client:GetObserverTarget() and client:GetObserverTarget():IsPlayer() then
            local obsTarget = client:GetObserverTarget()
            if IsValid(obsTarget:GetActiveWeapon()) and obsTarget:GetActiveWeapon():GetClass() == "weapon_ttt2_medic_medigun" then return true end
        end

        if IsValid(client:GetNWEntity("ttt2_med_medigun_healer", nil)) and not IsValid(client:GetNWEntity("ttt2_med_medigun_target", nil)) then return true end
        local holdsMedigun = false
        if IsValid(client:GetActiveWeapon()) and client:GetActiveWeapon():GetClass() == "weapon_ttt2_medic_medigun" and client:GetActiveWeapon().Owner == client then holdsMedigun = true end
        return HUDEditor.IsEditing or holdsMedigun
    end

    function HUDELEMENT:PerformLayout()
        local scale = self:GetHUDScale()
        self.basecolor = self:GetHUDBasecolor()
        self.pad = pad * scale
        BaseClass.PerformLayout(self)
    end

    function HUDELEMENT:Draw()
        local client = LocalPlayer()
        local pos = self:GetPos()
        local size = self:GetSize()
        local x, y = pos.x, pos.y
        local w, h = size.w, size.h
        -- draw bg and shadow
        self:DrawBg(x, y, w, h, self.basecolor)
        -- draw lines around the element
        self:DrawLines(x, y, w, h, self.basecolor.a)
        surface.SetFont("PureSkinRole")
        if client:IsSpec() and client:GetObserverTarget() and client:GetObserverTarget():IsPlayer() then
            local obsTarget = client:GetObserverTarget()
            if IsValid(obsTarget:GetActiveWeapon()) and obsTarget:GetActiveWeapon():GetClass() == "weapon_ttt2_medic_medigun" then
                self:DrawBar(x + self.pad, y + self.pad, w - self.pad * 2, h - self.pad * 2, uber_color, HUDEditor.IsEditing and 1 or obsTarget:GetNWFloat("ttt2_med_medigun_uber", 0), 1)
                draw.AdvancedText("UBERCHARGE", "PureSkinRole", x + 0.5 * w, y + 0.5 * h, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true, Vector(1, 1, 1))
                return
            end
        end

        if IsValid(client:GetActiveWeapon()) and client:GetActiveWeapon():GetClass() == "weapon_ttt2_medic_medigun" and client:GetActiveWeapon().Owner == client then
            self:DrawBar(x + self.pad, y + self.pad, w - self.pad * 2, h - self.pad * 2, uber_color, HUDEditor.IsEditing and 1 or client:GetNWFloat("ttt2_med_medigun_uber", 0), 1)
            draw.AdvancedText("UBERCHARGE", "PureSkinRole", x + 0.5 * w, y + 0.5 * h, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true, Vector(1, 1, 1))
        end

        local healTarget = client:GetNWEntity("ttt2_med_medigun_target", nil)
        if IsValid(healTarget) then
            local name
            if healTarget:IsPlayer() then
                name = healTarget:Nick()
            else
                name = healTarget:GetClass()
            end

            draw.AdvancedText(name .. ": " .. healTarget:Health(), "PureSkinRole", self.pos.x + self.size.w * 0.5, y - 25, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, true, Vector(1, 1, 1))
            return
        end

        local healer = client:GetNWEntity("ttt2_med_medigun_healer", nil)
        if not IsValid(healer) then return end
        draw.AdvancedText("Healer: " .. healer:Nick(), "PureSkinRole", self.pos.x + self.size.w * 0.5, y - 25, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, true, Vector(1, 1, 1))
        self:DrawBar(x + self.pad, y + self.pad, w - self.pad * 2, h - self.pad * 2, uber_color, HUDEditor.IsEditing and 1 or healer:GetNWFloat("ttt2_med_medigun_uber", 0), 1)
        draw.AdvancedText("UBERCHARGE", "PureSkinRole", x + 0.5 * w, y + 0.5 * h, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true, Vector(1, 1, 1))
    end
end