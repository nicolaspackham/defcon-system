function RDV.DEFCON.Config()
    RDV.DEFCON.CFG = {
        AddDefcon = function(self, id, values)
            if !id or !values then return end

            local teams = {}

            if values.Teams then
                for k, v in ipairs(values.Teams) do
                    teams[v] = true
                end

                values.Teams = teams
            end
            
            RDV.DEFCON.LIST[id] = values
        end,
        SetPrefix = function(self, tab)
            if !tab or !tab.Appension or !tab.Color then return end

            self.PREFIX = tab
        end,
        SetAdmins = function(self, tab)
            if !tab[1] then return end

            local STAFF = {}

            for k, v in ipairs(tab) do
                STAFF[v] = true    
            end

            self.STAFF = STAFF
        end,
        SetModel = function(self, model)
            self.MODEL = model
        end,
        DisplayChanger = function(self, val)
            self.DisplayChanger = val
        end,
        SetCommand = function(self, command)
            self.COMMAND = command
        end,
    }

    return RDV.DEFCON.CFG
end