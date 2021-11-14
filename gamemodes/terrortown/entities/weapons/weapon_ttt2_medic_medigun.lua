if SERVER then
    AddCSLuaFile() -- adding this file for download, the rest is base ttt/ttt2 and other code for the medigun
    resource.AddFile("materials/vgui/ttt/icon_medigun.vmt") -- adding medigun icon for download
    resource.AddWorkshop("2086831737") -- adding the medigun for download
    util.AddNetworkString("ttt2_med_medigun_clear_healer") -- adding network string for the healer display
    util.AddNetworkString("ttt2_med_medigun_clear_target") -- adding network string for the target display

    sound.Add({
        name = "ttt2_med_medigun_heal_sound",
        channel = "CHAN_AUTO",
        volume = 1.0,
        level = 75,
        pitch = {100, 100},
        sound = "medigun/medic_heal.wav"
    })
end

SWEP.AutoSpawnable = false
SWEP.AdminSpawnable = true
SWEP.Weight = 3
SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = "models/weapons/v_models/v_mediown_medic.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_mediown.mdl"
SWEP.ViewModelFlip = false
SWEP.HoldType = "shotgun"
SWEP.UseHands = false
SWEP.BobScale = 1
SWEP.SwayScale = 0
SWEP.ViewModelFOV = 65
SWEP.CSMuzzleFlashes = 1
SWEP.Kind = WEAPON_EQUIP1
SWEP.Icon = "vgui/ttt/icon_medigun"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.AllowDrop = false
SWEP.AllowPickup = false
SWEP.CanBuy = nil
SWEP.notBuyable = true

SWEP.InLoadoutFor = {ROLE_MEDIC}

if CLIENT then
    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "weapon_med_medigun_name",
        desc = "weapon_med_medigun_desc"
    }
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)

    if CLIENT then
        self:AddHUDHelp("ttt2_med_medigun_help1", "ttt2_med_medigun_help2", true)
    end
end

function SWEP:InitValues()
    self.next_uber_tick = GetConVar("ttt2_med_medigun_ticks_per_uber"):GetInt()
    self.uber_last_ticks = 0
    self.uber_drain_pct = 0
    self.disturb_tick = 66
    self.disturb_tick_distance = 33
    self.heal_tick = GetConVar("ttt2_med_medigun_ticks_per_heal"):GetInt()
    self.heal_tick_self = GetConVar("ttt2_med_medigun_ticks_per_self_heal"):GetInt()
    self.uber_active = false
    self.charged_sound_called = false
    self.shoot_cooldown = 0
end

function SWEP:Deploy()
    self:SetHoldType(self.HoldType)
    self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:Equip()
    self.LastOwner = self:GetOwner()
    self:InitValues()
end

