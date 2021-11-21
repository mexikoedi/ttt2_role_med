local L = LANG.GetLanguageTableReference("ru")
-- GENERAL ROLE LANGUAGE STRINGS
L[MEDIC.name] = "Медик"
L["info_popup_" .. MEDIC.name] = [[Вы медик!
Оставайся в живых и помогай всем, если можешь!]]
L["body_found_" .. MEDIC.abbr] = "Он был Медиком."
L["search_role_" .. MEDIC.abbr] = "Этот человек был Медиком!"
L["target_" .. MEDIC.name] = "Медик"
L["ttt2_desc_" .. MEDIC.name] = [[Медик должен лечить всех изо всех сил (ДЕЙСТВИТЕЛЬНО ВСЕХ), для этого у него есть Медипушка и Дефибриллятор.
Постарайтесь помочь всем!]]
-- OTHER ROLE LANGUAGE STRINGS
L["med_karma_penalty_tooltip"] = "Преступление"
L["ttt2_role_medic_popuptitle_1"] = "В поле прибыли Медики, их зовут: "
L["ttt2_role_medic_popuptitle_2"] = "Этого игрока сделали Mедиком: "
L["ttt2_role_medic_popuptitle_3"] = "Медик убит! Это военное преступление было совершено игроком: "
L["ttt2_role_medic_popuptitle_4"] = "Медик совершил преступление! Он потерял своё оборудование и теперь помогает невиновному: "
L["ttt2_role_medic_popuptitle_5"] = "Медик убил другого Медика! Это была измена, убить игрока: "
L["ttt2_role_medic_popuptitle_6"] = "Этот Mедик мог попасть в аварию: "
L["ttt2_role_medic_popuptitle_7"] = "Вам нужно остаться в живых и вылечить: "
L["ttt2_role_medic_popuptitle_7_1"] = " и вам нужно оживить одного игрока!"
L["ttt2_role_medic_popuptitle_8"] = "Оставайтесь в живых, вы выполнили условие победы!"
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
L["med_defi_error_player_alive"] = "Вы не можете оживить этого игрока, так как он уже жив."
L["ttt2_med_defibrillator_help1"] = "{primaryfire} Оживить трупы."
L["ttt2_med_defibrillator_help2"] = "{secondaryfire} Воспроизвести звуковой сигнал."
L["weapon_med_medigun_name"] = "Медик Медипушка"
L["weapon_med_medigun_desc"] = "Исцеляйте игроков и UBER ZEM! ВЫХОД ВЫХОД."
L["ttt2_med_medigun_help1"] = "{primaryfire} Исцелить кого-нибудь сильным лечебным лучом."
L["ttt2_med_medigun_help2"] = "{secondaryfire} После зарядки используйте убер-заряд, чтобы усилить луч."
L["label_med_armor"] = "Очки брони"
L["label_med_win_enabled"] = "Включить условие победы"
L["label_med_win_rqd_heal_per_alv_ply"] = "Требуемые очки исцеления для победы"
L["label_med_win_rqd_revive"] = "Включить необходимое возрождение для победы"
L["label_med_disable_kill_death_handling"] = "Отключить превращение в невинного или предателя"
L["label_med_karma_penalty"] = "Включить наказание кармой"
L["label_med_karma_penalty_per_killed_ply"] = "Очки наказания кармы на игрока"
L["label_med_announce_arrival_popup"] = "Включить объявление о прибытии"
L["label_med_announce_arrival_popup_duration"] = "Продолжительность объявления о прибытии"
L["label_med_announce_force_popup"] = "Включить принудительное объявление"
L["label_med_announce_force_popup_duration"] = "Продолжительность принудительного объявления"
L["label_med_announce_death_popup"] = "Включить объявление о смерти"
L["label_med_announce_death_popup_duration"] = "Продолжительность объявления о смерти"
L["label_med_announce_crime_popup"] = "Включить объявление о преступлении"
L["label_med_announce_crime_popup_duration"] = "Продолжительность объявления о преступлении"
L["label_med_announce_betrayal_popup"] = "Включить объявление о предательстве"
L["label_med_announce_betrayal_popup_duration"] = "Продолжительность объявления о предательстве"
L["label_med_announce_accident_popup"] = "Включить объявление об аварии"
L["label_med_announce_accident_popup_duration"] = "Продолжительность объявления об аварии"
L["label_med_announce_win_popup"] = "Включить объявление условия победы"
L["label_med_announce_win_popup_duration"] = "Продолжительность объявления условия победы"
L["label_med_announce_win_achaught_popup"] = "Включить объявление о победе"
L["label_med_announce_win_achaught_popup_duration"] = "Продолжительность объявления победы"
L["label_med_defibrillator_distance"] = "Максимальное расстояние для возрождения"
L["label_med_defibrillator_revive_braindead"] = "Включить возрождение безумных игроков"
L["label_med_defibrillator_play_sounds"] = "Включить звуки во время оживления"
L["label_med_defibrillator_revive_time"] = "Время, необходимое для возрождения"
L["label_med_defibrillator_error_time"] = "Тайм-аут после неудачного возрождения"
L["label_med_defibrillator_success_chance"] = "Вероятно, возрождение увенчается успехом"
L["label_med_defibrillator_reset_confirm"] = "Сбросить состояние подтверждения в начале раунда"
L["label_med_medigun_max_range"] = "Максимальное расстояние для исцеления (hammer измерения)"
L["label_med_medigun_ticks_per_heal"] = "Расстояние между точками исцеления (тикс)"
L["label_med_medigun_ticks_per_heal_uber"] = "Расстояние между точками исцеления - ubering (тикс)"
L["label_med_medigun_heal_per_tick"] = "Исцеления точки, которые исцеляют (тикс)"
L["label_med_medigun_heal_per_tick_uber"] = "Исцеляющие точки исцеления - ubering (тикс)"
L["label_med_medigun_ticks_per_self_heal"] = "Расстояние между точками самовосстановления (тикс)"
L["label_med_medigun_ticks_per_self_heal_uber"] = "Расстояние между точками самовосстановления - ubering (тикс)"
L["label_med_medigun_self_heal_per_tick"] = "Самовосстановления, которые исцеляют (тикс)"
L["label_med_medigun_self_heal_per_tick_uber"] = "Самовосстановления, которые исцеляют - ubering (тикс)"
L["label_med_medigun_self_heal_is_passive"] = "Получите очки исцеления, никого не исцеляя"
L["label_med_medigun_ticks_per_uber"] = "Расстояние между uber процент зарядки (тикс)"
L["label_med_medigun_uber_seconds"] = "Как долго должно длиться ubering"
L["label_med_medigun_uber_headshot_dmg_get_pct"] = "Pct голову урона, полученного, пока игрок ubert"
L["label_med_medigun_uber_general_dmg_get_pct"] = "Pct нормального урона, полученного, пока игрок ubert"
L["label_med_medigun_enable_beam"] = "Показать луч исцеляющего оружия"
L["label_med_medigun_call_healing_hook"] = "Выполнять хук исцеления каждый тик"