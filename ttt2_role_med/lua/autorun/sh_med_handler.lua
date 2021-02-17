if engine.ActiveGamemode() ~= "terrortown" then return end -- we need this (or we can have this) to prevent this file from loading if the gamemmode is not ttt, this is only needed here lua/autorun, in /terrortown/... is this not needed

if SERVER then
    -- what happens "after death"
    hook.Add("TTT2PostPlayerDeath", "MedicKill", function(ply, attacker)
        if not IsValid(ply) then return end
        if not IsValid(attacker) or not attacker:IsPlayer() then return end
        if attacker:GetSubRole() ~= ROLE_MEDIC then return end
    end)

    if CLIENT then
        -- targetid stuff
        hook.Add("TTTRenderEntityInfo", "ttt2_med_targetid", function(tData)
            if not MEDIC then return end
            local client = LocalPlayer()
            if not IsValid(client) or not client:IsPlayer() or client:GetSubRole() ~= ROLE_MEDIC then return end
            if not tData:GetEntity():IsPlayer() then return end
        end)
    end
end
