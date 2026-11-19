--==============================================================
-- PYROVEX LOADER V17 | ROUNDED SCRIPT LOGOS
-- UI / animation refresh. Existing script collections and actions
-- are preserved: Execute, Copy, Discord Copy, tabs, minimize,
-- restore, close, dragging, floating button, responsive scaling.
--==============================================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- ASSETS
local LogoAsset = "rbxthumb://type=Asset&id=97950138094007&w=420&h=420"
local DiscordAsset = "rbxthumb://type=Asset&id=127546963058457&w=420&h=420"
local DiscordLink = "https://discord.gg/K3ahPnJV8y"

-- CLEANUP
for _, name in ipairs({"PyrovexTopLoader", "PyroVexLoader"}) do
    local old = PlayerGui:FindFirstChild(name)
    if old then old:Destroy() end
end

-- CONFIGURATION
local Config = {
    LoadingDuration = 5,
    MainWidth = 510,
    MainHeight = 370,
    MinimumScale = 0.65,
    MaximumScale = 1,
    FloatingSize = 54,
    CardHeight = 88,
    Animation = {
        Open = 0.62, Close = 0.32, Minimize = 0.30,
        Restore = 0.46, Hover = 0.20, Button = 0.11,
        Tab = 0.28, Card = 0.38, Fade = 0.22
    }
}
local Animation = Config.Animation

-- THEME
local C = {
    Background = Color3.fromRGB(5, 7, 15),
    Background2 = Color3.fromRGB(10, 13, 27),
    Header = Color3.fromRGB(13, 19, 37),
    Header2 = Color3.fromRGB(25, 18, 47),
    Panel = Color3.fromRGB(9, 14, 27),
    Card = Color3.fromRGB(17, 24, 42),
    CardHover = Color3.fromRGB(29, 42, 68),
    Blue = Color3.fromRGB(38, 126, 255),
    LightBlue = Color3.fromRGB(117, 195, 255),
    DarkBlue = Color3.fromRGB(18, 55, 120),
    Purple = Color3.fromRGB(145, 74, 255),
    LightPurple = Color3.fromRGB(196, 151, 255),
    Red = Color3.fromRGB(239, 62, 100),
    LightRed = Color3.fromRGB(255, 112, 137),
    Green = Color3.fromRGB(48, 224, 151),
    White = Color3.fromRGB(248, 250, 255),
    Gray = Color3.fromRGB(151, 164, 190),
    DarkGray = Color3.fromRGB(83, 97, 125),
    Border = Color3.fromRGB(48, 64, 99),
    CopyBackground = Color3.fromRGB(35, 45, 73)
}

-- HELPERS
local function New(class, props, parent)
    local object = Instance.new(class)
    for property, value in pairs(props or {}) do object[property] = value end
    object.Parent = parent
    return object
end

local function Round(object, radius)
    return New("UICorner", {CornerRadius = UDim.new(0, radius)}, object)
end

local function Outline(object, color, thickness, transparency)
    return New("UIStroke", {
        Color = color, Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, object)
end

local function Gradient(object, color1, color2, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }),
        Rotation = rotation or 0
    }, object)
end

local function PremiumGradient(object, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.Blue),
            ColorSequenceKeypoint.new(0.34, C.Purple),
            ColorSequenceKeypoint.new(0.68, C.Red),
            ColorSequenceKeypoint.new(1, C.Blue)
        }),
        Rotation = rotation or 0
    }, object)
end

local function Tween(object, properties, duration, style, direction)
    if not object or not object.Parent then return nil end
    local success, tween = pcall(function()
        return TweenService:Create(object, TweenInfo.new(
            duration or 0.25,
            style or Enum.EasingStyle.Quart,
            direction or Enum.EasingDirection.Out
        ), properties)
    end)
    if not success then return nil end
    tween:Play()
    return tween
end

local function AnimateGradient(gradient, speed)
    task.spawn(function()
        while gradient and gradient.Parent do
            Tween(gradient, {Rotation = gradient.Rotation + 180},
                speed or 3, Enum.EasingStyle.Linear)
            task.wait(speed or 3)
        end
    end)
end

local function Pulse(object, property, value1, value2, speed)
    task.spawn(function()
        while object and object.Parent do
            Tween(object, {[property] = value1}, speed or 1)
            task.wait(speed or 1)
            if not object or not object.Parent then break end
            Tween(object, {[property] = value2}, speed or 1)
            task.wait(speed or 1)
        end
    end)
end

local function GetLoadstring(url)
    return 'loadstring(game:HttpGet("' .. url .. '"))()'
end

local function GetResponsiveScale()
    if not Camera then Camera = workspace.CurrentCamera end
    if not Camera then return 1 end
    local viewport = Camera.ViewportSize
    return math.clamp(math.min(viewport.X / 560, viewport.Y / 430, 1),
        Config.MinimumScale, Config.MaximumScale)
end

local function AddGlass(parent, transparency)
    local overlay = New("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = transparency or 0.965,
        BorderSizePixel = 0,
        ZIndex = parent.ZIndex + 1
    }, parent)
    Round(overlay, 16)
    Gradient(overlay, Color3.fromRGB(255,255,255),
        Color3.fromRGB(100,130,190), 90)
    return overlay
end

