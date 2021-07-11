function RDV.DEFCON.GetDefcon()
	return (RDV.DEFCON.CURRENT or 0)
end

function RDV.DEFCON.GetLanguage(LANG, TAB2)
    local LANGUAGE = ( RDV.DEFCON.LANG.SELECTED or "eng" )

    if !RDV.DEFCON.LANG.LIST[LANGUAGE] then
        return "NOT FOUND"
    end

    local TAB = RDV.DEFCON.LANG.LIST[LANGUAGE][LANG]
    local NEWLANG = TAB

    if !TAB then
        return "NOT FOUND"
    elseif TAB and !TAB2 then
        return TAB
    end

    if istable(TAB2) then
        for k, v in ipairs(TAB2) do
            if !v.Replacement then
                continue
            end

            NEWLANG = string.Replace(NEWLANG, v.Name, v.Replacement)
        end
    end

    return (NEWLANG or "NOT FOUND")
end