local COL_WHITE = Color(255,255,255)

local function SendNotification(ply, msg)
	local PRE_COLOR = RDV.DEFCON.CFG.PREFIX.Color
	local PRE = RDV.DEFCON.CFG.PREFIX.Appension

    RDV.LIBRARY.AddText(ply, PRE_COLOR, "["..PRE.."] ", COL_WHITE, msg)
end

hook.Add("PlayerSay", "RDV.DEFCON.PlayerSay", function(ply, text)
	local COMMAND = RDV.DEFCON.CFG.COMMAND

	if string.sub(string.lower(text), 1, #COMMAND) == COMMAND then
		local args = string.Explode(" ", text)

		if !args[2] then
			local LANG = RDV.DEFCON.GetLanguage("pleaseChooseLevel")

			SendNotification(ply, LANG)

			return ""
		end

		RDV.DEFCON.SetDefcon(args[2], ply)

		return ""
	end
end)

local DEFAULT
hook.Add("PlayerReadyForNetworking", "RDV.DEFCON.PlayerReadyForNetworking", function(ply)
	if RDV.DEFCON.CURRENT and ( DEFAULT ~= RDV.DEFCON.CURRENT ) then
		net.Start("RDV.DEFCON.CHANGE")
			net.WriteUInt(RDV.DEFCON.CURRENT, 6)
		net.Send(ply)
	end
end)

hook.Add("Initialize", "RDV.DEFCON.INITIALIZE", function()
	RDV.DEFCON.CURRENT = table.maxn(RDV.DEFCON.LIST)

	DEFAULT = RDV.DEFCON.CURRENT
end)

local COL_WHITE = Color(255,255,255)

function RDV.DEFCON.SetDefcon(number, ply)
	if not IsValid(ply) then
		return false
	end

	local CFG = RDV.DEFCON.LIST
	local DEFCON_LVL = tonumber(number)

	if !CFG[DEFCON_LVL] then
		local LANG = RDV.DEFCON.GetLanguage("DefconLevelInvalid")

		SendNotification(ply, LANG)

		return ""
	end

	if RDV.DEFCON.CFG.STAFF[ply:GetUserGroup()] or ( CFG[DEFCON_LVL].Check and CFG[DEFCON_LVL].Check(ply) ~= false ) then
		RDV.DEFCON.CURRENT = DEFCON_LVL

		net.Start("RDV.DEFCON.CHANGE")
			net.WriteUInt(DEFCON_LVL, 6)
			net.WriteUInt(ply:EntIndex(), 8)
		net.Broadcast()

		hook.Run("RDV.DEFCON.PlayerChangedDefcon", DEFCON_LVL, ply)

		return ""
	end
end