function SWEP:Think()
    if SERVER then
        if self:GetOwner():KeyDown(IN_ATTACK) or self.target ~= nil and CurTime() > self.shoot_cooldown then
            self.target = self.target or self:GetOwner():GetEyeTrace().Entity

            if self.forcestop then
                self:ClearHealer()
                self.shoot_cooldown = CurTime() + 0.3
                self:StopHealSound()
                self:ClearTarget()
                hook.Run("TTT2MedMediGunStopHealing", self:GetOwner(), self.target, self)
                self.target = nil
                self.forcestop = nil

                return
            end

            if not IsValid(self.target) or not self:IsDistanceViable() then
                if self.target and self.beam then
                    self:ClearHealer()
                    self.shoot_cooldown = CurTime() + 0.3
                    self:StopHealSound()
                    self:ClearTarget()
                    hook.Run("TTT2MedMediGunStopHealing", self:GetOwner(), self.target, self)
                end

                self.target = nil
            end

            if not self:CheckTargetValid() then
                if self.target and (self.target:IsPlayer() or self.target:IsNPC()) then
                    self:ClearHealer()
                    self.shoot_cooldown = CurTime() + 0.3
                    self:StopHealSound()
                    self:ClearTarget()
                    hook.Run("TTT2MedMediGunStopHealing", self:GetOwner(), self.target, self)
                end

                self.target = nil
            end
        else
            if self.target then
                self:ClearHealer()
                self.shoot_cooldown = CurTime() + 0.3
                self:StopHealSound()
                self:ClearTarget()
                hook.Run("TTT2MedMediGunStopHealing", self:GetOwner(), self.target, self)
            end

            self.target = nil
        end

        if self.target then
            if not self.beam or not IsValid(self.beam) then
                local allow_heal = hook.Run("TTT2MedMediGunAllowHeal", self:GetOwner(), self.target, self)
                allow_heal = allow_heal == nil and true or allow_heal

                if not allow_heal then
                    self.target = nil

                    return
                end

                self:CreateBeam()
                self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
                hook.Run("TTT2MedMediGunStartHealing", self:GetOwner(), self.target, self)
            else
                self:UpdateBeam()
            end

            if GetConVar("ttt2_med_medigun_call_healing_hook"):GetBool() then
                hook.Run("TTT2MedMediGunHealing", self:GetOwner(), self.target, self)
            end

            local nwTarget = self:GetOwner():GetNWEntity("ttt2_med_medigun_target", nil)
            local nwHealer = self.target:GetNWEntity("ttt2_med_medigun_healer", nil)

            if not IsValid(nwTarget) or not IsValid(nwHealer) then
                self:GetOwner():SetNWEntity("ttt2_med_medigun_target", self.target)
                self.target:SetNWEntity("ttt2_med_medigun_healer", self:GetOwner())
                self:StartHealSound()
            end

            self:HealTarget()

            if not GetConVar("ttt2_med_medigun_self_heal_is_passive"):GetBool() then
                self:HealSelf()
            end

            if self.next_uber_tick <= 1 and not self.uber_active and self:GetOwner():GetNWFloat("ttt2_med_medigun_uber", 0) < 1.00 then
                self:GetOwner():SetNWFloat("ttt2_med_medigun_uber", self:GetOwner():GetNWFloat("ttt2_med_medigun_uber", 0) + 0.01)
                self.next_uber_tick = self.target:Health() < self.target:GetMaxHealth() and GetConVar("ttt2_med_medigun_ticks_per_uber"):GetInt() - 6 or GetConVar("ttt2_med_medigun_ticks_per_uber"):GetInt()
            end

            if self:GetOwner():GetNWFloat("ttt2_med_medigun_uber", 0) >= 1.00 and not self.charged_sound_called and not self.uber_active then
                self:GetOwner():EmitSound("medigun/medic_chargeready.wav")
                self.charged_sound_called = true
                hook.Run("TTT2MedMediGunUberReady", self:GetOwner(), self.target, self)
            end

            if self:GetOwner():GetNWFloat("ttt2_med_medigun_uber", 0) < 1.00 and not self.uber_active then
                self.next_uber_tick = self.next_uber_tick - 1
            end
        else
            self:RemoveBeam()
            self:SendWeaponAnim(ACT_VM_IDLE)
        end

        if GetConVar("ttt2_med_medigun_self_heal_is_passive"):GetBool() then
            self:HealSelf()
        end

        self:NextThink(CurTime())

        return true
    end
end

function SWEP:CheckTargetValid(ent)
    local target = self.target

    if ent then
        target = ent
    end

    if not IsValid(target) then return false end
    if not (target:IsNPC() or target:IsPlayer()) then return false end
    if (target:IsPlayer() and (not target:IsTerror() or not target:Alive())) or (target:IsNPC() and (not IsValid(target))) then return false end
    if not self.beam then return true end

    local tr = util.TraceLine{
        start = self:GetOwner():GetShootPos(),
        endpos = target:GetShootPos(),
        mask = MASK_SOLID_BRUSHONLY
    }

    if tr.Hit then
        if self.disturb_tick <= 1 then
            self.disturb_tick = 66

            return false
        end

        self.disturb_tick = self.disturb_tick - 1
    end

    return true
end

function SWEP:IsDistanceViable(ent)
    local target = self.target

    if ent then
        target = ent
    end

    if self:GetOwner():GetShootPos():Distance(target:GetPos()) > GetConVar("ttt2_med_medigun_max_range"):GetInt() then
        if self.beam and self.target == ent then
            if self.disturb_tick_distance <= 1 then
                self.disturb_tick_distance = 33

                return false
            end

            self.disturb_tick_distance = self.disturb_tick_distance - 1
        else
            return false
        end
    end

    return true
end

function SWEP:PrimaryAttack()
    if not self.target then return end
    local newTarget = self:GetOwner():GetEyeTrace().Entity
    if newTarget == self.target then return end

    if not newTarget or not self:IsDistanceViable(newTarget) or not self:CheckTargetValid(newTarget) then
        self.forcestop = true

        return
    end

    self.forcestop = true

    timer.Simple(0, function()
        self.shoot_cooldown = CurTime()
        self.target = newTarget
    end)
