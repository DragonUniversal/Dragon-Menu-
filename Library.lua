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

local Button1 = Create("TextButton", ScreenGui, {
Size = UDim2.new(0.07, 0, 0.07, 0),
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 0.9, 0),
TextScaled = true,
Text = "v",
ZIndex = 10,
TextColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1
})

Button1.MouseButton1Click:Connect(function()
minimize1 = not minimize1
if minimize1 then
Button1.Text = "^"
CreateTween1(frame, "Size", UDim2.new(0.5, 0, 0, 0), 0.3, true)
CreateTween1(Button1, "Position", UDim2.new(0.5, 0, 1.005, 0), 0.3, false)
frame.Visible = false
else
frame.Visible = true
Button1.Text = "v"
CreateTween1(frame, "Size", UDim2.new(0.5, 0, 0.1, 0), 0.3, true)
CreateTween1(Button1, "Position", UDim2.new(0.5, 0, 0.9, 0), 0.3, false)
end
end)

local TimeLabelgui = Create("TextLabel", frame, {
Size = UDim2.new(0.215, 0, 0.5, 0),
Position = UDim2.new(0.005, 0, 0.235, 0),
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundTransparency = 1,
TextScaled = true,
Text = ""
})TextSetColor(TimeLabelgui)

local RobloxVersion = Create("TextLabel", frame, {
Size = UDim2.new(0.2, 0, 0.35, 0),
TextSize = 20,
TextWrapped = true,
TextScaled = true,
Position = UDim2.new(0.2 + 0.5, 0, 0.31, 0),
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundTransparency = 1,
Text = ""
})TextSetColor(RobloxVersion)

functions.createToggleButton = function(parent, position, callback, initialState)
local TextButton = Create("TextButton", parent, {
Size = UDim2.new(0.13, 0, 0.17, 0),
Position = position,
BackgroundColor3 = Configs_HUB.Cor_Options,
Name = "Frame",
Text = "",
BackgroundTransparency = 1,
AutoButtonColor = false
})Corner(TextButton)

local Frame1 = Create("Frame", TextButton, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
})
Corner(Frame1, {CornerRadius = UDim.new(1, 0)})
local Stroke = Stroke(Frame1, {Thickness = 2})

local Frame2 = Create("Frame", Frame1, {
Size = UDim2.new(0.4, 0, 0.95, 0),
Position = UDim2.new(0, 0, 0.49, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = Configs_HUB.Cor_Stroke
})
Corner(Frame2, {CornerRadius = UDim.new(1, 0)})

local OnOff = initialState

local function setState(state)
OnOff = state
if OnOff then
clicktoggle:Play()
CreateTween(Frame2, "Position", UDim2.new(0.6, 0, 0.5, 0), 0.2, false)
CreateTween(Frame2, "BackgroundColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
CreateTween(Stroke, "Color", Color3.fromRGB(30, 140, 200), 0.2, false)
callback(true)
else
falsetoggle:Play()
CreateTween(Frame2, "Position", UDim2.new(0, 0, 0.5, 0), 0.2, false)
CreateTween(Frame2, "BackgroundColor3", Configs_HUB.Cor_Stroke, 0.2, false)
CreateTween(Stroke, "Color", Configs_HUB.Cor_Stroke, 0.2, false)
callback(false)
end
end

TextButton.MouseButton1Click:Connect(function()
setState(not OnOff)
end)

TextButton.AncestryChanged:Connect(function(_, parent)
if not parent and OnOff then
setState(false)
end
end)

return setState
end

functions.createSettingSection = function(parent, title, description, buttonCallback, buttonState)
local sectionFrame = Create("Frame", parent, {
Size = UDim2.new(0.96, 0, 0.4, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0
})local Stroke = Stroke(sectionFrame, {Thickness = 2})

local titleLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.2, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Text = title
})
TextSetColor(titleLabel)

local descriptionLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.5, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
Position = UDim2.new(0, 0, 0.2, 0),
TextColor3 = Configs_HUB.Cor_Text,
Text = description
})
TextSetColor(descriptionLabel)

local toggleButtonPosition = UDim2.new(0.81, 0, 0.75, 0)
local toggleButtonState = functions.createToggleButton(sectionFrame, toggleButtonPosition, buttonCallback, buttonState)

return toggleButtonState
end

functions.createTextboxWithButton = function(parent, title, description, callback)
local sectionFrame = Create("Frame", parent, {
Size = UDim2.new(0.96, 0, 0.4, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0
})local Stroke = Stroke(sectionFrame, {Thickness = 2})

local titleLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.2, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Text = title
})
TextSetColor(titleLabel)

local descriptionLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.6, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
Position = UDim2.new(0, 0, 0.2, 0),
TextColor3 = Configs_HUB.Cor_Text,
Text = description
})
TextSetColor(descriptionLabel)

local messageTextbox = Create("TextBox", sectionFrame, {Size = UDim2.new(0.75, 0, 0.2, 0), Position = UDim2.new(0, 0, 0.8, 0), BackgroundColor3 = Configs_HUB.Cor_Options, TextColor3 = Configs_HUB.Cor_Text, PlaceholderText = "Enter your message here...", ClearTextOnFocus = true, TextScaled = true, Font = Configs_HUB.Text_Font})

local sendButton = Create("TextButton", sectionFrame, {Size = UDim2.new(0.25, 0, 0.2, 0), Position = UDim2.new(0.75, 0, 0.8, 0), BackgroundColor3 = Configs_HUB.Cor_Options, TextColor3 = Configs_HUB.Cor_Text, Text = "Send Message", TextScaled = true, Font = Configs_HUB.Text_Font})

sendButton.MouseButton1Click:Connect(function()
local message = messageTextbox.Text
if message and message:match("%S") then
callback(message)
messageTextbox.Text = ""
messageTextbox.TextColor3 = Configs_HUB.Cor_Text
else
messageTextbox.Text = "Please enter a message."
messageTextbox.TextColor3 = Color3.new(1, 0, 0)
end
end)

messageTextbox.Focused:Connect(function()
if messageTextbox.Text == "Please enter a message." then
messageTextbox.Text = ""
messageTextbox.TextColor3 = Configs_HUB.Cor_Text
end
end)

return sectionFrame
end

functions.createTextBox = function(parent, title, description, buttonText, callback, minValue, maxValue)
local sectionFrame = Create("Frame", parent, {
Size = UDim2.new(0.96, 0, 0.4, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0
})
local Stroke = Stroke(sectionFrame, {Thickness = 2})

local titleLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.2, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Text = title
})
TextSetColor(titleLabel)

