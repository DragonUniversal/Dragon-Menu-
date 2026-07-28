repeat wait() until game:IsLoaded()

local Configs_HUB = {
Cor_Hub = Color3.fromRGB(15, 15, 15),
Cor_Options = Color3.fromRGB(15, 15, 15),
Cor_Stroke = Color3.fromRGB(60, 60, 60),
Cor_Text = Color3.fromRGB(240, 240, 240),
Cor_DarkText = Color3.fromRGB(140, 140, 140),
Corner_Radius = UDim.new(0, 4),
Text_Font = Enum.Font.FredokaOne
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
functionCreate = {}

functionCreate.Create = function(instance, parent, props)
local new = Instance.new(instance, parent)
if props then
table.foreach(props, function(prop, value)
new[prop] = value
end)
end
local clse
clse = new.AncestryChanged:Connect(function()
if not new.Parent then
new:Destroy()
if clse then
clse:Disconnect()
clse = nil
end
end
end)
return new
end

Create = functionCreate.Create

functionCreate.SetProps = function(instance, props)
if instance and props then
table.foreach(props, function(prop, value)
instance[prop] = value
end)
end
return instance
end

functionCreate.Corner = function(parent, props)
local new = Create("UICorner", parent)
new.CornerRadius = Configs_HUB.Corner_Radius
if props then
SetProps(new, props)
end
return new
end

functionCreate.Stroke = function(parent, props)
local new = Create("UIStroke", parent)
new.Color = Configs_HUB.Cor_Stroke
if props and props.Color then
new.Color = props.Color
end
new.ApplyStrokeMode = "Border"
if props then
SetProps(new, props)
end
return new
end

functionCreate.CreateGradient = function(parent, props)
local new = Instance.new("UIGradient")
new.Parent = parent

local defaultColors = {
Color3.fromRGB(255, 255, 255),
Color3.fromRGB(127, 127, 127),
Color3.fromRGB(0, 0, 0)
}
if props and props.Color then
local colorList = props.Color
local colorCount = math.min(#colorList, 3)
local colorKeypoints = {}
for i = 1, colorCount do
local position = (i - 1) / (colorCount - 1)
table.insert(colorKeypoints, ColorSequenceKeypoint.new(position, colorList[i]))
end
new.Color = ColorSequence.new(colorKeypoints)
else
new.Color = ColorSequence.new(defaultColors[1], defaultColors[2], defaultColors[3])
end
if props and props.Rotation then
new.Rotation = props.Rotation
end
if props and props.Intensity then
local color1 = new.Color.Keypoints[1].Value
local color2 = new.Color.Keypoints[#new.Color.Keypoints].Value

local intensifiedColor1 = color1:Lerp(Color3.fromRGB(0, 0, 0), props.Intensity)
local intensifiedColor2 = color2:Lerp(Color3.fromRGB(0, 0, 0), props.Intensity)

new.Color = ColorSequence.new(intensifiedColor1, intensifiedColor2)
end
if props and props.Offset then
new.Offset = props.Offset
end
if props and props.Tween then
local speed = props.Speed or 2
local goal = {Rotation = new.Rotation + 360}
local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
local tween = TweenService:Create(new, tweenInfo, goal)
tween:Play()
end
return new
end

functionCreate.CreateTween = function(instance, prop, value, time, tweenWait)
local tween = TweenService:Create(instance,
TweenInfo.new(time, Enum.EasingStyle.Linear),
{[prop] = value})
tween:Play()
if tweenWait then
tween.Completed:Wait()
end
end

functionCreate.CreateTween1 = function(instance, property, goal, duration, easingDirection)
local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local tween = TweenService:Create(instance, tweenInfo, {[property] = goal})
tween:Play()
return tween
end

functionCreate.TextSetColor = function(instance)
if not instance or not instance.Parent then return end
local connectionTextSetColor = {}
local isMouseHovered = false
connectionTextSetColor.MouseEnter = instance.MouseEnter:Connect(function()
isMouseHovered = true
end)
connectionTextSetColor.MouseLeave = instance.MouseLeave:Connect(function()
isMouseHovered = false
end)
connectionTextSetColor.RenderStepped = RunService.RenderStepped:Connect(function()
if isMouseHovered then
CreateTween(instance, "TextColor3", Color3.fromRGB(30, 140, 200), 0.4, true)
else
CreateTween(instance, "TextColor3", Configs_HUB.Cor_Text, 0.4, false)
end
end)
local function cleanup()
for _, connection in pairs(connectionTextSetColor) do
if connection then
connection:Disconnect()
end
end
connectionTextSetColor = {}
end
connectionTextSetColor.AncestryChanged = instance.AncestryChanged:Connect(function(_, parent)
if parent == nil and instance.Parent == nil then
cleanup()
end
end)
end

SetProps = functionCreate.SetProps
Corner = functionCreate.Corner
Stroke = functionCreate.Stroke
CreateGradient = functionCreate.CreateGradient
CreateTween = functionCreate.CreateTween
CreateTween1 = functionCreate.CreateTween1
TextSetColor = functionCreate.TextSetColor

local parentgui = (gethui and gethui()) or game:GetService("CoreGui")
local ScreenFind = parentgui:FindFirstChild("Dragon hub library2")
if ScreenFind then
ScreenFind:Destroy()
end

local ScreenGui = Create("ScreenGui", parentgui, {
Name = "Menu library2",
DisplayOrder = math.huge,
IgnoreGuiInset = true
})

functionCreate.DestroyScript = function()
ScreenGui:Destroy()
end

DestroyScript = functionCreate.DestroyScript

local Menu_Notifi = Create("Frame", ScreenGui, {
Size = UDim2.new(0.287, 0, 0.16, 0),
Position = UDim2.new(1, 0, 0.6, 0),
AnchorPoint = Vector2.new(1, 0),
BackgroundTransparency = 1
})

functionCreate.MakeNotifi = function(Configs)
local Title = Configs.Title or "Dragon Menu"
local text = Configs.Text or "Notifications"
local timewait = Configs.Time or 5

local Frame1 = Create("Frame", Menu_Notifi, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
AutomaticSize = "Y",
Name = "Title"
})

local Frame2 = Create("Frame", Frame1, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
Position = UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),
AutomaticSize = "Y"
})Corner(Frame2)

