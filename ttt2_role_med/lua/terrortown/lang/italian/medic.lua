L = LANG.GetLanguageTableReference( "italiano" )
-- GENERAL ROLE LANGUAGE STRINGS
L[ MEDIC.name ] = "Medico"
L[ "info_popup_" .. MEDIC.name ] = [[Sei un Medico!
Stai vivo e aiuta tutti se puoi!]]
L[ "body_found_" .. MEDIC.abbr ] = "Lui era un Medico."
L[ "search_role_" .. MEDIC.abbr ] = "Questa persona era un Medico!"
L[ "target_" .. MEDIC.name ] = "Medico"
L[ "ttt2_desc_" .. MEDIC.name ] = [[Il Medico deve curare tutti con tutte le sue forze (Veramente tutti), per questo ha la Medigun e il defibrillatore.
cerca di aiutare tutti!]]
L[ "ttt2_role_medic_popuptitle" ] = "Un Medico è arrivato sul campo, il suo nome è: "
L[ "ttt2_role_medic_popuptitle_2" ] = "Il Medico è stato ucciso! Questo crimine è stato commesso da: "
L[ "ttt2_role_medic_popuptitle_3" ] = "Il Medico ha commesso un crimine! ha perso tutto il suo equipaggiamente e ora lavora con gli innocenti: "
L[ "ttt2_role_medic_popuptitle_4" ] = "Il Medico ha ucciso un altro Medico! Questo è un Tradimento, Uccidi: "
L[ "weapon_med_defi_name" ] = "Defibrillatore Medico"
L[ "weapon_med_defi_desc" ] = "Un dispositivo ad alta tecnologia per rianimare un altro giocatore."
L[ "med_revived_by_player" ] = "Stai venendo rianimato da {name}. Preparati!"
L[ "med_defi_hold_key_to_revive" ] = "Tieni premuto [{key}] per rianimare un giocatore"
L[ "med_defi_revive_progress" ] = "Tempo rimasto: {time}s"
L[ "med_defi_charging" ] = "Il defribrillatore si sta ricaricando, per favore aspetta"
L[ "med_defi_player_already_reviving" ] = "Il giocatore sta gia rianimando"
L[ "med_defi_error_braindead" ] = "Non puoi rianimare un giocatore senza cervello."
L[ "med_defi_error_no_space" ] = "Non c'è abbastanza spazio per un tentativo di rianimazione."
L[ "med_defi_error_too_fast" ] = "il Defribrillatore si sta carindo. Per favore aspetta."
L[ "med_defi_error_lost_target" ] = "Hai perso il tuo obbiettivo. Per favore riprova."
L[ "med_defi_error_no_valid_ply" ] = "Non puoi rianimare questo giocatore perchè non è piu valido."
L[ "med_defi_error_already_reviving" ] = "Non puoi rianimare questo giocatore poiché sta già rianimando."
L[ "med_defi_error_failed" ] = "Tentativo di rianimazione fallito. Per favore riprova."
L[ "ttt2_med_defibrillator_help1" ] = "{primaryfire} Rianima i cadaveri."
L[ "ttt2_med_defibrillator_help2" ] = "{secondaryfire} Fai un beep sonoro."
L[ "ttt2_med_medigun_help1" ] = "{primaryfire} Cura qualcuno con un potente raggio."
L[ "ttt2_med_medigun_help2" ] = "{secondaryfire} Una volta carico, usa l'Ubercharge per fare diventare il tuo giocatore più forte."
