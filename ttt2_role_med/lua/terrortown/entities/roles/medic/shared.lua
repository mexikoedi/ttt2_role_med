if SERVER then
    AddCSLuaFile( ) -- adding this file for download
    resource.AddFile( "materials/vgui/ttt/dynamic/roles/icon_med.vmt" ) -- adding medic icon for download
    util.AddNetworkString( "ttt2_med_role_epop" ) -- adding network string for first popup
    util.AddNetworkString( "ttt2_med_role_epop_2" ) -- adding network string for second popup
    util.AddNetworkString( "ttt2_med_role_epop_3" ) -- adding network string for third popup
    util.AddNetworkString( "ttt2_med_role_epop_4" ) -- adding network string for fourth popup
end

-- only for servers
function ROLE:PreInitialize( )
    self.color = Color( 4 , 180 , 134 , 255 ) -- color of everything role specific
    self.abbr = "med" -- abbreviation
    self.surviveBonus = 5 -- bonus multiplier for every survive while another player was killed
    self.scoreKillsMultiplier = 0 -- multiplier for kill of player of another team
    self.scoreTeamKillsMultiplier = -50 -- multiplier for teamkill
    self.unknownTeam = true -- player don't know their teammates/fix for team_none roles which were seen by the medic
    self.preventWin = true -- prevent win
    self.preventFindCredits = true -- prevent finding credits
    self.preventKillCredits = true -- prevent to get credits after kill
    self.preventTraitorAloneCredits = true -- prevent to get credits
    self.defaultTeam = TEAM_NONE -- the team name: roles with same team name are working together
    self.defaultEquipment = MEDIC_EQUIPMENT -- here you can set up your own default equipment

    self.conVarData = {
        pct = 0.15 , -- necessary: percentage of getting this role selected (per player)
        maximum = 1 , -- maximum amount of roles in a round
        minPlayers = 8 , -- minimum amount of players until this role is able to get selected
        credits = 0 , -- the starting credits of a specific role
        creditsTraitorKill = 0 , -- credit for traitor kill
        creditsTraitorDead = 0 , -- credits for traitor dead
        togglable = true , -- option to toggle a role for a client if possible (F1 menu)
        shopFallback = SHOP_DISABLED , -- shop that is uses
        random = 33 , -- random convar
        traitorButton = 0 -- traitor button visbile (1) or not (0)
    }

    -- making the medic visible for all teams + team_none
    local allTeams = { TEAM_NONE }

    for i , k in pairs( TEAMS ) do
        allTeams[ #allTeams + 1 ] = i
    end

    self.visibleForTeam = allTeams
end

function ROLE:Initialize( )
end

-- everything above is shared
if SERVER then
    -- adding loadout on role change/spawn
    function ROLE:GiveRoleLoadout( ply , isRoleChange )
        if isRoleChange then
            ply.msgShown = false -- variable, fix for some popup issues
            ply:GiveEquipmentWeapon( "weapon_ttt2_medic_medigun" ) -- adding the medigun to the medic loadout
            ply:GiveEquipmentWeapon( "weapon_ttt2_medic_defibrillator" ) -- adding the defibrillator to the medic loadout
            ply:GiveArmor( GetConVar( "ttt2_med_armor" ):GetInt( ) ) -- adding the armor to the medic loadout

            -- first popup with the convar
            if GetConVar( "ttt2_med_announce_arrival_popup" ):GetBool( ) and GetRoundState( ) ~= ROUND_ACTIVE then
                nick = ""
                -- getting all players and picking the medic players to be announced with the popup
                local plys = player.GetAll( )

                for i = 1 , #plys do
                    ply = plys[ i ]

                    if ply:GetSubRole( ) == ROLE_MEDIC then
                        nick = ply:Nick( ) .. " | " .. nick
                    end
                end

                net.Start( "ttt2_med_role_epop" ) -- the first added network string starts here if the convar is true
                net.WriteString( nick ) -- writing medic names
                net.Broadcast( ) -- broadcasting but no popup at the screen yet
            end
        end
    end

    -- removing loadout on role change/despawn
    function ROLE:RemoveRoleLoadout( ply , isRoleChange )
        if isRoleChange then
            ply:RemoveEquipmentWeapon( "weapon_ttt2_medic_medigun" ) -- removing the medigun from the medic loadout
            ply:RemoveEquipmentWeapon( "weapon_ttt2_medic_defibrillator" ) -- removing the defibrillator from the medic loadout
            ply:RemoveArmor( GetConVar( "ttt2_med_armor" ):GetInt( ) ) -- removing the armor from the medic loadout
        end
    end

    -- what happens if the medic gets killed or if he kills someone
    local function MedicKilled( victim , inflictor , attacker )
        if not IsValid( attacker ) or not attacker:IsPlayer( ) or not IsValid( victim ) or not victim:IsPlayer( ) then return end -- ensure attacker and victim are valid and players first
        if SpecDM and ( victim.IsGhost and victim:IsGhost( ) or ( attacker.IsGhost and attacker:IsGhost( ) ) ) then return end -- fix for specdm popups/errors

        -- checks if convar true, victim is valid, player and is medic, attacker is valid, player and not medic, and msgshown is true
        if GetConVar( "ttt2_med_announce_death_popup" ):GetBool( ) and victim:GetSubRole( ) == ROLE_MEDIC and attacker:GetSubRole( ) ~= ROLE_MEDIC and not victim.msgShown then
            net.Start( "ttt2_med_role_epop_2" ) -- the second added network string starts here if the convar is true and the checks allow it
            net.WriteString( attacker:Nick( ) ) -- writing the name of the medic attacker (killer)
            net.Broadcast( ) -- broadcasting but no popup at the screen yet
        end

        -- checks if attacker is medic, and victim is no medic and if msgshown is not true
        if attacker:GetSubRole( ) == ROLE_MEDIC and victim:GetSubRole( ) ~= ROLE_MEDIC and attacker.msgShown ~= true then
            attacker:SetRole( ROLE_INNOCENT , TEAM_INNOCENT ) -- sets the role and the team to innocent
            attacker:SetCredits( 0 ) -- sets the credits to 0

            -- if all checks pass then it checks if the convar is true
            if GetConVar( "ttt2_med_announce_crime_popup" ):GetBool( ) == true then
                attacker.msgShown = true -- setting msgshown to true to prevent the second popup to appear
                net.Start( "ttt2_med_role_epop_3" ) -- the third added network string starts here if the convar is true
                net.WriteString( attacker:Nick( ) ) -- writing the name of the attacking medic (killer medic)
                net.Broadcast( ) -- broadcasting but no popup at the screen yet
            end
            -- checks if attacker is medic, and victim is medic, if victim is not attacker and if msgshown is not true
        elseif attacker:GetSubRole( ) == ROLE_MEDIC and victim:GetSubRole( ) == ROLE_MEDIC and victim ~= attacker and attacker.msgShown ~= true then
            attacker:SetRole( ROLE_TRAITOR , TEAM_TRAITOR ) -- sets the role and the team to traitor
            attacker:SetCredits( 0 ) -- sets the credits to 0

            if GetConVar( "ttt2_med_announce_betrayel_popup" ):GetBool( ) == true then
                attacker.msgShown = true -- setting msgshown to true to prevent the second popup to appear
                net.Start( "ttt2_med_role_epop_4" ) -- the fourth added network string starts here if the convar is true
                net.WriteString( attacker:Nick( ) ) -- writing the name of the attacking medic (killer medic)
                net.Broadcast( ) -- broadcasting but no popup at the screen yet
            end
        end

        SendFullStateUpdate( ) -- to refresh everything until now
    end

    hook.Add( "PlayerDeath" , "MedicKilled" , MedicKilled ) -- playerdeath hook added, look gmod wiki for more information

    -- ulx force role medic fix and again a refresh
    local function ttt_force_medic( ply )
        ply:SetRole( ROLE_MEDIC )
        SendFullStateUpdate( )
    end

    concommand.Add( "ttt_force_medic" , ttt_force_medic , nil , nil , FCVAR_CHEAT ) -- added concommand, look ttt2 github detective, traitor, innocent files to see this too
end

-- this need to be on server
if CLIENT then
    -- finally the broadcasted first popup is received but again not at the players screen
    net.Receive( "ttt2_med_role_epop" , function( )
        plo = net.ReadString( ) -- reading the written string

        -- putting it into plo
        if plo == nil then
            plo = ""
        end

        EPOP:AddMessage( {
            text = LANG.GetTranslation( "ttt2_role_medic_popuptitle" ) .. plo , -- getting translation from language files and plo
            color = Color( 4 , 180 , 134 , 255 ) -- setting color to the role color
        } , "" , GetConVar( "ttt2_med_announce_arrival_popup_duration" ):GetInt( ) )
    end )

    -- how long should the message appear on screen
    -- the first popup is now on the screen
    -- finally the broadcasted second popup is received but again not at the players screen
    net.Receive( "ttt2_med_role_epop_2" , function( )
        plo2 = net.ReadString( ) -- reading the written string

        -- putting it into plo2
        if plo2 == nil then
            plo2 = ""
        end

        EPOP:AddMessage( {
            text = LANG.GetTranslation( "ttt2_role_medic_popuptitle_2" ) .. plo2 , -- getting translation from language files and plo2
            color = Color( 4 , 180 , 134 , 255 ) -- setting color to the role color
        } , "" , GetConVar( "ttt2_med_announce_death_popup_duration" ):GetInt( ) )
    end )

    -- how long should the message appear on screen
    -- the second popup is now on the screen
    -- finally the broadcasted third popup is received but again not at the players screen
    net.Receive( "ttt2_med_role_epop_3" , function( )
        plo3 = net.ReadString( ) -- reading the written string

        -- putting it into plo3
        if plo3 == nil then
            plo3 = ""
        end

        EPOP:AddMessage( {
            text = LANG.GetTranslation( "ttt2_role_medic_popuptitle_3" ) .. plo3 , -- getting translation from language files and plo3
            color = Color( 4 , 180 , 134 , 255 ) -- setting color to the role color
        } , "" , GetConVar( "ttt2_med_announce_crime_popup_duration" ):GetInt( ) )
    end )

    -- how long should the message appear on screen
    -- the third popup is now on the screen
    -- finally the broadcasted fourth popup is received but again not at the players screen
    net.Receive( "ttt2_med_role_epop_4" , function( )
        plo4 = net.ReadString( ) -- reading the written string

        -- putting it into plo4
        if plo4 == nil then
            plo4 = ""
        end

        EPOP:AddMessage( {
            text = LANG.GetTranslation( "ttt2_role_medic_popuptitle_4" ) .. plo4 , -- getting translation from language files and plo4
            color = Color( 4 , 180 , 134 , 255 ) -- setting color to the role color
        } , "" , GetConVar( "ttt2_med_announce_betrayel_popup_duration" ):GetInt( ) )
    end )
    -- how long should the message appear on screen
    -- the fourth popup is now on the screen
end
-- this need to be on client
