-- only for servers
if SERVER then
    AddCSLuaFile() -- adding this file for download
    resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_med.vmt") -- adding medic icon for download
    util.AddNetworkString("ttt2_med_role_epop_1") -- adding network string for first popup
    util.AddNetworkString("ttt2_med_role_epop_2") -- adding network string for second popup
    util.AddNetworkString("ttt2_med_role_epop_3") -- adding network string for third popup
    util.AddNetworkString("ttt2_med_role_epop_4") -- adding network string for fourth popup
    util.AddNetworkString("ttt2_med_role_epop_5") -- adding network string for fifth popup
    util.AddNetworkString("ttt2_med_role_epop_6") -- adding network string for sixth popup
    util.AddNetworkString("ttt2_med_role_epop_7") -- adding network string for seventh popup
end

function ROLE:PreInitialize()
    self.color = Color(4, 180, 134, 255) -- color of everything role specific
    self.abbr = "med" -- abbreviation
    self.score.surviveBonusMultiplier = 0 -- The amount of score points gained by surviving a round, based on the amount of dead enemy players.
    self.score.aliveTeammatesBonusMultiplier = 1 -- The amount of score points granted due to a survival of the round for every teammate alive.
    self.score.allSurviveBonusMultiplier = 2 -- Multiplier for a score for every player alive at the end of the round. Can be negative for roles that should kill everyone.
    self.score.killsMultiplier = -5 -- The multiplier that is used to calculate the gained score by killing someone from a different team.
    self.score.teamKillsMultiplier = -5 -- The multiplier that is used to calculate the score penalty that is added if this role kills a team member.
    self.score.suicideMultiplier = -10 -- The amount of points gained by killing yourself. Should be a negative number for most roles.
    self.score.bodyFoundMuliplier = 2 -- The amount of score points gained by confirming a body.
    self.score.survivePenaltyMultiplier = 0 -- The amount of score points lost by surviving a round, based on the amount of surviving team players. Only applied when not in winning team.
    self.score.timelimitMultiplier = 1 -- The amount of score points gained by being alive if the round ended with nobody winning, usually a negative number.
    self.unknownTeam = true -- player don't know their teammates
    self.preventWin = true -- prevent win
    self.preventFindCredits = true -- prevent finding credits
    self.defaultTeam = TEAM_NONE -- the team name: roles with same team name are working together
    self.defaultEquipment = MEDIC_EQUIPMENT -- here you can set up your own default equipment
    self.isPublicRole = true -- Set this flag to true to make a role public known. This results in a detective-like behavior.
    self.isOmniscientRole = true -- Omniscient roles are able to see missing in action players and therefore the haste mode timer as well. This is mostly traitor-like behaviour.
    self.karma = {
        teamKillPenaltyMultiplier = 1.5, -- The multiplier that is used to calculate the Karma penalty for a team kill. Keep in mind that the game will increase the multiplier further if it was avoidable like a kill on a public policing role.
        teamHurtPenaltyMultiplier = 1.5, -- The multiplier that is used to calculate the Karma penalty for team damage. Keep in mind that the game will increase the multiplier further if it was avoidable like damage applied to a public policing role.
        enemyKillBonusMultiplier = 0, -- The multiplier that is used to change the Karma given to the killer if a player from an enemy team is killed.
        enemyHurtBonusMultiplier = 0 -- The multiplier that is used to change the Karma given to the attacker if a player from an enemy team is damaged.
    }

    self.conVarData = {
        pct = 0.15, -- necessary: percentage of getting this role selected (per player)
        maximum = 1, -- maximum amount of roles in a round
        minPlayers = 8, -- minimum amount of players until this role is able to get selected
        minKarma = 500, -- The minimum amount of Karma needed for selection.
        credits = 0, -- the starting credits of a specific role
        creditsAwardDeadEnable = 0, -- Defines if this role gains credits if a certain percentage of players from other teams is dead.
        creditsAwardKillEnable = 0, -- Defines if this role is awarded with credits for the kill of a high profile. policing role, such as a detective.
        togglable = true, -- option to toggle a role for a client if possible (F1 menu)
        shopFallback = SHOP_DISABLED, -- shop that is uses
        random = 33, -- random convar
        traitorButton = 0 -- traitor button visbile (1) or not (0)
    }
