if engine.ActiveGamemode( ) ~= "terrortown" then return end -- we need this (or we can have this) to prevent this file from loading if the gamemmode is not ttt, this is only needed here lua/autorun, in /terrortown/... is this not needed

-- convars added with default values
CreateConVar( "ttt2_med_armor" , "50" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_arrival_popup" , "1" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_arrival_popup_duration" , "5" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_death_popup" , "1" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_death_popup_duration" , "5" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_crime_popup" , "1" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_crime_popup_duration" , "5" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_betrayel_popup" , "1" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_announce_betrayel_popup_duration" , "5" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_distance" , "100" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_revive_braindead" , "0" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_play_sounds" , "1" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_revive_time" , "3.0" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_error_time" , "1.5" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_defibrillator_success_chance" , "75" , { FCVAR_NOTIFY , FCVAR_ARCHIVE } )

CreateConVar( "ttt2_med_medigun_max_range" , "450" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "Max Range (in Hammer units) the Medigun can heal" )

CreateConVar( "ttt2_med_medigun_ticks_per_heal" , "40" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many ticks between each healing point(s)" )

CreateConVar( "ttt2_med_medigun_ticks_per_heal_uber" , "25" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many ticks between each healing point(s) while ubering" )

CreateConVar( "ttt2_med_medigun_heal_per_tick" , "3" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many health points received for 1 heal tick" )

CreateConVar( "ttt2_med_medigun_heal_per_tick_uber" , "4" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many health points received for 1 heal tick while ubering" )

CreateConVar( "ttt2_med_medigun_ticks_per_self_heal" , "300" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many ticks between each self healing point(s)" )

CreateConVar( "ttt2_med_medigun_ticks_per_self_heal_uber" , "15" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many ticks between each self healing point(s) while ubering" )

CreateConVar( "ttt2_med_medigun_self_heal_per_tick" , "1" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many health points self-received for 1 heal tick" )

CreateConVar( "ttt2_med_medigun_self_heal_per_tick_uber" , "1" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many health points self-received for 1 heal tick while ubering" )

CreateConVar( "ttt2_med_medigun_self_heal_is_passive" , "1" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "The Holder of the Medigun will receive his HP without healing someone" )

CreateConVar( "ttt2_med_medigun_ticks_per_uber" , "50" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many ticks between each pct of uber" )

CreateConVar( "ttt2_med_medigun_uber_seconds" , "8" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "How many seconds should the uber last" )

CreateConVar( "ttt2_med_medigun_enable_beam" , "1" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "Should the heal-beam be rendered" )

CreateConVar( "ttt2_med_medigun_call_healing_hook" , "0" , { FCVAR_SERVER_CAN_EXECUTE , FCVAR_ARCHIVE , FCVAR_NOTIFY } , "Should we call the heal hook every tick or not at all" )

if CLIENT then
    -- Use string or string.format("%.f",<steamid64>) 
    -- addon dev emblem in scoreboard
    hook.Add( "TTT2FinishedLoading" , "TTT2RegistermexikoediAddonDev" , function( )
        AddTTT2AddonDev( "76561198279816989" )
    end )
end

-- added the convars into ulx and set if the ulx convars have slider or checkbox, the min/max values, description and where to insert the convars in ulx
hook.Add( "TTTUlxDynamicRCVars" , "ttt2_ulx_dynamic_medic_convars" , function( tbl )
    tbl[ ROLE_MEDIC ] = tbl[ ROLE_MEDIC ] or { }

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_armor" ,
        slider = true ,
        min = 0 ,
        max = 100 ,
        decimal = 0 ,
        desc = "ttt2_med_armor (def. 50)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_arrival_popup" ,
        checkbox = true ,
        desc = "ttt2_med_announce_arrvival_popup (def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_arrival_popup_duration" ,
        slider = true ,
        min = 1 ,
        max = 15 ,
        decimal = 0 ,
        desc = "ttt2_med_announce_arrival_popup_duration (def. 5)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_death_popup" ,
        checkbox = true ,
        desc = "ttt2_med_announce_death_popup (def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_death_popup_duration" ,
        slider = true ,
        min = 1 ,
        max = 15 ,
        decimal = 0 ,
        desc = "ttt2_med_announce_death_popup_duration (def. 5)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_crime_popup" ,
        checkbox = true ,
        desc = "ttt2_med_announce_crime_popup (def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_crime_popup_duration" ,
        slider = true ,
        min = 1 ,
        max = 15 ,
        decimal = 0 ,
        desc = "ttt2_med_announce_crime_popup_duration (def. 5)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_betrayel_popup" ,
        checkbox = true ,
        desc = "ttt2_med_announce_betrayel_popup (def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_announce_betrayel_popup_duration" ,
        slider = true ,
        min = 1 ,
        max = 15 ,
        decimal = 0 ,
        desc = "ttt2_med_announce_betrayel_popup_duration (def. 5)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_distance" ,
        slider = true ,
        min = 0 ,
        max = 250 ,
        decimal = 0 ,
        desc = "ttt2_med_defibrillator_distance (def. 100)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_revive_braindead" ,
        checkbox = true ,
        desc = "ttt2_med_defibrillator_revive_braindead (def. 0)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_play_sounds" ,
        checkbox = true ,
        desc = "ttt2_med_defibrillator_play_sounds (def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_revive_time" ,
        slider = true ,
        min = 0 ,
        max = 15 ,
        decimal = 1 ,
        desc = "ttt2_med_defibrillator_revive_time (def. 3.0)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_error_time" ,
        slider = true ,
        min = 0 ,
        max = 15 ,
        decimal = 1 ,
        desc = "ttt2_med_defibrillator_error_time (def. 1.5)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_defibrillator_success_chance" ,
        slider = true ,
        min = 0 ,
        max = 100 ,
        decimal = 0 ,
        desc = "ttt2_med_defibrillator_success_chance (def. 75)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_max_range" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_max_range (Def. 450)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_ticks_per_heal" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_ticks_per_heal (Def. 40)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_ticks_per_heal_uber" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_ticks_per_heal_uber (Def. 25)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_heal_per_tick" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_heal_per_tick (Def. 3)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_heal_per_tick_uber" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_heal_per_tick_uber (Def. 4)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_ticks_per_self_heal" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_ticks_per_self_heal (Def. 300)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_ticks_per_self_heal_uber" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_ticks_per_self_heal_uber (Def. 15)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_self_heal_per_tick" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_self_heal_per_tick (Def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_self_heal_per_tick_uber" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_self_heal_per_tick_uber (Def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_ticks_per_uber" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_ticks_per_uber (Def. 50)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_uber_seconds" ,
        slider = true ,
        min = 1 ,
        max = 10000 ,
        decimal = 0 ,
        desc = "ttt2_med_medigun_uber_seconds (Def. 8)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_self_heal_is_passive" ,
        checkbox = true ,
        desc = "ttt2_med_medigun_self_heal_is_passive (Def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_enable_beam" ,
        checkbox = true ,
        desc = "ttt2_med_medigun_enable_beam (Def. 1)"
    } )

    table.insert( tbl[ ROLE_MEDIC ] , {
        cvar = "ttt2_med_medigun_call_healing_hook" ,
        checkbox = true ,
        desc = "ttt2_med_medigun_call_healing_hook (Def. 0)"
    } )
end )

-- medigun has a different approach on convars, that's why this is needed, maybe not needed but yeah ... why not, look into weapon_ttt2_medic_medigun.lua
if SERVER then
    TTT2MEDMEDIGUN_DATA = { }
    TTT2MEDMEDIGUN_DATA.CVARS = { }
    TTT2MEDMEDIGUN_DATA.CVARS.max_range = GetConVar( "ttt2_med_medigun_max_range" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_tick = GetConVar( "ttt2_med_medigun_ticks_per_heal" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_tick_uber = GetConVar( "ttt2_med_medigun_ticks_per_heal_uber" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_points_tick = GetConVar( "ttt2_med_medigun_heal_per_tick" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_points_tick_uber = GetConVar( "ttt2_med_medigun_heal_per_tick_uber" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_tick_self = GetConVar( "ttt2_med_medigun_ticks_per_self_heal" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_tick_self_uber = GetConVar( "ttt2_med_medigun_ticks_per_self_heal_uber" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_points_tick_self = GetConVar( "ttt2_med_medigun_self_heal_per_tick" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_points_tick_self_uber = GetConVar( "ttt2_med_medigun_self_heal_per_tick_uber" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.heal_self_passive = GetConVar( "ttt2_med_medigun_self_heal_is_passive" ):GetBool( )
    TTT2MEDMEDIGUN_DATA.CVARS.uber_tick = GetConVar( "ttt2_med_medigun_ticks_per_uber" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.uber_seconds = GetConVar( "ttt2_med_medigun_uber_seconds" ):GetInt( )
    TTT2MEDMEDIGUN_DATA.CVARS.enable_beam = GetConVar( "ttt2_med_medigun_enable_beam" ):GetBool( )
    TTT2MEDMEDIGUN_DATA.CVARS.call_healing_hook = GetConVar( "ttt2_med_medigun_call_healing_hook" ):GetBool( )
end