local TextLabel = Create("TextLabel", Frame2, {
Size = UDim2.new(0.9, 0, 0.58, 0),
Font = Configs_HUB.Text_Font,
BackgroundTransparency = 1,
Text = Title,
TextScaled = true,
TextXAlignment = "Left",
TextColor3 = Configs_HUB.Cor_Text
})

local TextButton = Create("TextButton", Frame2, {
Text = "X",
Font = Configs_HUB.Text_Font,
TextSize = 15,
TextWrapped = true,
BackgroundTransparency = 1,
TextColor3 = Color3.fromRGB(200, 200, 200),
Position = UDim2.new(1, 0, -0.12, 0),
AnchorPoint = Vector2.new(1, 0),
Size = UDim2.new(0.1, 0, 1, 0)
})

local TextLabel = Create("TextLabel", Frame2, {
Size = UDim2.new(1, 0, 0.58, 0),
Position = UDim2.new(0, 0, 0.58, 0),
TextScaled = true,
TextColor3 = Configs_HUB.Cor_DarkText,
TextXAlignment = "Left",
TextYAlignment = "Top",
AutomaticSize = "Y",
Text = text,
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
TextWrapped = true
})

local FrameSize = Create("Frame", Frame2, {
Size = UDim2.new(1, 0, 0.04, 0),
BackgroundColor3 = Configs_HUB.Cor_Stroke,
Position = UDim2.new(0, 0, 0.58, 0),
BorderSizePixel = 0
})Corner(FrameSize)Create("Frame", Frame2, {
Size = UDim2.new(0, 0, 0, 5),
Position = UDim2.new(0, 0, 1, 5),
BackgroundTransparency = 1
})

