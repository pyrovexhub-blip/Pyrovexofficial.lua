
--==============================================================
-- PYROVEX LOADER V12
-- EXTREME PREMIUM EDITION
--==============================================================
-- DESIGN:
-- BLUE x PURPLE x RED x BLACK
-- ADVANCED GLASSMORPHISM
-- NEON BORDER ANIMATIONS
-- PREMIUM SCRIPT CARDS
-- SMOOTH TAB TRANSITIONS
-- ADVANCED LOADING SCREEN
--==============================================================
-- FEATURES:
-- 5 SECOND LOADING SCREEN
-- ANIMATED PROGRESS BAR
-- ROTATING LOGO
-- GRADIENT EFFECTS
-- SCRIPT COLLECTIONS
-- ALL SCRIPTS TAB
-- EXECUTE / COPY BUTTONS
-- DISCORD COPY
-- MINIMIZE / RESTORE
-- FLOATING LOGO
-- DRAGGABLE INTERFACE
-- RESPONSIVE SCALING
--==============================================================

--==============================================================
-- SERVICES
--==============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Camera = workspace.CurrentCamera

--==============================================================
-- ASSETS
--==============================================================

local LogoAsset =
    "rbxthumb://type=Asset&id=97950138094007&w=420&h=420"

local DiscordAsset =
    "rbxthumb://type=Asset&id=127546963058457&w=420&h=420"

local DiscordLink =
    "https://discord.gg/K3ahPnJV8y"

--==============================================================
-- CLEANUP
--==============================================================

for _,name in ipairs({
    "PyrovexTopLoader",
    "PyroVexLoader"
}) do

    local old = PlayerGui:FindFirstChild(name)

    if old then
        old:Destroy()
    end

end

--==============================================================
-- CONFIGURATION
--==============================================================

local Config = {

    LoadingDuration = 5,

    MainWidth = 510,
    MainHeight = 370,

    MinimumScale = 0.65,
    MaximumScale = 1,

    FloatingSize = 52,

    CardHeight = 88,

    Animation = {

        Open = 0.65,
        Close = 0.35,

        Minimize = 0.32,
        Restore = 0.48,

        Hover = 0.22,
        Button = 0.12,

        Tab = 0.30,
        Card = 0.42,

        Fade = 0.25

    }

}

local Animation = Config.Animation

--==============================================================
-- THEME
--==============================================================

local C = {

    Background = Color3.fromRGB(6,8,16),
    Background2 = Color3.fromRGB(10,14,26),

    Header = Color3.fromRGB(13,18,34),
    Header2 = Color3.fromRGB(20,20,43),

    Panel = Color3.fromRGB(11,16,29),

    Card = Color3.fromRGB(19,26,43),
    CardHover = Color3.fromRGB(30,42,68),

    Blue = Color3.fromRGB(35,125,255),
    LightBlue = Color3.fromRGB(105,190,255),
    DarkBlue = Color3.fromRGB(18,55,120),

    Purple = Color3.fromRGB(137,65,255),
    LightPurple = Color3.fromRGB(190,140,255),

    Red = Color3.fromRGB(238,55,90),
    LightRed = Color3.fromRGB(255,105,125),

    Green = Color3.fromRGB(45,220,145),

    White = Color3.fromRGB(248,250,255),
    Gray = Color3.fromRGB(143,157,184),

    DarkGray = Color3.fromRGB(70,82,108),

    Border = Color3.fromRGB(48,62,94),

    CopyBackground = Color3.fromRGB(36,45,73)

}

--==============================================================
-- HELPER FUNCTIONS
--==============================================================

local function New(class,props,parent)

    local object = Instance.new(class)

    for property,value in pairs(props or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object

end

--==============================================================
-- ROUNDING
--==============================================================

local function Round(object,radius)

    return New("UICorner",{
        CornerRadius = UDim.new(0,radius)
    },object)

end

--==============================================================
-- OUTLINE
--==============================================================

local function Outline(object,color,thickness,transparency)

    return New("UIStroke",{

        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    },object)

end

--==============================================================
-- GRADIENT
--==============================================================

local function Gradient(object,color1,color2,rotation)

    return New("UIGradient",{

        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,color1),
            ColorSequenceKeypoint.new(1,color2)
        }),

        Rotation = rotation or 0

    },object)

end

--==============================================================
-- MULTICOLOR GRADIENT
--==============================================================

local function PremiumGradient(object,rotation)

    return New("UIGradient",{

        Color = ColorSequence.new({

            ColorSequenceKeypoint.new(0,C.Blue),
            ColorSequenceKeypoint.new(0.35,C.Purple),
            ColorSequenceKeypoint.new(0.70,C.Red),
            ColorSequenceKeypoint.new(1,C.Blue)

        }),

        Rotation = rotation or 0

    },object)

end

--==============================================================
-- TWEEN ENGINE
--==============================================================

local function Tween(object,properties,duration,style,direction)

    if not object or not object.Parent then
        return nil
    end

    local success,tween = pcall(function()

        return TweenService:Create(

            object,

            TweenInfo.new(

                duration or 0.25,

                style or Enum.EasingStyle.Quart,

                direction or Enum.EasingDirection.Out

            ),

            properties

        )

    end)

    if not success then
        return nil
    end

    tween:Play()

    return tween

end

--==============================================================
-- GRADIENT ANIMATION
--==============================================================

local function AnimateGradient(gradient,speed)

    task.spawn(function()

        while gradient and gradient.Parent do

            Tween(gradient,{

                Rotation = gradient.Rotation + 180

            },speed or 3,Enum.EasingStyle.Linear)

            task.wait(speed or 3)

        end

    end)

end

--==============================================================
-- PULSE ANIMATION
--==============================================================

local function Pulse(object,property,value1,value2,speed)

    task.spawn(function()

        while object and object.Parent do

            Tween(object,{
                [property] = value1
            },speed or 1)

            task.wait(speed or 1)

            if not object or not object.Parent then
                break
            end

            Tween(object,{
                [property] = value2
            },speed or 1)

            task.wait(speed or 1)

        end

    end)

end

--==============================================================
-- LOADSTRING TEXT
--==============================================================

local function GetLoadstring(url)

    return 'loadstring(game:HttpGet("'..url..'"))()'

end

--==============================================================
-- RESPONSIVE SCALE
--==============================================================

local function GetResponsiveScale()

    if not Camera then
        Camera = workspace.CurrentCamera
    end

    if not Camera then
        return 1
    end

    local viewport = Camera.ViewportSize

    return math.clamp(

        math.min(
            viewport.X / 560,
            viewport.Y / 430,
            1
        ),

        Config.MinimumScale,
        Config.MaximumScale

    )