local descriptionLabel = Create("TextLabel", sectionFrame, {
Size = UDim2.new(1, 0, 0.6, 0),
TextScaled = true,
TextXAlignment = Enum.TextXAlignment.Left,
BackgroundTransparency = 1,
Position = UDim2.new(0, 0, 0.2, 0),
TextColor3 = Configs_HUB.Cor_Text,
Text = description
})
TextSetColor(descriptionLabel)

local inputBox = Create("TextBox", sectionFrame, {
Size = UDim2.new(0.75, 0, 0.2, 0),
Position = UDim2.new(0, 0, 0.8, 0),
BackgroundColor3 = Configs_HUB.Cor_Options,
Text = tostring(minValue or 0),
TextScaled = true,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font
})
TextSetColor(inputBox)

local sendButton = Create("TextButton", sectionFrame, {
Size = UDim2.new(0.25, 0, 0.2, 0),
Position = UDim2.new(0.75, 0, 0.8, 0),
BackgroundColor3 = Configs_HUB.Cor_Options,
TextColor3 = Configs_HUB.Cor_Text,
Text = buttonText,
TextScaled = true,
Font = Configs_HUB.Text_Font
})

sendButton.MouseButton1Click:Connect(function()
local value = tonumber(inputBox.Text)
if value then
if minValue then value = math.max(value, minValue) end
if maxValue then value = math.min(value, maxValue) end
inputBox.Text = tostring(value)
callback(value)
else
inputBox.Text = tostring(minValue or 1)
end
end)

return inputBox, sendButton
end