task.spawn(function()
CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0.04, 0), timewait, true)
end)

TextButton.MouseButton1Click:Connect(function()
CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
Frame1:Destroy()
end)

task.spawn(function()
CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true)
CreateTween(Frame2, "Position", UDim2.new(), 0.1, true)task.wait(timewait)
if Frame2 then
CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
Frame1:Destroy()
end
end)
end

MakeNotifi = functionCreate.MakeNotifi

function MakeWindow(Configs)
local title = Configs.Hub.Title or "Menu"
local Anim_Title = Configs.Hub.Animation or "by : Vitor"

local Menu = Create("Frame", ScreenGui, {
BackgroundColor3 = Configs_HUB.Cor_Hub,
Position = UDim2.new(0.77, 0, 0.227, 0),
AnchorPoint = Vector2.new(1, 0),
Active = true,
Draggable = true
})CreateGradient(Menu, {
Color = {
Color3.fromRGB(255, 255, 255),
Color3.fromRGB(0, 0, 0),
Color3.fromRGB(255, 0, 0)
},
Rotation = 45,
Tween = true,
Speed = 3
})Corner(Menu)

local TopBar = Create("Frame", Menu, {
BackgroundTransparency = 1,
Size = UDim2.new(1, 0, 0.09, 0),
Visible = false
})

local BottomLine = Create("Frame", TopBar, {
Size = UDim2.new(1, 0, 0.05, 0),
Position = UDim2.new(0, 0, 1, -2),
BackgroundColor3 = Configs_HUB.Cor_Stroke,
BorderSizePixel = 0
})

local Title = Create("TextLabel", TopBar, {
Size = UDim2.new(0.9, 0, 1, 0),
Position = UDim2.new(0, 0, 0, 0),
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextXAlignment = "Left",
Text = title,
TextScaled = true,
BackgroundTransparency = 1
})

local Close_Button = Create("TextButton", TopBar, {
Size = UDim2.new(0.05, 0, 1, 0),
Position = UDim2.new(0.95, 0, 0, 0),
TextColor3 = Configs_HUB.Cor_Text,
Text = "×",
TextScaled = true,
BackgroundTransparency = 1
})Corner(Close_Button)

local Minimize_BTN = Create("TextButton", TopBar, {
Size = UDim2.new(0.05, 0, 1, 0),
Position = UDim2.new(0.9, 0, 0, 0),
TextColor3 = Configs_HUB.Cor_Text,
Text = "-",
TextScaled = true,
BackgroundTransparency = 1
})Corner(Close_Button)

