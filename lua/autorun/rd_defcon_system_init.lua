RDV = RDV or {}
RDV.DEFCON = RDV.DEFCON or {
    CFG = {},
    LIST = {},
    LANG = {
        LIST = {},
    },
}

local rootDir = "rdv_defcon_system"

local function AddFile(File, dir)
    local fileSide = string.lower(string.Left(File , 3))

    if SERVER and fileSide == "sv_" then
        include(dir..File)
    elseif fileSide == "sh_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        end
        include(dir..File)
    elseif fileSide == "cl_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        elseif CLIENT then
            include(dir..File)
        end
    end
end

local function IncludeDir(dir)
    dir = dir .. "/"
    local File, Directory = file.Find(dir.."*", "LUA")

    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end
    
    for k, v in ipairs(Directory) do
        IncludeDir(dir..v)
    end

end
IncludeDir(rootDir)

MsgC(Color(255,0,0), "[DEFCON SYSTEM] ", Color(255,255,255), "The addon has initialized properly, info below:\nDefault Defcon Level: "..(table.maxn(RDV.DEFCON.LIST) or "N/A").."\n" )
