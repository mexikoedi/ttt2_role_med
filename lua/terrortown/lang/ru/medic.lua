L = LANG.GetLanguageTableReference("ru")
-- GENERAL ROLE LANGUAGE STRINGS
L[MEDIC.name] = "Медик"
L["info_popup_" .. MEDIC.name] = [[Вы медик!
Оставайся в живых и помогай всем, если можешь!]]
L["body_found_" .. MEDIC.abbr] = "Он был Медиком."
L["search_role_" .. MEDIC.abbr] = "Этот человек был Медиком!"
L["target_" .. MEDIC.name] = "Медик"
L["ttt2_desc_" .. MEDIC.name] = [[Медик должен лечить всех изо всех сил (ДЕЙСТВИТЕЛЬНО ВСЕХ), для этого у него есть Медипушка и Дефибриллятор.
Постарайтесь помочь всем!]]
L["ttt2_role_medic_popuptitle_1"] = "В поле прибыли Медики, их зовут: "
L["ttt2_role_medic_popuptitle_2"] = "Этого игрока сделали Mедиком: "
L["ttt2_role_medic_popuptitle_3"] = "Медик убит! Это военное преступление было совершено игроком: "
L["ttt2_role_medic_popuptitle_4"] = "Медик совершил преступление! Он потерял своё оборудование и теперь помогает невиновному: "
L["ttt2_role_medic_popuptitle_5"] = "Медик убил другого Медика! Это была измена, убить игрока: "
L["ttt2_role_medic_popuptitle_6"] = "Этот Mедик мог попасть в аварию: "
L["weapon_med_defi_name"] = "Дефибриллятор медика"
L["weapon_med_defi_desc"] = "Устройство высокой энергии для оживления других игроков."
L["med_revived_by_player"] = "Вас оживляет игрок {name}. Приготовься!"
L["med_defi_hold_key_to_revive"] = "Удерживайте [{key}], чтобы оживить игрока"
L["med_defi_revive_progress"] = "Времени осталось: {time}с"
L["med_defi_charging"] = "Дефибриллятор заряжается, подождите."
L["med_defi_player_already_reviving"] = "Игрок уже оживает"
L["med_defi_error_braindead"] = "Невозможно оживить игрока с простреленной головой."
L["med_defi_error_no_space"] = "Для этой попытки возрождения недостаточно места."
L["med_defi_error_too_fast"] = "Дефибриллятор заряжается. Пожалуйста, подождите."
L["med_defi_error_lost_target"] = "Вы потеряли свою цель. Пожалуйста, попробуйте ещё раз."
L["med_defi_error_no_valid_ply"] = "Вы не можете оживить этого игрока, так как он больше не действителен."
L["med_defi_error_already_reviving"] = "Вы не можете оживить этого игрока, так как он уже оживляется."
L["med_defi_error_failed"] = "Попытка возрождения не удалась. Пожалуйста, попробуйте ещё раз."
L["ttt2_med_defibrillator_help1"] = "{primaryfire} Оживить трупы."
L["ttt2_med_defibrillator_help2"] = "{secondaryfire} Воспроизвести звуковой сигнал."
L["weapon_med_medigun_name"] = "Медик Медипушка"
L["weapon_med_medigun_desc"] = "Исцеляйте игроков и UBER ZEM! ВЫХОД ВЫХОД."
L["ttt2_med_medigun_help1"] = "{primaryfire} Исцелить кого-нибудь сильным лечебным лучом."
L["ttt2_med_medigun_help2"] = "{secondaryfire} После зарядки используйте убер-заряд, чтобы усилить луч."
