local OBJ = RDV.DEFCON.Config()

--[[---------------------------------]]--
-- Defcon Levels
--[[---------------------------------]]--

OBJ:AddDefcon(6, {
	Name = "Defcon 6",
	Description = "Natural State, weapons away / on safety.",
	Color = Color(52, 232, 235, 200),
	Teams = {"Citizen"},
})

OBJ:AddDefcon(5, {
	Name = "Defcon 5",
	Description = "High alert, weapons out / off safety.",
	Color = Color(10, 245, 22, 200),
})

OBJ:AddDefcon(4, {
	Name = "Defcon 4",
	Description = "All Battalions patrol, weapons out / off safety.",
	Color = Color(219, 200, 26, 200),
})

OBJ:AddDefcon(3, {
	Name = "Defcon 3",
	Description = "All Battalions to your appointed Battlestations, weapons out / off safety.",
	Color = Color(191, 131, 11, 200),
})

OBJ:AddDefcon(2, {
	Name = "Defcon 2",
	Description = "All Battalions defend key areas, weapons out / off safety.",
	Color = Color(255,0,0, 200),
})

OBJ:AddDefcon(1, {
	Name = "Defcon 1",
	Description = "All Battalions evacuate the base.",
	Color = Color(0, 0, 0, 200),
})

OBJ:AddDefcon(0, {
	Name = "Mission",
	Description = "All Battalions are currently on a Mission.",
	Color = Color(52, 232, 235, 200),
})

--[[---------------------------------]]--
-- Cosmetic
--[[---------------------------------]]--

OBJ:SetPrefix({
    Appension = "Defcon",
    Color = Color(255,0,0)
})

OBJ:SetModel("models/lordtrilobite/starwars/isd/imp_console_medium01.mdl")

--[[---------------------------------]]--
-- Staff
--[[---------------------------------]]--

OBJ:SetAdmins({
	"superadmin",
})

--[[---------------------------------]]--
-- Other
--[[---------------------------------]]--

OBJ:DisplayChanger(true) -- Should we display who changed the Defcon?

--[[---------------------------------]]--
-- Command
--[[---------------------------------]]--

OBJ:SetCommand("!defcon")