local mod	= DBM:NewMod("Vesperon", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3695 $"):sub(12, -3))
mod:SetCreatureID(30449)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
    "SPELL_CAST_SUCCESS"
)

local warnShadowFissure	= mod:NewSpellAnnounce(59127)
local timerShadowFissure = mod:NewCastTimer(5, 59128)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.

function mod:OnCombatStart()
    DBM:FireCustomEvent("DBM_EncounterStart", 740, "Vesperon")
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 740, "Vesperon", wipe)
end

function mod:SPELL_CAST_SUCCESS(args)
    if args:IsSpellID(57579, 59127) and self:IsInCombat() then
        warnShadowFissure:Show()
        timerShadowFissure:Start()
    end
end