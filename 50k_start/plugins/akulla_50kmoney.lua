local PLUGIN = PLUGIN
PLUGIN.name = "50k start"
PLUGIN.author = "Akulla"
PLUGIN.description = "50k start"

if SERVER then
	function PLUGIN:AdjustCreationPayload(client, payload, newPayload)
		newPayload.money = 50000
	end
end