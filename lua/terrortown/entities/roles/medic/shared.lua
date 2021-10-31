if SERVER then
    AddCSLuaFile() -- adding this file for download
    resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_med.vmt") -- adding medic icon for download
    util.AddNetworkString("ttt2_med_role_epop_1") -- adding network string for first popup
    util.AddNetworkString("ttt2_med_role_epop_2") -- adding network string for second popup
    util.AddNetworkString("ttt2_med_role_epop_3") -- adding network string for third popup
    util.AddNetworkString("ttt2_med_role_epop_4") -- adding network string for fourth popup
    util.AddNetworkString("ttt2_med_role_epop_5") -- adding network string for fifth popup
    util.AddNetworkString("ttt2_med_role_epop_6") -- adding network string for sixth popup
end

-- only for servers
function ROLE:PreInitialize()
    self.color = Color(4, 180, 134, 255) -- color of everything role specific
    self.abbr = "med" -- abbreviation
    self.score.surviveBonusMultiplier = 1 -- The amount of score points gained by surviving a round, based on the amount of dead enemy players.
    self.score.aliveTeammatesBonusMultiplier = 1 -- The amount of score points granted due to a survival of the round for every teammate alive.
    self.score.allSurviveBonusMultiplier = 2 -- Multiplier for a score for every player alive at the end of the round. Can be negative for roles that should kill everyone.
    self.score.killsMultiplier = -5 -- The multiplier that is used to calculate the gained score by killing someone from a different team.
    self.score.teamKillsMultiplier = -5 -- The multiplier that is used to calculate the score penalty that is added if this role kills a team member.
    self.score.suicideMultiplier = -10 -- The amount of points gained by killing yourself. Should be a negative number for most roles.
    self.score.bodyFoundMuliplier = 2 -- The amount of score points gained by confirming a body.
    self.score.survivePenaltyMultiplier = 0 -- The amount of score points lost by surviving a round, based on the amount of surviving team players. Only applied when not in winning team.
    self.score.timelimitMultiplier = 2 -- The amount of score points gained by being alive if the round ended with nobody winning, usually a negative number.
    self.unknownTeam = true -- player don't know their teammates
    self.preventWin = true -- prevent win
    self.preventFindCredits = true -- prevent finding credits
    self.defaultTeam = TEAM_NONE -- the team name: roles with same team name are working together
    self.defaultEquipment = MEDIC_EQUIPMENT -- here you can set up your own default equipment
    self.isPublicRole = true -- Set this flag to true to make a role public known. This results in a detective-like behavior.

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