end

--==============================================================
-- SCRIPT COLLECTIONS
--==============================================================

local Scripts = {

    {
        Name = "CHILI HUB",
        Subtitle = "ALL IN ONE SCRIPT",
        URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"
    },

    {
        Name = "ADMIN BADGE",
        Subtitle = "ADMIN BADGE AND SPEED CHANGER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua.sae/main/steal.an.egg.lua"
    }

}

local GrowScripts = {

    {
        Name = "TOKEN SPAWNER",
        Subtitle = "TOKEN SPOOFER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua/main/Token.spawner.lua"
    },

    {
        Name = "ANTI AFK",
        Subtitle = "AFK 24/7",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex-Anti-afk/main/Pyrovex.lua"
    }

}

local UniversalScripts = {

    {
        Name = "PYROVEX DEBUGGER",
        Subtitle = "DETECTS AN ERROR TO YOUR SCRIPT",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.debug/main/Pyro.lua"
    },

    {
        Name = "PYROVEX HUB SHADER",
        Subtitle = "IMPROVE YOUR GAME VISUAL GRAPHICS",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Shader.lua/main/Pyrovex.lua"
    }

}

--==============================================================
-- ALL SCRIPTS COLLECTION
-- DUPLICATES ALL ENTRIES FROM OTHER SECTIONS
-- ORIGINAL COLLECTIONS REMAIN UNCHANGED
--==============================================================

local AllScripts = {}

for _,scriptInfo in ipairs(Scripts) do
    table.insert(AllScripts,scriptInfo)
end

for _,scriptInfo in ipairs(GrowScripts) do
    table.insert(AllScripts,scriptInfo)
end

for _,scriptInfo in ipairs(UniversalScripts) do
    table.insert(AllScripts,scriptInfo)
end

--==============================================================
-- SECTIONS
--==============================================================

local Sections = {

    {
        Name = "ALL SCRIPTS",
        Width = 110
    },

    {
        Name = "STEAL AN EGG",
        Width = 125
    },

    {
        Name = "GROW A GARDEN",
        Width = 125
    },

    {
        Name = "UNIVERSAL SCRIPTS",
        Width = 155
    }

}

--==============================================================
-- ADVANCED LOADING SCREEN
--==============================================================

local LoadingGui = New("ScreenGui",{

    Name = "PyrovexTopLoader",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling

},PlayerGui)

--==============================================================
-- LOADING BACKGROUND
--==============================================================

local LoadingMain = New("Frame",{

    Name = "LoadingContainer",
    Size = UDim2.fromOffset(370,100),
    Position = UDim2.new(0.5,0,0,-130),
    AnchorPoint = Vector2.new(0.5,0),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 10

},LoadingGui)

Round(LoadingMain,18)

local LoadingGradient = Gradient(
    LoadingMain,
    Color3.fromRGB(13,25,49),
    Color3.fromRGB(36,15,49),
    25
)

AnimateGradient(LoadingGradient,4)

local LoadingStroke = Outline(
    LoadingMain,
    C.Blue,
    1.6,
    0.1
)

local LoadingBorderGradient = PremiumGradient(LoadingStroke,0)

AnimateGradient(LoadingBorderGradient,3)

--==============================================================
-- LOADING TOP ACCENT
--==============================================================

local LoadingAccent = New("Frame",{

    Size = UDim2.new(1,-20,0,3),
    Position = UDim2.fromOffset(10,0),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ZIndex = 15

},LoadingMain)

Round(LoadingAccent,5)

local LoadingAccentGradient = PremiumGradient(LoadingAccent,0)

AnimateGradient(LoadingAccentGradient,2)

--==============================================================
-- LOADING LOGO CONTAINER
--==============================================================

local LoadingLogoFrame = New("Frame",{

    Size = UDim2.fromOffset(49,49),
    Position = UDim2.fromOffset(13,16),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 15

},LoadingMain)

Round(LoadingLogoFrame,14)

local LoadingLogoGradient = PremiumGradient(LoadingLogoFrame,45)

AnimateGradient(LoadingLogoGradient,3)

Outline(LoadingLogoFrame,C.LightBlue,1.5,0.15)

local LoadingLogo = New("ImageLabel",{

    Size = UDim2.new(1,-6,1,-6),
    Position = UDim2.fromOffset(3,3),
    BackgroundTransparency = 1,
    Image = LogoAsset,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 16

},LoadingLogoFrame)

Round(LoadingLogo,11)

--==============================================================
-- LOADING TITLE
--==============================================================

local LoadingTitle = New("TextLabel",{

    Position = UDim2.fromOffset(73,14),
    Size = UDim2.new(1,-140,0,22),
    BackgroundTransparency = 1,
    Text = "PYROVEX HUB",
    TextColor3 = C.White,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 15

},LoadingMain)

--==============================================================
-- LOADING SUBTITLE
--==============================================================

local LoadingSubtitle = New("TextLabel",{

    Position = UDim2.fromOffset(74,37),
    Size = UDim2.new(1,-140,0,17),
    BackgroundTransparency = 1,
    Text = "EXTREME PREMIUM INITIALIZATION",
    TextColor3 = C.LightBlue,
    TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    ZIndex = 15

},LoadingMain)

--==============================================================
-- LOADING STATUS
--==============================================================

local LoadingStatus = New("TextLabel",{

    Position = UDim2.fromOffset(15,72),
    Size = UDim2.new(1,-85,0,15),
    BackgroundTransparency = 1,
    Text = "Initializing Pyrovex Hub...",
    TextColor3 = C.Gray,
    TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    ZIndex = 15

},LoadingMain)

--==============================================================
-- LOADING PERCENTAGE
--==============================================================

local LoadingPercentage = New("TextLabel",{

    Position = UDim2.new(1,-62,0,70),
    Size = UDim2.fromOffset(47,18),
    BackgroundTransparency = 1,
    Text = "0%",
    TextColor3 = C.LightBlue,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.GothamBlack,
    ZIndex = 15

},LoadingMain)

--==============================================================
-- LOADING BAR BACKGROUND
--==============================================================

local BarBG = New("Frame",{

    Size = UDim2.new(1,-28,0,7),
    Position = UDim2.fromOffset(14,93),
    BackgroundColor3 = Color3.fromRGB(35,43,64),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 15

},LoadingMain)

Round(BarBG,10)

--==============================================================
-- LOADING BAR
--==============================================================

local Bar = New("Frame",{

    Size = UDim2.new(0,0,1,0),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ZIndex = 16

},BarBG)

Round(Bar,10)

local BarGradient = PremiumGradient(Bar,0)

