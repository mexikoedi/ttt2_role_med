local L = LANG.GetLanguageTableReference("de")
-- GENERAL ROLE LANGUAGE STRINGS
L[MEDIC.name] = "Sanitäter"
L["info_popup_" .. MEDIC.name] = [[Du bist ein Sanitäter!
Bleib am leben und hilf allen, solange es möglich ist!]]
L["body_found_" .. MEDIC.abbr] = "Er war ein Sanitäter..."
L["search_role_" .. MEDIC.abbr] = "Diese Person war ein Sanitäter!"
L["target_" .. MEDIC.name] = "Sanitäter"
L["ttt2_desc_" .. MEDIC.name] = [[Der Sanitäter muss jeden mit all seiner Macht heilen (WIRKLICH JEDEN), dafür hat er die Heilwaffe und einen Defribillator.
Versuche, allen zu helfen!]]
-- OTHER ROLE LANGUAGE STRINGS
L["med_karma_penalty_tooltip"] = "Verbrechen"
L["ttt2_role_medic_popuptitle_1"] = "Ein Sanitäter ist auf dem Feld angekommen. Der Name lautet: "
L["ttt2_role_medic_popuptitle_2"] = "Dieser Spieler wurde zu einem Sanitäter gezwungen: "
L["ttt2_role_medic_popuptitle_3"] = "Der Sanitäter wurde getötet! Dieses Kriegsverbrechen wurde begangen von: "
L["ttt2_role_medic_popuptitle_4"] = "Der Sanitäter hat ein Verbrechen begangen! Er hat seine Ausrüstung verloren und hilft nun den Unschuldigen: "
L["ttt2_role_medic_popuptitle_5"] = "Der Sanitäter hat einen anderen Sanitäter getötet! Das ist Verrat, tötet: "
L["ttt2_role_medic_popuptitle_6"] = "Dieser Sanitäter hatte möglicherweise einen Unfall: "
L["ttt2_role_medic_popuptitle_7"] = "Du musst am Leben bleiben und du musst heilen: "
L["ttt2_role_medic_popuptitle_7_1"] = " und du musst einen Spieler wiederbeleben!"
L["ttt2_role_medic_popuptitle_8"] = "Bleiben Sie am Leben, Sie haben die Siegbedingung erreicht!"
L["weapon_med_defi_name"] = "Sanitäter Defibrillator"
L["weapon_med_defi_desc"] = "Ein hochenergetisches Gerät zum Wiederbeleben anderer Spieler."
L["med_revived_by_player"] = "Sie werden durch {name} wiederbelebt. Bereiten Sie sich vor!"
L["med_defi_hold_key_to_revive"] = "Halte [{key}] um Spieler wiederzubeleben"
L["med_defi_revive_progress"] = "Zeit übrig: {time}s"
L["med_defi_charging"] = "Defibrillator lädt sich auf, bitte warten"
L["med_defi_player_already_reviving"] = "Dieser Spieler wird bereits wiederbelebt"
L["med_defi_error_braindead"] = "Du kannst keinen hirntoten Spieler wiederbeleben."
L["med_defi_error_no_space"] = "Es ist nicht genügend Platz vorhanden um den Spieler wiederzubeleben."
L["med_defi_error_too_fast"] = "Defibrillator lädt sich auf. Bitte warten."
L["med_defi_error_lost_target"] = "Du hast dein Ziel verloren. Bitte versuche es erneut."
L["med_defi_error_no_valid_ply"] = "Du kannst diesen Spieler nicht wiederbeleben, da er nicht länger valide ist."
L["med_defi_error_already_reviving"] = "Du kannst diesen Spieler nicht wiederbeleben, da er bereits wiederbelebt wird."
L["med_defi_error_failed"] = "Wiederbeleben fehlgeschlagen. Bitte versuche es erneut."
L["med_defi_error_player_alive"] = "Du kannst diesen Spieler nicht wiederbeleben, da er bereits am Leben ist."
L["ttt2_med_defibrillator_help1"] = "{primaryfire} Leichen wiederbeleben."
L["ttt2_med_defibrillator_help2"] = "{secondaryfire} Piepton abspielen."
L["weapon_med_medigun_name"] = "Sanitäter Heilwaffe"
L["weapon_med_medigun_desc"] = "Heile Spieler und UBER ZEM! RAUS RAUS."
L["ttt2_med_medigun_help1"] = "{primaryfire} Heile jemanden mit einem starken Heilstrahl."
L["ttt2_med_medigun_help2"] = "{secondaryfire} Verwenden Sie nach dem Aufladen Ubercharge, um Ihren Strahl stärker zu machen."
L["label_med_armor"] = "Rüstungspunkte"
L["label_med_win_enabled"] = "Aktiviere die Siegbedingung"
L["label_med_win_rqd_heal_per_alv_ply"] = "Erforderliche Heilpunkte für den Sieg"
L["label_med_win_rqd_revive"] = "Aktiviere die erforderliche Wiederbelebung für den Sieg"
L["label_med_disable_kill_death_handling"] = "Deaktiviere die Verwandlung in einen Unschuldigen oder Verräter"
L["label_med_karma_penalty"] = "Aktiviere die Karma-Bestrafung"
L["label_med_karma_penalty_per_killed_ply"] = "Karma-Bestrafungspunkte pro Spieler"
L["label_med_announce_arrival_popup"] = "Aktiviere die Ankunftsankündigung"
L["label_med_announce_arrival_popup_duration"] = "Dauer der Ankunftsankündigung"
L["label_med_announce_force_popup"] = "Aktiviere die Zwangsankündigung"
L["label_med_announce_force_popup_duration"] = "Dauer der Zwangsankündigung"
L["label_med_announce_death_popup"] = "Aktiviere die Todesankündigung"
L["label_med_announce_death_popup_duration"] = "Dauer der Todesankündigung"
L["label_med_announce_crime_popup"] = "Aktiviere die Verbrechensankündigung"
L["label_med_announce_crime_popup_duration"] = "Dauer der Verbrechensankündigung"
L["label_med_announce_betrayel_popup"] = "Aktiviere die Verratsankündigung"
L["label_med_announce_betrayel_popup_duration"] = "Dauer der Verratsankündigung"
L["label_med_announce_accident_popup"] = "Aktiviere die Unfallankündigung"
L["label_med_announce_accident_popup_duration"] = "Dauer der Unfallankündigung"
L["label_med_announce_win_popup"] = "Aktiviere die Siegbedingungankündigung"
L["label_med_announce_win_popup_duration"] = "Dauer der Siegbedingungankündigung"
L["label_med_announce_win_achieved_popup"] = "Aktiviere die Siegesankündigung"
L["label_med_announce_win_achieved_popup_duration"] = "Dauer der Siegesankündigung"
L["label_med_defibrillator_distance"] = "Max. Distanz für die Wiederbelebung"
L["label_med_defibrillator_revive_braindead"] = "Ermögliche die Wiederbelebung hirntoter Spieler"
L["label_med_defibrillator_play_sounds"] = "Aktiviere die Töne während der Wiederbelebung"
L["label_med_defibrillator_revive_time"] = "Zeit bis zur Wiederbelebung"
L["label_med_defibrillator_error_time"] = "Pause nach einer fehlgeschlagenen Wiederbelebung"
L["label_med_defibrillator_success_chance"] = "Chance für erfolgreiche Wiederbelebung"
L["label_med_defibrillator_reset_confirm"] = "Bestätigungsstatus bei Rundenbeginn zurücksetzen"
L["label_med_medigun_max_range"] = "Max. Distanz für Heilung (Hammereinheiten)"
L["label_med_medigun_ticks_per_heal"] = "Abstand zwischen Heilpunkten (Ticks)"
L["label_med_medigun_ticks_per_heal_uber"] = "Abstand zwischen Heilpunkten - ubering (Ticks)"
L["label_med_medigun_heal_per_tick"] = "Heilpunkte die geheilt werden (Ticks)"
L["label_med_medigun_heal_per_tick_uber"] = "Heilpunkte die geheilt werden - ubering (Ticks)"
L["label_med_medigun_ticks_per_self_heal"] = "Abstand zwischen Selbstheilungspunkten (Ticks)"
L["label_med_medigun_ticks_per_self_heal_uber"] = "Abstand zwischen Selbstheilungspunkten - ubering (Ticks)"
L["label_med_medigun_self_heal_per_tick"] = "Selbstheilungspunkte die geheilt werden (Ticks)"
L["label_med_medigun_self_heal_per_tick_uber"] = "Selbstheilungspunkte die geheilt werden - ubering (Ticks)"
L["label_med_medigun_self_heal_is_passive"] = "Erhalte Heilpunkte, ohne jemanden zu heilen"
L["label_med_medigun_ticks_per_uber"] = "Abstand zwischen Uberprozenten (Ticks)"
L["label_med_medigun_uber_seconds"] = "Wie lange das Ubering dauern soll"
L["label_med_medigun_uber_headshot_dmg_get_pct"] = "Proz. Kopfschussschaden, während Spieler geubert wird"
L["label_med_medigun_uber_general_dmg_get_pct"] = "Proz. normalen Schaden, während Spieler geubert wird"
L["label_med_medigun_enable_beam"] = "Zeige den Strahl der Heilwaffe an"
L["label_med_medigun_call_healing_hook"] = "Führe den Heilungshook bei jedem Tick aus"