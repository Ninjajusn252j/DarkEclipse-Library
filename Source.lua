local UI = {}
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

UI.Config = {
    Font = Enum.Font.SourceSans,
    FontSize = 16,
    TextColor = Color3.new(1, 1, 1),
    BackgroundColor = Color3.new(0.15, 0.15, 0.15),
    ButtonColor = Color3.new(0.25, 0.25, 0.25),
    AccentColor = Color3.new(0.8, 0.2, 0.2),
    Padding = 10,
    Spacing = 5,
    WindowBorderRadius = 8,
    ComponentHeight = 30,
    WindowDraggable = true,
}

local function applyDefaultProperties(instance, properties)
    for prop, value in pairs(properties) do
        pcall(function() instance[prop] = value end)
    end
end

local function createBaseElement(className, parent, name, defaultProps)
    local element = Instance.new(className)
    element.Name = name or className
    element.BackgroundTransparency = 1
    element.Parent = parent
    if defaultProps then
        applyDefaultProperties(element, defaultProps)
    end
    return element
end

UI.Window = function(title, size, position)
    local screenGui = createBaseElement("ScreenGui", PlayerGui, title)
    
    local frame = createBaseElement("Frame", screenGui, "WindowFrame", {
        Size = size or UDim2.new(0, 300, 0, 200),
        Position = position or UDim2.new(0.5, -150, 0.5, -100),
        BackgroundColor3 = UI.Config.BackgroundColor,
        BorderSizePixel = 0,
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, UI.Config.WindowBorderRadius)
    corner.Parent = frame

    local titleBar = createBaseElement("Frame", frame, "TitleBar", {
        Size = UDim2.new(1, 0, 0, UI.Config.ComponentHeight),
        BackgroundColor3 = Color3.new(
            UI.Config.BackgroundColor.R * 0.8, 
            UI.Config.BackgroundColor.G * 0.8, 
            UI.Config.BackgroundColor.B * 0.8
        ),
        BorderSizePixel = 0,
    })

    local titleLabel = createBaseElement("TextLabel", titleBar, "TitleLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        TextColor3 = UI.Config.TextColor,
        Text = title or "Nueva Ventana",
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize + 2,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
    })

    if UI.Config.WindowDraggable then
        local dragging = false
        local dragOffset = Vector2.new()

        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragOffset = input.Position - frame.AbsolutePosition
            end
        end)

        titleBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    local newPos = input.Position - dragOffset
                    frame.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
                end
            end
        end)
    end

    local contentFrame = createBaseElement("Frame", frame, "ContentFrame", {
        Size = UDim2.new(1, 0, 1, -UI.Config.ComponentHeight),
        Position = UDim2.new(0, 0, 0, UI.Config.ComponentHeight),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
    })
    
    local windowApi = {
        Frame = frame,
        Content = contentFrame,
        SetTitle = function(newTitle) titleLabel.Text = newTitle end,
        SetVisible = function(visible) screenGui.Enabled = visible end,
        ToggleVisible = function() screenGui.Enabled = not screenGui.Enabled end,
        Close = function() screenGui:Destroy() end,
    }
    
    return windowApi
end