AnimateGradient(BarGradient,2)

--==============================================================
-- LOADING BAR SHINE
--==============================================================

local Shine = New("Frame",{

    Size = UDim2.new(0,50,1,0),
    Position = UDim2.new(0,-50,0,0),
    BackgroundColor3 = C.White,
    BackgroundTransparency = 0.45,
    BorderSizePixel = 0,
    ZIndex = 17

},Bar)

Round(Shine,10)

New("UIGradient",{

    Transparency = NumberSequence.new({

        NumberSequenceKeypoint.new(0,1),
        NumberSequenceKeypoint.new(0.5,0),
        NumberSequenceKeypoint.new(1,1)

    })

},Shine)

--==============================================================
-- LOADING DOTS
--==============================================================

local LoadingDots = {}

for index = 1,3 do

    local Dot = New("Frame",{

        Size = UDim2.fromOffset(5,5),
        Position = UDim2.fromOffset(76 + (index * 10),57),
        BackgroundColor3 = C.LightBlue,
        BorderSizePixel = 0,
        ZIndex = 15

    },LoadingMain)

    Round(Dot,100)

    LoadingDots[index] = Dot

end

task.spawn(function()

    while LoadingGui.Parent do

        for index,Dot in ipairs(LoadingDots) do

            if not Dot.Parent then
                return
            end

            Tween(Dot,{
                BackgroundTransparency = 0.75,
                Size = UDim2.fromOffset(4,4)
            },0.25)

            task.wait(0.12)

            Tween(Dot,{
                BackgroundTransparency = 0,
                Size = UDim2.fromOffset(6,6)
            },0.25)

        end

        task.wait(0.15)

    end

end)

--==============================================================
-- LOADING LOGO ANIMATION
--==============================================================

task.spawn(function()

    while LoadingLogoFrame.Parent do

        Tween(LoadingLogoFrame,{

            Rotation = LoadingLogoFrame.Rotation + 360

        },5,Enum.EasingStyle.Linear)

        task.wait(5)

    end

end)

--==============================================================
-- LOADING BORDER PULSE
--==============================================================

task.spawn(function()

    while LoadingGui.Parent do

        Tween(LoadingStroke,{
            Color = C.Purple,
            Transparency = 0.35
        },0.7)

        task.wait(0.7)

        if not LoadingGui.Parent then
            break
        end

        Tween(LoadingStroke,{
            Color = C.LightBlue,
            Transparency = 0.05
        },0.7)

        task.wait(0.7)

    end

end)

--==============================================================
-- LOADING ENTRANCE
--==============================================================

Tween(LoadingMain,{

    Position = UDim2.new(0.5,0,0,15)

},0.85,Enum.EasingStyle.Back)

--==============================================================
-- LOADING SHINE LOOP
--==============================================================

task.spawn(function()

    while LoadingGui.Parent and Shine.Parent do

        Shine.Position = UDim2.new(0,-50,0,0)

        local shineTween = Tween(Shine,{

            Position = UDim2.new(1,0,0,0)

        },0.9,Enum.EasingStyle.Linear)

        if shineTween then
            shineTween.Completed:Wait()
        else
            break
        end

        task.wait(0.1)

    end

end)

--==============================================================
-- LOADING MESSAGES
--==============================================================

local LoadingMessages = {

    {
        Time = 0,
        Text = "Initializing Pyrovex Hub..."
    },

    {
        Time = 1,
        Text = "Preparing premium interface..."
    },

    {
        Time = 2,
        Text = "Loading script collection..."
    },

    {
        Time = 3,
        Text = "Preparing UI components..."
    },

    {
        Time = 4,
        Text = "Almost ready..."
    }

}

for _,message in ipairs(LoadingMessages) do

    task.delay(message.Time,function()

        if not LoadingGui.Parent then
            return
        end

        Tween(LoadingStatus,{
            TextTransparency = 1
        },0.15)

        task.wait(0.15)

        if not LoadingGui.Parent then
            return
        end

        LoadingStatus.Text = message.Text

        Tween(LoadingStatus,{
            TextTransparency = 0
        },0.2)

    end)

end

--==============================================================
-- LOADING PROGRESS
--==============================================================

local LoadingStart = os.clock()

local LoadingDuration = Config.LoadingDuration

local ProgressTween = Tween(Bar,{

    Size = UDim2.new(1,0,1,0)

},LoadingDuration,Enum.EasingStyle.Linear)

while os.clock() - LoadingStart < LoadingDuration do

    if not LoadingGui.Parent then
        return
    end

    local elapsed = os.clock() - LoadingStart

    local progress = math.clamp(
        elapsed / LoadingDuration,
        0,
        1
    )

    local percentage = math.floor(progress * 100)

    LoadingPercentage.Text = percentage.."%"

    task.wait(0.025)

end

LoadingPercentage.Text = "100%"
LoadingStatus.Text = "PYROVEX HUB IS READY!"

Tween(LoadingStroke,{
    Color = C.Green,
    Transparency = 0
},0.25)

Tween(LoadingPercentage,{
    TextColor3 = C.Green
},0.25)

task.wait(0.35)

--==============================================================
-- LOADING EXIT
--==============================================================

Tween(LoadingMain,{

    Position = UDim2.new(0.5,0,0,-130),
    BackgroundTransparency = 1

},0.65,Enum.EasingStyle.Quint,Enum.EasingDirection.In)

Tween(LoadingLogoFrame,{
    BackgroundTransparency = 1
},0.3)

Tween(LoadingTitle,{
    TextTransparency = 1
},0.3)

Tween(LoadingSubtitle,{
    TextTransparency = 1
},0.3)

Tween(LoadingStatus,{
    TextTransparency = 1
},0.3)

Tween(LoadingPercentage,{
    TextTransparency = 1
},0.3)

task.wait(0.7)

LoadingGui:Destroy()

--==============================================================
-- MAIN SCREEN GUI
--==============================================================

local Screen = New("ScreenGui",{

    Name = "PyroVexLoader",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling

},PlayerGui)

--==============================================================
-- MAIN WINDOW
--==============================================================

local Outer = New("Frame",{

    Name = "OuterFrame",

    Size = UDim2.fromOffset(
        Config.MainWidth,
        Config.MainHeight
    ),

    Position = UDim2.new(0.5,0,0.5,0),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ClipsDescendants = false,
    Active = true,
    ZIndex = 1

},Screen)

Round(Outer,23)

local OuterGradient = PremiumGradient(Outer,25)

AnimateGradient(OuterGradient,4)

local OuterStroke = Outline(Outer,C.LightBlue,2,0.15)

