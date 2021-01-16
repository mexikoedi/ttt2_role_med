if SERVER then
    AddCSLuaFile( ) -- adding this file for download, the rest is base ttt/ttt2 and other code for the defibrillator
    resource.AddFile( "materials/vgui/ttt/icon_defibrillator.vmt" ) -- adding defibrillator icon for download
    resource.AddWorkshop( "2115944312" ) -- adding the defibrillator for download
end

local DEFI_IDLE = 0
local DEFI_BUSY = 1
local DEFI_CHARGE = 2
local DEFI_ERROR_BRAINDEAD = 0
local DEFI_ERROR_NO_SPACE = 1
local DEFI_ERROR_TOO_FAST = 2
local DEFI_ERROR_LOST_TARGET = 3
local DEFI_ERROR_NO_VALID_PLY = 4
local DEFI_ERROR_ALREADY_REVIVING = 5
local DEFI_ERROR_FAILED = 6

local sounds = {
    empty = Sound( "Weapon_SMG1.Empty" ) ,
    beep = Sound( "buttons/button17.wav" ) ,
    hum = Sound( "items/nvg_on.wav" ) ,
    zap = Sound( "ambient/energy/zap7.wav" ) ,
    revived = Sound( "items/smallmedkit1.wav" )
}

SWEP.Base = "weapon_tttbase"

if CLIENT then
    SWEP.ViewModelFOV = 78
    SWEP.DrawCrosshair = false
    SWEP.ViewModelFlip = false

    SWEP.EquipMenuData = {
        type = "item_weapon" ,
        name = "weapon_med_defi_name" ,
        desc = "weapon_med_defi_desc"
    }

    SWEP.Icon = "vgui/ttt/icon_defibrillator"
end

function SWEP:Initialize( )
    if CLIENT then
        self:AddHUDHelp( "ttt2_med_defibrillator_help1" , "ttt2_med_defibrillator_help2" , true )
    end
end

SWEP.Kind = WEAPON_EQUIP2
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"
SWEP.AutoSpawnable = false
SWEP.NoSights = true
SWEP.HoldType = "pistol"
SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = 0.5
SWEP.Charge = 0
SWEP.Timer = -1
SWEP.AllowDrop = false
SWEP.AllowPickup = false

SWEP.InLoadoutFor = { ROLE_MEDIC }