-- SCRIPT COLLECTIONS (original entries and URLs retained)
local Scripts = {
    {Name = "CHILI HUB", Icon = "🌶️", Subtitle = "ALL IN ONE SCRIPT",
        URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"},
    {Name = "ADMIN BADGE", Icon = "🛡️", Subtitle = "ADMIN BADGE AND SPEED CHANGER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua.sae/main/steal.an.egg.lua"}
}

local GrowScripts = {
    {Name = "TOKEN SPAWNER", Icon = "🎟️", Subtitle = "TOKEN SPOOFER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua/main/Token.spawner.lua"},
    {Name = "ANTI AFK", Icon = "😴", Subtitle = "AFK 24/7",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex-Anti-afk/main/Pyrovex.lua"}
}

local UniversalScripts = {
    {Name = "PYROVEX DEBUGGER", Icon = "🐞", Subtitle = "DETECTS AN ERROR TO YOUR SCRIPT",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.debug/main/Pyro.lua"},
    {Name = "PYROVEX HUB SHADER", Icon = "🎨", Subtitle = "IMPROVE YOUR GAME VISUAL GRAPHICS",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Shader.lua/main/Pyrovex.lua"}
}

local AllScripts = {}
for _, scriptInfo in ipairs(Scripts) do table.insert(AllScripts, scriptInfo) end
for _, scriptInfo in ipairs(GrowScripts) do table.insert(AllScripts, scriptInfo) end
for _, scriptInfo in ipairs(UniversalScripts) do table.insert(AllScripts, scriptInfo) end

local Sections = {
    {Name = "ALL SCRIPTS", Width = 110},
    {Name = "STEAL AN EGG", Width = 125},
    {Name = "GROW A GARDEN", Width = 125},
    {Name = "UNIVERSAL SCRIPTS", Width = 155}
}

--==============================================================
-- PREMIUM LOADING SCREEN
--==============================================================
local LoadingGui = New("ScreenGui", {
    Name = "PyrovexTopLoader", IgnoreGuiInset = true,
    ResetOnSpawn = false, DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local LoadingDim = New("Frame", {
    Size = UDim2.fromScale(1,1), BackgroundColor3 = Color3.fromRGB(2,3,9),
    BackgroundTransparency = 0.20, BorderSizePixel = 0, ZIndex = 1
}, LoadingGui)

local LoadingMain = New("Frame", {
    Name = "LoadingContainer", Size = UDim2.fromOffset(390, 126),
    Position = UDim2.new(0.5,0,0,-150), AnchorPoint = Vector2.new(0.5,0),
    BackgroundColor3 = C.Background, BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 10
}, LoadingGui)
Round(LoadingMain, 20)
Gradient(LoadingMain, Color3.fromRGB(15,27,53), Color3.fromRGB(35,16,50), 25)
local LoadingStroke = Outline(LoadingMain, C.Blue, 1.8, 0.05)
AnimateGradient(PremiumGradient(LoadingStroke, 0), 2.8)

local LoadingAccent = New("Frame", {
    Size = UDim2.new(1,-22,0,3), Position = UDim2.fromOffset(11,0),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0, ZIndex = 15
}, LoadingMain)
Round(LoadingAccent, 5)
AnimateGradient(PremiumGradient(LoadingAccent, 0), 2)

local LoadingLogoFrame = New("Frame", {
    Size = UDim2.fromOffset(54,54), Position = UDim2.fromOffset(16,18),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 15
}, LoadingMain)
Round(LoadingLogoFrame, 15)
AnimateGradient(PremiumGradient(LoadingLogoFrame, 45), 2.5)
Outline(LoadingLogoFrame, C.LightBlue, 1.5, 0.1)

local LoadingLogo = New("ImageLabel", {
    Size = UDim2.new(1,-6,1,-6), Position = UDim2.fromOffset(3,3),
    BackgroundTransparency = 1, Image = LogoAsset,
    ScaleType = Enum.ScaleType.Fit, ZIndex = 16
}, LoadingLogoFrame)
Round(LoadingLogo, 12)

New("TextLabel", {
    Position = UDim2.fromOffset(82,17), Size = UDim2.new(1,-100,0,25),
    BackgroundTransparency = 1, Text = "PYROVEX HUB",
    TextColor3 = C.White, TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 15
}, LoadingMain)

New("TextLabel", {
    Position = UDim2.fromOffset(83,42), Size = UDim2.new(1,-100,0,16),
    BackgroundTransparency = 1, Text = "EXTREME PREMIUM INITIALIZATION",
    TextColor3 = C.LightBlue, TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold, ZIndex = 15
}, LoadingMain)

local LoadingStatus = New("TextLabel", {
    Position = UDim2.fromOffset(17,78), Size = UDim2.new(1,-90,0,15),
    BackgroundTransparency = 1, Text = "Initializing Pyrovex Hub...",
    TextColor3 = C.Gray, TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium, ZIndex = 15
}, LoadingMain)

local LoadingPercentage = New("TextLabel", {
    Position = UDim2.new(1,-65,0,76), Size = UDim2.fromOffset(48,18),
    BackgroundTransparency = 1, Text = "0%", TextColor3 = C.LightBlue,
    TextSize = 11, TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.GothamBlack, ZIndex = 15
}, LoadingMain)

local BarBG = New("Frame", {
    Size = UDim2.new(1,-32,0,8), Position = UDim2.fromOffset(16,101),
    BackgroundColor3 = Color3.fromRGB(35,43,64),
    BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 15
}, LoadingMain)
Round(BarBG, 10)

local Bar = New("Frame", {
    Size = UDim2.new(0,0,1,0), BackgroundColor3 = C.Blue,
    BorderSizePixel = 0, ZIndex = 16
}, BarBG)
Round(Bar, 10)
AnimateGradient(PremiumGradient(Bar, 0), 1.8)

local Shine = New("Frame", {
    Size = UDim2.new(0,55,1,0), Position = UDim2.new(0,-60,0,0),
    BackgroundColor3 = C.White, BackgroundTransparency = 0.45,
    BorderSizePixel = 0, ZIndex = 17
}, Bar)
Round(Shine, 10)
New("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,1),
        NumberSequenceKeypoint.new(0.5,0),
        NumberSequenceKeypoint.new(1,1)
    })
}, Shine)

local LoadingDots = {}
for i = 1, 3 do
    local dot = New("Frame", {
        Size = UDim2.fromOffset(5,5),
        Position = UDim2.fromOffset(84 + i*10,62),
        BackgroundColor3 = C.LightBlue, BorderSizePixel = 0, ZIndex = 15
    }, LoadingMain)
    Round(dot, 100)
    LoadingDots[i] = dot
end

task.spawn(function()
    while LoadingGui.Parent do
        for _, dot in ipairs(LoadingDots) do
            if not dot.Parent then return end
            Tween(dot, {Size = UDim2.fromOffset(7,7), BackgroundTransparency = 0}, 0.22)
            task.wait(0.12)
            Tween(dot, {Size = UDim2.fromOffset(4,4), BackgroundTransparency = 0.65}, 0.22)
        end
        task.wait(0.12)
    end
end)

task.spawn(function()
    while LoadingLogoFrame.Parent do
        Tween(LoadingLogoFrame, {Rotation = LoadingLogoFrame.Rotation + 360},
            5, Enum.EasingStyle.Linear)
        task.wait(5)
    end
end)

task.spawn(function()
    while LoadingGui.Parent do
        Tween(LoadingStroke, {Color = C.Purple, Transparency = 0.28}, 0.65)
        task.wait(0.65)
        if not LoadingGui.Parent then break end
        Tween(LoadingStroke, {Color = C.LightBlue, Transparency = 0.02}, 0.65)
        task.wait(0.65)
    end
end)

Tween(LoadingDim, {BackgroundTransparency = 0.08}, 0.45)
Tween(LoadingMain, {Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5)},
    0.82, Enum.EasingStyle.Back)

task.spawn(function()
    while LoadingGui.Parent and Shine.Parent do
        Shine.Position = UDim2.new(0,-60,0,0)
        local shineTween = Tween(Shine, {Position = UDim2.new(1,0,0,0)},
            0.9, Enum.EasingStyle.Linear)
        if shineTween then shineTween.Completed:Wait() else break end
        task.wait(0.08)
    end
end)

local LoadingMessages = {
    {Time=0, Text="Initializing Pyrovex Hub..."},
    {Time=1, Text="Preparing premium interface..."},
    {Time=2, Text="Loading script collection..."},
    {Time=3, Text="Preparing UI components..."},
    {Time=4, Text="Almost ready..."}
}
for _, message in ipairs(LoadingMessages) do
    task.delay(message.Time, function()
        if not LoadingGui.Parent then return end
        Tween(LoadingStatus, {TextTransparency = 1}, 0.12)
        task.wait(0.13)
        if not LoadingGui.Parent then return end
        LoadingStatus.Text = message.Text
        Tween(LoadingStatus, {TextTransparency = 0}, 0.18)
    end)
end

local LoadingStart = os.clock()
local LoadingDuration = Config.LoadingDuration
Tween(Bar, {Size = UDim2.new(1,0,1,0)}, LoadingDuration, Enum.EasingStyle.Linear)
while os.clock() - LoadingStart < LoadingDuration do
    if not LoadingGui.Parent then return end
    local progress = math.clamp((os.clock()-LoadingStart)/LoadingDuration, 0, 1)
    LoadingPercentage.Text = math.floor(progress*100).."%"
    task.wait(0.025)
end
LoadingPercentage.Text = "100%"
LoadingStatus.Text = "PYROVEX HUB IS READY!"
Tween(LoadingStroke, {Color = C.Green, Transparency = 0}, 0.25)
Tween(LoadingPercentage, {TextColor3 = C.Green}, 0.25)
task.wait(0.35)

Tween(LoadingMain, {
    Position = UDim2.new(0.5,0,0.5,35),
    BackgroundTransparency = 1
}, 0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
Tween(LoadingDim, {BackgroundTransparency = 1}, 0.5)
Tween(LoadingLogoFrame, {BackgroundTransparency = 1}, 0.25)
Tween(LoadingLogo, {ImageTransparency = 1}, 0.25)
Tween(LoadingStatus, {TextTransparency = 1}, 0.25)
Tween(LoadingPercentage, {TextTransparency = 1}, 0.25)
task.wait(0.62)
LoadingGui:Destroy()

--==============================================================
-- MAIN SCREEN GUI
--==============================================================
local Screen = New("ScreenGui", {
    Name = "PyroVexLoader", ResetOnSpawn = false,
    IgnoreGuiInset = true, DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local Outer = New("Frame", {
    Name = "OuterFrame",
    Size = UDim2.fromOffset(Config.MainWidth, Config.MainHeight),
    Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0,
    ClipsDescendants = false, Active = true, ZIndex = 1
}, Screen)
Round(Outer, 24)
AnimateGradient(PremiumGradient(Outer, 25), 4)
local OuterStroke = Outline(Outer, C.LightBlue, 2, 0.12)
AnimateGradient(PremiumGradient(OuterStroke, 0), 3)

local OuterGlow = New("Frame", {
    Name = "OuterGlow", Size = UDim2.new(1,14,1,14),
    Position = UDim2.fromOffset(-7,-7), BackgroundTransparency = 1,
    BorderSizePixel = 0, ZIndex = 0
}, Outer)
Round(OuterGlow, 29)
Pulse(Outline(OuterGlow, C.Purple, 3, 0.72), "Transparency", 0.42, 0.88, 1.1)

local Main = New("Frame", {
    Name = "Main", Size = UDim2.new(1,-4,1,-4),
    Position = UDim2.fromOffset(2,2), BackgroundColor3 = C.Background,
    BorderSizePixel = 0, ClipsDescendants = true, Active = true, ZIndex = 2
}, Outer)
Round(Main, 22)
Gradient(Main, C.Background, C.Background2, 45)

local MainScale = New("UIScale", {Scale = GetResponsiveScale()}, Outer)
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        if MainScale and MainScale.Parent then
            Tween(MainScale, {Scale = GetResponsiveScale()}, 0.25)
        end
    end)
end

-- SUBTLE BACKGROUND ORBS
local BackgroundDecoration = New("Frame", {
    Size = UDim2.fromOffset(230,230), Position = UDim2.new(1,-140,0,90),
    BackgroundColor3 = C.Purple, BackgroundTransparency = 0.95,
    BorderSizePixel = 0, ZIndex = 2
}, Main)
Round(BackgroundDecoration, 100)
AnimateGradient(Gradient(BackgroundDecoration, C.Blue, C.Red, 45), 5)

local BackgroundDecoration2 = New("Frame", {
    Size = UDim2.fromOffset(170,170), Position = UDim2.new(0,-110,1,-160),
    BackgroundColor3 = C.Blue, BackgroundTransparency = 0.96,
    BorderSizePixel = 0, ZIndex = 2
}, Main)
Round(BackgroundDecoration2, 100)
AnimateGradient(Gradient(BackgroundDecoration2, C.Purple, C.Blue, 90), 6)

local TopAccent = New("Frame", {
    Size = UDim2.new(1,-24,0,3), Position = UDim2.fromOffset(12,5),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0, ZIndex = 20
}, Main)
Round(TopAccent, 5)
AnimateGradient(PremiumGradient(TopAccent, 0), 2.5)

-- HEADER
local Header = New("Frame", {
    Name = "Header", Size = UDim2.new(1,-16,0,83),
    Position = UDim2.fromOffset(8,11), BackgroundColor3 = C.Header,
    BorderSizePixel = 0, Active = true, ClipsDescendants = true, ZIndex = 5
}, Main)
Round(Header, 17)
AnimateGradient(Gradient(Header, Color3.fromRGB(20,34,62),
    Color3.fromRGB(37,17,54), 0), 6)
Outline(Header, C.Border, 1, 0.18)
New("Frame", {
    Size = UDim2.new(1,-28,0,1), Position = UDim2.new(0,14,1,-1),
    BackgroundColor3 = C.Border, BorderSizePixel = 0, ZIndex = 6
}, Header)

local Logo = New("Frame", {
    Size = UDim2.fromOffset(49,49), Position = UDim2.fromOffset(13,16),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 7
}, Header)
Round(Logo, 14)
AnimateGradient(PremiumGradient(Logo, 45), 3)
local LogoStroke = Outline(Logo, C.LightPurple, 1.5, 0.12)
Pulse(LogoStroke, "Transparency", 0.08, 0.55, 1)

local LogoImage = New("ImageLabel", {
    Name = "LogoImage", Size = UDim2.new(1,-6,1,-6),
    Position = UDim2.fromOffset(3,3), BackgroundTransparency = 1,
    Image = LogoAsset, ScaleType = Enum.ScaleType.Fit, ZIndex = 8
}, Logo)
Round(LogoImage, 11)

New("TextLabel", {
    Name = "Title", Position = UDim2.fromOffset(74,12),
    Size = UDim2.fromOffset(180,26), BackgroundTransparency = 1,
    Text = "PYROVEX LOADER", TextColor3 = C.White, TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 7
}, Header)

New("TextLabel", {
    Position = UDim2.fromOffset(75,13), Size = UDim2.fromOffset(180,26),
    BackgroundTransparency = 1, Text = "PYROVEX LOADER",
    TextColor3 = C.Purple, TextTransparency = 0.78, TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 6
}, Header)

local DiscordContainer = New("Frame", {
    Name = "DiscordImageContainer", Size = UDim2.fromOffset(23,23),
    Position = UDim2.fromOffset(254,16), BackgroundColor3 = Color3.fromRGB(48,105,230),
    BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 9
}, Header)
Round(DiscordContainer, 8)
Outline(DiscordContainer, C.LightBlue, 1, 0.2)

local DiscordImage = New("ImageLabel", {
    Name = "DiscordImage", Size = UDim2.fromScale(1,1),
    BackgroundTransparency = 1, Image = DiscordAsset,
    ScaleType = Enum.ScaleType.Crop, ZIndex = 10
}, DiscordContainer)
Round(DiscordImage, 8)

local DiscordCopy = New("TextButton", {
    Name = "DiscordCopy", Size = UDim2.fromOffset(135,25),
    Position = UDim2.fromOffset(282,15), BackgroundTransparency = 1,
    Text = "COPY DISCORD LINK", TextColor3 = C.LightBlue,
    TextSize = 7, TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, AutoButtonColor = false,
    BorderSizePixel = 0, ZIndex = 10
}, Header)

DiscordCopy.MouseEnter:Connect(function()
    Tween(DiscordCopy, {TextColor3 = C.White}, 0.15)
end)
DiscordCopy.MouseLeave:Connect(function()
    Tween(DiscordCopy, {TextColor3 = C.LightBlue}, 0.15)
end)
DiscordCopy.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        if not setclipboard then error("Clipboard is unsupported") end
        setclipboard(DiscordLink)
    end)
    if success then
        DiscordCopy.Text = "LINK COPIED!"
        DiscordCopy.TextColor3 = C.Green
    else
        DiscordCopy.Text = "COPY FAILED!"
        DiscordCopy.TextColor3 = C.Red
        warn("[PYROVEX] DISCORD COPY ERROR: "..tostring(err))
    end
    task.delay(1.5, function()
        if DiscordCopy and DiscordCopy.Parent then
            DiscordCopy.Text = "COPY DISCORD LINK"
            DiscordCopy.TextColor3 = C.LightBlue
        end
    end)
end)

New("TextLabel", {
    Position = UDim2.fromOffset(75,39), Size = UDim2.fromOffset(250,15),
    BackgroundTransparency = 1, Text = "PYROVEX HUB COMMUNITY",
    TextColor3 = C.LightBlue, TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold, ZIndex = 7
}, Header)

local StatusDot = New("Frame", {
    Size = UDim2.fromOffset(7,7), Position = UDim2.fromOffset(75,63),
    BackgroundColor3 = C.Green, BorderSizePixel = 0, ZIndex = 7
}, Header)
Round(StatusDot, 100)
Pulse(StatusDot, "BackgroundTransparency", 0.7, 0, 0.65)

New("TextLabel", {
    Position = UDim2.fromOffset(87,60), Size = UDim2.fromOffset(150,13),
    BackgroundTransparency = 1, Text = "LOADER ACTIVE",
    TextColor3 = C.Gray, TextSize = 7,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 7
}, Header)

-- BUTTON ANIMATION ENGINE
local function ButtonAnimation(button, normalColor, hoverColor)
    local originalSize = button.Size
    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundColor3 = hoverColor}, Animation.Hover)
    end)
    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundColor3 = normalColor, Size = originalSize}, Animation.Hover)
    end)
    button.MouseButton1Down:Connect(function()
        Tween(button, {Size = UDim2.new(originalSize.X.Scale,
            originalSize.X.Offset-2, originalSize.Y.Scale,
            originalSize.Y.Offset-2)}, Animation.Button)
    end)
    button.MouseButton1Up:Connect(function()
        Tween(button, {Size = originalSize}, Animation.Button, Enum.EasingStyle.Back)
    end)