local OuterStrokeGradient = PremiumGradient(OuterStroke,0)

AnimateGradient(OuterStrokeGradient,3)

--==============================================================
-- OUTER GLOW
--==============================================================

local OuterGlow = New("Frame",{

    Name = "OuterGlow",
    Size = UDim2.new(1,12,1,12),
    Position = UDim2.fromOffset(-6,-6),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 0

},Outer)

Round(OuterGlow,27)

local OuterGlowStroke = Outline(OuterGlow,C.Purple,3,0.72)

Pulse(OuterGlowStroke,"Transparency",0.45,0.85,1.2)

--==============================================================
-- INNER WINDOW
--==============================================================

local Main = New("Frame",{

    Name = "Main",
    Size = UDim2.new(1,-4,1,-4),
    Position = UDim2.fromOffset(2,2),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true,
    ZIndex = 2

},Outer)

Round(Main,21)

local MainGradient = Gradient(
    Main,
    C.Background,
    C.Background2,
    45
)

--==============================================================
-- MAIN SCALE
--==============================================================

local MainScale = New("UIScale",{

    Scale = 0.75

},Outer)

MainScale.Scale = GetResponsiveScale()

--==============================================================
-- RESPONSIVE UPDATE
--==============================================================

if Camera then

    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()

        if MainScale and MainScale.Parent then

            Tween(MainScale,{
                Scale = GetResponsiveScale()
            },0.25)

        end

    end)

end

--==============================================================
-- BACKGROUND DECORATION
--==============================================================

local BackgroundDecoration = New("Frame",{

    Size = UDim2.fromOffset(210,210),
    Position = UDim2.new(1,-125,0,100),
    BackgroundColor3 = C.Purple,
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    ZIndex = 2

},Main)

Round(BackgroundDecoration,100)

local DecorationGradient = Gradient(
    BackgroundDecoration,
    C.Blue,
    C.Red,
    45
)

AnimateGradient(DecorationGradient,5)

--==============================================================
-- SECOND DECORATION
--==============================================================

local BackgroundDecoration2 = New("Frame",{

    Size = UDim2.fromOffset(150,150),
    Position = UDim2.new(0,-95,1,-145),
    BackgroundColor3 = C.Blue,
    BackgroundTransparency = 0.95,
    BorderSizePixel = 0,
    ZIndex = 2

},Main)

Round(BackgroundDecoration2,100)

--==============================================================
-- TOP ACCENT
--==============================================================

local TopAccent = New("Frame",{

    Size = UDim2.new(1,-24,0,3),
    Position = UDim2.fromOffset(12,5),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ZIndex = 20

},Main)

Round(TopAccent,5)

local TopAccentGradient = PremiumGradient(TopAccent,0)

AnimateGradient(TopAccentGradient,2.5)

--==============================================================
-- HEADER
--==============================================================

local Header = New("Frame",{

    Name = "Header",
    Size = UDim2.new(1,-16,0,83),
    Position = UDim2.fromOffset(8,11),
    BackgroundColor3 = C.Header,
    BorderSizePixel = 0,
    Active = true,
    ClipsDescendants = true,
    ZIndex = 5

},Main)

Round(Header,17)

local HeaderGradient = Gradient(
    Header,
    Color3.fromRGB(20,34,62),
    Color3.fromRGB(35,17,51),
    0
)

AnimateGradient(HeaderGradient,6)

local HeaderStroke = Outline(Header,C.Border,1,0.2)

--==============================================================
-- HEADER DECORATION
--==============================================================

local HeaderLine = New("Frame",{

    Size = UDim2.new(1,-28,0,1),
    Position = UDim2.new(0,14,1,-1),
    BackgroundColor3 = C.Border,
    BorderSizePixel = 0,
    ZIndex = 6

},Header)

--==============================================================
-- LOGO CONTAINER
--==============================================================

local Logo = New("Frame",{

    Size = UDim2.fromOffset(49,49),
    Position = UDim2.fromOffset(13,16),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 7

},Header)

Round(Logo,14)

local LogoGradient = PremiumGradient(Logo,45)

AnimateGradient(LogoGradient,3)

local LogoStroke = Outline(Logo,C.LightPurple,1.5,0.12)

local LogoImage = New("ImageLabel",{

    Name = "LogoImage",
    Size = UDim2.new(1,-6,1,-6),
    Position = UDim2.fromOffset(3,3),
    BackgroundTransparency = 1,
    Image = LogoAsset,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 8

},Logo)

Round(LogoImage,11)

--==============================================================
-- LOGO GLOW
--==============================================================

local LogoGlow = New("Frame",{

    Size = UDim2.new(1,8,1,8),
    Position = UDim2.fromOffset(-4,-4),
    BackgroundTransparency = 1,
    ZIndex = 6

},Logo)

Round(LogoGlow,16)

Outline(LogoGlow,C.LightBlue,2,0.7)

--==============================================================
-- LOGO ANIMATION
--==============================================================

Pulse(LogoStroke,"Transparency",0.1,0.55,1)

--==============================================================
-- HEADER TITLE
--==============================================================

local Title = New("TextLabel",{

    Name = "Title",
    Position = UDim2.fromOffset(74,12),
    Size = UDim2.fromOffset(180,26),
    BackgroundTransparency = 1,
    Text = "PYROVEX LOADER",
    TextColor3 = C.White,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 7

},Header)

--==============================================================
-- TITLE SHADOW
--==============================================================

local TitleShadow = New("TextLabel",{

    Position = UDim2.fromOffset(75,13),
    Size = UDim2.fromOffset(180,26),
    BackgroundTransparency = 1,
    Text = "PYROVEX LOADER",
    TextColor3 = C.Purple,
    TextTransparency = 0.72,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 6

},Header)

--==============================================================
-- DISCORD IMAGE
--==============================================================

local DiscordContainer = New("Frame",{

    Name = "DiscordImageContainer",
    Size = UDim2.fromOffset(23,23),
    Position = UDim2.fromOffset(254,16),
    BackgroundColor3 = Color3.fromRGB(48,105,230),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 9

},Header)

Round(DiscordContainer,8)

Outline(DiscordContainer,C.LightBlue,1,0.2)

local DiscordImage = New("ImageLabel",{

    Name = "DiscordImage",
    Size = UDim2.fromScale(1,1),
    BackgroundTransparency = 1,
    Image = DiscordAsset,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 10

},DiscordContainer)

Round(DiscordImage,8)

--==============================================================
-- DISCORD COPY BUTTON
--==============================================================

