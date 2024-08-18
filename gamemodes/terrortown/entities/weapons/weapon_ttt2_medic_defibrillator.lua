-- defibrillator code follows
if GetConVar("ttt2_med_disable_defibrillator"):GetBool() == true then return end
if SERVER then
    AddCSLuaFile() -- adding this file for download, the rest is base ttt/ttt2 and other code for the defibrillator
    resource.AddWorkshop("2115944312") -- adding the defibrillator for download
end

local flags = {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED}
SWEP.Base = "weapon_ttt_defibrillator"
if CLIENT then
    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "weapon_med_defi_name",
        desc = "weapon_med_defi_desc"
    }

    SWEP.Icon = "vgui/ttt/icon_defibrillator"
end

SWEP.Kind = WEAPON_EQUIP2
SWEP.AllowDrop = false
SWEP.AllowPickup = false
SWEP.CanBuy = nil
SWEP.notBuyable = true
SWEP.InLoadoutFor = {ROLE_MEDIC}
SWEP.cvars = {
    reviveBraindead = CreateConVar("ttt2_med_defibrillator_revive_braindead", "0", flags),
    playSound = CreateConVar("ttt2_med_defibrillator_play_sounds", "1", flags),
    reviveTime = CreateConVar("ttt2_med_defibrillator_revive_time", "3.0", flags),
    errorTime = CreateConVar("ttt2_med_defibrillator_error_time", "1.5", flags),
    successChance = CreateConVar("ttt2_med_defibrillator_success_chance", "80", flags),
    resetConfirmation = CreateConVar("ttt2_med_defibrillator_reset_confirm", "0", flags)
}

SWEP.revivalReason = "revived_by_medic"
if SERVER then
    function SWEP:OnDrop()
        self:Remove()
    end

    function SWEP:OnRevive()
        -- win condition checks, the round state and the variables med_popupstarted/med_fin_heal are important to avoid issues
        if GetConVar("ttt2_med_win_enabled"):GetBool() and GetRoundState() == ROUND_ACTIVE and med_fin_revive == nil then
            if GetConVar("ttt2_med_announce_win_popup"):GetBool() and med_popupstarted == nil then
                net.Start("ttt2_med_role_epop_6") -- the seventh added network string starts here if the convar is true
                net.WriteString(med_rqd_heal) -- writing required health points
                net.WriteInt(GetConVar("ttt2_med_announce_win_popup_duration"):GetInt(), 32) -- writing popup duration
                -- checks if the convars are true/false|false/true
                if GetConVar("ttt2_med_win_rqd_revive"):GetBool() then
                    net.WriteBool(true) -- writing required boolean
                end

                net.Broadcast() -- broadcasting but no popup at the screen yet
            end

            med_popupstarted = true
            med_fin_revive = true
            -- checks if the convars are true, med_fin_revive is true and med_fin_heal is true
            if GetConVar("ttt2_med_win_rqd_revive"):GetBool() and GetConVar("ttt2_med_announce_win_achieved_popup"):GetBool() and med_fin_revive == true and med_fin_heal == true then
                net.Start("ttt2_med_role_epop_7") -- the eighth added network string starts here if the convar is true
                net.WriteInt(GetConVar("ttt2_med_announce_win_achieved_popup_duration"):GetInt(), 32) -- writing popup duration
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
        end
    end
end