local framek = Create("Frame", ScreenGui, {
Size = UDim2.new(0.7, 0, 0.64, 0),
Position = UDim2.new(0.13, 0, 0.2, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
Visible = false
})

local mainText = Create("TextLabel", framek, {
Size = UDim2.new(1, 0, 0.15, 0),
BackgroundTransparency = 0.7,
Text = "Universal Viewer",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
TextSetColor(mainText)

Create("UIGradient", mainText, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})

local frameGame = Create("ScrollingFrame", framek, {
Size = UDim2.new(1, 0, 0.85, 0),
Position = UDim2.new(0, 0, 0.15, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
CanvasSize = UDim2.new(0, 0, 5, 0),
ScrollBarThickness = 0
})
Create("UIListLayout", frameGame, {
Padding = UDim.new(0, 1),
SortOrder = Enum.SortOrder.LayoutOrder,
})
Create("UIPadding", frameGame, {
PaddingLeft = UDim.new(0.028, 0),
PaddingTop = UDim.new(0.003, 0),
PaddingBottom = UDim.new(0.003, 0)
})

functions.UpdatePlaces = function()
local existing = {}
for _, child in ipairs(frameGame:GetChildren()) do
if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
existing[child.Name] = child
end
end
local desired = {}
desired["MainGameLabel"] = true
desired["Place_" .. tostring(gamePlaces[1].PlaceId)] = true
if #gamePlaces <= 1 then
desired["NoSplitLabel"] = true
else
desired["SplitGamesLabel"] = true
for i = 2, #gamePlaces do
desired["Place_" .. tostring(gamePlaces[i].PlaceId)] = true
end
end
for name, node in pairs(existing) do
if not desired[name] then
node:Destroy()
end
end
if not frameGame:FindFirstChild("MainGameLabel") then
local lbl = Create("TextLabel", frameGame, {
Name = "MainGameLabel",
Size = UDim2.new(0.96, 0, 0.02, 0),
BackgroundTransparency = 0.7,
Text = "MainGame",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
TextSetColor(lbl)
Create("UIGradient", lbl, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(0,   0,   0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 255, 255))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})
end
local mainPlace = gamePlaces[1]
local mainName  = "Place_" .. tostring(mainPlace.PlaceId)
if not frameGame:FindFirstChild(mainName) then
local fr = Create("Frame", frameGame, {
Name = mainName,
Size = UDim2.new(0.96, 0, 0.12, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub
})
Create("UIGradient", fr, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,   0,   0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,     0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})
Create("ImageLabel", fr, {
Size = UDim2.new(0.25, 0, 1, 0),
BackgroundTransparency = 1,
Position = UDim2.new(0, 0, 0, 0),
Image = "rbxthumb://type=Asset&id=" .. mainPlace.PlaceId .. "&w=420&h=420"
})
Create("TextLabel", fr, {
Size = UDim2.new(0.05, 0, 0.09, 0),
Position = UDim2.new(0.252, 0, 0, 0),
Text = "1",
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
Create("TextLabel", fr, {
Size = UDim2.new(0.748, 0, 0.23, 0),
Position = UDim2.new(0.252, 0, 0.16, 0),
Text = "Name: " .. mainPlace.Name,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
Create("TextLabel", fr, {
Size = UDim2.new(0.748, 0, 0.23, 0),
Position = UDim2.new(0.252, 0, 0.4, 0),
Text = "Id: " .. mainPlace.PlaceId,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
local tb = Create("TextButton", fr, {
Size = UDim2.new(1, 0, 0.17, 0),
Position = UDim2.new(0, 0, 0.83, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundTransparency = 0,
Text = "Play",
TextScaled = true
})
tb.MouseButton1Click:Connect(function()
TeleportService:Teleport(mainPlace.PlaceId, game.Players.LocalPlayer)
end)
Create("UIGradient", tb, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,   0,   0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,     0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})
end
if #gamePlaces <= 1 then
if not frameGame:FindFirstChild("NoSplitLabel") then
local lbl2 = Create("TextLabel", frameGame, {
Name = "NoSplitLabel",
Size = UDim2.new(0.96, 0, 0.02, 0),
BackgroundTransparency = 0.7,
Text = "This game does not have a split game",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
TextSetColor(lbl2)
Create("UIGradient", lbl2, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,     0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})
end
else
if not frameGame:FindFirstChild("SplitGamesLabel") then
local lbl3 = Create("TextLabel", frameGame, {
Name = "SplitGamesLabel",
Size = UDim2.new(0.96, 0, 0.02, 0),
BackgroundTransparency = 0,
Text = "Splitgame",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})

TextSetColor(lbl3)
Create("UIGradient", lbl3, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,     0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 90
})
end
for i = 2, #gamePlaces do
local place = gamePlaces[i]
local name  = "Place_" .. tostring(place.PlaceId)
if not frameGame:FindFirstChild(name) then
local fr2 = Create("Frame", frameGame, {
Name = name,
Size = UDim2.new(0.96, 0, 0.12, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub
})
Create("UIGradient", fr2, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   0,   0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,   0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = 40
})
Create("ImageLabel", fr2, {
Size = UDim2.new(0.25, 0, 1, 0),
Position = UDim2.new(0, 0, 0, 0),
BackgroundTransparency = 1,
Image = "rbxthumb://type=Asset&id=" .. place.PlaceId .. "&w=420&h=420"
})
Create("TextLabel", fr2, {
Size = UDim2.new(0.05, 0, 0.09, 0),
Position = UDim2.new(0.252, 0, 0, 0),
Text = tostring(i),
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
Create("TextLabel", fr2, {
Size = UDim2.new(0.748, 0, 0.23, 0),
Position = UDim2.new(0.252, 0, 0.16, 0),
Text = "Name: " .. place.Name,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
Create("TextLabel", fr2, {
Size = UDim2.new(0.748, 0, 0.23, 0),
Position = UDim2.new(0.252, 0, 0.4, 0),
Text = "Id: " .. place.PlaceId,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
Font = Configs_HUB.Text_Font,
TextScaled = true
})
local tb2 = Create("TextButton", fr2, {
Size = UDim2.new(1, 0, 0.17, 0),
Position = UDim2.new(0, 0, 0.83, 0),
BackgroundTransparency = 0,
BackgroundColor3 = Configs_HUB.Cor_Hub,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
Text = "Play",
TextScaled = true
})
tb2.MouseButton1Click:Connect(function()
TeleportService:Teleport(place.PlaceId, game.Players.LocalPlayer)
end)
Create("UIGradient", tb2, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,   0,   0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,     0,   0))
},
Transparency = NumberSequence.new{
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 0)
},
Rotation = -60
})
end
end
end
end

functions.UpdatePlaces()

local SplitgameToggleButton = Create("ImageButton", frame, {
Size = UDim2.new(0.06, 0, 0.6, 0),
Position = UDim2.new(0.22 + 0.2, 0, 0.22, 0),
BackgroundColor3 = Color3.fromRGB(204, 255, 204),
ZIndex = 10,
BackgroundTransparency = 1,
Image = "rbxthumb://type=Asset&id=82825316875765&w=150&h=150"
})

local framep = Create("Frame", ScreenGui, {
Size = UDim2.new(0.6, 0, 0.64, 0),
Position = UDim2.new(0.2, 0, 0.2, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.8,
Visible = false
})Corner(framep)Stroke(framep)

local frametext = Create("TextLabel", framep, {
Size = UDim2.new(1, 0, 0.08, 0),
Position = UDim2.new(0, 0, 0, 0),
Text = "Players in Server "..string.format("%d/%d", #game.Players:GetPlayers(), game.Players.MaxPlayers),
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true
})

local linep = Create("Frame", framep, {
Size = UDim2.new(1, 0, 0.005, 0),
Position = UDim2.new(0, 0, 0.07, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0
})

local ScrollBarPlayers = Create("ScrollingFrame", framep, {
Size = UDim2.new(1, 0, 0.82, 0),
Position = UDim2.new(0, 0, 0.08, 0),
CanvasSize = UDim2.new(0, 0, 0, 0),
ScrollingDirection = Enum.ScrollingDirection.Y,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
ScrollBarThickness = 0
})local listLayoutScrollBar = Create("UIListLayout", ScrollBarPlayers, {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder,
})Create("UIPadding", ScrollBarPlayers, {
PaddingLeft = UDim.new(0.028, 0),
PaddingTop = UDim.new(0.003, 0),
PaddingBottom = UDim.new(0.003, 0)
})

local unviewallplayerbutton = Create("ImageButton", framep, {
Size = UDim2.new(0.07, 0, 0.1, 0),
Position = UDim2.new(0.93, 0, 0.9, 0),
BackgroundColor3 = Configs_HUB.Cor_Options,
BackgroundTransparency = 1,
Image = "rbxassetid://137903829820448"
})

unviewallplayerbutton.MouseButton1Click:Connect(function()
local localChar = game:GetService("Players").LocalPlayer.Character
if localChar then
local hum = localChar:WaitForChild("Humanoid")
if hum then
workspace.CurrentCamera.CameraSubject = hum
end
end
for _, data in pairs(playerFrames) do
if data.UI then
local viewButton = data.UI:FindFirstChildOfClass("ImageButton")
if viewButton then
viewButton.Image = "rbxassetid://96859795672738"
end
end
end
View = nil
end)

functions.UpdatePlayerList = function()
local _ps = game:GetService("Players")
local _lp = _ps.LocalPlayer
local _plrs = _ps:GetPlayers()
frametext.Text = "Players in Server " .. string.format("%d/%d", #_plrs, _ps.MaxPlayers)
local _ids = {}
for _, _p in ipairs(_plrs) do
_ids[_p.UserId] = true
local _isF = false
if _p ~= _lp then
local success, isFriend = pcall(function()
return _p:IsFriendsWith(_lp.UserId)
end)
if success and isFriend then
_isF = true
end
end
if not playerFrames[_p.UserId] then
local _f = Create("Frame", ScrollBarPlayers, {
Size = UDim2.new(0.95, 0, 0.18, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1
})
Corner(_f)
Stroke(_f)
local _lbl = Create("TextLabel", _f, {
Size = UDim2.new(0.81, 0, 0.5, 0),
Position = UDim2.new(0.089, 0, 0, 0),
Text = _p.DisplayName,
TextXAlignment = "Left",
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextScaled = true,
Name = "DisplayName"
})
local _info = "@" .. _p.Name
if _isF then
_info = _info .. " • Your Friend"
end
local _il = Create("TextLabel", _f, {
Size = UDim2.new(0.81, 0, 0.5, 0),
Position = UDim2.new(0.089, 0, 0.5, 0),
Text = _info,
TextXAlignment = "Left",
BackgroundTransparency = 1,
TextColor3 = Color3.fromRGB(114, 117, 130),
Font = Configs_HUB.Text_Font,
TextScaled = true,
Name = "Info"
})
local _avt = Create("ImageLabel", _f, {
Size = UDim2.new(0.078, 0, 0.95, 0),
Position = UDim2.new(0.005, 0, 0.015, 0),
BackgroundTransparency = 1,
Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId=" .. _p.UserId
})
Corner(_avt, {CornerRadius = UDim.new(1, 0)})
Stroke(_avt, {Color = Color3.fromRGB(255, 255, 255)})
if _p ~= _lp then
local _btn = Create("ImageButton", _f, {
Size = UDim2.new(0.09, 0, 0.95, 0),
Position = UDim2.new(0.905, 0, 0.025, 0),
BackgroundColor3 = Configs_HUB.Cor_Options,
BackgroundTransparency = 1,
Image = "rbxassetid://96859795672738"
})
_btn.MouseButton1Click:Connect(function()
if View and View.button == _btn then
_btn.Image = "rbxassetid://96859795672738"
View = nil
else
if View and View.button then
View.button.Image = "rbxassetid://96859795672738"
end
if _p and _p.Parent then
View = {
player = _p,
button = _btn
}
_btn.Image = "rbxassetid://137903829820448"
else
View = nil
_btn.Image = "rbxassetid://96859795672738"
end
end
end)
end
playerFrames[_p.UserId] = {
UI = _f,
DisplayName = _p.DisplayName,
Username = _p.Name
}
else
if playerFrames[_p.UserId].DisplayName ~= _p.DisplayName then
local _lbl = playerFrames[_p.UserId].UI:FindFirstChild("DisplayName")
if _lbl then
_lbl.Text = _p.DisplayName
end
playerFrames[_p.UserId].DisplayName = _p.DisplayName
end
if playerFrames[_p.UserId].Username ~= _p.Name then
local _il = playerFrames[_p.UserId].UI:FindFirstChild("Info")
if _il then
local _info = "@" .. _p.Name
if _isF then
_info = _info .. " • Your Friend"
end
_il.Text = _info
end
playerFrames[_p.UserId].Username = _p.Name
end
end
end
for _id, _data in pairs(playerFrames) do
if not _ids[_id] then
if _data.UI and _data.UI.Parent then
_data.UI:Destroy()
end
playerFrames[_id] = nil
if View and View.player and View.player.UserId == _id then
local _char = _lp.Character
if _char then
local _hum = _char:FindFirstChild("Humanoid")
if _hum then
workspace.CurrentCamera.CameraSubject = _hum
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
end
end
View = nil
end
end
end
if View and (not View.player or not View.player.Parent) then
View = nil
end
end

functions.UpdatePlayerList()

local PlayerListToggleButton = Create("ImageButton", frame, {
Size = UDim2.new(0.06, 0, 0.6, 0),
Position = UDim2.new(0.22 + 0.3, 0, 0.22, 0),
BackgroundColor3 = Color3.fromRGB(204, 255, 204),
ZIndex = 10,
BackgroundTransparency = 1,
Image = "rbxthumb://type=Asset&id=140380840270815&w=150&h=150"
})

local success, result = pcall(function()
return MarketplaceService:GetProductInfo(PlaceId)
end)

local Asset = MarketplaceService:GetProductInfo(PlaceId)
local gameName = success and result.Name or Asset.Name or "Unknown"

local frameinfogui = Create("Frame", ScreenGui, {
Size = UDim2.new(),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
Visible = false
})

local blur = Create("Frame", frameinfogui, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(17, 17, 17),
BackgroundTransparency = 0,
Visible = false
})

local frameinfo = Create("Frame", frameinfogui, {
Size = UDim2.new(0.27, 0, 0.21, 0),
Position = UDim2.new(0.04, 0, 0.24, 0),
AnchorPoint = Vector2.new(0.04, 0.21),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 0.5,
})
Corner(frameinfo, {CornerRadius = UDim.new(0.15, 0)})
local stroke_1 = Create("UIStroke", frameinfo, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_1 = Create("UIGradient", stroke_1, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
},
Rotation = 0
})

local iconplayers = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.06, 0, 0.124, 0),
Position = UDim2.new(0.05, 0, 0.06, 0),
AnchorPoint = Vector2.new(0.05, 0.06),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
})
Corner(iconplayers, {CornerRadius = UDim.new(1, 0)})
local stroke_2 = Create("UIStroke", iconplayers, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_2 = Create("UIGradient", stroke_2, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

local Wellcome = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.25, 0, 0.09, 0),
Text = "Welcome "..game.Players.LocalPlayer.Name,
Position = UDim2.new(0.14, 0, 0.077, 0),
AnchorPoint = Vector2.new(0.11, 0.085),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true
})
TextSetColor(Wellcome)

local AvaterToHead = Create("ImageButton", frameinfogui, {
Size = UDim2.new(0.036, 0, 0.07, 0),
Position = UDim2.new(0.37, 0, 0.0765, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
Image = "rbxthumb://type=Asset&id=93917932838439&w=150&h=150"
})
local stroke_2_1 = Create("UIStroke", AvaterToHead, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_2_1 = Create("UIGradient", stroke_2_1, {
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 0, 0))
}),
Rotation = 0
})

AvaterToHead.MouseButton1Click:Connect(function()
Avatar = not Avatar
end)

local gameinfoframe = Create("Frame", frameinfogui, {
Size = UDim2.new(0.27, 0, 0.3, 0),
Position = UDim2.new(0.032, 0, 0.74, 0),
AnchorPoint = Vector2.new(0.032, 0.51),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5
})
Corner(gameinfoframe, {CornerRadius = UDim.new(0.08, 0)})
local stroke_3 = Create("UIStroke", gameinfoframe, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_3 = Create("UIGradient", stroke_3, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
},
Rotation = 0
})

local iconGamecreator = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.05, 0, 0.104, 0),
Position = UDim2.new(0.315, 0, 0.162, 0),
AnchorPoint = Vector2.new(0.05, 0.06),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
Image = ""
})
Corner(iconGamecreator, {CornerRadius = UDim.new(1, 0)})
local stroke_4 = Create("UIStroke", iconGamecreator, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_4 = Create("UIGradient", stroke_4, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

local iconAvaterGamecreator = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.05, 0, 0.104, 0),
Position = UDim2.new(0.315, 0, 0.162, 0),
AnchorPoint = Vector2.new(0.05, 0.06),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
Image = "",
Visible = false
})
Corner(iconAvaterGamecreator, {CornerRadius = UDim.new(1, 0)})
local stroke_4_1 = Create("UIStroke", iconAvaterGamecreator, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_4_1 = Create("UIGradient", stroke_4_1, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

local icongroupicon = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.05, 0, 0.104, 0),
Position = UDim2.new(0.315, 0, 0.278, 0),
AnchorPoint = Vector2.new(0.05, 0.06),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
Image = ""
})

