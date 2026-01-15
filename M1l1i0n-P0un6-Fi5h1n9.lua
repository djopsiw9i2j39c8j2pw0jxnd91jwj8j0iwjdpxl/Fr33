getgenv().ServiceLogic = getgenv().ServiceLogic or {}
local ServiceLogic = getgenv().ServiceLogic

local SERVICE_LIST = {
    "TeleportService","Lighting","Players","ReplicatedStorage",
    "Workspace","RunService","Stats","VirtualUser","HttpService",
    "UserInputService","CoreGui","TweenService",
    "VirtualInputManager","StarterGui",
}

local cache = {}

local function initServices()
    for _, s in ipairs(SERVICE_LIST) do
        cache[s] = game:GetService(s)
    end
end

local function getMap()
    local m = cache.Workspace:FindFirstChild("Map")
    return m and m:FindFirstChild("Ingame") and m.Ingame:FindFirstChild("Map")
end

local function setChar(c)
    cache.Character = c
    cache.Humanoid = c:WaitForChild("Humanoid",5)
    cache.HRP = c:WaitForChild("HumanoidRootPart",5)
end

function ServiceLogic.getServiceLogic()
    if cache._loaded then return cache end
    cache._loaded = true

    initServices()

    local lp = cache.Players.LocalPlayer
    cache.LocalPlayer = lp
    cache.PlayerGui = function() return lp:FindFirstChild("PlayerGui") end
    cache.Camera = function() return cache.Workspace.CurrentCamera end

    if lp.Character then setChar(lp.Character) end
    lp.CharacterAdded:Connect(setChar)

    cache.Map = getMap()
    cache.RefreshMap = function()
        cache.Map = getMap()
        return cache.Map
    end

    return cache
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b", 
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

WindUI:AddTheme({
    Name = "Light",
    Accent = "#f4f4f5",
    Dialog = "#f4f4f5",
    Outline = "#000000", 
    Text = "#000000",
    Placeholder = "#666666",
    Background = "#ffffff",
    Button = "#e4e4e7",
    Icon = "#52525b",
})

WindUI:AddTheme({
    Name = "Gray",
    Accent = "#374151",
    Dialog = "#374151",
    Outline = "#d1d5db", 
    Text = "#f9fafb",
    Placeholder = "#9ca3af",
    Background = "#1f2937",
    Button = "#4b5563",
    Icon = "#d1d5db",
})

WindUI:AddTheme({
    Name = "Blue",
    Accent = "#1e40af",
    Dialog = "#1e3a8a",
    Outline = "#93c5fd", 
    Text = "#f0f9ff",
    Placeholder = "#60a5fa",
    Background = "#1e293b",
    Button = "#3b82f6",
    Icon = "#93c5fd",
})

WindUI:AddTheme({
    Name = "Green",
    Accent = "#059669",
    Dialog = "#047857",
    Outline = "#6ee7b7", 
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#064e3b",
    Button = "#10b981",
    Icon = "#6ee7b7",
})

WindUI:AddTheme({
    Name = "Purple",
    Accent = "#7c3aed",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd", 
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#581c87",
    Button = "#8b5cf6",
    Icon = "#c4b5fd",
})

WindUI:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "Purple"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = true
end

local Window = WindUI:CreateWindow({
    Title = "Hutao Hub [Free]",
    Icon = "rbxassetid://109995816235688", 
    Background = "rbxassetid://130999733265467",
    Author = "Câu Cá Triệu Cân | By: SLK GAMING",
    Folder = "HutaoHub - WindUI",
    Size = UDim2.fromOffset(500, 350),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Blue",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            currentThemeIndex = currentThemeIndex + 1
            if currentThemeIndex > #themes then
                currentThemeIndex = 1
            end
            
            local newTheme = themes[currentThemeIndex]
            WindUI:SetTheme(newTheme)
           
            WindUI:Notify({
                Title = "Theme Changed",
                Content = "Switched to " .. newTheme .. " theme!",
                Duration = 2,
                Icon = "palette"
            })
            print("Switched to " .. newTheme .. " theme")
        end,
    },
    
})

Window:SetToggleKey(Enum.KeyCode.V)

pcall(function()
    Window:CreateTopbarButton("TransparencyToggle", "eye", function()
        if getgenv().TransparencyEnabled then
            getgenv().TransparencyEnabled = false
            pcall(function() Window:ToggleTransparency(false) end)
            
            WindUI:Notify({
                Title = "Transparency", 
                Content = "Transparency disabled",
                Duration = 3,
                Icon = "eye"
            })
            print("Transparency = false")
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)
            
            WindUI:Notify({
                Title = "Transparency",
                Content = "Transparency enabled", 
                Duration = 3,
                Icon = "eye-off"
            })
            print(" Transparency = true")
        end

        print("Debug - Current Transparency state:", getgenv().TransparencyEnabled)
    end, 990)
end)

Window:EditOpenButton({
    Title = "Hutao Hub - Open Gui",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 120)),
}),
    Draggable = true,
})

Window:Tag({
    Title = "v0.2.0",
    Color = Color3.fromHex("#30ff6a")
})

local Tabs = {
    About = Window:Section({ Title = "About", Opened = true }),
    Main = Window:Section({ Title = "Main", Opened = true }),
}

local TabHandles = {
    Info = Tabs.About:Tab({ Title = "Information", Icon = "badge-info", Desc = "" }),
    Money = Tabs.Main:Tab({ Title = "Money", Icon = "crown", Desc = "" }),
}

local ServiceLogic = getgenv().ServiceLogic
local S = ServiceLogic.getServiceLogic()

local Remote = S.ReplicatedStorage:WaitForChild("SaveMoney")

local moneyValue = nil

TabHandles.Money:Input({
    Title = "Enter Money",
    Placeholder = "Nhập số tiền cần thêm",
    Value = "",
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            moneyValue = math.floor(num)
        else
            moneyValue = nil
        end
    end
})

TabHandles.Money:Button({
    Title = "Add Money",
    Locked = false,
    Callback = function()
        if not moneyValue then
            return
        end

        Remote:FireServer(moneyValue)
    end
})