local DiscordCopy = New("TextButton",{

    Name = "DiscordCopy",
    Size = UDim2.fromOffset(135,25),
    Position = UDim2.fromOffset(282,15),
    BackgroundTransparency = 1,
    Text = "COPY DISCORD LINK",
    TextColor3 = C.LightBlue,
    TextSize = 7,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 10

},Header)

DiscordCopy.MouseEnter:Connect(function()

    Tween(DiscordCopy,{
        TextColor3 = C.White
    },0.15)

end)

DiscordCopy.MouseLeave:Connect(function()

    Tween(DiscordCopy,{
        TextColor3 = C.LightBlue
    },0.15)

end)

DiscordCopy.MouseButton1Click:Connect(function()

    local success,err = pcall(function()

        if not setclipboard then
            error("Clipboard is unsupported")
        end

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

    task.delay(1.5,function()

        if DiscordCopy and DiscordCopy.Parent then

            DiscordCopy.Text = "COPY DISCORD LINK"
            DiscordCopy.TextColor3 = C.LightBlue

        end

    end)

end)

--==============================================================
-- HEADER SUBTITLE
--==============================================================

local HeaderSubtitle = New("TextLabel",{

    Position = UDim2.fromOffset(75,39),
    Size = UDim2.fromOffset(250,15),
    BackgroundTransparency = 1,
    Text = "PYROVEX HUB COMMUNITY",
    TextColor3 = C.LightBlue,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    ZIndex = 7

},Header)

--==============================================================
-- HEADER STATUS
--==============================================================

local StatusDot = New("Frame",{

    Size = UDim2.fromOffset(7,7),
    Position = UDim2.fromOffset(75,63),
    BackgroundColor3 = C.Green,
    BorderSizePixel = 0,
    ZIndex = 7

},Header)

Round(StatusDot,100)

local StatusText = New("TextLabel",{

    Position = UDim2.fromOffset(87,60),
    Size = UDim2.fromOffset(150,13),
    BackgroundTransparency = 1,
    Text = "LOADER ACTIVE",
    TextColor3 = C.Gray,
    TextSize = 7,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 7

},Header)

Pulse(StatusDot,"BackgroundTransparency",0.7,0,0.65)

--==============================================================
-- BUTTON ANIMATION ENGINE
--==============================================================

local function ButtonAnimation(button,normalColor,hoverColor)

    local originalSize = button.Size

    button.MouseEnter:Connect(function()

        Tween(button,{
            BackgroundColor3 = hoverColor
        },Animation.Hover)

    end)

    button.MouseLeave:Connect(function()

        Tween(button,{
            BackgroundColor3 = normalColor,
            Size = originalSize
        },Animation.Hover)

    end)

    button.MouseButton1Down:Connect(function()

        Tween(button,{

            Size = UDim2.new(
                originalSize.X.Scale,
                originalSize.X.Offset - 2,
                originalSize.Y.Scale,
                originalSize.Y.Offset - 2
            )

        },Animation.Button)

    end)

    button.MouseButton1Up:Connect(function()

        Tween(button,{
            Size = originalSize
        },Animation.Button,Enum.EasingStyle.Back)

    end)

end

--==============================================================
-- MINIMIZE BUTTON
--==============================================================

local Minimize = New("TextButton",{

    Name = "Minimize",
    Size = UDim2.fromOffset(30,30),
    Position = UDim2.new(1,-68,0,26),
    BackgroundColor3 = C.Card,
    Text = "—",
    TextColor3 = C.White,
    TextSize = 18,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 10

},Header)

Round(Minimize,9)

local MinimizeStroke = Outline(Minimize,C.Border,1)

ButtonAnimation(Minimize,C.Card,Color3.fromRGB(63,83,130))

--==============================================================
-- CLOSE BUTTON
--==============================================================

local Close = New("TextButton",{

    Name = "Close",
    Size = UDim2.fromOffset(30,30),
    Position = UDim2.new(1,-34,0,26),
    BackgroundColor3 = Color3.fromRGB(65,28,43),
    Text = "×",
    TextColor3 = C.Red,
    TextSize = 20,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 10

},Header)

Round(Close,9)

local CloseStroke = Outline(Close,C.Red,1,0.3)

ButtonAnimation(Close,Color3.fromRGB(65,28,43),C.Red)

--==============================================================
-- SECTION LABEL
--==============================================================

local SectionAccent = New("Frame",{

    Size = UDim2.fromOffset(3,11),
    Position = UDim2.fromOffset(12,108),
    BackgroundColor3 = C.Blue,
    BorderSizePixel = 0,
    ZIndex = 6

},Main)

Round(SectionAccent,4)

local SectionAccentGradient = PremiumGradient(SectionAccent,90)

local SectionTitle = New("TextLabel",{

    Size = UDim2.new(1,-30,0,16),
    Position = UDim2.fromOffset(19,105),
    BackgroundTransparency = 1,
    Text = "SCRIPT COLLECTION",
    TextColor3 = C.Gray,
    TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 5

},Main)

--==============================================================
-- SECTION DESCRIPTION
--==============================================================

local SectionDescription = New("TextLabel",{

    Size = UDim2.new(1,-30,0,12),
    Position = UDim2.fromOffset(19,120),
    BackgroundTransparency = 1,
    Text = "SELECT A CATEGORY TO EXPLORE AVAILABLE SCRIPTS",
    TextColor3 = C.DarkGray,
    TextSize = 6,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    ZIndex = 5

},Main)

--==============================================================
-- TAB CONTAINER
--==============================================================

local Tabs = New("ScrollingFrame",{

    Name = "Tabs",
    Size = UDim2.new(1,-28,0,36),
    Position = UDim2.fromOffset(14,139),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.fromOffset(0,0),
    AutomaticCanvasSize = Enum.AutomaticSize.X,
    ScrollingDirection = Enum.ScrollingDirection.X,
    ZIndex = 5

},Main)

New("UIListLayout",{

    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0,8),
    SortOrder = Enum.SortOrder.LayoutOrder

},Tabs)

--==============================================================
-- CONTENT PANEL
--==============================================================

