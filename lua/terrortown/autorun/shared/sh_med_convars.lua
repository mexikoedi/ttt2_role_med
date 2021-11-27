-- added the convars and set default values with internal descriptions
CreateConVar("ttt2_med_armor", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much armor gets the player")

CreateConVar("ttt2_med_win_enabled", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable win")

CreateConVar("ttt2_med_win_rqd_heal_per_alv_ply", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much healing needs to be done per alive player to win")

CreateConVar("ttt2_med_win_rqd_revive", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable if the medic needs to revive someone to win")

CreateConVar("ttt2_med_disable_kill_death_handling", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Disable or enable kill/death handling")

CreateConVar("ttt2_med_karma_penalty", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable karma penalty")

CreateConVar("ttt2_med_karma_penalty_per_killed_ply", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much karma will be reduced per killed player")

CreateConVar("ttt2_med_announce_arrival_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for the arrival of the medic")

CreateConVar("ttt2_med_announce_arrival_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the arrival popup")

CreateConVar("ttt2_med_announce_force_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Enable or disable popup for a forced medic")

CreateConVar("ttt2_med_announce_force_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Duration of the forced popup")

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

CreateConVar("ttt2_med_defibrillator_distance", "100", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "The defibrillation distance")

CreateConVar("ttt2_med_defibrillator_revive_braindead", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Should the defibrillator be able to revive braindead people or not")

CreateConVar("ttt2_med_defibrillator_play_sounds", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Should the revival process make sounds or not")

CreateConVar("ttt2_med_defibrillator_revive_time", "3.0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "The time needed for the revival")

CreateConVar("ttt2_med_defibrillator_error_time", "1.5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "The cooldown time after an revival attempt")

CreateConVar("ttt2_med_defibrillator_success_chance", "80", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "The chance that a revival is successful")

CreateConVar("ttt2_med_defibrillator_reset_confirm", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Reset confirm state on round begin to prevent short blinking of confirmed roles on round start")

CreateConVar("ttt2_med_medigun_max_range", "450", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Max range (in hammer units) the medigun can heal")

CreateConVar("ttt2_med_medigun_ticks_per_heal", "40", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each healing point(s)")

CreateConVar("ttt2_med_medigun_ticks_per_heal_uber", "25", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each healing point(s) while ubering")

CreateConVar("ttt2_med_medigun_heal_per_tick", "3", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points are received for one heal tick")

CreateConVar("ttt2_med_medigun_heal_per_tick_uber", "4", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points are received for one heal tick while ubering")

CreateConVar("ttt2_med_medigun_ticks_per_self_heal", "300", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each self-healing point(s)")

CreateConVar("ttt2_med_medigun_ticks_per_self_heal_uber", "15", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each self-healing point(s) while ubering")

CreateConVar("ttt2_med_medigun_self_heal_per_tick", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points are self-received for one heal tick")

CreateConVar("ttt2_med_medigun_self_heal_per_tick_uber", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points are self-received for one heal tick while ubering")

CreateConVar("ttt2_med_medigun_self_heal_is_passive", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The holder of the medigun will receive his health points without healing someone")

CreateConVar("ttt2_med_medigun_ticks_per_uber", "50", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each pct of uber")

CreateConVar("ttt2_med_medigun_uber_seconds", "8", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many seconds should the uber last")

CreateConVar("ttt2_med_medigun_uber_headshot_dmg_get_pct", "0.50", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Pct of damage a headshot will actually do")

CreateConVar("ttt2_med_medigun_uber_general_dmg_get_pct", "0.60", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Pct of damage other things will actually do")

CreateConVar("ttt2_med_medigun_enable_beam", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should the heal beam be rendered")

CreateConVar("ttt2_med_medigun_call_healing_hook", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should we call the heal hook every tick or not at all")

-- for medigun, look in weapon_ttt2_medic_medigun code
TTT2MEDMEDIGUN_DATA = {}

if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add("TTT2FinishedLoading", "TTT2RegistermexikoediAddonDev", function()
        AddTTT2AddonDev("76561198279816989")
    end)
end