end

function SWEP:SecondaryAttack()
    if not SERVER then return end
    local ply = self:GetOwner()
    if ply:GetNWFloat("ttt2_med_medigun_uber", 0) < 1.00 then return end
    local allow_uber = hook.Run("TTT2MedMediGunAllowUber", self:GetOwner(), self.target, self)
    allow_uber = allow_uber == nil and true or allow_uber
    if not allow_uber then return end
    local uberTicks = (1 / FrameTime()) * GetConVar("ttt2_med_medigun_uber_seconds"):GetInt()
    self.uber_last_ticks = uberTicks
    self.uber_drain_pct = 1 / uberTicks
    self.uber_active = true
    self.charged_sound_called = false
    self:GetOwner():EmitSound("medigun/medic_chargeactivate.wav")
    self.heal_tick = 1
    self.heal_tick_self = 1
    hook.Run("TTT2MedMediGunUberStart", self:GetOwner(), self.target, self)
    self:HandleUber()
end

function SWEP:Reload()
end

function SWEP:OnDrop()
    if SERVER then
        if self.target then
            if IsValid(self.target) then
                self:ClearHealer()
                self:ClearTarget()
            end

            self:RemoveBeam()
            hook.Run("TTT2MedMediGunStopHealing", self.LastOwner, self.target)
            self.StopHookCalled = true
        end

        self:StopHealSound(self.LastOwner)
        self:Remove()
    end
end

function SWEP:Holster()
    if SERVER then
        if self.target then
            if IsValid(self.target) then
                self:ClearHealer()
                self:ClearTarget()
            end

            self:RemoveBeam()
            hook.Run("TTT2MedMediGunStopHealing", self.LastOwner, self.target)
            self.target = nil
        end

        self:StopHealSound(self.LastOwner)
    end

    return true
end

function SWEP:OnRemove()
    if SERVER then
        if self.target then
            if IsValid(self.target) then
                self:ClearHealer()
                self:ClearTarget()
            end

            self:RemoveBeam()

            if not self.StopHookCalled then
                hook.Run("TTT2MedMediGunStopHealing", self.LastOwner, self.target)
            else
                self.StopHookCalled = nil
            end
        end

        self:StopHealSound(self.LastOwner)
    end
end