local grouptext = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.18, 0, 0.065, 0),
Text = "Name_Group: ",
Position = UDim2.new(0.39, 0, 0.3, 0),
AnchorPoint = Vector2.new(0.11, 0.085),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true
})TextSetColor(grouptext)

local Gamecreatortext = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.18, 0, 0.065, 0),
Text = "Creator_Game",
Position = UDim2.new(0.39, 0, 0.18, 0),
AnchorPoint = Vector2.new(0.11, 0.085),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true
})TextSetColor(Gamecreatortext)

local framecreatorinfo = Create("Frame", frameinfogui, {
Size = UDim2.new(0.23, 0, 0.19, 0),
Position = UDim2.new(0.31, 0, 0.45, 0),
AnchorPoint = Vector2.new(0.04, 0.21),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 0.5,
})
Corner(framecreatorinfo, {CornerRadius = UDim.new(0.15, 0)})
local stroke_5 = Create("UIStroke", framecreatorinfo, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_5 = Create("UIGradient", stroke_5, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
},
Rotation = 0
})

local iconGame = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.06, 0, 0.124, 0),
Position = UDim2.new(0.01, 0, 0.47, 0),
AnchorPoint = Vector2.new(0.04, 0.38),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
Image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="..result.IconImageAssetId.."&fmt=png&wd=500&ht=500"
})