local AnimMenu = Create("Frame", ScreenGui, {
Position = UDim2.new(0.5, 0, 0.57, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Configs_HUB.Cor_Hub
})Corner(AnimMenu, {CornerRadius = UDim.new(0, 6)})

local Anim_Credits = Create("TextLabel", AnimMenu, {
Text = Anim_Title,
BackgroundTransparency = 1,
Size = UDim2.new(1, 0, 1, 0),
Visible = false,
Font = Configs_HUB.Text_Font,
TextTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Position = UDim2.new(0, 10, 0, 0),
TextXAlignment = "Left",
TextScaled = true
})

CreateTween(AnimMenu, "Size", UDim2.new(0, 0, 0.064, 0), 0.5, true)
CreateTween(AnimMenu, "Size", UDim2.new(0.15, 0, 0.064, 0), 0.5, true)
Anim_Credits.Visible = true
task.wait(0.5)
for i = 1, 0, -0.1 do task.wait()
Anim_Credits.TextTransparency = i
end
task.wait(1)
for i = 0, 1, 0.1 do task.wait()
Anim_Credits.TextTransparency = i
end
Anim_Credits:Destroy()
AnimMenu:Destroy()
CreateTween(Menu, "Size", UDim2.new(0.576, 0, 0.09, 0), 0.5, true)
TopBar.Visible = true
CreateTween(Menu, "Size", UDim2.new(0.576, 0, 0.545, 0), 0.3, true)
Menu.Draggable = true

local line_Containers = Create("Frame", Menu, {
BackgroundTransparency = 1,
Size = UDim2.new(1, 0, 1, 0)
})

local ScrollBar = Create("ScrollingFrame", Menu, {
Size = UDim2.new(0.225, 0, 0.91, 0),
Position = UDim2.new(0, 0, 0.085, 0),
CanvasSize = UDim2.new(0, 0, 0, 0),
ScrollingDirection = Enum.ScrollingDirection.Y,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
ScrollBarThickness = 2
})local listLayoutScrollBar = Create("UIListLayout", ScrollBar, {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder,
})Create("UIPadding", ScrollBar, {
PaddingLeft = UDim.new(0.028, 0),
PaddingTop = UDim.new(0.003, 0),
PaddingBottom = UDim.new(0.003, 0)
})

local Bottomright = Create("Frame", Menu, {
Size = UDim2.new(0.002, 0, 0.913, 0),
Position = UDim2.new(0.006 + ScrollBar.Position.X.Scale + ScrollBar.Size.X.Scale, ScrollBar.Position.X.Offset + ScrollBar.Size.X.Offset, 1, ScrollBar.Position.Y.Offset),
AnchorPoint = Vector2.new(0, 1),
BackgroundColor3 = Configs_HUB.Cor_Stroke,
BorderSizePixel = 0
})

local Containers = Create("Frame", Menu, {
Size = UDim2.new(0.762, 0, 0.915, 0),
Position = UDim2.new(0.237, 0, 0.085, 0),
BackgroundTransparency = 1
})Corner(Containers)

IsMinimized = true
IsMinimizedu = false
local isLockedMinimize = false
local isLockedClose = false

Minimize_BTN.MouseButton1Click:Connect(function()
if not isLockedMinimize then
isLockedMinimize = true
if IsMinimized then
IsMinimized = false
IsMinimizedu = true
Containers.Visible = false
Bottomright.Visible = false
ScrollBar.Visible = false
BottomLine.Visible = false
CreateTween(Menu, "Size", UDim2.new(0.576, 0, 0.06, 0), 0.15, true)
CreateTween(TopBar, "Size", UDim2.new(1, 0, 1, 0), 0, false)
else
IsMinimized = true
IsMinimizedu = false
CreateTween(TopBar, "Size", UDim2.new(1, 0, 0.09, 0), 0, false)
CreateTween(Menu, "Size", UDim2.new(0.576, 0, 0.63, 0), 0.15, true)
Containers.Visible = true
ScrollBar.Visible = true
BottomLine.Visible = true
Bottomright.Visible = true
end
isLockedMinimize = false
end
end)

function CreateClose()
if not isLockedClose then
isLockedClose = true
if IsMinimizedu then
IsMinimized = true
IsMinimizedu = false
CreateTween(TopBar, "Size", UDim2.new(1, 0, 0.09, 0), 0, false)
CreateTween(Menu, "Size", UDim2.new(0.576, 0, 0.63, 0), 0.15, true)
Containers.Visible = true
ScrollBar.Visible = true
BottomLine.Visible = true
Bottomright.Visible = true
end

local CloseGui = Create("TextButton", Menu, {
BackgroundTransparency = 0.5,
BackgroundColor3 = Configs_HUB.Cor_Hub,
Size = UDim2.new(1, 0, 1, 0),
AutoButtonColor = false,
Text = "",
BackgroundTransparency = 0.5,
Visible = false
})Corner(CloseGui)

local CloseMenu = Create("Frame", CloseGui, {
Size = UDim2.new(),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 0),
Transparency = 1,
BackgroundColor3 = Configs_HUB.Cor_Hub
})Corner(CloseMenu)Stroke(CloseMenu)

local Mensage = Create("TextLabel", CloseMenu, {
Size = UDim2.new(0.8, 0, 0.25, 0),
Text = "Tem certeza de que deseja fechar este script?",
Position = UDim2.new(0.1, 0, 0.2),
Font = Configs_HUB.Text_Font,
TextColor3 = Configs_HUB.Cor_Text,
TextScaled = true,
BackgroundTransparency = 1
})