local Content = New("ScrollingFrame",{

    Name = "Content",
    Size = UDim2.new(1,-28,1,-202),
    Position = UDim2.fromOffset(14,183),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Blue,
    ScrollBarImageTransparency = 0.1,
    CanvasSize = UDim2.fromOffset(0,0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ZIndex = 5

},Main)

Round(Content,15)

local ContentStroke = Outline(Content,C.Border,1,0.2)

local ContentGradient = Gradient(
    Content,
    C.Panel,
    Color3.fromRGB(15,21,39),
    90
)

New("UIPadding",{

    PaddingTop = UDim.new(0,12),
    PaddingBottom = UDim.new(0,12),
    PaddingLeft = UDim.new(0,11),
    PaddingRight = UDim.new(0,11)

},Content)

New("UIListLayout",{

    Padding = UDim.new(0,11),
    SortOrder = Enum.SortOrder.LayoutOrder

},Content)

--==============================================================
-- CARD CREATOR
--==============================================================

local function CreateScriptCard(scriptInfo,index)

    -- CARD BASE

    local Card = New("Frame",{

        Name = scriptInfo.Name,
        Size = UDim2.new(1,0,0,Config.CardHeight),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0,
        LayoutOrder = index,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 6

    },Content)

    Round(Card,14)

    local CardStroke = Outline(Card,C.Border,1,0.1)

    -- CARD GRADIENT

    local CardGradient = Gradient(
        Card,
        C.Card,
        Color3.fromRGB(27,32,57),
        0
    )

    -- CARD SCALE

    local CardScale = New("UIScale",{
        Scale = 0.92
    },Card)

    -- CARD ACCENT

    local CardAccent = New("Frame",{

        Size = UDim2.new(0,3,1,-24),
        Position = UDim2.fromOffset(5,12),
        BackgroundColor3 = C.Blue,
        BorderSizePixel = 0,
        ZIndex = 7

    },Card)

    Round(CardAccent,5)

    local CardAccentGradient = PremiumGradient(CardAccent,90)

    -- CARD ICON

    local Icon = New("Frame",{

        Size = UDim2.fromOffset(47,47),
        Position = UDim2.fromOffset(13,20),
        BackgroundColor3 = Color3.fromRGB(32,44,72),
        BorderSizePixel = 0,
        ZIndex = 7

    },Card)

    Round(Icon,12)

    local IconGradient = Gradient(
        Icon,
        Color3.fromRGB(43,76,124),
        Color3.fromRGB(79,40,117),
        45
    )

    Outline(Icon,C.Blue,1,0.3)

    -- ICON TEXT

    local IconText = New("TextLabel",{

        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        Text = "📜",
        TextColor3 = C.White,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        ZIndex = 8

    },Icon)

    -- CARD TITLE

    local CardTitle = New("TextLabel",{

        Position = UDim2.fromOffset(71,11),
        Size = UDim2.new(1,-235,0,19),
        BackgroundTransparency = 1,
        Text = scriptInfo.Name,
        TextColor3 = C.White,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBlack,
        ZIndex = 7

    },Card)

    -- CARD DESCRIPTION

    local CardDescription = New("TextLabel",{

        Position = UDim2.fromOffset(71,32),
        Size = UDim2.new(1,-235,0,17),
        BackgroundTransparency = 1,
        Text = scriptInfo.Subtitle,
        TextColor3 = C.Gray,
        TextSize = 7,
        TextWrapped = false,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
        ZIndex = 7

    },Card)

    -- BADGES

    local HasHubBadges =

        scriptInfo.Name == "ADMIN BADGE"
        or scriptInfo.Name == "ANTI AFK"
        or scriptInfo.Name == "PYROVEX DEBUGGER"
        or scriptInfo.Name == "PYROVEX HUB SHADER"
        or scriptInfo.Name == "TOKEN SPAWNER"

    local BadgeX = 71

    local function CreateBadge(text,color,width)

        local Badge = New("TextLabel",{

            Size = UDim2.fromOffset(width,14),
            Position = UDim2.fromOffset(BadgeX,59),
            BackgroundColor3 = color,
            BackgroundTransparency = 0.12,
            Text = text,
            TextColor3 = C.White,
            TextSize = 6,
            Font = Enum.Font.GothamBlack,
            BorderSizePixel = 0,
            ZIndex = 8

        },Card)

        Round(Badge,5)

        BadgeX = BadgeX + width + 5

        return Badge

    end

    if scriptInfo.Name == "CHILI HUB" then

        CreateBadge("FEATURED",C.Purple,50)

    elseif HasHubBadges then

        CreateBadge("FEATURED",C.Purple,50)

        CreateBadge(
            "BY PYROVEX HUB",
            Color3.fromRGB(54,65,110),
            78
        )

    end

    if scriptInfo.Name == "TOKEN SPAWNER" then
        CreateBadge("KEY REQUIRED",C.Red,67)
    end

    -- EXECUTE BUTTON

    local Execute = New("TextButton",{

        Name = "ExecuteButton",
        Size = UDim2.fromOffset(72,30),
        Position = UDim2.new(1,-158,0,29),
        BackgroundColor3 = C.Blue,
        Text = "EXECUTE",
        TextColor3 = C.White,
        TextSize = 8,
        Font = Enum.Font.GothamBlack,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 9

    },Card)

    Round(Execute,9)

    local ExecuteStroke = Outline(Execute,C.LightBlue,1,0.15)

    local ExecuteGradient = Gradient(
        Execute,
        C.Blue,
        C.Purple,
        0
    )

    AnimateGradient(ExecuteGradient,4)

    ButtonAnimation(
        Execute,
        C.Blue,
        Color3.fromRGB(95,120,255)
    )

    -- COPY BUTTON

    local Copy = New("TextButton",{

        Name = "CopyButton",
        Size = UDim2.fromOffset(68,30),
        Position = UDim2.new(1,-80,0,29),
        BackgroundColor3 = C.CopyBackground,
        Text = "COPY",
        TextColor3 = C.White,
        TextSize = 8,
        Font = Enum.Font.GothamBlack,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 9

    },Card)

    Round(Copy,9)

    local CopyStroke = Outline(Copy,C.LightPurple,1,0.25)

    ButtonAnimation(
        Copy,
        C.CopyBackground,
        Color3.fromRGB(78,85,145)
    )

    -- EXECUTE FUNCTION

    local Executing = false

    Execute.MouseButton1Click:Connect(function()

        if Executing then
            return
        end

        Executing = true

        Execute.Text = "LOADING..."

        Tween(Execute,{
            BackgroundColor3 = C.Purple
        },0.2)

        task.spawn(function()

            local success,err = pcall(function()

                local source = game:HttpGet(scriptInfo.URL)

                local func = loadstring(source)

                if not func then
                    error("Unable to compile script")
                end

                func()

            end)

            if success then

                Execute.Text = "EXECUTED"
                Execute.TextColor3 = C.Green

            else

                Execute.Text = "FAILED"
                Execute.TextColor3 = C.Red

                warn(
                    "[PYROVEX LOADER] "
                    ..scriptInfo.Name
                    ..": "
                    ..tostring(err)
                )

            end

            task.wait(1.5)

            if Execute and Execute.Parent then

                Execute.Text = "EXECUTE"
                Execute.TextColor3 = C.White

                Tween(Execute,{
                    BackgroundColor3 = C.Blue
                },0.2)

            end

            Executing = false

        end)

    end)

    -- COPY FUNCTION

    Copy.MouseButton1Click:Connect(function()

        local success,err = pcall(function()

            if not setclipboard then
                error("Clipboard is unsupported")
            end

            setclipboard(GetLoadstring(scriptInfo.URL))

        end)

        if success then

            Copy.Text = "COPIED"
            Copy.TextColor3 = C.Green

        else

            Copy.Text = "FAILED"
            Copy.TextColor3 = C.Red

            warn(
                "[PYROVEX LOADER] COPY ERROR: "
                ..tostring(err)
            )

        end

        task.delay(1.5,function()

            if Copy and Copy.Parent then

                Copy.Text = "COPY"
                Copy.TextColor3 = C.White

            end

        end)

    end)

    -- CARD HOVER ENTER

    Card.MouseEnter:Connect(function()

        Tween(Card,{
            BackgroundColor3 = C.CardHover
        },Animation.Hover)

        Tween(CardStroke,{
            Color = C.LightBlue,
            Transparency = 0.05
        },Animation.Hover)

        Tween(CardScale,{
            Scale = 1
        },Animation.Hover,Enum.EasingStyle.Back)

        Tween(CardAccent,{
            Size = UDim2.new(0,4,1,-12),
            Position = UDim2.fromOffset(5,6)
        },Animation.Hover)

        Tween(Icon,{
            BackgroundColor3 = Color3.fromRGB(49,70,113)
        },Animation.Hover)

    end)

    -- CARD HOVER LEAVE

    Card.MouseLeave:Connect(function()

        Tween(Card,{
            BackgroundColor3 = C.Card
        },Animation.Hover)

        Tween(CardStroke,{
            Color = C.Border,
            Transparency = 0.1
        },Animation.Hover)

        Tween(CardScale,{
            Scale = 0.97
        },Animation.Hover)

        Tween(CardAccent,{
            Size = UDim2.new(0,3,1,-24),
            Position = UDim2.fromOffset(5,12)
        },Animation.Hover)

        Tween(Icon,{
            BackgroundColor3 = Color3.fromRGB(32,44,72)
        },Animation.Hover)

    end)

    -- CARD ENTRANCE

    Tween(Card,{
        BackgroundTransparency = 0
    },Animation.Card)

    Tween(CardScale,{
        Scale = 1
    },Animation.Card,Enum.EasingStyle.Back)

    return Card

end

--==============================================================
-- TAB SYSTEM
--==============================================================

local SelectedTab = nil

local TabButtons = {}
local TabIndicators = {}
local TabStrokes = {}

--==============================================================
-- TAB SCRIPT SELECTOR
--==============================================================

local function GetSelectedScripts(name)

    if name == "ALL SCRIPTS" then

        return AllScripts

    elseif name == "STEAL AN EGG" then

        return Scripts

    elseif name == "GROW A GARDEN" then

        return GrowScripts

    elseif name == "UNIVERSAL SCRIPTS" then

        return UniversalScripts

    end

    return {}

end

--==============================================================
-- TAB SELECTION
--==============================================================

local function SelectTab(name)

    if SelectedTab == name then
        return
    end

    SelectedTab = name

    -- UPDATE TAB APPEARANCE

    for tabName,tab in pairs(TabButtons) do

        local active = tabName == name

        Tween(tab,{

            BackgroundColor3 = active and C.Blue or C.Card,
            TextColor3 = active and C.White or C.Gray

        },Animation.Tab)

        local stroke = TabStrokes[tabName]

        if stroke then

            Tween(stroke,{

                Color = active and C.LightBlue or C.Border,
                Transparency = active and 0.1 or 0

            },Animation.Tab)

        end

        local indicator = TabIndicators[tabName]

        if indicator then

            Tween(indicator,{

                Size = UDim2.new(
                    active and 0.65 or 0,
                    0,
                    0,
                    2
                ),

                BackgroundTransparency = active and 0 or 1

            },Animation.Tab)

        end

    end

    -- CLEAR OLD CONTENT

    for _,child in ipairs(Content:GetChildren()) do

        if child:IsA("Frame") then
            child:Destroy()
        end

    end

    Content.CanvasPosition = Vector2.new(0,0)

    -- LOAD SELECTED COLLECTION

    local selectedScripts = GetSelectedScripts(name)

    for index,scriptInfo in ipairs(selectedScripts) do

        CreateScriptCard(scriptInfo,index)

        task.wait(0.035)

    end

end

--==============================================================
-- CREATE TAB BUTTONS
--==============================================================

for index,section in ipairs(Sections) do

    local Tab = New("TextButton",{

        Name = section.Name,
        Size = UDim2.fromOffset(section.Width,34),
        BackgroundColor3 = C.Card,
        Text = section.Name,
        TextColor3 = C.Gray,
        TextSize = 8,
        Font = Enum.Font.GothamBlack,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        LayoutOrder = index,
        ClipsDescendants = true,
        ZIndex = 7

    },Tabs)

    Round(Tab,10)

    local TabStroke = Outline(Tab,C.Border,1)

    local Indicator = New("Frame",{

        Name = "Indicator",
        Size = UDim2.new(0,0,0,2),
        Position = UDim2.new(0.175,0,1,-4),
        BackgroundColor3 = C.White,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 9

    },Tab)

    Round(Indicator,5)

    TabButtons[section.Name] = Tab
    TabIndicators[section.Name] = Indicator
    TabStrokes[section.Name] = TabStroke

    Tab.MouseButton1Click:Connect(function()
        SelectTab(section.Name)
    end)

    Tab.MouseEnter:Connect(function()

        if SelectedTab ~= section.Name then

            Tween(Tab,{
                BackgroundColor3 = Color3.fromRGB(38,51,79)
            },Animation.Hover)

        end

    end)

    Tab.MouseLeave:Connect(function()

        if SelectedTab ~= section.Name then

            Tween(Tab,{
                BackgroundColor3 = C.Card
            },Animation.Hover)

        end

    end)

end

--==============================================================
-- FLOATING MINIMIZE BUTTON
--==============================================================

local FloatingButton = New("ImageButton",{

    Name = "FloatingButton",

    Size = UDim2.fromOffset(
        Config.FloatingSize,
        Config.FloatingSize
    ),

    Position = UDim2.new(0,20,0.5,-26),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0,
    Image = LogoAsset,
    ScaleType = Enum.ScaleType.Crop,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    Visible = false,
    Active = true,
    ZIndex = 100

},Screen)

Round(FloatingButton,100)

local FloatingStroke = Outline(FloatingButton,C.LightBlue,2,0.05)

local FloatingGradient = PremiumGradient(FloatingStroke,0)

AnimateGradient(FloatingGradient,2)

local FloatingScale = New("UIScale",{
    Scale = 0.7
},FloatingButton)

--==============================================================
-- FLOATING BUTTON GLOW
--==============================================================

local FloatingGlow = New("Frame",{

    Size = UDim2.new(1,10,1,10),
    Position = UDim2.fromOffset(-5,-5),
    BackgroundTransparency = 1,
    ZIndex = 99

},FloatingButton)

Round(FloatingGlow,100)

local FloatingGlowStroke = Outline(FloatingGlow,C.Purple,2,0.65)

Pulse(FloatingGlowStroke,"Transparency",0.35,0.8,1)

--==============================================================
-- FLOATING HOVER
--==============================================================

FloatingButton.MouseEnter:Connect(function()

    Tween(FloatingScale,{
        Scale = 1.12
    },0.18,Enum.EasingStyle.Back)

end)

FloatingButton.MouseLeave:Connect(function()

    Tween(FloatingScale,{
        Scale = 1
    },0.18)

end)

--==============================================================
-- MAIN OPENING ANIMATION
--==============================================================

Main.BackgroundTransparency = 1
Outer.BackgroundTransparency = 1

MainScale.Scale = 0.72

Tween(Outer,{
    BackgroundTransparency = 0
},Animation.Open)

Tween(Main,{
    BackgroundTransparency = 0
},Animation.Open)

Tween(MainScale,{
    Scale = GetResponsiveScale()
},Animation.Open,Enum.EasingStyle.Back)

--==============================================================
-- ANIMATION STATES
--==============================================================

local IsAnimating = false
local Closing = false

--==============================================================
-- MINIMIZE FUNCTION
--==============================================================

Minimize.MouseButton1Click:Connect(function()

    if IsAnimating or Closing then
        return
    end

    IsAnimating = true

    -- SHRINK MAIN WINDOW

    Tween(
        MainScale,
        {
            Scale = MainScale.Scale * 0.72
        },
        Animation.Minimize,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    local fade = Tween(Main,{
        BackgroundTransparency = 1
    },Animation.Minimize)

    Tween(Outer,{
        BackgroundTransparency = 1
    },Animation.Minimize)

    if fade then
        fade.Completed:Wait()
    end

    if not Screen.Parent then
        return
    end

    -- HIDE MAIN

    Main.Visible = false
    Outer.Visible = false

    -- SHOW FLOATING BUTTON

    FloatingButton.Visible = true
    FloatingScale.Scale = 0.55

    Tween(
        FloatingScale,
        {
            Scale = 1
        },
        Animation.Restore,
        Enum.EasingStyle.Back
    )

    IsAnimating = false

end)

--==============================================================
-- RESTORE FUNCTION
--==============================================================

FloatingButton.MouseButton1Click:Connect(function()

    if IsAnimating or Closing then
        return
    end

    IsAnimating = true

    -- FLOATING BUTTON SHRINK

    Tween(FloatingScale,{
        Scale = 0.55
    },0.12)

    task.wait(0.12)

    if not Screen.Parent then
        return
    end

    FloatingButton.Visible = false

    -- RESTORE MAIN WINDOW

    Outer.Visible = true
    Main.Visible = true

    Main.BackgroundTransparency = 1
    Outer.BackgroundTransparency = 1

    MainScale.Scale = 0.72

    Tween(Outer,{
        BackgroundTransparency = 0
    },Animation.Restore)

    Tween(Main,{
        BackgroundTransparency = 0
    },Animation.Restore)

    local restore = Tween(
        MainScale,
        {
            Scale = GetResponsiveScale()
        },
        Animation.Restore,
        Enum.EasingStyle.Back
    )

    if restore then
        restore.Completed:Wait()
    end

    IsAnimating = false

end)

--==============================================================
-- CLOSE ANIMATION
--==============================================================

Close.MouseButton1Click:Connect(function()

    if Closing or IsAnimating then
        return
    end

    Closing = true
    IsAnimating = true

    -- CLOSE SHRINK

    Tween(
        MainScale,
        {
            Scale = 0.78
        },
        Animation.Close,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    local fade = Tween(Main,{
        BackgroundTransparency = 1
    },Animation.Close)

    Tween(Outer,{
        BackgroundTransparency = 1
    },Animation.Close)

    if fade then
        fade.Completed:Wait()
    end

    if Screen and Screen.Parent then
        Screen:Destroy()
    end

end)

--==============================================================
-- MAIN WINDOW DRAGGING
--==============================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil
local DragInput = nil

-- HEADER INPUT BEGAN

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = input.Position
        StartPosition = Outer.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)

    end

end)

-- HEADER INPUT CHANGED

Header.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        DragInput = input

    end

end)