if SERVER then
    function SWEP:CreateBeam()
        if not GetConVar("ttt2_med_medigun_enable_beam"):GetBool() then
            self.beam = self:GetOwner()

            return
        end

        self.beam = ents.Create("info_particle_system")
        self.beam:SetKeyValue("effect_name", "medicgun_beam_own")
        self.beam:SetOwner(self:GetOwner())
        local Forward = self:GetOwner():EyeAngles():Forward()
        local Right = self:GetOwner():EyeAngles():Right()
        local Up = self:GetOwner():EyeAngles():Up()
        self.beam:SetAngles(self:GetOwner():EyeAngles())
        self.beamtarget = ents.Create("tf_med_target_medigun")
        self.beamtarget:SetOwner(self:GetOwner())
        self.beamtarget:Spawn()
        self.beamtarget:SetPos(self.target:GetPos() + Vector(0, 0, 50))
        self.beamtarget:Activate()
        self.beam:SetKeyValue("cpoint1", self.beamtarget:GetName())
        self.beam:Spawn()
        self.beam:SetPos(self:GetOwner():GetShootPos() + Forward * 50 + Right * 8 + Up * -6)
        self.beam:Activate()
        self.beam:Fire("start", "", 0)
    end

    function SWEP:UpdateBeam()
        if not GetConVar("ttt2_med_medigun_enable_beam"):GetBool() then return end
        local Forward = self:GetOwner():EyeAngles():Forward()
        local Right = self:GetOwner():EyeAngles():Right()
        local Up = self:GetOwner():EyeAngles():Up()
        self.beam:SetPos(self:GetOwner():GetShootPos() + Forward * 50 + Right * 8 + Up * -6)
        self.beam:SetAngles(self:GetOwner():EyeAngles())
        self.beamtarget:SetPos(self.target:GetPos() + Vector(0, 0, 50))
    end

    function SWEP:RemoveBeam()
        if not GetConVar("ttt2_med_medigun_enable_beam"):GetBool() then
            self.beam = nil

            return
        end

        if self.beam and IsValid(self.beam) then
            self.beam:Remove()
            self.beamtarget:Remove()
            self.beam = nil
            self.beamtarget = nil
        end
    end

    function SWEP:StartHealSound()
        self:GetOwner():EmitSound("ttt2_med_medigun_heal_sound")
    end

    function SWEP:StopHealSound(ent)
        if ent and IsValid(ent) then
            ent:StopSound("ttt2_med_medigun_heal_sound")

            return
        end

        if not IsValid(self:GetOwner()) then return end
        self:GetOwner():StopSound("ttt2_med_medigun_heal_sound")
    end

    function SWEP:HealTarget()
        if self.heal_tick > 1 then
            self.heal_tick = self.heal_tick - 1

            return
        else
            self.heal_tick = self.uber_active and GetConVar("ttt2_med_medigun_ticks_per_heal_uber"):GetInt() or GetConVar("ttt2_med_medigun_ticks_per_heal"):GetInt()
        end

        if self.target:Health() >= self.target:GetMaxHealth() then return end
        local h = self.target:Health()
        local mh = self.target:GetMaxHealth()
        local gn = self.uber_active and GetConVar("ttt2_med_medigun_heal_per_tick_uber"):GetInt() or GetConVar("ttt2_med_medigun_heal_per_tick"):GetInt()
        gn = hook.Run("TTT2MedMediGunHealthHeal", self:GetOwner(), self.target, self, gn) or gn
        local nh = h + gn
        nh = nh > mh and mh or nh
        self.target:SetHealth(nh)

        -- win condition checks, the variables med_popupstarted and med_fin_heal are important to avoid issues
        if GetConVar("ttt2_med_win_enabled"):GetBool() and med_fin_heal == nil then
            if GetConVar("ttt2_med_announce_win_popup"):GetBool() and med_popupstarted == nil then
                net.Start("ttt2_med_role_epop_7") -- the seventh added network string starts here if the convar is true
                net.WriteString(med_rqd_heal) -- writing required health points
                net.Send(self:GetOwner()) -- broadcasting but no popup at the screen yet
            end

            med_popupstarted = true

            -- HealthCheck is done here and health is deducted
            if med_rqd_heal > 0 then
                timer.Create("HealthCheck", 0, 1, function()
                    med_rqd_heal = med_rqd_heal - gn
                end)
            end

            -- HealthCheck is done here
            if (med_rqd_heal - gn) <= 0 then
                med_fin_heal = true

                -- checks if convar is true, med_fin_revive is true, med_fin_heal is true and the convar is true
                if GetConVar("ttt2_med_win_rqd_revive"):GetBool() and med_fin_revive == true and med_fin_heal == true and GetConVar("ttt2_med_announce_win_achieved_popup"):GetBool() then
                    net.Start("ttt2_med_role_epop_8") -- the eighth added network string starts here if the convar is true
                    net.Send(self:GetOwner()) -- broadcasting but no popup at the screen yet
                    -- checks if med_fin_heal is true and the convar is true
                elseif GetConVar("ttt2_med_win_rqd_revive"):GetBool() == false and med_fin_heal == true and GetConVar("ttt2_med_announce_win_achieved_popup"):GetBool() then
                    net.Start("ttt2_med_role_epop_8") -- the eighth added network string starts here if the convar is true
                    net.Send(self:GetOwner()) -- broadcasting but no popup at the screen yet
                end
            end
        end
    end

    function SWEP:HealSelf()
        if self.heal_tick_self > 1 then
            self.heal_tick_self = self.heal_tick_self - 1

            return
        else
            self.heal_tick_self = self.uber_active and GetConVar("ttt2_med_medigun_ticks_per_self_heal_uber"):GetInt() or GetConVar("ttt2_med_medigun_ticks_per_self_heal"):GetInt()
        end

        if self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() then return end
        local h = self:GetOwner():Health()
        local mh = self:GetOwner():GetMaxHealth()
        local nh = self.uber_active and h + GetConVar("ttt2_med_medigun_self_heal_per_tick_uber"):GetInt() or h + GetConVar("ttt2_med_medigun_self_heal_per_tick"):GetInt()
        nh = nh > mh and mh or nh
        self:GetOwner():SetHealth(nh)
    end

    function SWEP:HandleUber()
        if not self.uber_active then return end
        local ply = self:GetOwner()

        hook.Add("Tick", "TTT2MedMediGunUberTick" .. tostring(ply:SteamID64()), function()
            if not IsValid(ply) or not IsValid(self) then
                hook.Remove("Tick", "TTT2MedMediGunUberTick" .. tostring(ply:SteamID64()))

                if IsValid(ply) then
                    ply:SetNWFloat("ttt2_med_medigun_uber", 0)
                end

                hook.Run("TTT2MedMediGunUberStop", self:GetOwner(), self.target, self)

                return
            end

            if not ply:IsTerror() or not ply:Alive() then
                hook.Remove("Tick", "TTT2MedMediGunUberTick" .. tostring(ply:SteamID64()))
                ply:SetNWFloat("ttt2_med_medigun_uber", 0)
                hook.Run("TTT2MedMediGunUberStop", self:GetOwner(), self.target, self)

                return
            end

            if ply:GetNWFloat("ttt2_med_medigun_uber", 0) <= 0 then
                self.uber_active = false
                ply:SetNWFloat("ttt2_med_medigun_uber", 0)
                hook.Remove("Tick", "TTT2MedMediGunUberTick" .. tostring(ply:SteamID64()))
                hook.Run("TTT2MedMediGunUberStop", self:GetOwner(), self.target, self)

                return
            end

            ply:SetNWFloat("ttt2_med_medigun_uber", ply:GetNWFloat("ttt2_med_medigun_uber", 0) - self.uber_drain_pct)
        end)
    end

    function SWEP:ClearTarget()
        local owner = IsValid(self:GetOwner()) and self:GetOwner() or self.LastOwner
        owner:SetNWEntity("ttt2_med_medigun_target", nil)
        net.Start("ttt2_med_medigun_clear_target")
        net.Send(owner)
    end

    function SWEP:ClearHealer()
        if not self.target or not IsValid(self.target) or not self.target:IsPlayer() then return end
        self.target:SetNWEntity("ttt2_med_medigun_healer", nil)
        net.Start("ttt2_med_medigun_clear_healer")
        net.Send(self.target)
    end

    timer.Remove("HealthCheck")