end

function ROLE:Initialize()
end

local med_mediccount = 0
local function UpdateMedicCount()
    med_mediccount = 0
    -- getting all players and picking the medic players and saving them in a variable
    local plys = select(2, player.Iterator())
    for i = 1, #plys do
        local ply = plys[i]
        if ply:GetSubRole() == ROLE_MEDIC then med_mediccount = med_mediccount + 1 end
    end
    return med_mediccount
end

-- everything above is shared
if SERVER then
    local function AnnounceMedics()
        -- first popup with the convar
        if GetConVar("ttt2_med_announce_arrival_popup"):GetBool() and med_mediccount ~= 0 then
            local medics = {}
            -- getting all players and picking the medic players who will be announced with the popup
            local plys = select(2, player.Iterator())
            for i = 1, #plys do
                local ply = plys[i]
                if ply:GetSubRole() == ROLE_MEDIC then table.insert(medics, ply:Nick()) end
            end

            local nick = table.concat(medics, " | ")
            net.Start("ttt2_med_role_epop_1") -- the first added network string starts here if the convar is true
            net.WriteString(nick) -- writing medic names
            net.WriteInt(GetConVar("ttt2_med_announce_arrival_popup_duration"):GetInt(), 32) -- writing popup duration
            net.WriteBool(med_mediccount > 1) -- writing required boolean
            net.Broadcast() -- broadcasting but no popup at the screen yet
        end
    end

    -- adding loadout on role change/spawn
    function ROLE:GiveRoleLoadout(ply, isRoleChange)
        if isRoleChange then
            ply.msgShown = false -- variable, fix for some popup issues
            ply:GiveEquipmentWeapon("weapon_ttt2_medic_medigun") -- adding the medigun to the medic loadout
            ply:GiveEquipmentWeapon("weapon_ttt2_medic_defibrillator") -- adding the defibrillator to the medic loadout
            ply:GiveArmor(GetConVar("ttt2_med_armor"):GetInt()) -- adding the armor to the medic loadout
            if GetConVar("ttt2_med_win_enabled"):GetBool() then
                local med_playercount = table.Count(team.GetPlayers(TEAM_TERROR)) -- get the playercount of all alive players
                med_rqd_heal = GetConVar("ttt2_med_win_rqd_heal_per_alv_ply"):GetInt() * med_playercount -- multiply the convar value with all alive players
            end
        end
    end

    -- TTTBeginRound hook added, look TTT2 API Documentation for more information
    hook.Add("TTTBeginRound", "MedicAnnouncement", function()
        -- this is needed to get all medic players and to correctly announce them
        UpdateMedicCount()
        AnnounceMedics()
    end)

    -- removing loadout on role change/despawn
    function ROLE:RemoveRoleLoadout(ply, isRoleChange)
        if isRoleChange then
            ply:RemoveEquipmentWeapon("weapon_ttt2_medic_medigun") -- removing the medigun from the medic loadout
            ply:RemoveEquipmentWeapon("weapon_ttt2_medic_defibrillator") -- removing the defibrillator from the medic loadout
            ply:RemoveArmor(GetConVar("ttt2_med_armor"):GetInt()) -- removing the armor from the medic loadout
        end
    end

    -- medic win hook
    -- TTT2ModifyWinningAlives hook added, look ttt2 api documentation for more information
    hook.Add("TTT2ModifyWinningAlives", "MedicWin", function(alives)
        if GetConVar("ttt2_med_win_enabled"):GetBool() == false then -- checks if win is enabled
            return
        end

        if alives == nil then -- checks if alives is not nil 
            return
        end

        -- getting all alive teams and doing some checks
        local winningTeam = ""
        -- check all alive teams
        for i in pairs(alives) do
            local t = alives[i]
            if winningTeam ~= "" and winningTeam ~= t then return end
            winningTeam = t
        end

        -- ensure winningTeam has a value
        if winningTeam == "" or winningTeam == nil then return end
        -- getting all players and doing some checks
        local allPlayers = select(2, player.Iterator())
        for _, ply in ipairs(allPlayers) do
            if not IsValid(ply) or not ply:IsPlayer() then -- ensure ply is valid and player first
                continue
            end

            if ply:GetSubRole() ~= ROLE_MEDIC then -- ensure ply is medic first
                continue
            end

            -- checks if convar is true, med_fin_revive is true, med_fin_heal is true and ply is active
            if GetConVar("ttt2_med_win_rqd_revive"):GetBool() and med_fin_revive == true and med_fin_heal == true and ply:IsActive() then
                ply:UpdateTeam(winningTeam, false) -- putting medic to the winning team
                -- checks if convar is false, med_fin_heal is true and ply is active
            elseif GetConVar("ttt2_med_win_rqd_revive"):GetBool() == false and med_fin_heal == true and ply:IsActive() then
                ply:UpdateTeam(winningTeam, false) -- putting medic to the winning team
            end
        end

        med_popupstarted = nil -- setting med_popupstarted to nil to prevent issues with the win condition
        med_fin_revive = nil -- setting med_fin_heal to nil to prevent issues with the win condition
        med_fin_heal = nil -- setting med_fin_heal to nil to prevent issues with the win condition
    end)

    -- what happens if the medic gets killed or if he kills someone
    local function MedicKilled(victim, inflictor, attacker)
        if not IsValid(attacker) or not attacker:IsPlayer() or not IsValid(victim) or not victim:IsPlayer() then -- ensure attacker and victim are valid and players first
            return
        end

        if SpecDM and (victim.IsGhost and victim:IsGhost() or attacker.IsGhost and attacker:IsGhost()) then -- fix for specdm popups/errors
            return
        end

        -- checks if convar is true and attacker is medic
        if GetConVar("ttt2_med_karma_penalty"):GetBool() and attacker:GetSubRole() == ROLE_MEDIC then
            KARMA.GivePenalty(attacker, GetConVar("ttt2_med_karma_penalty_per_killed_ply"):GetInt(), victim, "med_karma_penalty_tooltip") -- gives the medic a karma penalty with reason
        end

        if GetConVar("ttt2_med_disable_kill_death_handling"):GetBool() then return end
        -- checks if convar is true, victim is medic, attacker is not medic and msgshown is false
        if GetConVar("ttt2_med_announce_death_popup"):GetBool() and victim:GetSubRole() == ROLE_MEDIC and attacker:GetSubRole() ~= ROLE_MEDIC and not victim.msgShown then
            net.Start("ttt2_med_role_epop_2") -- the third added network string starts here if the convar is true and the checks allow it
            net.WriteString(attacker:Nick()) -- writing the name of the medic attacker (killer)
            net.WriteInt(GetConVar("ttt2_med_announce_death_popup_duration"):GetInt(), 32) -- writing popup duration
            net.Broadcast() -- broadcasting but no popup at the screen yet
        end

        -- checks if attacker is medic, and victim is no medic and if msgshown is not true
        if attacker:GetSubRole() == ROLE_MEDIC and victim:GetSubRole() ~= ROLE_MEDIC and attacker.msgShown ~= true then
            attacker:SetRole(ROLE_INNOCENT, TEAM_INNOCENT) -- sets the role and the team to innocent
            attacker:SetCredits(0) -- sets the credits to 0
            -- if all checks pass then it checks if the convar is true
            if GetConVar("ttt2_med_announce_crime_popup"):GetBool() then
                attacker.msgShown = true -- setting msgshown to true to prevent the third popup to appear
                net.Start("ttt2_med_role_epop_3") -- the fourth added network string starts here if the convar is true
                net.WriteString(attacker:Nick()) -- writing the name of the attacking medic (killer medic)
                net.WriteInt(GetConVar("ttt2_med_announce_crime_popup_duration"):GetInt(), 32) -- writing popup duration
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
            -- checks if attacker is medic, and victim is medic, if victim is not attacker and if msgshown is not true
        elseif attacker:GetSubRole() == ROLE_MEDIC and victim:GetSubRole() == ROLE_MEDIC and victim ~= attacker and attacker.msgShown ~= true then
            attacker:SetRole(ROLE_TRAITOR, TEAM_TRAITOR) -- sets the role and the team to traitor
            attacker:SetCredits(0) -- sets the credits to 0
            if GetConVar("ttt2_med_announce_betrayal_popup"):GetBool() then
                attacker.msgShown = true -- setting msgshown to true to prevent the third popup to appear
                net.Start("ttt2_med_role_epop_4") -- the fifth added network string starts here if the convar is true
                net.WriteString(attacker:Nick()) -- writing the name of the attacking medic (killer medic)
                net.WriteInt(GetConVar("ttt2_med_announce_betrayal_popup_duration"):GetInt(), 32) -- writing popup duration
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
        end

        SendFullStateUpdate() -- to refresh everything until now
    end

    hook.Add("PlayerDeath", "MedicKilled", MedicKilled) -- PlayerDeath hook added, look gmod wiki for more information
    local function MedicKilledAccident(ply, attacker, dmg)
        if SpecDM and (ply.IsGhost and ply:IsGhost() or attacker.IsGhost and attacker:IsGhost()) then -- fix for specdm popups/errors
            return
        end

        local killer = dmg:GetAttacker() -- get attacker inflictor
        -- checks convar is true, if ply is medic, if ply is attacker or if killer is not valid or killer is not a player
        if GetConVar("ttt2_med_announce_accident_popup"):GetBool() and ply:GetSubRole() == ROLE_MEDIC and (ply == attacker or not IsValid(killer) or not killer:IsPlayer()) then
            net.Start("ttt2_med_role_epop_5") -- the sixth added network string starts here if the convar is true
            net.WriteString(ply:Nick()) -- writing the name of the killed medic
            net.WriteInt(GetConVar("ttt2_med_announce_accident_popup_duration"):GetInt(), 32) -- writing popup duration
            net.Broadcast() -- broadcasting but no popup at the screen yet
        end
    end

    hook.Add("DoPlayerDeath", "MedicKilledAccident", MedicKilledAccident) -- DoPlayerDeath hook added, look gmod wiki for more information
    -- ulx force role medic fix and again a refresh
    local function ttt_force_medic(ply)
        ply:SetRole(ROLE_MEDIC)
        SendFullStateUpdate()
    end

    concommand.Add("ttt_force_medic", ttt_force_medic, nil, nil, FCVAR_CHEAT) -- added concommand, look ttt2 github detective, traitor, innocent files to see this too
    -- TTT2CanBeHitmanTarget hook added, look hitman code for more information
    hook.Add("TTT2CanBeHitmanTarget", "TTT2MedicNoHitmanTarget", function(hitman, ply)
        if ply:GetSubRole() == ROLE_MEDIC then -- medic can't be a target of the hitman anymore
            return false
        end
    end)

    -- TTTPrepareRound hook added, look gmod wiki/ttt2 api documentation for more information
    hook.Add("TTTPrepareRound", "MedicWinReset", function()
        med_popupstarted = nil -- setting med_popupstarted to nil to prevent issues with the win condition
        med_fin_revive = nil -- setting med_fin_heal to nil to prevent issues with the win condition
        med_fin_heal = nil -- setting med_fin_heal to nil to prevent issues with the win condition
    end)
