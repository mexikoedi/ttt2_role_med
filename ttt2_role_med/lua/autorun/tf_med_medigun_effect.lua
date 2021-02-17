if engine.ActiveGamemode() ~= "terrortown" then return end -- we need this (or we can have this) to prevent this file from loading if the gamemmode is not ttt, this is only needed here lua/autorun, in /terrortown/... is this not needed
game.AddParticles("particles/ttt_medigun/medicgun_beam.pcf") -- added/loaded the particles for the medigun that are called in weapon_ttt2_medic_medigun
game.AddParticles("particles/ttt_medigun/ownmedicgun_beam.pcf")
game.AddParticles("particles/ttt_medigun/ownmedicgun_attrib.pcf")