end

if SERVER then
    function TTT2MEDMEDIGUN_DATA:HandleDamage(ply, inflic, att, damage, dmginfo)
        if dmginfo:IsBulletDamage() and ply:LastHitGroup() == 1 then
            dmginfo:ScaleDamage(GetConVar("ttt2_med_medigun_uber_headshot_dmg_get_pct"):GetFloat())
        else
            dmginfo:ScaleDamage(GetConVar("ttt2_med_medigun_uber_general_dmg_get_pct"):GetFloat())
        end
    end

    hook.Add("TTTPrepareRound", "TTT2MedResetMediguns", function()
        for k, v in ipairs(player.GetAll()) do
            v:SetNWFloat("ttt2_med_medigun_uber", 0)
            v:SetNWEntity("ttt2_med_medigun_target", nil)
            v:SetNWEntity("ttt2_med_medigun_healer", nil)
            timer.Remove("ttt2_med_medic_uber_" .. v:SteamID64())
        end
    end)

    hook.Add("PlayerTakeDamage", "TTT2MedMedigunScaleDamage", function(ply, inflic, att, damage, dmginfo)
        if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_ttt2_medic_medigun" then
            if ply:GetActiveWeapon().uber_active then
                TTT2MEDMEDIGUN_DATA:HandleDamage(ply, inflic, att, damage, dmginfo)
            end

            return
        end

        if IsValid(ply:GetNWEntity("ttt2_med_medigun_healer", nil)) then
            local healer = ply:GetNWEntity("ttt2_med_medigun_healer", nil)
            if not IsValid(healer:GetActiveWeapon()) or healer:GetActiveWeapon():GetClass() ~= "weapon_ttt2_medic_medigun" then return end
            if not healer:GetActiveWeapon().uber_active then return end
            TTT2MEDMEDIGUN_DATA:HandleDamage(ply, inflic, att, damage, dmginfo)
        end
    end)
end

if CLIENT then
    hook.Add("TTTPrepareRound", "TTT2MedResetMediguns", function()
        local localPly = LocalPlayer()
        localPly:SetNWEntity("ttt2_med_medigun_target", nil)
        localPly:SetNWEntity("ttt2_med_medigun_healer", nil)
    end)

    net.Receive("ttt2_med_medigun_clear_healer", function()
        LocalPlayer():SetNWEntity("ttt2_med_medigun_healer", nil)
    end)

    net.Receive("ttt2_med_medigun_clear_target", function()
        LocalPlayer():SetNWEntity("ttt2_med_medigun_target", nil)
    end)
end