end

local Minimize = New("TextButton", {
    Name = "Minimize", Size = UDim2.fromOffset(30,30),
    Position = UDim2.new(1,-68,0,26), BackgroundColor3 = C.Card,
    Text = "—", TextColor3 = C.White, TextSize = 18,
    Font = Enum.Font.GothamBlack, AutoButtonColor = false,
    BorderSizePixel = 0, ZIndex = 10
}, Header)
Round(Minimize, 9)
Outline(Minimize, C.Border, 1)
ButtonAnimation(Minimize, C.Card, Color3.fromRGB(63,83,130))

local Close = New("TextButton", {
    Name = "Close", Size = UDim2.fromOffset(30,30),
    Position = UDim2.new(1,-34,0,26), BackgroundColor3 = Color3.fromRGB(65,28,43),
    Text = "×", TextColor3 = C.Red, TextSize = 20,
    Font = Enum.Font.GothamBlack, AutoButtonColor = false,
    BorderSizePixel = 0, ZIndex = 10
}, Header)
Round(Close, 9)
Outline(Close, C.Red, 1, 0.3)
ButtonAnimation(Close, Color3.fromRGB(65,28,43), C.Red)

-- SECTION LABEL
local SectionAccent = New("Frame", {
    Size = UDim2.fromOffset(3,11), Position = UDim2.fromOffset(12,108),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0, ZIndex = 6
}, Main)
Round(SectionAccent, 4)
PremiumGradient(SectionAccent, 90)

