L = LANG.GetLanguageTableReference( "deutsch" )
-- GENERAL ROLE LANGUAGE STRINGS
L[ MEDIC.name ] = "Sanitäter"
L[ "info_popup_" .. MEDIC.name ] = [[Du bist ein Sanitäter!
Bleib am leben und hilf allen, solange es möglich ist!]]
L[ "body_found_" .. MEDIC.abbr ] = "Er war ein Sanitäter..."
L[ "search_role_" .. MEDIC.abbr ] = "Diese Person war ein Sanitäter!"
L[ "target_" .. MEDIC.name ] = "Sanitäter"
L[ "ttt2_desc_" .. MEDIC.name ] = [[Der Sanitäter muss jeden mit all seiner Macht heilen (WIRKLICH JEDEN), dafür hat er die Heilwaffe und einen Defribillator.
Versuche, allen zu helfen!]]
L[ "ttt2_role_medic_popuptitle" ] = "Ein Sanitäter ist auf dem Feld angekommen. Der Name lautet: "
L[ "ttt2_role_medic_popuptitle_2" ] = "Der Saniäter wurde getötet! Dieses Kriegsverbrechen wurde begangen von: "
L[ "ttt2_role_medic_popuptitle_3" ] = "Der Sanitäter hat ein Verbrechen begangen! Er hat seine Ausrüstung verloren und hilft nun den Unschuldigen: "
L[ "ttt2_role_medic_popuptitle_4" ] = "Der Sanitäter hat einen anderen Sanitäter getötet! Das ist Verrat, tötet: "
L[ "weapon_med_defi_name" ] = "Sanitäter Defibrillator"
L[ "weapon_med_defi_desc" ] = "Ein hochenergetisches Gerät zum Wiederbeleben anderer Spieler."
L[ "med_revived_by_player" ] = "Sie werden durch {name} wiederbelebt. Bereiten Sie sich vor!"
L[ "med_defi_hold_key_to_revive" ] = "Halte [{key}] um Spieler wiederzubeleben"
L[ "med_defi_revive_progress" ] = "Zeit übrig: {time}s"
L[ "med_defi_charging" ] = "Defibrillator lädt sich auf, bitte warten"
L[ "med_defi_player_already_reviving" ] = "Dieser Spieler wird bereits wiederbelebt"
L[ "med_defi_error_braindead" ] = "Du kannst keinen hirntoten Spieler wiederbeleben."
L[ "med_defi_error_no_space" ] = "Es ist nicht genügend Platz vorhanden um den Spieler wiederzubeleben."
L[ "med_defi_error_too_fast" ] = "Defibrillator lädt sich auf. Bitte warten."
L[ "med_defi_error_lost_target" ] = "Du hast dein Ziel verloren. Bitte versuche es erneut."
L[ "med_defi_error_no_valid_ply" ] = "Du kannst diesen Spieler nicht wiederbeleben, da er nicht länger valide ist."
L[ "med_defi_error_already_reviving" ] = "Du kannst diesen Spieler nicht wiederbeleben, da er bereits wiederbelebt wird."
L[ "med_defi_error_failed" ] = "Wiederbeleben fehlgeschlagen. Bitte versuche es erneut."
L[ "ttt2_med_defibrillator_help1" ] = "{primaryfire} Leichen wiederbeleben."
L[ "ttt2_med_defibrillator_help2" ] = "{secondaryfire} Piepton abspielen."
L[ "weapon_med_medigun_name" ] = "Sanitäter Heilwaffe"
L[ "weapon_med_medigun_desc" ] = "Heile Spieler und UBER ZEM! RAUS RAUS."
L[ "ttt2_med_medigun_help1" ] = "{primaryfire} Heile jemanden mit einem starken Heilstrahl."
L[ "ttt2_med_medigun_help2" ] = "{secondaryfire} Verwenden Sie nach dem Aufladen Ubercharge, um Ihren Strahl stärker zu machen."