if SERVER then
    util.AddNetworkString( "RequestRevivalStatus" )
    util.AddNetworkString( "ReceiveRevivalStatus" )

    function SWEP:OnDrop( )
        self.BaseClass.OnDrop( self )
        self:CancelRevival( )
        self:Remove( )
    end

    function SWEP:SetState( state )
        self:SetNWInt( "defi_state" , state or DEFI_IDLE )
    end

    function SWEP:Reset( )
        self:SetState( DEFI_IDLE )
        self.defiTarget = nil
        self.defiBone = nil
        self.defiStart = 0
        self.defiTimer = nil
    end

    function SWEP:Error( type )
        self:SetState( DEFI_CHARGE )
        self:StopSound( "hum" )
        self:PlaySound( "beep" )
        self.defiTarget = nil
        self.defiTimer = "defi_reset_timer_" .. self:EntIndex( )
        if timer.Exists( self.defiTimer ) then return end

        timer.Create( self.defiTimer , GetConVar( "ttt2_med_defibrillator_error_time" ):GetFloat( ) , 1 , function( )
            if not IsValid( self ) then return end
            self:Reset( )
        end )

        self:Message( type )
    end

    function SWEP:Message( type )
        local owner = self:GetOwner( )

        if type == DEFI_ERROR_BRAINDEAD then
            LANG.Msg( owner , "med_defi_error_braindead" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_NO_SPACE then
            LANG.Msg( owner , "med_defi_error_no_space" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_TOO_FAST then
            LANG.Msg( owner , "med_defi_error_too_fast" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_LOST_TARGET then
            LANG.Msg( owner , "med_defi_error_lost_target" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_NO_VALID_PLY then
            LANG.Msg( owner , "med_defi_error_no_valid_ply" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_ALREADY_REVIVING then
            LANG.Msg( owner , "med_defi_error_already_reviving" , nil , MSG_MSTACK_WARN )
        elseif type == DEFI_ERROR_FAILED then
            LANG.Msg( owner , "med_defi_error_failed" , nil , MSG_MSTACK_WARN )
        end
    end

    function SWEP:BeginRevival( ragdoll , bone )
        local ply = CORPSE.GetPlayer( ragdoll )

        if not IsValid( ply ) then
            self:Error( DEFI_ERROR_NO_VALID_PLY )

            return
        end

        if ply:IsReviving( ) then
            self:Error( DEFI_ERROR_ALREADY_REVIVING )

            return
        end

        local reviveTime = GetConVar( "ttt2_med_defibrillator_revive_time" ):GetFloat( )
        self:SetState( DEFI_BUSY )
        self:SetStartTime( CurTime( ) )
        self:SetReviveTime( reviveTime )
        self:PlaySound( "hum" )

        -- start revival
        ply:Revive( reviveTime , function( )
            if GetConVar( "ttt2_med_defibrillator_reset_confirm" ):GetBool( ) then
                ply:ResetConfirmPlayer( )
            end
        end , nil , true , false )

        ply:SendRevivalReason( "med_revived_by_player" , {
            name = self:GetOwner( ):Nick( )
        } )

        self.defiTarget = ragdoll
        self.defiBone = bone
    end

    function SWEP:FinishRevival( )
        self:PlaySound( "zap" )

        if math.random( 0 , 100 ) > GetConVar( "ttt2_med_defibrillator_success_chance" ):GetInt( ) then
            local phys = self.defiTarget:GetPhysicsObjectNum( self.defiBone )

            if IsValid( phys ) then
                phys:ApplyForceCenter( Vector( 0 , 0 , 4096 ) )
            end

            self:CancelRevival( )
            self:Error( DEFI_ERROR_FAILED )

            return
        end

        self:Reset( )
        self:PlaySound( "revived" )
        self:Remove( )
        RunConsoleCommand( "lastinv" )
    end

    function SWEP:CancelRevival( )
        local ply = CORPSE.GetPlayer( self.defiTarget )
        self:Reset( )
        if not IsValid( ply ) then return end
        ply:CancelRevival( )
        ply:SendRevivalReason( nil )
    end

    function SWEP:StopSound( soundName )
        if not GetConVar( "ttt2_med_defibrillator_play_sounds" ):GetBool( ) then return end
        self:GetOwner( ):StopSound( sounds[ soundName ] )
    end

    function SWEP:PlaySound( soundName )
        if not GetConVar( "ttt2_med_defibrillator_play_sounds" ):GetBool( ) then return end
        self:GetOwner( ):EmitSound( sounds[ soundName ] )
    end

    function SWEP:SetStartTime( time )
        self:SetNWFloat( "defi_start_time" , time or 0 )
    end

    function SWEP:SetReviveTime( time )
        self:SetNWFloat( "defi_revive_time" , time or 0 )
    end

    function SWEP:Think( )
        if self:GetState( ) ~= DEFI_BUSY then return end
        local owner = self:GetOwner( )

        if CurTime( ) >= self:GetStartTime( ) + GetConVar( "ttt2_med_defibrillator_revive_time" ):GetFloat( ) - 0.01 then
            self:FinishRevival( )
        elseif not owner:KeyDown( IN_ATTACK ) or owner:GetEyeTrace( MASK_SHOT_HULL ).Entity ~= self.defiTarget then
            self:CancelRevival( )
            self:Error( DEFI_ERROR_LOST_TARGET )
        end
    end

    function SWEP:PrimaryAttack( )
        local owner = self:GetOwner( )
        local trace = owner:GetEyeTrace( MASK_SHOT_HULL )
        local distance = trace.StartPos:Distance( trace.HitPos )
        local ent = trace.Entity

        if distance > GetConVar( "ttt2_med_defibrillator_distance" ):GetInt( ) or not IsValid( ent ) or ent:GetClass( ) ~= "prop_ragdoll" or not CORPSE.IsValidBody( ent ) then
            self:PlaySound( "empty" )

            return
        end

        local spawnPoint = spawn.MakeSpawnPointSafe( CORPSE.GetPlayer( ent ) , ent:GetPos( ) )

        if self:GetState( ) ~= DEFI_IDLE then
            self:Error( DEFI_ERROR_TOO_FAST )

            return
        end

        if CORPSE.WasHeadshot( ent ) and not GetConVar( "ttt2_med_defibrillator_revive_braindead" ):GetBool( ) then
            self:Error( DEFI_ERROR_BRAINDEAD )
        elseif not spawnPoint then
            self:Error( DEFI_ERROR_NO_SPACE )
        else
            self:BeginRevival( ent , trace.PhysicsBone )
        end
    end

    function SWEP:SecondaryAttack( )
        self:PlaySound( "beep" )
    end

    net.Receive( "RequestRevivalStatus" , function( _ , requester )
        local ply = net.ReadEntity( )
        if not IsValid( ply ) then return end
        net.Start( "ReceiveRevivalStatus" )
        net.WriteEntity( ply )
        net.WriteBool( ply:IsReviving( ) )
        net.Send( requester )
    end )
end

-- do not play sound when swep is empty
function SWEP:DryFire( )
    return false
end

function SWEP:GetState( )
    return self:GetNWInt( "defi_state" , DEFI_IDLE )
end

function SWEP:GetStartTime( )
    return self:GetNWFloat( "defi_start_time" , 0 )
end

function SWEP:GetReviveTime( )
    return self:GetNWFloat( "defi_revive_time" , 0 )
end

if CLIENT then
    local colorGreen = Color( 36 , 160 , 30 )

    local function IsPlayerReviving( ply )
        if not ply.defi_lastRequest or ply.defi_lastRequest < CurTime( ) + 0.3 then
            net.Start( "RequestRevivalStatus" )
            net.WriteEntity( ply )
            net.SendToServer( )
            ply.defi_lastRequest = CurTime( )
        end

        return ply.defi_isReviving or false
    end

    net.Receive( "ReceiveRevivalStatus" , function( )
        local ply = net.ReadEntity( )
        if not IsValid( ply ) then return end
        ply.defi_isReviving = net.ReadBool( )
    end )

    hook.Add( "TTTRenderEntityInfo" , "ttt2_med_defibrillator_display_info" , function( tData )
        local ent = tData:GetEntity( )
        local client = LocalPlayer( )
        local activeWeapon = client:GetActiveWeapon( )
        -- has to be a ragdoll
        if ent:GetClass( ) ~= "prop_ragdoll" or not CORPSE.IsValidBody( ent ) then return end
        -- player has to hold a defibrillator
        if not IsValid( activeWeapon ) or activeWeapon:GetClass( ) ~= "weapon_ttt2_medic_defibrillator" then return end
        -- ent has to be in usable range
        if tData:GetEntityDistance( ) > GetGlobalFloat( "ttt2_med_defibrillator_distance" , 100.0 ) then return end

        if activeWeapon:GetState( ) == DEFI_CHARGE then
            tData:AddDescriptionLine( LANG.TryTranslation( "med_defi_charging" ) , COLOR_ORANGE )
            tData:SetOutlineColor( COLOR_ORANGE )

            return
        end

        local ply = CORPSE.GetPlayer( ent )

        if activeWeapon:GetState( ) ~= DEFI_BUSY and IsValid( ply ) and IsPlayerReviving( ply ) then
            tData:AddDescriptionLine( LANG.TryTranslation( "med_defi_player_already_reviving" ) , COLOR_ORANGE )
            tData:SetOutlineColor( COLOR_ORANGE )

            return
        end

        tData:AddDescriptionLine( LANG.GetParamTranslation( "med_defi_hold_key_to_revive" , {
            key = Key( "+attack" , "LEFT MOUSE" )
        } ) , colorGreen )

        if activeWeapon:GetState( ) ~= DEFI_BUSY then return end
        local progress = math.min( ( CurTime( ) - activeWeapon:GetStartTime( ) ) / activeWeapon:GetReviveTime( ) , 1.0 )
        local timeLeft = activeWeapon:GetReviveTime( ) - ( CurTime( ) - activeWeapon:GetStartTime( ) )
        local x = 0.5 * ScrW( )
        local y = 0.5 * ScrH( )
        local w , h = 0.2 * ScrW( ) , 0.025 * ScrH( )
        y = 0.95 * y
        surface.SetDrawColor( 50 , 50 , 50 , 220 )
        surface.DrawRect( x - 0.5 * w , y - h , w , h )
        surface.SetDrawColor( clr( colorGreen ) )
        surface.DrawOutlinedRect( x - 0.5 * w , y - h , w , h )
        surface.SetDrawColor( clr( ColorAlpha( colorGreen , ( 0.5 + 0.15 * math.sin( CurTime( ) * 4 ) ) * 255 ) ) )
        surface.DrawRect( x - 0.5 * w + 2 , y - h + 2 , w * progress - 4 , h - 4 )

        tData:AddDescriptionLine( LANG.GetParamTranslation( "med_defi_revive_progress" , {
            time = math.Round( timeLeft , 1 )
        } ) , colorGreen )

        tData:SetOutlineColor( colorGreen )
    end )
end
