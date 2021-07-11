util.AddNetworkString("RDV.DEFCON.CHANGE")
util.AddNetworkString("RD_DEFCON_MENU")
util.AddNetworkString("RD_DEFCON_CHANGE")

local COL_WHITE = Color(255,255,255)

local function SendNotification(ply, msg)
	local PRE_COLOR = RDV.DEFCON.CFG.PREFIX.Color
	local PRE = RDV.DEFCON.CFG.PREFIX.Appension

    RDV.LIBRARY.AddText(ply, PRE_COLOR, "["..PRE.."] ", COL_WHITE, msg)
end

net.Receive("RDV.DEFCON.CHANGE", function(len, ply)
	local COOLDOWN, TIME = RD_Cooldown_Get("RD_DEFCON_DELAY"..ply:SteamID64())

	if COOLDOWN then
		local LANG = RDV.DEFCON.GetLanguage("rateLimited")

		SendNotification(ply, LANG)

		return
	end

	local defcon = net.ReadUInt(8)
	local CFG = RDV.DEFCON.LIST

	if !CFG or !CFG[defcon] then
		return
	end

	local TEAMS = CFG[defcon].Teams

	if TEAMS and !table.IsEmpty(TEAMS) then
		if !TEAMS[team.GetName(ply:Team())] then
			local LANG = RDV.DEFCON.GetLanguage("notCorrectTeam")
			SendNotification(ply, LANG)

			return
		end
	end

	RDV.DEFCON.SetDefcon(defcon, ply)

	RD_Cooldown_Add("RD_DEFCON_DELAY"..ply:SteamID64(), 1)
end)