local GameName = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.215, 0, 0.08, 0),
Text = "Game Name: " .. gameName,
Position = UDim2.new(0.1, 0, 0.48, 0),
AnchorPoint = Vector2.new(0.11, 0.405),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true,
})TextSetColor(GameName)

local welcometext = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.18, 0, 0.065, 0),
Text = "Hope you Enjoy The My Script",
Position = UDim2.new(0.39, 0, 0.66, 0),
AnchorPoint = Vector2.new(0.11, 0.085),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true
})TextSetColor(welcometext)

local frame100 = Create("Frame", frameinfogui, {
Size = UDim2.new(0.41, 0, 0.48, 0),
Position = UDim2.new(0.6178 + 0.11, 0, 0.22, 0),
AnchorPoint = Vector2.new(0.4178, 0.14),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})Corner(frame100)Stroke(frame100)

local FriendList = Create("TextLabel", frame100, {
Size = UDim2.new(1, 0, 0.13, 0),
Position = UDim2.new(0, 0, 0.001, 0),
Text = "Friend List",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5
})TextSetColor(FriendList)

local linef = Create("Frame", frame100, {
Size = UDim2.new(1, 0, 0.003, 0),
Position = UDim2.new(0, 0, 0.13, 0),
BackgroundColor3 = Configs_HUB.Cor_Stroke,
BorderSizePixel = 0
})

local friendsFrame1 = Create("ScrollingFrame", frame100, {
Size = UDim2.new(1, 0, 0.87, 0),
Position = UDim2.new(0, 0, 0.13, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5
})local friendsFrame1listLayout = Create("UIListLayout", friendsFrame1, {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder
})local friendsFrame1uiPadding = Create("UIPadding", friendsFrame1, {
PaddingLeft = UDim.new(0.028, 0),
PaddingTop = UDim.new(0.003, 0),
PaddingBottom = UDim.new(0.003, 0)
})

local iconfriend = Create("ImageLabel", frameinfogui, {
Size = UDim2.new(0.06, 0, 0.124, 0),
Position = UDim2.new(0.48 + 0.11, 0, 0.006, 0),
AnchorPoint = Vector2.new(0.43, 0.006),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.4,
Image = "rbxthumb://type=Asset&id=98919122646377&w=420&h=420",
})
Corner(iconfriend, {CornerRadius = UDim.new(1, 0)})
local stroke_6 = Create("UIStroke", iconfriend, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_6 = Create("UIGradient", stroke_6, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

local friendnumber = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.28, 0, 0.09, 0),
Text = "Friend: 0/1000",
Position = UDim2.new(0.67 + 0.11, 0, 0.03, 0),
AnchorPoint = Vector2.new(0.49, 0.029),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextScaled = true
})
TextSetColor(friendnumber)

functions.checkFriends = function()
if friendsCooldown <= 0 then
friendsCooldown = 5
local playersFriends = {}
local page = players:GetFriendsAsync(localPlayer.UserId)
repeat
local info = page:GetCurrentPage()
for _, friendInfo in pairs(info) do
table.insert(playersFriends, friendInfo)
end
if not page.IsFinished then
page:AdvanceToNextPageAsync()
end
until page.IsFinished
local friendsInTotal = #playersFriends
functions.updateFriendsGUI = function(friends)
local existingIds = {}
for _, friend in ipairs(friends) do
existingIds[friend.Id] = true
if not displayedFriends[friend.Id] then
local frame = Create("Frame", friendsFrame1, {
Size = UDim2.new(0.95, 0, 0.18, 0),
BackgroundTransparency = 1,
Name = tostring(friend.Id)
})
Corner(frame)
Stroke(frame)
Create("ImageLabel", frame, {
Size = UDim2.new(0.078, 0, 0.95, 0),
Position = UDim2.new(0.005, 0, 0.015, 0),
BackgroundTransparency = 1,
Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..friend.Id
})
local friendDisplayName = Create("TextLabel", frame, {
Size = UDim2.new(0.81, 0, 0.5, 0),
Position = UDim2.new(0.089, 0, 0),
Text = friend.DisplayName,
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
TextXAlignment = "Left",
TextScaled = true
})
local friendUsername = Create("TextLabel", frame, {
Size = UDim2.new(0.81, 0, 0.5, 0),
Position = UDim2.new(0.089, 0, 0.5, 0),
Text = "@" .. friend.Username,
BackgroundTransparency = 1,
TextColor3 = Color3.fromRGB(114, 117, 130),
Font = Configs_HUB.Text_Font,
TextXAlignment = "Left",
TextScaled = true
})
displayedFriends[friend.Id] = frame
end
end
for friendId, frame in pairs(displayedFriends) do
if not existingIds[tonumber(friendId)] then
frame:Destroy()
displayedFriends[friendId] = nil
end
end
end
functions.updateFriendsGUI(playersFriends)
friendnumber.Text = "Friend: " .. friendsInTotal .. "/1000"
else
friendsCooldown = friendsCooldown - 1
end
end