-- MAIN DRAG UPDATE

UserInputService.InputChanged:Connect(function(input)

    if Dragging and (
        input == DragInput
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - DragStart

        Outer.Position = UDim2.new(

            StartPosition.X.Scale,
            StartPosition.X.Offset + delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + delta.Y

        )

    end

end)

--==============================================================
-- FLOATING BUTTON DRAGGING
--==============================================================

local FloatingDragging = false
local FloatingDragStart = nil
local FloatingStartPosition = nil
local FloatingDragInput = nil

-- FLOATING INPUT BEGAN

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

-- FLOATING INPUT CHANGED

FloatingButton.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        FloatingDragInput = input

    end

end)

-- FLOATING DRAG UPDATE

UserInputService.InputChanged:Connect(function(input)

    if FloatingDragging and (
        input == FloatingDragInput
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - FloatingDragStart

        FloatingButton.Position = UDim2.new(

            FloatingStartPosition.X.Scale,
            FloatingStartPosition.X.Offset + delta.X,

            FloatingStartPosition.Y.Scale,
            FloatingStartPosition.Y.Offset + delta.Y

        )

    end

end)

--==============================================================
-- INITIALIZE DEFAULT TAB
-- ALL SCRIPTS IS NOW THE FIRST TAB
--==============================================================

SelectTab("ALL SCRIPTS")

--==============================================================
-- INITIALIZATION COMPLETE
--==============================================================

print("==================================================")
print("PYROVEX LOADER V12")
print("EXTREME PREMIUM EDITION")
print("BLUE x PURPLE x RED x BLACK")
print("ADVANCED ANIMATIONS ENABLED")
print("ALL SCRIPTS COLLECTION INITIALIZED")
print("6 SCRIPTS AVAILABLE")
print("PYROVEX HUB SUCCESSFULLY LOADED")
print("==================================================")
