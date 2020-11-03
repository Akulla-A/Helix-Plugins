PLUGIN.name = "Braquage de Magasin"
PLUGIN.author = "Akulla"
PLUGIN.description = "Braquer les magasins"

local function There_Is_Police()
    for k,v in pairs(player.GetAll()) do
        if ix.faction.Get(v:GetCharacter():GetFaction()).name == "Police" then
            return true
        end
    end
end

if SERVER then
    local function GoodSteal(ply)
        local amt = math.Round(math.Rand(15, 30))
        ply:GetCharacter():SetMoney(ply:GetCharacter():GetMoney() + amt)
        ply:SetAction()
        ply:Notify("Vol réussi : +"..ix.currency.Get(amt))
        ply:EmitSound("zmlab/sfx_cash01.wav")
    end

    local function BadSteal(ply)
        ply:Notify("Vous avez annulé la prise d'argent")
        ply:SetAction()
    end

    function PLUGIN:PlayerUse(ply, ent)
        ply.LastShopTake = ply.LastShopTake or CurTime() - 2
        if ply.LastShopTake < CurTime() and ent:GetModel() == "models/uc/props_stores/cash_register.mdl" and ix.faction.Get(ply:GetCharacter():GetFaction()).name ~= "Police" then
            ply.LastShopTake = CurTime() + 2

            if There_Is_Police() then
                for k,v in pairs(ents.FindInSphere(ent:GetPos(), 500)) do
                    if v:GetClass() == "npc_magasin" then
                        if v.FearChar then
                            ply:SetAction("Vol dans la caisse",2)
                            ply:DoStaredAction(ent, GoodSteal(ply), 2, BadSteal(ply))
                        else
                            ply:Notify("Vous devez d'abord braquer le vendeur")
                        end
                        break
                    end
                end
            else
                ply:Notify("Pas de policiers en ville, action impossible")
            end
        end
    end
end