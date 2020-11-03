local PLUGIN = PLUGIN
PLUGIN.name = "Illegal Money"
PLUGIN.author = "Akulla"
PLUGIN.description = "Illegal tu coco wlh la cité la vraie"

local PLAYER = FindMetaTable("Player")

function PLAYER:IM_GetMoney()
	return self:GetLocalVar("illegalmoney", 0)
end

if SERVER then
	function PLAYER:IM_SetMoney(amt)
		self:SetLocalVar("illegalmoney", amt)
	end

	function PLAYER:IM_AddMoney(amt)
		self:IM_SetMoney(self:IM_GetMoney() + amt)
	end

	function PLAYER:IM_Transfer()
		self:GetCharacter():SetMoney(self:GetCharacter():GetMoney() + self:IM_GetMoney())
		self:IM_SetMoney(0)
	end

	function PLUGIN:CharacterPreSave(character)
	    local client = character:GetPlayer()
	    if (IsValid(client)) then
	        character:SetData("illegalmoney", client:GetLocalVar("illegalmoney", 0))
	    end
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
	    timer.Simple(0.25, function()
	        client:SetLocalVar("illegalmoney", character:GetData("illegalmoney", 0))
	    end)
	end
else
	function PLUGIN:CreateCharacterInfo(panel)
		IM = panel:Add("ixListRow")
		IM:SetList(panel.list)
		IM:Dock(TOP)
		IM:SizeToContents()
		IM:SetLabelText("Argent Sale")
		IM:SetText(ix.currency.Get(LocalPlayer():IM_GetMoney()))
	end
end