coroutine.wrap(functions.checkFriends)

local TimePlay = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.205, 0, 0.07, 0),
Text = "TimePlay",
Position = UDim2.new(0.5294 + 0.11, 0, 0.681, 0),
AnchorPoint = Vector2.new(0.41, 0.623),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
TextScaled = true
})
TextSetColor(TimePlay)
Corner(TimePlay, {CornerRadius = UDim.new(0.15, 0)})

local AccountAge = Create("TextLabel", frameinfogui, {
Size = UDim2.new(0.205, 0, 0.07, 0),
Text = "AccountAge",
Position = UDim2.new(0.7781 + 0.11, 0, 0.681, 0),
AnchorPoint = Vector2.new(0.62, 0.623),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
TextScaled = true
})
TextSetColor(AccountAge)
Corner(AccountAge, {CornerRadius = UDim.new(0.15, 0)})

local Join = Create("TextButton", frameinfogui, {
Size = UDim2.new(0.101, 0, 0.07, 0),
Text = "Join Game Script\nYou can press Copy",
Position = UDim2.new(0.4868 + 0.11, 0, 0.762, 0),
AnchorPoint = Vector2.new(0.41, 0.699),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
TextScaled = true
})
TextSetColor(Join)
Corner(Join, {CornerRadius = UDim.new(0.15, 0)})

local Position = Create("TextButton", frameinfogui, {
Size = UDim2.new(0.101, 0, 0.07, 0),
Text = "Position\nYou can press Copy",
Position = UDim2.new(0.6026 + 0.11, 0, 0.762, 0),
AnchorPoint = Vector2.new(0.528, 0.699),
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = "Left",
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
TextScaled = true
})
TextSetColor(Position)
Corner(Position, {CornerRadius = UDim.new(0.15, 0)})

Position.MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
local position = player.Character.HumanoidRootPart.Position

local positionString = string.format("Vector3.new(%f, %f, %f)", position.X, position.Y, position.Z)
local teleportCode = [[
-- Dragon: You can take it, paste it into your Executor and press execute. And it will teleport you to where you originally pressed Copy
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(]] .. positionString .. [[)
]]
setclipboard(teleportCode)
end)
Join.MouseButton1Click:Connect(function()
local teleportCode = [[
-- Dragon: This script will take you to the game"]]..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name..[["
--If it doesn't work then the script isn't working
game:GetService("TeleportService"):Teleport(]] .. game.PlaceId .. [[, player)
]]
setclipboard(teleportCode)
end)

local frame23 = Create("Frame", frame100, {Size = UDim2.new(1, 0, 0.11, 0), Position = UDim2.new(0, 0, 0.001, 0), BackgroundColor3 = Configs_HUB.Cor_Hub, BackgroundTransparency = 1})

local frame9 = Create("TextLabel", frameinfo, {Size = UDim2.new(1, 0, 1, 0), Text = "hi", BackgroundColor3 = Configs_HUB.Cor_Hub, BackgroundTransparency = 1, Font = Configs_HUB.Text_Font, TextColor3 = Configs_HUB.Cor_Text, TextXAlignment = Enum.TextXAlignment.Left, TextScaled = true})
TextSetColor(frame9)

local frame199 = Create("TextLabel", framecreatorinfo, {Size = UDim2.new(1, 0, 1, 0), Text = "hi", BackgroundColor3 = Configs_HUB.Cor_Hub, BackgroundTransparency = 1, Font = Configs_HUB.Text_Font, TextColor3 = Configs_HUB.Cor_Text, TextXAlignment = Enum.TextXAlignment.Left, TextScaled = true})
TextSetColor(frame199)

local frame79 = Create("TextLabel", gameinfoframe, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(20, 20, 20),
BackgroundTransparency = 1,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
Font = Configs_HUB.Text_Font,
TextScaled = true,
Text = "Fetching data..."
})
Corner(frame79, {CornerRadius = UDim.new(0.08, 0)})
TextSetColor(frame79)

local listLayout1 = Create("UIListLayout", frame79, {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 5)})
local listLayout2 = Create("UIListLayout", frame9, {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 6)})
local listLayout3 = Create("UIListLayout", frame199, {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 6)})

local frameswitchpage = Create("Frame", frameinfogui, {
Size = UDim2.new(0.14, 0, 0.08, 0),
Position = UDim2.new(0.32, 0, 0.8, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5
})Corner(frameswitchpage, {CornerRadius = UDim.new(0.15, 0)})local stroke_6_1 = Create("UIStroke", frameswitchpage, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_6_1 = Create("UIGradient", stroke_6_1, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 0, 255)),
ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

local switchpage = Create("TextButton", frameswitchpage, {
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
Font = Configs_HUB.Text_Font,
TextColor3 = Configs_HUB.Cor_Text,
TextScaled = true,
Text = "Switch To Page 2",
})TextSetColor(switchpage)Corner(switchpage, {CornerRadius = UDim.new(0.15, 0)})
local stroke_6_2 = Create("UIStroke", switchpage, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_6_2 = Create("UIGradient", stroke_6_2, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 0, 255)),
ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
},
Rotation = 0
})

switchpage.MouseButton1Click:Connect(function()
if not waitswitchpage then
waitswitchpage = true
switchtodescription = not switchtodescription
wait(1.1)
waitswitchpage = false
end
end)

local description = Create("Frame", frameinfogui, {
Size = UDim2.new(0.45, 0, 0.6, 0),
Position = UDim2.new(0.02, 0, 0.37 - 1, 0),
AnchorPoint = Vector2.new(0.032, 0.51),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 0.5,
Visible = false
})Corner(description)Stroke(description)

local info_d = Create("Frame", frameinfogui, {
Size = UDim2.new(0.24, 0, 0.75, 0),
Position = UDim2.new(0.48, 0, 0.24 - 1, 0),
AnchorPoint = Vector2.new(0.04, 0.21),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 0.5,
})Corner(info_d, {CornerRadius = UDim.new(0.05, 0)})
local stroke_7 = Create("UIStroke", info_d, {
Color = Color3.fromRGB(255, 255, 255),
Thickness = 1,
Transparency = 0.1,
})

local gradient_7 = Create("UIGradient", stroke_7, {
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
},
Rotation = 0
})

