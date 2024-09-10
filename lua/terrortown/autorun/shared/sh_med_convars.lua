-- added the convars and set default values with internal descriptions
CreateConVar("ttt2_med_armor", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much armor gets the player")
CreateConVar("ttt2_med_win_enabled", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable win")
CreateConVar("ttt2_med_win_rqd_heal_per_alv_ply", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much healing needs to be done per alive player to win")
CreateConVar("ttt2_med_win_rqd_revive", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable if the medic needs to revive someone to win")
CreateConVar("ttt2_med_disable_kill_death_handling", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Disable or enable kill/death handling")
CreateConVar("ttt2_med_disable_defibrillator", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Disable or enable defibrillator")
CreateConVar("ttt2_med_karma_penalty", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable karma penalty")
CreateConVar("ttt2_med_karma_penalty_per_killed_ply", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much karma will be reduced per killed player")
CreateConVar("ttt2_med_announce_arrival_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for the arrival of the medic")
CreateConVar("ttt2_med_announce_arrival_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the arrival popup")
CreateConVar("ttt2_med_announce_death_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for the death of one medic")
CreateConVar("ttt2_med_announce_death_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the death popup")
CreateConVar("ttt2_med_announce_crime_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for a crime on the medic")
CreateConVar("ttt2_med_announce_crime_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the crime popup")
CreateConVar("ttt2_med_announce_betrayal_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for a betrayal on the medic")
CreateConVar("ttt2_med_announce_betrayal_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the betrayal popup")
CreateConVar("ttt2_med_announce_accident_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for an accident by the medic")
CreateConVar("ttt2_med_announce_accident_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the accident popup")
CreateConVar("ttt2_med_announce_win_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for a win by the medic")
CreateConVar("ttt2_med_announce_win_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the win popup")
CreateConVar("ttt2_med_announce_win_achieved_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for a win achieved by the medic")
CreateConVar("ttt2_med_announce_win_achieved_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the win achieved popup")
-- for medigun, look in weapon_ttt2_medic_medigun code
TTT2MEDMEDIGUN_DATA = {}
if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add("TTT2FinishedLoading", "TTT2RegistermexikoediAddonDev", function() AddTTT2AddonDev("76561198279816989") end)
end