UI.Button = function(parent, text, callback, size, position)
    local button = createBaseElement("TextButton", parent, "Button_" .. text:gsub("%s+", ""), {
        Size = size or UDim2.new(1, -UI.Config.Padding * 2, 0, UI.Config.ComponentHeight),
        Position = position or UDim2.new(0, UI.Config.Padding, 0, UI.Config.Padding),
        BackgroundColor3 = UI.Config.ButtonColor,
        TextColor3 = UI.Config.TextColor,
        Text = text or "Botón",
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize,
        BorderSizePixel = 0,
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return button
end

UI.Label = function(parent, text, size, position)
    local label = createBaseElement("TextLabel", parent, "Label_" .. text:gsub("%s+", ""), {
        Size = size or UDim2.new(1, -UI.Config.Padding * 2, 0, UI.Config.ComponentHeight),
        Position = position or UDim2.new(0, UI.Config.Padding, 0, UI.Config.Padding),
        BackgroundTransparency = 1,
        TextColor3 = UI.Config.TextColor,
        Text = text or "Etiqueta",
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    })
    
    label.TextWrapped = true
    
    local labelApi = {
        Instance = label,
        SetText = function(newText) label.Text = newText end,
    }
    return labelApi
end

UI.Input = function(parent, placeholder, callback, size, position)
    local textBox = createBaseElement("TextBox", parent, "Input_" .. placeholder:gsub("%s+", ""), {
        Size = size or UDim2.new(1, -UI.Config.Padding * 2, 0, UI.Config.ComponentHeight),
        Position = position or UDim2.new(0, UI.Config.Padding, 0, UI.Config.Padding),
        PlaceholderText = placeholder or "Introduce texto...",
        BackgroundColor3 = UI.Config.ButtonColor,
        TextColor3 = UI.Config.TextColor,
        Text = "",
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = textBox

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(textBox.Text)
        end
    end)
    
    local inputApi = {
        Instance = textBox,
        GetText = function() return textBox.Text end,
        SetText = function(text) textBox.Text = text end,
    }
    return inputApi
end

UI.Toggle = function(parent, text, initialValue, callback, size, position)
    local frame = createBaseElement("Frame", parent, "ToggleFrame_" .. text:gsub("%s+", ""), {
        Size = size or UDim2.new(1, -UI.Config.Padding * 2, 0, UI.Config.ComponentHeight),
        Position = position or UDim2.new(0, UI.Config.Padding, 0, UI.Config.Padding),
        BackgroundTransparency = 1,
    })

    local boxSize = UI.Config.ComponentHeight * 0.7
    local toggleBox = createBaseElement("Frame", frame, "ToggleBox", {
        Size = UDim2.new(0, boxSize, 0, boxSize),
        Position = UDim2.new(0, 0, 0.5, -boxSize/2),
        BackgroundColor3 = UI.Config.ButtonColor,
        BorderSizePixel = 0,
    })
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 3)
    corner.Parent = toggleBox

    local checkMark = createBaseElement("TextLabel", toggleBox, "CheckMark", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        TextColor3 = UI.Config.AccentColor,
        Text = "✔",
        Font = Enum.Font.SourceSansBold,
        TextSize = boxSize * 0.8,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Visible = initialValue or false,
    })

    local label = createBaseElement("TextLabel", frame, "ToggleLabel", {
        Size = UDim2.new(1, -boxSize - UI.Config.Spacing, 1, 0),
        Position = UDim2.new(0, boxSize + UI.Config.Spacing, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = UI.Config.TextColor,
        Text = text or "Opción",
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    })

    local currentValue = initialValue or false
    
    local function updateVisual()
        checkMark.Visible = currentValue
    end
    updateVisual()

    frame.MouseButton1Click:Connect(function()
        currentValue = not currentValue
        updateVisual()
        if callback then callback(currentValue) end
    end)
    
    local toggleApi = {
        Instance = frame,
        GetValue = function() return currentValue end,
        SetValue = function(value) 
            currentValue = value 
            updateVisual() 
        end,
    }
    return toggleApi
end

UI.Slider = function(parent, min, max, initialValue, callback, size, position)
    local sliderFrame = createBaseElement("Frame", parent, "SliderFrame", {
        Size = size or UDim2.new(1, -UI.Config.Padding * 2, 0, UI.Config.ComponentHeight),
        Position = position or UDim2.new(0, UI.Config.Padding, 0, UI.Config.Padding),
        BackgroundTransparency = 1,
    })

    local trackHeight = 5
    local track = createBaseElement("Frame", sliderFrame, "Track", {
        Size = UDim2.new(1, 0, 0, trackHeight),
        Position = UDim2.new(0, 0, 0.5, -trackHeight/2),
        BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
        BorderSizePixel = 0,
    })
    
    local filledTrack = createBaseElement("Frame", track, "FilledTrack", {
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = UI.Config.AccentColor,
        BorderSizePixel = 0,
    })

    local thumbSize = UI.Config.ComponentHeight * 0.7
    local thumb = createBaseElement("Frame", track, "Thumb", {
        Size = UDim2.new(0, thumbSize, 0, thumbSize),
        Position = UDim2.new(0, 0, 0.5, -thumbSize/2),
        BackgroundColor3 = UI.Config.TextColor,
        BorderSizePixel = 0,
    })

    local cornerThumb = Instance.new("UICorner")
    cornerThumb.CornerRadius = UDim.new(0, thumbSize/2)
    cornerThumb.Parent = thumb

    local valueLabel = createBaseElement("TextLabel", sliderFrame, "ValueLabel", {
        Size = UDim2.new(1, 0, 0, UI.Config.ComponentHeight * 0.5),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = UI.Config.TextColor,
        Font = UI.Config.Font,
        TextSize = UI.Config.FontSize - 2,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Top,
    })

    local currentValue = initialValue or min
    currentValue = math.clamp(currentValue, min, max)

    local function updateThumbPosition()
        local percent = (currentValue - min) / (max - min)
        local thumbX = percent * (track.AbsoluteSize.X - thumb.AbsoluteSize.X)
        thumb.Position = UDim2.new(0, thumbX, 0.5, -thumbSize/2)
        filledTrack.Size = UDim2.new(percent, 0, 1, 0)
        valueLabel.Text = string.format("%.1f", currentValue)
    end

    local dragging = false
    local function onMouseMoved(input)
        if dragging then
            local mouseX = input.Position.X
            local trackX = track.AbsolutePosition.X
            local trackWidth = track.AbsoluteSize.X

            local normalizedX = math.clamp((mouseX - trackX) / trackWidth, 0, 1)
            currentValue = min + (max - min) * normalizedX
            updateThumbPosition()
            if callback then callback(currentValue) end
        end
    end

    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UserInputService.InputChanged:Connect(onMouseMoved)
            UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
        end
    end)
    
    updateThumbPosition()

    local sliderApi = {
        Instance = sliderFrame,
        GetValue = function() return currentValue end,
        SetValue = function(value)
            currentValue = math.clamp(value, min, max)
            updateThumbPosition()
        end,
    }
    return sliderApi
end

UI.Container = function(parent, size, position, backgroundColor)
    local container = createBaseElement("Frame", parent, "Container", {
        Size = size or UDim2.new(1, 0, 1, 0),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = backgroundColor or Color3.new(
            UI.Config.BackgroundColor.R * 0.9, 
            UI.Config.BackgroundColor.G * 0.9, 
            UI.Config.BackgroundColor.B * 0.9
        ),
        BorderSizePixel = 0,
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, UI.Config.WindowBorderRadius - 2)
    corner.Parent = container

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = container
    uiListLayout.Padding = UDim.new(0, UI.Config.Spacing)
    uiListLayout.FillDirection = Enum.FillDirection.Vertical
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local containerApi = {
        Instance = container,
        Layout = uiListLayout,
    }
    return containerApi
end

return UI
