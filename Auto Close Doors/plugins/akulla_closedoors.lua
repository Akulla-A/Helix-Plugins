PLUGIN.name = "Close Doors"
PLUGIN.author = ""
PLUGIN.description = "Close doors on start"

if SERVER then
    local enttbl = {
        prop_door_rotating = true,
        func_door = true,
        func_door_rotating = true,
    }

    function PLUGIN:InitPostEntity()
		for k,v in pairs(ents.GetAll()) do
			if enttbl[v:GetClass()] then
				v:Fire("Close")
            end
        end
    end
end