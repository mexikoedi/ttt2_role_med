-- convars added with default values
CreateConVar("ttt2_med_armor", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "how much armor")

CreateConVar("ttt2_med_win_enabled", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable win")

CreateConVar("ttt2_med_win_rqd_heal_per_ply", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much healing needs to be done per player to win")

CreateConVar("ttt2_med_disable_kill_death_handling", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "disable kill/death handling")

CreateConVar("ttt2_med_announce_arrival_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for the arrival of the medic")

CreateConVar("ttt2_med_announce_arrival_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the arrival popup")

CreateConVar("ttt2_med_announce_force_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for a forced medic")

CreateConVar("ttt2_med_announce_force_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the forced popup")

CreateConVar("ttt2_med_announce_death_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for the death of one medic")

CreateConVar("ttt2_med_announce_death_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the death popup")

CreateConVar("ttt2_med_announce_crime_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for a crime on the medic")

CreateConVar("ttt2_med_announce_crime_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the crime popup")

CreateConVar("ttt2_med_announce_betrayel_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for a betrayel on the medic")

CreateConVar("ttt2_med_announce_betrayel_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the betrayel popup")

CreateConVar("ttt2_med_announce_accident_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for an accident by the medic")

CreateConVar("ttt2_med_announce_accident_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the accident popup")

CreateConVar("ttt2_med_announce_win_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for an win by the medic")

CreateConVar("ttt2_med_announce_win_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the win popup")

CreateConVar("ttt2_med_announce_win_achieved_popup", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "enable or disable popup for an win achieved by the medic")

CreateConVar("ttt2_med_announce_win_achieved_popup_duration", "5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "duration of the win achieved popup")

CreateConVar("ttt2_med_defibrillator_distance", "100", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "the defibrillation distance")

CreateConVar("ttt2_med_defibrillator_revive_braindead", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "should the defibrillator be able to revive braindead people or not")

CreateConVar("ttt2_med_defibrillator_play_sounds", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "should the revival process make sounds or not")

CreateConVar("ttt2_med_defibrillator_revive_time", "3.0", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "the time needed for the revival")

CreateConVar("ttt2_med_defibrillator_error_time", "1.5", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "the cooldown time after an revival attempt")

CreateConVar("ttt2_med_defibrillator_success_chance", "80", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "the chance that a revival is successful")

CreateConVar("ttt2_med_defibrillator_reset_confirm", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "reset confirm state on round begin to prevent short blinking of confirmed roles on round start")

CreateConVar("ttt2_med_medigun_max_range", "450", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Max Range (in Hammer units) the Medigun can heal")

CreateConVar("ttt2_med_medigun_ticks_per_heal", "40", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each healing point(s)")

CreateConVar("ttt2_med_medigun_ticks_per_heal_uber", "25", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each healing point(s) while ubering")

CreateConVar("ttt2_med_medigun_heal_per_tick", "3", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points received for 1 heal tick")

CreateConVar("ttt2_med_medigun_heal_per_tick_uber", "4", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points received for 1 heal tick while ubering")

CreateConVar("ttt2_med_medigun_ticks_per_self_heal", "300", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each self healing point(s)")

CreateConVar("ttt2_med_medigun_ticks_per_self_heal_uber", "15", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each self healing point(s) while ubering")

CreateConVar("ttt2_med_medigun_self_heal_per_tick", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points self-received for 1 heal tick")

CreateConVar("ttt2_med_medigun_self_heal_per_tick_uber", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many health points self-received for 1 heal tick while ubering")

CreateConVar("ttt2_med_medigun_self_heal_is_passive", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The Holder of the Medigun will receive his HP without healing someone")

CreateConVar("ttt2_med_medigun_ticks_per_uber", "50", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many ticks between each pct of uber")

CreateConVar("ttt2_med_medigun_uber_seconds", "8", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many seconds should the uber last")

CreateConVar("ttt2_med_medigun_uber_headshot_dmg_get_pct", "0.50", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "PCT of damage a headshot will actually do")

CreateConVar("ttt2_med_medigun_uber_general_dmg_get_pct", "0.60", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "PCT of damage other things will actually do")

CreateConVar("ttt2_med_medigun_enable_beam", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should the heal-beam be rendered")

CreateConVar("ttt2_med_medigun_call_healing_hook", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should we call the heal hook every tick or not at all")

if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add("TTT2FinishedLoading", "TTT2RegistermexikoediAddonDev", function()
        AddTTT2AddonDev("76561198279816989")
    end)
end

-- added the convars into ulx and set if the ulx convars have slider or checkbox, the min/max values, description and where to insert the convars in ulx
hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_medic_convars", function(tbl)
    tbl[ROLE_MEDIC] = tbl[ROLE_MEDIC] or {}

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_armor",
        slider = true,
        min = 0,
        max = 100,
        decimal = 0,
        desc = "ttt2_med_armor (def. 50)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_win_enabled",
        checkbox = true,
        desc = "ttt2_med_win_enabled (def. 0)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_win_rqd_heal_per_ply",
        slider = true,
        min = 1,
        max = 100,
        decimal = 0,
        desc = "ttt2_med_win_rqd_heal_per_ply (def. 25)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_disable_kill_death_handling",
        checkbox = true,
        desc = "ttt2_med_disable_kill_death_handling (def. 0)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_arrival_popup",
        checkbox = true,
        desc = "ttt2_med_announce_arrvival_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_arrival_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_arrival_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_force_popup",
        checkbox = true,
        desc = "ttt2_med_announce_force_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_force_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_force_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_death_popup",
        checkbox = true,
        desc = "ttt2_med_announce_death_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_death_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_death_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_crime_popup",
        checkbox = true,
        desc = "ttt2_med_announce_crime_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_crime_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_crime_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_betrayel_popup",
        checkbox = true,
        desc = "ttt2_med_announce_betrayel_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_betrayel_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_betrayel_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_accident_popup",
        checkbox = true,
        desc = "ttt2_med_announce_accident_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_accident_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_accident_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_win_popup",
        checkbox = true,
        desc = "ttt2_med_announce_win_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_win_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_win_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_win_achieved_popup",
        checkbox = true,
        desc = "ttt2_med_announce_win_achieved_popup (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_announce_win_achieved_popup_duration",
        slider = true,
        min = 1,
        max = 15,
        decimal = 0,
        desc = "ttt2_med_announce_win_achieved_popup_duration (def. 5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_distance",
        slider = true,
        min = 0,
        max = 250,
        decimal = 0,
        desc = "ttt2_med_defibrillator_distance (def. 100)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_revive_braindead",
        checkbox = true,
        desc = "ttt2_med_defibrillator_revive_braindead (def. 0)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_play_sounds",
        checkbox = true,
        desc = "ttt2_med_defibrillator_play_sounds (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_revive_time",
        slider = true,
        min = 0,
        max = 15,
        decimal = 1,
        desc = "ttt2_med_defibrillator_revive_time (def. 3.0)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_error_time",
        slider = true,
        min = 0,
        max = 15,
        decimal = 1,
        desc = "ttt2_med_defibrillator_error_time (def. 1.5)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_success_chance",
        slider = true,
        min = 0,
        max = 100,
        decimal = 0,
        desc = "ttt2_med_defibrillator_success_chance (def. 80)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_defibrillator_reset_confirm",
        checkbox = true,
        desc = "ttt2_med_defibrillator_reset_confirm (def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_max_range",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_max_range (Def. 450)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_ticks_per_heal",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_ticks_per_heal (Def. 40)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_ticks_per_heal_uber",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_ticks_per_heal_uber (Def. 25)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_heal_per_tick",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_heal_per_tick (Def. 3)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_heal_per_tick_uber",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_heal_per_tick_uber (Def. 4)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_ticks_per_self_heal",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_ticks_per_self_heal (Def. 300)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_ticks_per_self_heal_uber",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_ticks_per_self_heal_uber (Def. 15)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_self_heal_per_tick",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_self_heal_per_tick (Def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_self_heal_per_tick_uber",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_self_heal_per_tick_uber (Def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_ticks_per_uber",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_ticks_per_uber (Def. 50)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_uber_seconds",
        slider = true,
        min = 1,
        max = 10000,
        decimal = 0,
        desc = "ttt2_med_medigun_uber_seconds (Def. 8)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_uber_headshot_dmg_get_pct",
        slider = true,
        min = 0,
        max = 1,
        decimal = 1,
        desc = "ttt2_med_medigun_uber_headshot_dmg_get_pct (Def. 0.50)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_uber_general_dmg_get_pct",
        slider = true,
        min = 0,
        max = 1,
        decimal = 1,
        desc = "ttt2_med_medigun_uber_general_dmg_get_pct (Def. 0.60)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_self_heal_is_passive",
        checkbox = true,
        desc = "ttt2_med_medigun_self_heal_is_passive (Def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_enable_beam",
        checkbox = true,
        desc = "ttt2_med_medigun_enable_beam (Def. 1)"
    })

    table.insert(tbl[ROLE_MEDIC], {
        cvar = "ttt2_med_medigun_call_healing_hook",
        checkbox = true,
        desc = "ttt2_med_medigun_call_healing_hook (Def. 0)"
    })
end)

if SERVER then
    -- for medigun, look weapon_ttt2_medic_medigun.lua
    TTT2MEDMEDIGUN_DATA = {}
end