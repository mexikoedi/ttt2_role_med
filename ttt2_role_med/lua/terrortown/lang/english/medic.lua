L = LANG.GetLanguageTableReference( "english" )
-- GENERAL ROLE LANGUAGE STRINGS
L[ MEDIC.name ] = "Medic"
L[ "info_popup_" .. MEDIC.name ] = [[You are a Medic!
Stay alive and help everyone if you can!]]
L[ "body_found_" .. MEDIC.abbr ] = "They were a Medic."
L[ "search_role_" .. MEDIC.abbr ] = "This person was a Medic!"
L[ "target_" .. MEDIC.name ] = "Medic"
L[ "ttt2_desc_" .. MEDIC.name ] = [[The Medic has to provide everyone with medicine with all his might (REALLY EVERYONE), for that you have the Medigun and a Defibrillator.
Try to help everyone!]]
L[ "ttt2_role_medic_popuptitle" ] = "A medic has arrived in the field, they're name is: "
L[ "ttt2_role_medic_popuptitle_2" ] = "The medic was killed! This war crime was commited by: "
L[ "ttt2_role_medic_popuptitle_3" ] = "The medic has commited a crime! He's lost his equipment and now is helping the innocent: "
L[ "ttt2_role_medic_popuptitle_4" ] = "The medic has killed another medic! This is treason, kill: "
L[ "weapon_med_defi_name" ] = "Medic Defibrillator"
L[ "weapon_med_defi_desc" ] = "A high energy device to revive other players."
L[ "med_revived_by_player" ] = "You are being revived by {name}. Prepare yourself!"
L[ "med_defi_hold_key_to_revive" ] = "Hold [{key}] to revive player"
L[ "med_defi_revive_progress" ] = "Time left: {time}s"
L[ "med_defi_charging" ] = "Defibrillator is recharging, please wait"
L[ "med_defi_player_already_reviving" ] = "Player is already reviving"
L[ "med_defi_error_braindead" ] = "You can't revive a braindead player."
L[ "med_defi_error_no_space" ] = "There is insufficient room available for this revival attempt."
L[ "med_defi_error_too_fast" ] = "Defibrillator is recharging. Please wait."
L[ "med_defi_error_lost_target" ] = "You lost your target. Please try again."
L[ "med_defi_error_no_valid_ply" ] = "You can't revive this player since they are no longer valid."
L[ "med_defi_error_already_reviving" ] = "You can't revive this player since they are already reviving."
L[ "med_defi_error_failed" ] = "Revival attempt failed. Please try again."
L[ "ttt2_med_defibrillator_help1" ] = "{primaryfire} Revive corpses."
L[ "ttt2_med_defibrillator_help2" ] = "{secondaryfire} Play beep sound."
L[ "ttt2_med_medigun_help1" ] = "{primaryfire} Heal someone with a strong healing beam."
L[ "ttt2_med_medigun_help2" ] = "{secondaryfire} Once charged, use Ubercharge to make your beam stronger."