local Confirm = Create("TextButton", CloseMenu, {
Size = UDim2.new(0.35, 0, 0.3, 0),
Position = UDim2.new(0.1, 0, 0.5, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
Text = "fechar Script",
Font = Configs_HUB.Text_Font,
TextColor3 = Color3.fromRGB(240, 0, 0),
TextScaled = true
})Corner(Confirm)Stroke(Confirm)

local Cancel = Create("TextButton", CloseMenu, {
Size = UDim2.new(0.35, 0, 0.3, 0),
Position = UDim2.new(0.9, 0, 0.5, 0),
AnchorPoint = Vector2.new(1, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
Text = "Cancelar",
Font = Configs_HUB.Text_Font,
TextColor3 = Color3.fromRGB(0, 240, 0),
TextScaled = true
})Corner(Cancel)Stroke(Cancel)

CloseGui.Visible = true
CreateTween(CloseMenu, "Transparency", 0, 0.2, false)
CreateTween(CloseMenu, "Size", UDim2.new(0.7, 0, 0.7, 0), 0.2, false)

Cancel.MouseButton1Click:Connect(function()
CreateTween(CloseMenu, "Transparency", 1, 0.3, false)
CreateTween(CloseMenu, "Size", UDim2.new(), 0.2, true)
CloseGui:Destroy()
end)

Confirm.MouseButton1Click:Connect(function()
CloseGui:Destroy()
CreateTween(Menu, "Size", UDim2.new(), 0.3, true)
DestroyScript()
end)

CloseGui.MouseButton1Click:Connect(function()
CreateTween(CloseMenu, "Transparency", 1, 0.3, false)
CreateTween(CloseMenu, "Size", UDim2.new(), 0.2, true)
CloseGui:Destroy()
end)
isLockedClose = false
end
end

Close_Button.MouseButton1Click:Connect(CreateClose)

local clicktoggle = Create("Sound", ScreenGui, {SoundId = "rbxassetid://6042053626", Volume = 0.1})
local falsetoggle = Create("Sound", ScreenGui, {SoundId = "rbxassetid://9083627113", Volume = 0.1})
local click1 = Create("Sound", ScreenGui, {SoundId = "rbxassetid://7475853483", Volume = 0.1})
local click2 = Create("Sound", ScreenGui, {SoundId = "rbxassetid://8432836186", Volume = 0.1})
local notifyfriend = Create("Sound", ScreenGui, {SoundId = "rbxassetid://1862045322", Volume = 0.2, PlaybackSpeed = 0.9})
local notifyfriendleave = Create("Sound", ScreenGui, {SoundId = "rbxassetid://489103549", Volume = 0.2})
local musicPlaying = false
local soundId1 = "rbxassetid://8486683243"
local soundId2 = "rbxassetid://4499400560"
local notificationgui = {}

local function notify(params)
local Title = params.Title or "Default Title"
local Text = params.Text or "Default Message"
local buttondeleteText = params.buttonText or "OK"
local image = params.image or "137903795082783"
local guiSize = params.guiSize or Vector2.new(400, 70)
local duration = params.duration
local position = params.Position or UDim2.new(0.5, -guiSize.X / 2, 0.45, 50)

local NotificationLabelText = Create("TextLabel", ScreenGui, {
Size = UDim2.new(0, guiSize.X, 0, guiSize.Y),
BackgroundTransparency = 1,
Text = Text,
TextScaled = true,
TextColor3 = Color3.fromRGB(255, 255, 255),
Position = position
})

local sound2 = Create("Sound", NotificationLabelText, {
SoundId = soundId1,
Volume = 0.2,
PlaybackSpeed = 0.9
})
sound2:Play()

local NotificationImage = Create("ImageLabel", NotificationLabelText, {
Size = UDim2.new(0, 70, 0, 70),
Position = UDim2.new(-0.2, 0, 0, 0),
Image = "rbxassetid://137903795082783" .. image,
BackgroundTransparency = 1
})

local NotificationLabelTitle = Create("TextLabel", NotificationLabelText, {
Size = UDim2.new(1, 0, 0.4, 0),
BackgroundTransparency = 1,
Text = Title,
TextScaled = true,
TextColor3 = Color3.fromRGB(255, 255, 255),
Position = UDim2.new(0, 0, -0.4, 0)
})

local OkButton = Create("TextButton", NotificationLabelText, {
Size = UDim2.new(1, 0, 0.4, 0),
Position = UDim2.new(0, 0, 1, 0),
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = true,
Text = buttondeleteText,
BackgroundTransparency = 1
})

local sound1 = Create("Sound", OkButton, {
SoundId = soundId2,
Volume = 0.2,
PlaybackSpeed = 0.9
})

table.insert(notificationgui, NotificationLabelText)

if #notificationgui > 1 then
local oldNotification = table.remove(notificationgui, 1)
oldNotification:Destroy()
end

local tween = TweenService:Create(NotificationLabelText, TweenInfo.new(0.5), {Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset - (#notificationgui * 60))})
tween:Play()

if duration then
delay(duration, function()
local tweenOut = TweenService:Create(NotificationLabelText, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -guiSize.X / 2, 0.45, 100), TextTransparency = 1})
tweenOut:Play()

tweenOut.Completed:Connect(function()
NotificationLabelText:Destroy()
end)
end)
end

OkButton.MouseButton1Click:Connect(function()
sound1:Play()
local tweenOut = TweenService:Create(NotificationLabelText, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -guiSize.X / 2, 0.45, 100), TextTransparency = 1})
tweenOut:Play()

tweenOut.Completed:Connect(function()
sound2:Destroy()
sound1:Destroy()
NotificationLabelText:Destroy()
end)
end)
end

notify({
Title = "Oi",
Text = "Espero Que Você Goste De Usá-lo",
buttonText = "ok",
imageID = "",
guiSize = Vector2.new(400, 70),
})

function MinimizeButton(Configs)
local functions = {}
local frameRefs, metaRefs, ddesug, stopupdateall, _XyZ, _cvZ = {}, {}, {}, {}, {}, {}
local minimize1 = false
local minimize = true
local minimize3 = false
local minimiz7 = true
local PlayerList = true
local minimize9 = false
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local LocalPlayer = players.LocalPlayer
local maxPlayers = players.MaxPlayers
local PlaceId = game.PlaceId
local friendsCooldown = 0
local friendsInTotal = 0
local TimeThai = false
local MarketplaceService = game:GetService("MarketplaceService")
local AssetService = game:GetService("AssetService")
local TeleportService = game:GetService("TeleportService")
local pages = AssetService:GetGamePlacesAsync()
local gamePlaces = pages:GetCurrentPage()
local count = 1
local Player = players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local View = nil
local playerFrames = {}
local displayedFriends = {}
local frameinfopy = false
local Avatar = false
local switchtodescription = false
local waitswitchpage = false
local image = Configs.Image or ""
functions.RunServerlock = function(lockName, Time, callback)
if stopupdateall[lockName] then
stopupdateall[lockName]:Disconnect()
end
if Time == "no" or Time == 0 then
stopupdateall[lockName] = RunService.Heartbeat:Connect(callback)
else
local Updates = tick()
stopupdateall[lockName] = RunService.Heartbeat:Connect(function()
if tick() - Updates >= Time then
Updates = tick()
callback()
end
end)
end
end
RunServerlock = functions.RunServerlock

local frame = Create("Frame", ScreenGui, {
Size = UDim2.new(0.5, 0, 0.1, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.95, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub
})

local tweenGradient = CreateGradient(frame, {
Color = {
Color3.fromRGB(255, 255, 255),
Color3.fromRGB(0, 0, 0),
Color3.fromRGB(255, 0, 0)
},
Rotation = 45,
Tween = true,
Speed = 3
})
