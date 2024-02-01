local ModID = "PermadeathMod"
local ModVersion = "0.0.1-dev-1"
local ModInitialized = false

--- @class ABP_Player_Female_C
local PlayerObj = nil

local function log(msg)
    print("-----------------------------------------")
    print("[" .. ModID .. " - v" .. ModVersion .. "] " .. msg)
    print("-----------------------------------------")
end

local function clear_inventory()
    if PlayerObj and PlayerObj:IsValid() then
        PlayerObj.PlayerState.InventoryData.InventoryMultiHelper.Containers:ForEach(function(index, elem_wrapper)
            local container = elem_wrapper:get()
            container.ItemSlotArray:ForEach(function(index, elem)
                local item = elem:get()
                item.StackCount = 0
                item.ItemId.StaticId = FName("None")
                item.ItemId.DynamicId = {
                    CreatedWorldId = { A = 0, B = 0, C = 0, D = 0 },
                    LocalIdInCreatedWorld = { A = 0, B = 0, C = 0, D = 0 }
                }
            end)
        end)
    end
end

local function init()
    local CharacterInstance = FindFirstOf("BP_Player_Female_C")
    if not CharacterInstance:IsValid() then
        log("No instance of Character was found.\n Init failed.")
        return
    else
        PlayerObj = CharacterInstance
    end

    RegisterHook("/Game/Pal/Blueprint/Status/BP_Status_Dying.BP_Status_Dying_C:TickStatus",
        function(self, dt)
            clear_inventory()
    end)

    ModInitialized = true
    log("Init succeeded.")
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
    init()
end)