local info_T = Create("TextLabel", info_d, {
Size = UDim2.new(1, 0, 0.93, 0),
Position = UDim2.new(0, 0, 0.07, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
Font = Configs_HUB.Text_Font,
TextColor3 = Configs_HUB.Cor_Text,
TextXAlignment = Enum.TextXAlignment.Left,
TextScaled = true,
Text = "Finding info..."
})TextSetColor(info_T)Corner(info_T, {CornerRadius = UDim.new(0.05, 0)})
local listLayout4 = Create("UIListLayout", info_T, {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 5)})

local info_TC = Create("TextLabel", info_d, {
Size = UDim2.new(1, 0, 0.93, 0),
Position = UDim2.new(0, 0, 0.07, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
Font = Configs_HUB.Text_Font,
TextColor3 = Configs_HUB.Cor_Text,
TextScaled = true,
Text = "If you don't want it shown, just turn it off",
TextTransparency = 1,
Visible = false
})TextSetColor(info_TC)Corner(info_TC, {CornerRadius = UDim.new(0.05, 0)})

local info_C = Create("TextButton", info_d, {
Size = UDim2.new(0.1, 0, 0.065, 0),
Position = UDim2.new(0.89, 0, 0.005, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
Font = Configs_HUB.Text_Font,
TextColor3 = Configs_HUB.Cor_Text,
TextScaled = true,
Text = "-"
})

local show, isBusy = true, false

info_C.MouseButton1Click:Connect(function()
if isBusy then return end
isBusy = true
if show then
local c1 = TweenService:Create(info_T, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
TextTransparency = 1
})
c1:Play()
c1.Completed:Wait()
info_T.Visible = false
info_TC.Visible = true
local c_1 = TweenService:Create(info_TC, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
TextTransparency = 0
})
c_1:Play()
info_C.Text = "×"
else
local c2 = TweenService:Create(info_TC, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
TextTransparency = 1
})
c2:Play()
c2.Completed:Wait()
info_TC.Visible = false
info_T.Visible = true
local c_2 = TweenService:Create(info_T, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
TextTransparency = 0
})
c_2:Play()
info_C.Text = "-"
end
show = not show
isBusy = false
end)

local Textdescpn = Create("TextLabel", description, {
Size = UDim2.new(1, 0, 0.1, 0),
Position = UDim2.new(0, 0, 0, 0),
Text = "Menu Description",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})TextSetColor(Textdescpn)