New("TextLabel", {
    Size = UDim2.new(1,-30,0,16), Position = UDim2.fromOffset(19,105),
    BackgroundTransparency = 1, Text = "SCRIPT COLLECTION",
    TextColor3 = C.Gray, TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 5
}, Main)

New("TextLabel", {
    Size = UDim2.new(1,-30,0,12), Position = UDim2.fromOffset(19,120),
    BackgroundTransparency = 1,
    Text = "SELECT A CATEGORY TO EXPLORE AVAILABLE SCRIPTS",
    TextColor3 = C.DarkGray, TextSize = 6,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium, ZIndex = 5
}, Main)

-- TABS
local Tabs = New("ScrollingFrame", {
    Name = "Tabs", Size = UDim2.new(1,-28,0,36),
    Position = UDim2.fromOffset(14,139), BackgroundTransparency = 1,
    BorderSizePixel = 0, ScrollBarThickness = 0,
    CanvasSize = UDim2.fromOffset(0,0), AutomaticCanvasSize = Enum.AutomaticSize.X,
    ScrollingDirection = Enum.ScrollingDirection.X, ZIndex = 5
}, Main)
New("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0,8), SortOrder = Enum.SortOrder.LayoutOrder
}, Tabs)

-- CONTENT PANEL
local Content = New("ScrollingFrame", {
    Name = "Content", Size = UDim2.new(1,-28,1,-202),
    Position = UDim2.fromOffset(14,183), BackgroundColor3 = C.Panel,
    BorderSizePixel = 0, ClipsDescendants = true, ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Blue, ScrollBarImageTransparency = 0.1,
    CanvasSize = UDim2.fromOffset(0,0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 5
}, Main)
Round(Content, 15)
Outline(Content, C.Border, 1, 0.2)
Gradient(Content, C.Panel, Color3.fromRGB(15,21,39), 90)
New("UIPadding", {
    PaddingTop = UDim.new(0,12), PaddingBottom = UDim.new(0,12),
    PaddingLeft = UDim.new(0,11), PaddingRight = UDim.new(0,11)
}, Content)
New("UIListLayout", {
    Padding = UDim.new(0,11), SortOrder = Enum.SortOrder.LayoutOrder
}, Content)

-- CARD CREATOR
local function CreateScriptCard(scriptInfo, index)
    local Card = New("Frame", {
        Name = scriptInfo.Name, Size = UDim2.new(1,0,0,Config.CardHeight),
        BackgroundColor3 = C.Card, BorderSizePixel = 0,
        LayoutOrder = index, BackgroundTransparency = 1,
        ClipsDescendants = true, ZIndex = 6
    }, Content)
    Round(Card, 15)
    local CardStroke = Outline(Card, C.Border, 1, 0.08)
    Gradient(Card, C.Card, Color3.fromRGB(27,32,57), 0)

    local CardScale = New("UIScale", {Scale = 0.92}, Card)

    local CardAccent = New("Frame", {
        Size = UDim2.new(0,3,1,-24), Position = UDim2.fromOffset(5,12),
        BackgroundColor3 = C.Blue, BorderSizePixel = 0, ZIndex = 7
    }, Card)
    Round(CardAccent, 5)
    AnimateGradient(PremiumGradient(CardAccent, 90), 3.5)

    -- Use the user's supplied Roblox thumbnails as the script logos.
    -- CHILI HUB has its own logo; all other scripts use the shared logo.
    local ScriptLogo = scriptInfo.Name == "CHILI HUB"
        and "rbxthumb://type=Asset&id=103785364011347&w=420&h=420"
        or "rbxthumb://type=Asset&id=111679469652157&w=420&h=420"
    local Icon = New("ImageLabel", {
        Name = "ScriptLogo",
        Size = UDim2.fromOffset(47,47), Position = UDim2.fromOffset(13,20),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = ScriptLogo, ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0, ZIndex = 8
    }, Card)
    Round(Icon, 12) -- Rounded-square script logo, no extra box/background.

    New("TextLabel", {
        Position = UDim2.fromOffset(71,11), Size = UDim2.new(1,-235,0,19),
        BackgroundTransparency = 1, Text = scriptInfo.Name,
        TextColor3 = C.White, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBlack, ZIndex = 7
    }, Card)

    New("TextLabel", {
        Position = UDim2.fromOffset(71,32), Size = UDim2.new(1,-235,0,17),
        BackgroundTransparency = 1, Text = scriptInfo.Subtitle,
        TextColor3 = C.Gray, TextSize = 7,
        TextWrapped = false, TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium, ZIndex = 7
    }, Card)

    local HasHubBadges =
        scriptInfo.Name == "ADMIN BADGE"
        or scriptInfo.Name == "ANTI AFK"
        or scriptInfo.Name == "PYROVEX DEBUGGER"
        or scriptInfo.Name == "PYROVEX HUB SHADER"
        or scriptInfo.Name == "TOKEN SPAWNER"

    local BadgeX = 71
    local function CreateBadge(text, color, width)
        local badge = New("TextLabel", {
            Size = UDim2.fromOffset(width,14),
            Position = UDim2.fromOffset(BadgeX,59),
            BackgroundColor3 = color, BackgroundTransparency = 0.12,
            Text = text, TextColor3 = C.White, TextSize = 6,
            Font = Enum.Font.GothamBlack, BorderSizePixel = 0, ZIndex = 8
        }, Card)
        Round(badge, 5)
        BadgeX = BadgeX + width + 5
        return badge
    end

    if scriptInfo.Name == "CHILI HUB" then
        CreateBadge("FEATURED", C.Purple, 50)
    elseif HasHubBadges then
        CreateBadge("FEATURED", C.Purple, 50)
        CreateBadge("BY PYROVEX HUB", Color3.fromRGB(54,65,110), 78)
    end
    if scriptInfo.Name == "TOKEN SPAWNER" then
        CreateBadge("KEY REQUIRED", C.Red, 67)
    end

    local Execute = New("TextButton", {
        Name = "ExecuteButton", Size = UDim2.fromOffset(72,30),
        Position = UDim2.new(1,-158,0,29), BackgroundColor3 = C.Blue,
        Text = "EXECUTE", TextColor3 = C.White, TextSize = 8,
        Font = Enum.Font.GothamBlack, AutoButtonColor = false,
        BorderSizePixel = 0, ZIndex = 9
    }, Card)
    Round(Execute, 9)
    Outline(Execute, C.LightBlue, 1, 0.15)
    AnimateGradient(Gradient(Execute, C.Blue, C.Purple, 0), 4)
    ButtonAnimation(Execute, C.Blue, Color3.fromRGB(95,120,255))

    local Copy = New("TextButton", {
        Name = "CopyButton", Size = UDim2.fromOffset(68,30),
        Position = UDim2.new(1,-80,0,29), BackgroundColor3 = C.CopyBackground,
        Text = "COPY", TextColor3 = C.White, TextSize = 8,
        Font = Enum.Font.GothamBlack, AutoButtonColor = false,
        BorderSizePixel = 0, ZIndex = 9
    }, Card)
    Round(Copy, 9)
    Outline(Copy, C.LightPurple, 1, 0.25)
    ButtonAnimation(Copy, C.CopyBackground, Color3.fromRGB(78,85,145))

    -- ORIGINAL EXECUTE BEHAVIOR
    local Executing = false
    Execute.MouseButton1Click:Connect(function()
        if Executing then return end
        Executing = true
        Execute.Text = "LOADING..."
        Tween(Execute, {BackgroundColor3 = C.Purple}, 0.2)
        task.spawn(function()
            local success, err = pcall(function()
                local source = game:HttpGet(scriptInfo.URL)
                local func = loadstring(source)
                if not func then error("Unable to compile script") end
                func()
            end)
            if success then
                Execute.Text = "EXECUTED"
                Execute.TextColor3 = C.Green
            else
                Execute.Text = "FAILED"
                Execute.TextColor3 = C.Red
                warn("[PYROVEX LOADER] "..scriptInfo.Name..": "..tostring(err))
            end
            task.wait(1.5)
            if Execute and Execute.Parent then
                Execute.Text = "EXECUTE"
                Execute.TextColor3 = C.White
                Tween(Execute, {BackgroundColor3 = C.Blue}, 0.2)
            end
            Executing = false
        end)
    end)

    -- ORIGINAL COPY BEHAVIOR
    Copy.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            if not setclipboard then error("Clipboard is unsupported") end
            setclipboard(GetLoadstring(scriptInfo.URL))
        end)
        if success then
            Copy.Text = "COPIED"
            Copy.TextColor3 = C.Green
        else
            Copy.Text = "FAILED"
            Copy.TextColor3 = C.Red
            warn("[PYROVEX LOADER] COPY ERROR: "..tostring(err))
        end
        task.delay(1.5, function()
            if Copy and Copy.Parent then
                Copy.Text = "COPY"
                Copy.TextColor3 = C.White
            end
        end)
    end)

    Card.MouseEnter:Connect(function()
        Tween(Card, {BackgroundColor3 = C.CardHover}, Animation.Hover)
        Tween(CardStroke, {Color = C.LightBlue, Transparency = 0.02}, Animation.Hover)
        Tween(CardScale, {Scale = 1}, Animation.Hover, Enum.EasingStyle.Back)
        Tween(CardAccent, {
            Size = UDim2.new(0,4,1,-12), Position = UDim2.fromOffset(5,6)
        }, Animation.Hover)
    end)
    Card.MouseLeave:Connect(function()
        Tween(Card, {BackgroundColor3 = C.Card}, Animation.Hover)
        Tween(CardStroke, {Color = C.Border, Transparency = 0.08}, Animation.Hover)
        Tween(CardScale, {Scale = 0.98}, Animation.Hover)
        Tween(CardAccent, {
            Size = UDim2.new(0,3,1,-24), Position = UDim2.fromOffset(5,12)
        }, Animation.Hover)
    end)

    Tween(Card, {BackgroundTransparency = 0}, Animation.Card)
    Tween(CardScale, {Scale = 1}, Animation.Card, Enum.EasingStyle.Back)
    return Card
