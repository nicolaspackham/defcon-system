local DEFCON_NAME
local DEFCON_DESC
local DEFCON_COLOR

local COL_WHITE = Color(255,255,255)

local function SendNotification(msg)
	local PRE_COLOR = RDV.DEFCON.CFG.PREFIX.Color
	local PRE = RDV.DEFCON.CFG.PREFIX.Appension

    RDV.LIBRARY.AddText(LocalPlayer(), PRE_COLOR, "["..PRE.."] ", COL_WHITE, msg)
end

--[[---------------------------------]]--
-- Draw Functions (Credit to Falco)
--[[---------------------------------]]--

local function textWrap(text, font, maxWidth)
    local totalWidth = 0

    surface.SetFont(font)

    local spaceWidth = surface.GetTextSize(' ')
    text = text:gsub("(%s?[%S]+)", function(word)
            local char = string.sub(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordlen = surface.GetTextSize(word)
            totalWidth = totalWidth + wordlen

            -- Wrap around when the max width is reached
            if wordlen >= maxWidth then -- Split the word if the word is too big
                local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end

            -- Split before the word
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                return '\n' .. string.sub(word, 2)
            end

            totalWidth = wordlen
            return '\n' .. word
        end)

    return text
end

local function safeText(text)
    return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text
end

local function DrawNonParsedText(text, font, x, y, color, xAlign)
    return draw.DrawText(safeText(text), font, x, y, color, xAlign)
end

--[[---------------------------------]]--
-- Defcon Changes
--[[---------------------------------]]--

local function CacheDefcon(num)
	local CFG = RDV.DEFCON.LIST

	if !CFG[num] then
		return false
	end

	RDV.DEFCON.CURRENT = num

	DEFCON_NAME = RDV.DEFCON.LIST[num].Name

	DEFCON_DESC = RDV.DEFCON.LIST[num].Description

    DEFCON_DESC = DEFCON_DESC:gsub("//", "\n"):gsub("\\n", "\n")

    DEFCON_DESC = textWrap(DEFCON_DESC, "STARLIGHT_MONSTERRAT_01", ScrW() * 0.175)

    DEFCON_COLOR = RDV.DEFCON.LIST[num].Color
end

net.Receive("RDV.DEFCON.CHANGE", function()
	local DEF_NUM = net.ReadUInt(6)
    local PLAYER = Entity(net.ReadUInt(8))

    local VAL = CacheDefcon(DEF_NUM)

    if VAL == false then
        return
    end

    local PRE_COLOR = RDV.DEFCON.CFG.PREFIX.Color
    local PRE = RDV.DEFCON.CFG.PREFIX.Appension

    if not RDV.DEFCON.CFG.DisplayChanger or not IsValid(PLAYER) then
        local LANG = RDV.DEFCON.GetLanguage("defconLevelChanged", {
            {
                Name = "{defcon}",
                Replacement = DEFCON_NAME,
            },
        })

        SendNotification(LANG)
    else
        if not PLAYER.Name then
            return
        end
        
        local LANG = RDV.DEFCON.GetLanguage("defconPlayerLevelChanged", {
            {
                Name = "{defcon}",
                Replacement = DEFCON_NAME,
            },
            {
                Name = "{player}",
                Replacement = PLAYER:Name(),
            },
        })

        SendNotification(LANG)
    end

    surface.PlaySound("common/talk.wav")
    surface.PlaySound("buttons/blip1.wav")
    
    hook.Run("RDV.DEFCON.PlayerChangedDefcon", DEF_NUM, PLAYER)
end)

--[[---------------------------------]]--
-- HUD
--[[---------------------------------]]--

hook.Add("HUDPaint", "RDV.DEFCON.HUDPaint", function()
	if not RDV.DEFCON.LIST[RDV.DEFCON.CURRENT] then return end

    if not DEFCON_DESC or DEFCON_DESC == "" then return end

    draw.SimpleText(DEFCON_NAME, "STARLIGHT_MONSTERRAT_03", ScrW() * 0.8975, ScrH() * 0.01, DEFCON_COLOR, TEXT_ALIGN_CENTER)

    DrawNonParsedText(DEFCON_DESC, "STARLIGHT_MONSTERRAT_01", ScrW() * 0.8975, ScrH() * 0.0375, COL_WHITE, TEXT_ALIGN_CENTER)
end)

--[[---------------------------------]]--
-- Spawn in, set default.
--[[---------------------------------]]--

hook.Add("InitPostEntity", "RDV.DEFCON.InitPostEntity", function()
    local MAX = table.maxn(RDV.DEFCON.LIST)
    local VAL = CacheDefcon(MAX)
end)