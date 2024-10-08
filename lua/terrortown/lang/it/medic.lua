local L = LANG.GetLanguageTableReference("it")
-- GENERAL ROLE LANGUAGE STRINGS
L[MEDIC.name] = "Medico"
L["info_popup_" .. MEDIC.name] = [[Sei un Medico!
Stai vivo e aiuta tutti se puoi!]]
L["body_found_" .. MEDIC.abbr] = "Lui era un Medico."
L["search_role_" .. MEDIC.abbr] = "Questa persona era un Medico!"
L["target_" .. MEDIC.name] = "Medico"
L["ttt2_desc_" .. MEDIC.name] = [[Il Medico deve curare tutti con tutte le sue forze (VERAMENTE TUTTI), per questo ha l'arma curativa e il defibrillatore.
cerca di aiutare tutti!]]
-- OTHER ROLE LANGUAGE STRINGS
L["med_karma_penalty_tooltip"] = "Crimine"
L["ttt2_role_medic_popuptitle_1"] = "Un Medico è arrivato sul campo, il suo nome è: "
L["ttt2_role_medic_popuptitle_1.5"] = "I Medici sono arrivati sul campo, i loro nomi sono: "
L["ttt2_role_medic_popuptitle_2"] = "Il Medico è stato ucciso! Questo crimine è stato commesso da: "
L["ttt2_role_medic_popuptitle_3"] = "Il Medico ha commesso un crimine! ha perso tutto il suo equipaggiamente e ora lavora con gli innocenti: "
L["ttt2_role_medic_popuptitle_4"] = "Il Medico ha ucciso un altro Medico! Questo è un Tradimento, Uccidi: "
L["ttt2_role_medic_popuptitle_5"] = "Questo Medico potrebbe aver avuto un incidente: "
L["ttt2_role_medic_popuptitle_6"] = "Il medico deve rimanere in vita e ha bisogno di guarire: "
L["ttt2_role_medic_popuptitle_6_1"] = "! Deve anche rianimare un giocatore!"
L["ttt2_role_medic_popuptitle_6.5"] = "I medici devono rimanere in vita e devono guarire insieme: "
L["ttt2_role_medic_popuptitle_6.5_1"] = "! Inoltre devono rianimare un giocatore!"
L["ttt2_role_medic_popuptitle_7"] = "Il medico ha raggiunto la condizione di vittoria! Ha bisogno di rimanere in vita!"
L["ttt2_role_medic_popuptitle_7.5"] = "I medici hanno raggiunto la condizione di vittoria! Hanno bisogno di rimanere in vita!"
L["weapon_med_defi_name"] = "Defibrillatore Medico"
L["weapon_med_defi_desc"] = "Un dispositivo ad alta tecnologia per rianimare un altro giocatore."
L["revived_by_medic"] = "Stai venendo rianimato da medico {name}. Preparati!"
L["weapon_med_medigun_name"] = "Medico arma curativa"
L["weapon_med_medigun_desc"] = "Guarisci i giocatori e UBER ZEM! FUORI FUORI."
L["ttt2_med_medigun_help1"] = "Cura qualcuno con un potente raggio"
L["ttt2_med_medigun_help2"] = "Una volta carico, usa l'Ubercharge per fare diventare il tuo giocatore più forte"
L["label_med_armor"] = "Punti armatura"
L["label_med_win_enabled"] = "Abilita la condizione di vittoria"
L["label_med_win_rqd_heal_per_alv_ply"] = "Punti di guarigione richiesti per la vittoria (per giocatore)"
L["label_med_win_rqd_revive"] = "Abilita il risveglio richiesto per la vittoria"
L["label_med_disable_kill_death_handling"] = "Disabilita la trasformazione in innocente o traditore"
L["label_med_disable_defibrillator"] = "Disabilita il defibrillatore"
L["label_med_karma_penalty"] = "Abilita la punizione del karma"
L["label_med_karma_penalty_per_killed_ply"] = "Punti di punizione karma per giocatore"
L["label_med_announce_arrival_popup"] = "Abilita annuncio di arrivo"
L["label_med_announce_arrival_popup_duration"] = "Durata dell'annuncio di arrivo"
L["label_med_announce_death_popup"] = "Abilita annuncio di morte"
L["label_med_announce_death_popup_duration"] = "Durata dell'annuncio di morte"
L["label_med_announce_crime_popup"] = "Abilita l'annuncio del crimine"
L["label_med_announce_crime_popup_duration"] = "Durata dell'annuncio del crimine"
L["label_med_announce_betrayal_popup"] = "Abilita annuncio tradimento"
L["label_med_announce_betrayal_popup_duration"] = "Durata dell'annuncio del tradimento"
L["label_med_announce_accident_popup"] = "Abilita annuncio incidente"
L["label_med_announce_accident_popup_duration"] = "Durata dell'annuncio dell'incidente"
L["label_med_announce_win_popup"] = "Abilita l'annuncio delle condizioni di vittoria"
L["label_med_announce_win_popup_duration"] = "Durata dell'annuncio della condizione di vittoria"
L["label_med_announce_win_achieved_popup"] = "Abilita annuncio vittoria"
L["label_med_announce_win_achieved_popup_duration"] = "Durata dell'annuncio della vittoria"
L["label_med_medigun_max_range"] = "Distanza massima per la guarigione (unità hammer)"
L["label_med_medigun_ticks_per_heal"] = "Distanza tra i punti di guarigione (ticks)"
L["label_med_medigun_ticks_per_heal_uber"] = "Distanza tra i punti di guarigione - ubering (ticks)"
L["label_med_medigun_heal_per_tick"] = "Punti curativi che vengono curati (ticks)"
L["label_med_medigun_heal_per_tick_uber"] = "Punti di guarigione che vengono curati - ubering (ticks)"
L["label_med_medigun_ticks_per_self_heal"] = "Distanza tra i punti di autoguarigione (ticks)"
L["label_med_medigun_ticks_per_self_heal_uber"] = "Distanza tra i punti di autoguarigione - ubering (ticks)"
L["label_med_medigun_self_heal_per_tick"] = "Punti di autoguarigione che vengono curati (ticks)"
L["label_med_medigun_self_heal_per_tick_uber"] = "Punti di autoguarigione che vengono curati - ubering (ticks)"
L["label_med_medigun_self_heal_is_passive"] = "Ricevi punti guarigione senza curare nessuno"
L["label_med_medigun_ticks_per_uber"] = "Distanza tra le percentuali di uber ricarica (ticks)"
L["label_med_medigun_uber_seconds"] = "Quanto dovrebbe durare l'ubering"
L["label_med_medigun_uber_headshot_dmg_get_pct"] = "Pct di danni testa subiti mentre il giocatore è ubert"
L["label_med_medigun_uber_general_dmg_get_pct"] = "Pct di danni normali subiti mentre il giocatore è ubert"
L["label_med_medigun_enable_beam"] = "Mostra il raggio dell'arma curativa"
L["label_med_medigun_call_healing_hook"] = "Eseguì il gancio di guarigione ogni tick"