end

-- TAB SYSTEM
local SelectedTab = nil
local TabButtons, TabIndicators, TabStrokes = {}, {}, {}

local function GetSelectedScripts(name)
    if name == "ALL SCRIPTS" then return AllScripts
    elseif name == "STEAL AN EGG" then return Scripts
    elseif name == "GROW A GARDEN" then return GrowScripts
    elseif name == "UNIVERSAL SCRIPTS" then return UniversalScripts end
    return {}
end

local function SelectTab(name)
    if SelectedTab == name then return end
    SelectedTab = name

    for tabName, tab in pairs(TabButtons) do
        local active = tabName == name
        Tween(tab, {
            BackgroundColor3 = active and C.Blue or C.Card,
            TextColor3 = active and C.White or C.Gray
        }, Animation.Tab)
        local stroke = TabStrokes[tabName]
        if stroke then
            Tween(stroke, {
                Color = active and C.LightBlue or C.Border,
                Transparency = active and 0.08 or 0
            }, Animation.Tab)
        end
        local indicator = TabIndicators[tabName]
        if indicator then
            Tween(indicator, {
                Size = UDim2.new(active and 0.65 or 0,0,0,2),
                BackgroundTransparency = active and 0 or 1
            }, Animation.Tab)
        end
    end

    for _, child in ipairs(Content:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    Content.CanvasPosition = Vector2.new(0,0)

    -- Short fade-out / fade-in gives tab changes a softer transition.
    local selectedScripts = GetSelectedScripts(name)
    for index, scriptInfo in ipairs(selectedScripts) do
        CreateScriptCard(scriptInfo, index)
        task.wait(0.035)
    end
end

for index, section in ipairs(Sections) do
    local Tab = New("TextButton", {
        Name = section.Name, Size = UDim2.fromOffset(section.Width,34),
        BackgroundColor3 = C.Card, Text = section.Name,
        TextColor3 = C.Gray, TextSize = 8,
        Font = Enum.Font.GothamBlack, AutoButtonColor = false,
        BorderSizePixel = 0, LayoutOrder = index,
        ClipsDescendants = true, ZIndex = 7
    }, Tabs)
    Round(Tab, 10)
    local TabStroke = Outline(Tab, C.Border, 1)
    local Indicator = New("Frame", {
        Name = "Indicator", Size = UDim2.new(0,0,0,2),
        Position = UDim2.new(0.175,0,1,-4),
        BackgroundColor3 = C.White, BackgroundTransparency = 1,
        BorderSizePixel = 0, ZIndex = 9
    }, Tab)
    Round(Indicator, 5)

    TabButtons[section.Name] = Tab
    TabIndicators[section.Name] = Indicator
    TabStrokes[section.Name] = TabStroke

    Tab.MouseButton1Click:Connect(function() SelectTab(section.Name) end)
    Tab.MouseEnter:Connect(function()
        if SelectedTab ~= section.Name then
            Tween(Tab, {BackgroundColor3 = Color3.fromRGB(38,51,79)}, Animation.Hover)
        end
    end)
    Tab.MouseLeave:Connect(function()
        if SelectedTab ~= section.Name then
            Tween(Tab, {BackgroundColor3 = C.Card}, Animation.Hover)
        end
    end)
end

-- FLOATING MINIMIZE BUTTON
local FloatingButton = New("ImageButton", {
    Name = "FloatingButton",
    Size = UDim2.fromOffset(Config.FloatingSize, Config.FloatingSize),
    Position = UDim2.new(0,20,0.5,-27),
    BackgroundColor3 = C.Background, BackgroundTransparency = 0,
    Image = LogoAsset, ScaleType = Enum.ScaleType.Crop,
    AutoButtonColor = false, BorderSizePixel = 0,
    Visible = false, Active = true, ZIndex = 100
}, Screen)
Round(FloatingButton, 100)
local FloatingStroke = Outline(FloatingButton, C.LightBlue, 2, 0.05)
AnimateGradient(PremiumGradient(FloatingStroke, 0), 2)
local FloatingScale = New("UIScale", {Scale = 0.7}, FloatingButton)

local FloatingGlow = New("Frame", {
    Size = UDim2.new(1,10,1,10), Position = UDim2.fromOffset(-5,-5),
    BackgroundTransparency = 1, ZIndex = 99
}, FloatingButton)
Round(FloatingGlow, 100)
Pulse(Outline(FloatingGlow, C.Purple, 2, 0.65), "Transparency", 0.35, 0.8, 1)

FloatingButton.MouseEnter:Connect(function()
    Tween(FloatingScale, {Scale = 1.12}, 0.18, Enum.EasingStyle.Back)
end)
FloatingButton.MouseLeave:Connect(function()
    Tween(FloatingScale, {Scale = 1}, 0.18)
end)

-- MAIN OPENING ANIMATION
Main.BackgroundTransparency = 1
Outer.BackgroundTransparency = 1
MainScale.Scale = 0.72
Tween(Outer, {BackgroundTransparency = 0}, Animation.Open)
Tween(Main, {BackgroundTransparency = 0}, Animation.Open)
Tween(MainScale, {Scale = GetResponsiveScale()}, Animation.Open, Enum.EasingStyle.Back)

-- ANIMATION STATES
local IsAnimating = false
local Closing = false

-- MINIMIZE
Minimize.MouseButton1Click:Connect(function()
    if IsAnimating or Closing then return end
    IsAnimating = true

    Tween(MainScale, {Scale = MainScale.Scale*0.72}, Animation.Minimize,
        Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local fade = Tween(Main, {BackgroundTransparency = 1}, Animation.Minimize)
    Tween(Outer, {BackgroundTransparency = 1}, Animation.Minimize)
    if fade then fade.Completed:Wait() end
    if not Screen.Parent then return end

    Main.Visible = false
    Outer.Visible = false
    FloatingButton.Visible = true
    FloatingScale.Scale = 0.55
    Tween(FloatingScale, {Scale = 1}, Animation.Restore, Enum.EasingStyle.Back)
    IsAnimating = false
end)

-- RESTORE
FloatingButton.MouseButton1Click:Connect(function()
    if IsAnimating or Closing then return end
    IsAnimating = true

    Tween(FloatingScale, {Scale = 0.55}, 0.12)
    task.wait(0.12)
    if not Screen.Parent then return end

    FloatingButton.Visible = false
    Outer.Visible = true
    Main.Visible = true
    Main.BackgroundTransparency = 1
    Outer.BackgroundTransparency = 1
    MainScale.Scale = 0.72

    Tween(Outer, {BackgroundTransparency = 0}, Animation.Restore)
    Tween(Main, {BackgroundTransparency = 0}, Animation.Restore)
    local restore = Tween(MainScale, {Scale = GetResponsiveScale()},
        Animation.Restore, Enum.EasingStyle.Back)
    if restore then restore.Completed:Wait() end
    IsAnimating = false
end)

-- CLOSE
Close.MouseButton1Click:Connect(function()
    if Closing or IsAnimating then return end
    Closing = true
    IsAnimating = true
    Tween(MainScale, {Scale = 0.78}, Animation.Close,
        Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local fade = Tween(Main, {BackgroundTransparency = 1}, Animation.Close)
    Tween(Outer, {BackgroundTransparency = 1}, Animation.Close)
    if fade then fade.Completed:Wait() end
    if Screen and Screen.Parent then Screen:Destroy() end
end)

-- MAIN WINDOW DRAGGING
local Dragging, DragStart, StartPosition, DragInput = false, nil, nil, nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPosition = Outer.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then Dragging = false end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        DragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input == DragInput
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        Outer.Position = UDim2.new(
            StartPosition.X.Scale, StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y
        )
    end
end)

-- FLOATING BUTTON DRAGGING
local FloatingDragging, FloatingDragStart, FloatingStartPosition, FloatingDragInput =
    false, nil, nil, nil

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        FloatingDragging = true
        FloatingDragStart = input.Position
        FloatingStartPosition = FloatingButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                FloatingDragging = false
            end
        end)
    end
end)

FloatingButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        FloatingDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if FloatingDragging and (input == FloatingDragInput
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - FloatingDragStart
        FloatingButton.Position = UDim2.new(
            FloatingStartPosition.X.Scale, FloatingStartPosition.X.Offset + delta.X,
            FloatingStartPosition.Y.Scale, FloatingStartPosition.Y.Offset + delta.Y
        )
    end
end)

-- INITIALIZE DEFAULT TAB
SelectTab("ALL SCRIPTS")

-- INITIALIZATION COMPLETE
print("==================================================")
print("PYROVEX LOADER V17")
print("EXTREME PREMIUM UI EDITION")
print("BLUE x PURPLE x RED x BLACK")
print("ADVANCED LOADING AND UI ANIMATIONS ENABLED")
print("ALL SCRIPTS COLLECTION INITIALIZED")
print("6 SCRIPTS AVAILABLE")
print("PYROVEX HUB SUCCESSFULLY LOADED")
print("==================================================")