local lined = Create("Frame", description, {
Size = UDim2.new(1, 0, 0.005, 0),
Position = UDim2.new(0, 0, 0.1, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0
})

local descriptionframe = Create("ScrollingFrame", description, {
Size = UDim2.new(0.87, 0, 0.87, 0),
Position = UDim2.new(0.07, 0, 0.115, 0),
AutomaticCanvasSize = Enum.AutomaticSize.X,
ScrollingDirection = Enum.ScrollingDirection.X,
ScrollBarThickness = 0,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})local descriptionframelistLayout = Create("UIListLayout", descriptionframe, {
Padding = UDim.new(0, 5),
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder
})

local info_group = Create("Frame", frameinfogui, {
Size = UDim2.new(0.28, 0, 0.37, 0),
Position = UDim2.new(0.725, 0, 0.2 - 1, 0),
AnchorPoint = Vector2.new(0.04, 0.21),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 0.5,
Visible = false
})Corner(info_group)Stroke(info_group)

local info_group_T = Create("TextLabel", info_group, {
Size = UDim2.new(1, 0, 0.1, 0),
Position = UDim2.new(0, 0, 0, 0),
Text = "List All Groups that you joiner",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})TextSetColor(info_group_T)

local line_g = Create("Frame", info_group, {
Size = UDim2.new(1, 0, 0.005, 0),
Position = UDim2.new(0, 0, 0.1, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0
})

local List_group = Create("ScrollingFrame", info_group, {
Size = UDim2.new(1, 0, 0.89, 0),
Position = UDim2.new(0, 0, 0.11, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})local List_grouplistLayout = Create("UIListLayout", List_group, {
Padding = UDim.new(0, 5),
FillDirection = Enum.FillDirection.Vertical,
SortOrder = Enum.SortOrder.LayoutOrder
})

functions.UpdateDescription = function(params)
local c_1 = params.fromFrame
local c_2 = params.Text
local c_3 = params.description
local c_4 = params.image
local c_5 = params.textwrapped or false
local c_6 = params.textscaled or false
local c_7 = params.size or 8
local c_8 = frameRefs[c_1]
local c_9 = metaRefs[c_1]
if c_9 and c_9.Text == c_2 and c_9.Description == c_3 and c_9.Image == c_4 then
return
end
if c_8 and c_8.Parent then
c_8:Destroy()
end
local c_10 = Create("Frame", descriptionframe, {
Size = UDim2.new(0.8, 0, 0.4, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 0.5
})
local c_11 = Create("TextLabel", c_10, {
Size = UDim2.new(0.88, 0, 0.1, 0),
Position = UDim2.new(0.12, 0, 0.03, 0),
Text = c_2 or "",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1
})TextSetColor(c_11)
local c_12 = Create("TextLabel", c_10, {
Size = UDim2.new(1, 0, 0.84, 0),
Position = UDim2.new(0, 0, 0.16, 0),
Text = c_3 or "",
TextColor3 = Configs_HUB.Cor_Text,
Font = Configs_HUB.Text_Font,
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
TextWrapped = c_5,
TextScaled = c_6,
TextSize = c_7,
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top
})TextSetColor(c_12)
Create("Frame", c_10, {
Size = UDim2.new(1, 0, 0.005, 0),
Position = UDim2.new(0, 0, 0.16, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0
})
Create("ImageLabel", c_10, {
Size = UDim2.new(0.11, 0, 0.16, 0),
Position = UDim2.new(0, 0, 0, 0),
AnchorPoint = Vector2.new(0.05, 0.06),
BackgroundColor3 = Configs_HUB.Cor_Hub,
BackgroundTransparency = 1,
Image = c_4 or ""
})
frameRefs[c_1] = c_10
metaRefs[c_1] = {
Text = c_2,
Description = c_3,
Image = c_4
}
end

functions.getplayerdescription = function(userId)
local zx_Desc = ddesug[userId]
local desc = ""
local success, response = pcall(function()
return game:HttpGet("https://users.roblox.com/v1/users/" .. userId)
end)
if success then
local data = HttpService:JSONDecode(response)
desc = data.description or ""
if desc == "" then
if userId == game.Players.LocalPlayer.UserId then
desc = "No description set for your account."
else
desc = "User has no description."
end
end
if zx_Desc == desc then
return zx_Desc
else
ddesug[userId] = desc
return desc
end
else
return zx_Desc or "Failed to load description"
end
end

functions.getGameDesc = function(_id)
local cachedDesc = _XyZ[_id]
local success, productInfo = pcall(function()
return game:GetService("MarketplaceService"):GetProductInfo(_id)
end)
if success and productInfo then
local desc = productInfo.Description or "This game has no description"
if cachedDesc == desc then
return cachedDesc
else
_XyZ[_id] = desc
return desc
end
else
return cachedDesc or "Failed to load game description"
end
end

functions.startUpdating = function()
functions.__ = (functions.__ or 0) + 1
local _a = game:GetService("Players").LocalPlayer.AccountAge
local _b = _a * 86400 + functions.__
local _c = math.floor(_b / 31536000)
_b = _b % 31536000
local _d = math.floor(_b / 2592000)
_b = _b % 2592000
local _e = math.floor(_b / 86400)
local _f = string.format("%d years, %d months, %d days", _c, _d, _e)
local _g = _a == 0 and "You just created an account"
or string.format("Your account has been active for %d days", _a)
AccountAge.Text = "Total Playtime since account creation: " .. _f .. "\n" .. _g
end

functions.startUpdating()

local jt = os.time()

functions.updatePlaytime = function()
local now = os.time()
local pt = now - jt
local m = 60
local h = 3600
local d = 86400
local mo = 2592000
local y = 31536000
local ft = ""
if pt < m then
ft = string.format("%02d", pt)
elseif pt < h then
ft = string.format("%d:%02d", math.floor(pt / m), pt % m)
elseif pt < d then
ft = string.format("%d:%02d:%02d", math.floor(pt / h), math.floor((pt % h) / m), pt % m)
elseif pt < mo then
ft = string.format("%d:%02d:%02d:%02d", math.floor(pt / d), math.floor((pt % d) / h), math.floor((pt % h) / m), pt % m)
elseif pt < y then
ft = string.format("%d:%02d:%02d:%02d:%02d", math.floor(pt / mo), math.floor((pt % mo) / d), math.floor((pt % d) / h), math.floor((pt % h) / m), pt % m)
else
ft = string.format("%d:%02d:%02d:%02d:%02d:%02d", math.floor(pt / y), math.floor((pt % y) / mo), math.floor((pt % mo) / d), math.floor((pt % d) / h), math.floor((pt % h) / m), pt % m)
end
TimePlay.Text = "Time Play: " .. ft .. "\nThis shows how long you've been playing"
end

functions.updatePlaytime()

functions.getAccountCreationDate = function(ageInDays)
local age = os.date("*t", os.time() - (ageInDays * 86400))
return string.format("%02d/%02d/%d", age.month, age.day, age.year)
end

local thaiDays = {
"อาทิตย์", "จันทร์", "อังคาร", "พุธ", "พฤหัสบดี", "ศุกร์", "เสาร์"
}local thaiMonths = {
"มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน",
"กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"
}functions.updateTime = function()
local currentTime = os.date("*t")
local hour = currentTime.hour
local min = currentTime.min
local sec = currentTime.sec
local formattedTime, formattedDate

if TimeThai then
local displayHour, period, position

if hour == 0 then
displayHour = 12
period = "เที่ยงคืน"
position = "front"
elseif hour >= 1 and hour <= 5 then
displayHour = hour
period = "ตี"
position = "front"
elseif hour == 6 then
displayHour = 6
period = "โมงเช้า"
position = "back"
elseif hour >= 7 and hour <= 10 then
displayHour = hour
period = "โมงเช้า"
position = "back"
elseif hour == 11 then
displayHour = 11
period = "โมง"
position = "back"
elseif hour == 12 then
displayHour = 12
period = "เที่ยง"
position = "front"
elseif hour >= 13 and hour <= 15 then
displayHour = hour - 12
period = "บ่าย"
position = "front"
elseif hour >= 16 and hour <= 18 then
displayHour = hour - 12
period = "โมงเย็น"
position = "back"
elseif hour >= 19 and hour <= 23 then
displayHour = hour - 18
period = "ทุ่ม"
position = "back"
end
if position == "front" then
formattedTime = string.format("%s %d:%02d:%02d", period, displayHour, min, sec)
elseif position == "back" then
formattedTime = string.format("%d:%02d:%02d %s", displayHour, min, sec, period)
else
formattedTime = string.format("%d:%02d:%02d", displayHour, min, sec)
end
local thaiDay = thaiDays[currentTime.wday] or ""
local thaiMonth = thaiMonths[currentTime.month]
local buddhistYear = currentTime.year + 543
formattedDate = string.format("วัน%sที่%d เดือน %s ปี %d", thaiDay, currentTime.day, thaiMonth, buddhistYear)
else
local amPm = "AM"
local displayHour = hour
if hour >= 12 then
amPm = "PM"
if hour > 12 then
displayHour = hour - 12
end
elseif hour == 0 then
displayHour = 12
end
formattedTime = string.format("%02d:%02d:%02d %s", displayHour, min, sec, amPm)
formattedDate = os.date("%b:%d:%Y")
end
TimeLabelgui.Text = formattedTime .. "\n" .. formattedDate
end

functions.updateTime()

local infoToggleButton = Create("ImageButton", frame, {
Size = UDim2.new(0.06, 0, 0.6, 0),
Position = UDim2.new(0.22 + 0.1, 0, 0.22, 0),
BackgroundColor3 = Color3.fromRGB(4, 175, 236),
ZIndex = 10,
BackgroundTransparency = 1,
Image = "rbxthumb://type=Asset&id=101525904089827&w=150&h=150",
})

local Button = Create("ImageButton", frame, {
Size = UDim2.new(0.06, 0, 0.6, 0),
ZIndex = 10,
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
Position = UDim2.new(0.22, 0, 0.22, 0),
Image = image
})

if corner then Corner(Button) end
if stroke then Stroke(Button, {Color = strokecolor}) end

local frameSetting = Create("Frame", ScreenGui, {
Size = UDim2.new(0.35, 0, 0.8, 0),
Position = UDim2.new(0.5, 0, 0.4, 0),
AnchorPoint = Vector2.new(0.52, 0.4),
BackgroundColor3 = Configs_HUB.Cor_Hub,
Visible = false
})