end

-- everything above needs to be on the server
if CLIENT then
    -- f1 menu convars added with labels
    function ROLE:AddToSettingsMenu(parent)
        local form = vgui.CreateTTT2Form(parent, "header_roles_additional")
        form:MakeSlider({
            serverConvar = "ttt2_med_armor",
            label = "label_med_armor",
            min = 0,
            max = 100,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_win_enabled",
            label = "label_med_win_enabled"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_win_rqd_heal_per_alv_ply",
            label = "label_med_win_rqd_heal_per_alv_ply",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_win_rqd_revive",
            label = "label_med_win_rqd_revive"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_disable_kill_death_handling",
            label = "label_med_disable_kill_death_handling"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_disable_defibrillator",
            label = "label_med_disable_defibrillator"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_karma_penalty",
            label = "label_med_karma_penalty"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_karma_penalty_per_killed_ply",
            label = "label_med_karma_penalty_per_killed_ply",
            min = 1,
            max = 150,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_arrival_popup",
            label = "label_med_announce_arrival_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_arrival_popup_duration",
            label = "label_med_announce_arrival_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_death_popup",
            label = "label_med_announce_death_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_death_popup_duration",
            label = "label_med_announce_death_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_crime_popup",
            label = "label_med_announce_crime_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_crime_popup_duration",
            label = "label_med_announce_crime_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_betrayal_popup",
            label = "label_med_announce_betrayal_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_betrayal_popup_duration",
            label = "label_med_announce_betrayal_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_accident_popup",
            label = "label_med_announce_accident_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_accident_popup_duration",
            label = "label_med_announce_accident_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_win_popup",
            label = "label_med_announce_win_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_win_popup_duration",
            label = "label_med_announce_win_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_announce_win_achieved_popup",
            label = "label_med_announce_win_achieved_popup"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_announce_win_achieved_popup_duration",
            label = "label_med_announce_win_achieved_popup_duration",
            min = 1,
            max = 15,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_max_range",
            label = "label_med_medigun_max_range",
            min = 1,
            max = 1000,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_ticks_per_heal",
            label = "label_med_medigun_ticks_per_heal",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_ticks_per_heal_uber",
            label = "label_med_medigun_ticks_per_heal_uber",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_heal_per_tick",
            label = "label_med_medigun_heal_per_tick",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_heal_per_tick_uber",
            label = "label_med_medigun_heal_per_tick_uber",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_ticks_per_self_heal",
            label = "label_med_medigun_ticks_per_self_heal",
            min = 1,
            max = 1000,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_ticks_per_self_heal_uber",
            label = "label_med_medigun_ticks_per_self_heal_uber",
            min = 1,
            max = 1000,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_self_heal_per_tick",
            label = "label_med_medigun_self_heal_per_tick",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_self_heal_per_tick_uber",
            label = "label_med_medigun_self_heal_per_tick_uber",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_medigun_self_heal_is_passive",
            label = "label_med_medigun_self_heal_is_passive"
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_ticks_per_uber",
            label = "label_med_medigun_ticks_per_uber",
            min = 1,
            max = 1000,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_uber_seconds",
            label = "label_med_medigun_uber_seconds",
            min = 1,
            max = 100,
            decimal = 0
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_uber_headshot_dmg_get_pct",
            label = "label_med_medigun_uber_headshot_dmg_get_pct",
            min = 0,
            max = 1,
            decimal = 1
        })

        form:MakeSlider({
            serverConvar = "ttt2_med_medigun_uber_general_dmg_get_pct",
            label = "label_med_medigun_uber_general_dmg_get_pct",
            min = 0,
            max = 1,
            decimal = 1
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_medigun_enable_beam",
            label = "label_med_medigun_enable_beam"
        })

        form:MakeCheckBox({
            serverConvar = "ttt2_med_medigun_call_healing_hook",
            label = "label_med_medigun_call_healing_hook"
        })
    end

    -- finally the broadcasted first popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_1", function()
        plo1 = net.ReadString() -- reading the written string
        plo1_1 = net.ReadInt(32) -- reading the written int
        plo1_2 = net.ReadBool() -- reading the written bool
        -- nil check plo1
        if plo1 == nil then plo1 = "" end
        -- nil check plo1_1
        if plo1_1 == nil then plo1_1 = 5 end
        -- nil check plo1_1
        if plo1_2 == nil then plo1_2 = false end
        if plo1_2 == false then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_1") .. plo1, -- getting translation from language files and plo1
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo1_1, nil, true)
            -- how long should the message appear on screen (plo1_1)
        elseif plo1_2 == true then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_1.5") .. plo1, -- getting translation from language files and plo1
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo1_1, nil, true)
            -- how long should the message appear on screen (plo1_1)
        end
    end)

    -- the first popup is now on the screen
    -- finally the broadcasted second popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_2", function()
        plo2 = net.ReadString() -- reading the written string
        plo2_1 = net.ReadInt(32) -- reading the written int
        -- nil check plo2
        if plo2 == nil then plo2 = "" end
        -- nil check plo2_1
        if plo2_1 == nil then plo2_1 = 5 end
        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_2") .. plo2, -- getting translation from language files and plo2
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", plo2_1, nil, true)
        -- how long should the message appear on screen (plo2_1)
    end)

    -- the second popup is now on the screen
    -- finally the broadcasted third popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_3", function()
        plo3 = net.ReadString() -- reading the written string
        plo3_1 = net.ReadInt(32) -- reading the written int
        -- nil check plo3
        if plo3 == nil then plo3 = "" end
        -- nil check plo3_1
        if plo3_1 == nil then plo3_1 = 5 end
        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_3") .. plo3, -- getting translation from language files and plo3
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", plo3_1, nil, true)
        -- how long should the message appear on screen (plo3_1)
    end)

    -- the third popup is now on the screen
    -- finally the broadcasted fourth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_4", function()
        plo4 = net.ReadString() -- reading the written string
        plo4_1 = net.ReadInt(32) -- reading the written int
        -- nil check plo4
        if plo4 == nil then plo4 = "" end
        -- nil check plo4_1
        if plo4_1 == nil then plo4_1 = 5 end
        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_4") .. plo4, -- getting translation from language files and plo4
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", plo4_1, nil, true)
        -- how long should the message appear on screen (plo4_1)
    end)

    -- the fourth popup is now on the screen
    -- finally the broadcasted fifth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_5", function()
        plo5 = net.ReadString() -- reading the written string
        plo5_1 = net.ReadInt(32) -- reading the written int
        -- nil check plo5
        if plo5 == nil then plo5 = "" end
        -- nil check plo5_1
        if plo5_1 == nil then plo5_1 = 5 end
        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_5") .. plo5, -- getting translation from language files and plo5
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", plo5_1, nil, true)
        -- how long should the message appear on screen (plo5_1)
    end)

    -- the fifth popup is now on the screen
    -- finally the broadcasted sixth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_6", function()
        plo6 = net.ReadString() -- reading the written string
        plo6_1 = net.ReadInt(32) -- reading the written int
        plo6_2 = net.ReadBool() -- reading the written bool
        -- nil check plo6
        if plo6 == nil then plo6 = "" end
        -- nil check plo6_1
        if plo6_1 == nil then plo6_1 = 5 end
        -- nil check plo6_2
        if plo6_2 == nil then plo6_2 = false end
        med_mediccount = UpdateMedicCount() -- getting all medics and saving them in a variable
        -- several checks to check if revival is required to win and if there are more than one medic
        if plo6_2 and med_mediccount == 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_6") .. plo6 .. LANG.GetTranslation("ttt2_role_medic_popuptitle_6_1"), -- getting translation from language files and plo6
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo6_1, nil, true)
            -- how long should the message appear on screen (plo6_1)
        elseif plo6_2 == false and med_mediccount == 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_6") .. plo6, -- getting translation from language files and plo6
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo6_1, nil, true)
            -- how long should the message appear on screen (plo6_1)
        elseif plo6_2 and med_mediccount > 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_6.5") .. plo6 .. LANG.GetTranslation("ttt2_role_medic_popuptitle_6.5_1"), -- getting translation from language files and plo6
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo6_1, nil, true)
            -- how long should the message appear on screen (plo6_1)
        elseif plo6_2 == false and med_mediccount > 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_6.5") .. plo6, -- getting translation from language files and plo6
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo6_1, nil, true)
            -- how long should the message appear on screen (plo6_1)
        end
    end)

    -- the sixth popup is now on the screen
    -- finally the broadcasted seventh popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_7", function()
        plo7 = net.ReadInt(32) -- reading the written int
        -- nil check plo7
        if plo7 == nil then plo7 = 5 end
        med_mediccount = UpdateMedicCount() -- getting all medics and saving them in a variable
        -- several checks to check if there are more than one medic
        if med_mediccount == 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_7"), -- getting translation from language files
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo7, nil, true)
            -- how long should the message appear on screen (plo7)
        elseif med_mediccount > 1 then
            EPOP:AddMessage({
                text = LANG.GetTranslation("ttt2_role_medic_popuptitle_7.5"), -- getting translation from language files
                color = Color(4, 180, 134, 255) -- setting color to the role color
            }, "", plo7, nil, true)
            -- how long should the message appear on screen (plo7)
        end
    end)
    -- the seventh popup is now on the screen
end
-- everything above needs to be on the client