-- everything above is shared
if SERVER then
    -- adding loadout on role change/spawn
    function ROLE:GiveRoleLoadout(ply, isRoleChange)
        if isRoleChange then
            ply.msgShown = false -- variable, fix for some popup issues
            ply:GiveEquipmentWeapon("weapon_ttt2_medic_medigun") -- adding the medigun to the medic loadout
            ply:GiveEquipmentWeapon("weapon_ttt2_medic_defibrillator") -- adding the defibrillator to the medic loadout
            ply:GiveArmor(GetConVar("ttt2_med_armor"):GetInt()) -- adding the armor to the medic loadout

            -- first popup with the convar
            if GetConVar("ttt2_med_announce_arrival_popup"):GetBool() and GetRoundState() ~= ROUND_ACTIVE then
                nick = ""
                -- getting all players and picking the medic players to be announced with the popup
                local plys = player.GetAll()

                for i = 1, #plys do
                    ply = plys[i]

                    if ply:GetSubRole() == ROLE_MEDIC then
                        nick = ply:Nick() .. " | " .. nick
                    end
                end

                net.Start("ttt2_med_role_epop_1") -- the first added network string starts here if the convar is true
                net.WriteString(nick) -- writing medic names
                net.Broadcast() -- broadcasting but no popup at the screen yet
            elseif GetConVar("ttt2_med_announce_force_popup"):GetBool() and ply:GetSubRole() == ROLE_MEDIC and GetRoundState() == ROUND_ACTIVE then
                net.Start("ttt2_med_role_epop_2") -- the second added network string starts here if the convar is true
                net.WriteString(ply:Nick()) -- writing the name of the forced medic
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
        end
    end

    -- removing loadout on role change/despawn
    function ROLE:RemoveRoleLoadout(ply, isRoleChange)
        if isRoleChange then
            ply:RemoveEquipmentWeapon("weapon_ttt2_medic_medigun") -- removing the medigun from the medic loadout
            ply:RemoveEquipmentWeapon("weapon_ttt2_medic_defibrillator") -- removing the defibrillator from the medic loadout
            ply:RemoveArmor(GetConVar("ttt2_med_armor"):GetInt()) -- removing the armor from the medic loadout
            med_started = nil -- setting med_started to nil to prevent issues with the win condition
            med_popupstarted = nil -- setting med_popupstarted to nil to prevent issues with the win condition
            med_fin_heal = nil -- setting med_fin_heal to nil to prevent issues with the win condition
        end
    end

    -- medic win hook
    -- ttt2modifywinningalives hook added, look ttt2 api documentation for more information
    hook.Add("TTT2ModifyWinningAlives", "MedicWin", function(alives)
        if GetConVar("ttt2_med_win_enabled"):GetBool() == false then return end -- checks if win is enabled
        -- getting all alive teams and doing some checks
        local winningTeam = ""

        for i in pairs(alives) do
            local t = alives[i]
            if winningTeam ~= "" and winningTeam ~= t then return end
            winningTeam = t
        end

        if winningTeam == "" then return end

        -- getting all players and doing some checks
        for _, ply in ipairs(player.GetAll()) do
            if not IsValid(ply) or not ply:IsPlayer() then return end -- ensure ply is valid and player first
            if ply:GetSubRole() ~= ROLE_MEDIC then return end -- ensure ply is medic first

            -- checks if med_fin_heal is true and ply is terror
            if med_fin_heal == true and ply:IsTerror() then
                ply:UpdateTeam(winningTeam, false) -- putting medic to the winning team
            end
        end

        med_fin_heal = false -- setting med_fin_heal to false to prevent issues with the win condition
    end)

    -- what happens if the medic gets killed or if he kills someone
    local function MedicKilled(victim, inflictor, attacker)
        if not IsValid(attacker) or not attacker:IsPlayer() or not IsValid(victim) or not victim:IsPlayer() then return end -- ensure attacker and victim are valid and players first
        if SpecDM and (victim.IsGhost and victim:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end -- fix for specdm popups/errors
        if GetConVar("ttt2_med_disable_kill_death_handling"):GetBool() then return end

        -- checks if convar is true, victim is medic, attacker is not medic and msgshown is false
        if GetConVar("ttt2_med_announce_death_popup"):GetBool() and victim:GetSubRole() == ROLE_MEDIC and attacker:GetSubRole() ~= ROLE_MEDIC and not victim.msgShown then
            net.Start("ttt2_med_role_epop_3") -- the third added network string starts here if the convar is true and the checks allow it
            net.WriteString(attacker:Nick()) -- writing the name of the medic attacker (killer)
            net.Broadcast() -- broadcasting but no popup at the screen yet
        end

        -- checks if attacker is medic, and victim is no medic and if msgshown is not true
        if attacker:GetSubRole() == ROLE_MEDIC and victim:GetSubRole() ~= ROLE_MEDIC and attacker.msgShown ~= true then
            attacker:SetRole(ROLE_INNOCENT, TEAM_INNOCENT) -- sets the role and the team to innocent
            attacker:SetCredits(0) -- sets the credits to 0

            -- if all checks pass then it checks if the convar is true
            if GetConVar("ttt2_med_announce_crime_popup"):GetBool() then
                attacker.msgShown = true -- setting msgshown to true to prevent the third popup to appear
                net.Start("ttt2_med_role_epop_4") -- the fourth added network string starts here if the convar is true
                net.WriteString(attacker:Nick()) -- writing the name of the attacking medic (killer medic)
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
            -- checks if attacker is medic, and victim is medic, if victim is not attacker and if msgshown is not true
        elseif attacker:GetSubRole() == ROLE_MEDIC and victim:GetSubRole() == ROLE_MEDIC and victim ~= attacker and attacker.msgShown ~= true then
            attacker:SetRole(ROLE_TRAITOR, TEAM_TRAITOR) -- sets the role and the team to traitor
            attacker:SetCredits(0) -- sets the credits to 0

            if GetConVar("ttt2_med_announce_betrayel_popup"):GetBool() then
                attacker.msgShown = true -- setting msgshown to true to prevent the third popup to appear
                net.Start("ttt2_med_role_epop_5") -- the fifth added network string starts here if the convar is true
                net.WriteString(attacker:Nick()) -- writing the name of the attacking medic (killer medic)
                net.Broadcast() -- broadcasting but no popup at the screen yet
            end
        end

        SendFullStateUpdate() -- to refresh everything until now
    end

    hook.Add("PlayerDeath", "MedicKilled", MedicKilled) -- playerdeath hook added, look gmod wiki for more information

    local function MedicKilledAccident(ply, attacker, dmg)
        if SpecDM and (ply.IsGhost and ply:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end -- fix for specdm popups/errors
        local killer = dmg:GetAttacker() -- get attacker inflictor

        -- checks convar is true, if ply is medic, if ply is attacker or if killer is not valid or killer is not a player
        if GetConVar("ttt2_med_announce_accident_popup"):GetBool() and ply:GetSubRole() == ROLE_MEDIC and (ply == attacker or not IsValid(killer) or not killer:IsPlayer()) then
            net.Start("ttt2_med_role_epop_6") -- the sixth added network string starts here if the convar is true
            net.WriteString(ply:Nick()) -- writing the name of the killed medic
            net.Broadcast() -- broadcasting but no popup at the screen yet
        end
    end

    hook.Add("DoPlayerDeath", "MedicKilledAccident", MedicKilledAccident) -- doplayerdeath hook added, look gmod wiki for more information

    -- ulx force role medic fix and again a refresh
    local function ttt_force_medic(ply)
        ply:SetRole(ROLE_MEDIC)
        SendFullStateUpdate()
    end

    concommand.Add("ttt_force_medic", ttt_force_medic, nil, nil, FCVAR_CHEAT) -- added concommand, look ttt2 github detective, traitor, innocent files to see this too
end

-- this needs to be on server
if CLIENT then
    -- finally the broadcasted first popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_1", function()
        plo1 = net.ReadString() -- reading the written string

        -- putting it into plo1
        if plo1 == nil then
            plo1 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_1") .. plo1, -- getting translation from language files and plo1
            color = Color(4, 180, 134, 255) -- setting color to the role color 
        }, "", GetConVar("ttt2_med_announce_arrival_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the first popup is now on the screen
    -- finally the broadcasted second popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_2", function()
        plo2 = net.ReadString() -- reading the written string

        -- putting it into plo2
        if plo2 == nil then
            plo2 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_2") .. plo2, -- getting translation from language files and plo2
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_force_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the second popup is now on the screen
    -- finally the broadcasted third popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_3", function()
        plo3 = net.ReadString() -- reading the written string

        -- putting it into plo3
        if plo3 == nil then
            plo3 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_3") .. plo3, -- getting translation from language files and plo3
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_death_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the third popup is now on the screen
    -- finally the broadcasted fourth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_4", function()
        plo4 = net.ReadString() -- reading the written string

        -- putting it into plo4
        if plo4 == nil then
            plo4 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_4") .. plo4, -- getting translation from language files and plo4
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_crime_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the fourth popup is now on the screen
    -- finally the broadcasted fifth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_5", function()
        plo5 = net.ReadString() -- reading the written string

        -- putting it into plo5
        if plo5 == nil then
            plo5 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_5") .. plo5, -- getting translation from language files and plo5
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_betrayel_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the fifth popup is now on the screen
    -- finally the broadcasted sixth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_6", function()
        plo6 = net.ReadString() -- reading the written string

        -- putting it into plo6
        if plo6 == nil then
            plo6 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_6") .. plo6, -- getting translation from language files and plo6
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_accident_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the sixth popup is now on the screen
    -- finally the broadcasted seventh popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_7", function()
        plo7 = net.ReadString() -- reading the written string

        -- putting it into plo7
        if plo7 == nil then
            plo7 = ""
        end

        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_7") .. plo7, -- getting translation from language files and plo7
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_win_popup_duration"):GetInt())
    end)

    -- how long should the message appear on screen
    -- the seventh popup is now on the screen
    -- finally the broadcasted eighth popup is received but again not at the players screen
    net.Receive("ttt2_med_role_epop_8", function()
        EPOP:AddMessage({
            text = LANG.GetTranslation("ttt2_role_medic_popuptitle_8"), -- getting translation from language files
            color = Color(4, 180, 134, 255) -- setting color to the role color
        }, "", GetConVar("ttt2_med_announce_win_achieved_popup_duration"):GetInt())
    end)
    -- how long should the message appear on screen
    -- the eighth popup is now on the screen
end
-- this needs to be on client