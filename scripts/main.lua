local ModID = "PermadeathMod"
local ModVersion = "0.0.2-dev"
local ModInitialized = false
local ModDevMode = false

--- @class ABP_Player_Female_C
local PlayerObj = nil

--- @class APlayerState
local PlayerState = nil

local function log(msg)
    print("-----------------------------------------")
    print("[" .. ModID .. " - v" .. ModVersion .. "] " .. msg)
    print("-----------------------------------------")
end

local function clear_inventory()
    if PlayerObj and PlayerObj:IsValid() then
        PlayerState.InventoryData.InventoryMultiHelper.Containers:ForEach(function(index, elem_wrapper)
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

local function clear_otomo_pals()
    local component = PlayerObj.Controller.BP_OtomoPalHolderComponent
    component.CharacterContainer.SlotArray:ForEach(function (index, elem)
        local pal = elem:get()

        if not pal or not pal.Handle:IsValid() then return end

        if ModDevMode then log("Pal: " .. pal:GetFullName()) end

        if pal.Handle:IsValid() then
            if ModDevMode then log("Deleting pal") end
            pal.Handle:TryGetIndividualActor().SetActiveActor(false)
        end
        
        pal.Handle = FName("None")
        pal.ReplicateHandleID.InstanceId = {A=0, B=0, C=0, D=0}
    end)
end

local function init()
    local CharacterInstance = FindFirstOf("BP_Player_Female_C")
    if not CharacterInstance:IsValid() then
        log("Init failed.")
        return
    else
        PlayerObj = CharacterInstance
        PlayerState = PlayerObj.PlayerState
    end

    RegisterHook("/Game/Pal/Blueprint/Status/BP_Status_Dying.BP_Status_Dying_C:TickStatus",
        function(self, dt)
            clear_inventory()
            clear_otomo_pals()
    end)

    ModInitialized = true
    log("Init succeeded.")
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
    init()
end)

-- Only for help in development
if ModDevMode then

RegisterKeyBind(Key.N, function()
    if ModInitialized == false then init() end
end)    

RegisterKeyBind(Key.Y, function()
    if PlayerObj and PlayerObj:IsValid() then log("Player: " .. PlayerObj:GetFullName()) end
    if PlayerState and PlayerState:IsValid() then log("PlayerState: " .. PlayerState:GetFullName()) end

    clear_otomo_pals()
end)

local function create_item(item_ref, id, count)
    log("Creating item: " .. id)
    item_ref.StackCount = count
    item_ref.ItemId.StaticId = FName(id)
    item_ref.ItemId.DynamicId = {
        CreatedWorldId = { A = 0, B = 0, C = 0, D = 0 },
        LocalIdInCreatedWorld = { A = 0, B = 0, C = 0, D = 0 }
    } 
end

RegisterKeyBind(Key.V, function()
    local container = PlayerState.InventoryData.InventoryMultiHelper.Containers[1]
    log(container:GetFullName())

    container.ItemSlotArray:ForEach(function(index, elem)
        local item = elem:get()
        if index == 1 then return create_item(item, "Stone", 10) end
        if index == 2 then return create_item(item, "Wood", 20) end
        if index == 3 then return create_item(item, "Pal_crystal_S", 10) end
        if index == 4 then return create_item(item, "PalSphere", 10) end
        if index == 5 then return create_item(item, "Berries", 10) end
        if index == 6 then return create_item(item, "Wool", 10) end
        if index == 7 then return create_item(item, "Fiber", 10) end
        
        local name = item.ItemId.StaticId:ToString()
        if name ~= "None" then return log(name) end
    end)
end)

end