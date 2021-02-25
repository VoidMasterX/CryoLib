-- Module Init
local Library = {}
Library.__index = Library
local self = setmetatable({}, Library)

-- Services
local Services = setmetatable({}, {__index = function(Self, Index)
    local GetService = game.GetService
    local NewService = GetService(game, Index)
    if NewService then
        Self[Index] = NewService
    end
    return NewService
end})

-- Create UI Lib
function Library:CreateWindow(winopts)
    local options = {}
    local windowdrag = false
    local sliderdrag = false
    local window_minified = false

    -- Create Options Variables
    options.Text = (winopts and winopts.Text) or options.Text
    options.Color = (winopts and winopts.Color) or options.Color
    options.Key = (winopts and winopts.Key) or options.Key

    -- Create Regular Variables
    local WinTypes = {}

    -- Create Main Window GUI
    local CryoLib = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local core_glow = Instance.new("ImageLabel")
    local sidebar = Instance.new("Frame")
    local button_container = Instance.new("ScrollingFrame")
    local tab_layout = Instance.new("UIListLayout")
    local topbar = Instance.new("Frame")
    local exit = Instance.new("TextButton")
    local mini = Instance.new("ImageButton")
    local title_2 = Instance.new("TextLabel")

    -- UI Protection
    local Protect = syn and syn.protect_gui or is_electron_function and gethui or function(ui) 
        ui.Parent = game.CoreGui
    end
    
    Protect(CryoLib)

    local function RandomString(length)
        local chars = {}
        for i = 97, 122 do
            table.insert(chars, string.char(i))
        end
        local string = ""
        for i = 1, length do
            string = string .. chars[math.random(1,#chars)]
        end
        return string
    end

    -- Create Properties
    CryoLib.Name = RandomString(20)
    CryoLib.Parent = game.CoreGui
    CryoLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    core.Name = "core"
    core.Parent = CryoLib
    core.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
    core.BorderSizePixel = 0
    core.Position = UDim2.new(0.229938269, 0, 0.201623827, 0)
    core.Size = UDim2.new(0, 699, 0, 440)

    sidebar.Name = "sidebar"
    sidebar.Parent = core
    sidebar.BackgroundColor3 = Color3.fromRGB(27, 27, 40)
    sidebar.BorderSizePixel = 0
    sidebar.Position = UDim2.new(0, 0, 0.0681818202, 0)
    sidebar.Size = UDim2.new(0, 200, 0, 410)

    button_container.Name = "button_container"
    button_container.Parent = sidebar
    button_container.Active = true
    button_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button_container.BackgroundTransparency = 1.000
    button_container.BorderSizePixel = 0
    button_container.Size = UDim2.new(0, 200, 0, 410)
    button_container.BottomImage = ""
    button_container.CanvasSize = UDim2.new(0, 0, 0, 0)
    button_container.ScrollBarThickness = 4
    button_container.TopImage = ""

    tab_layout.Name = "tab_layout"
    tab_layout.Parent = button_container
    tab_layout.SortOrder = Enum.SortOrder.LayoutOrder

    topbar.Name = "topbar"
    topbar.Parent = core
    topbar.BackgroundColor3 = Color3.fromRGB(32, 32, 48)
    topbar.BorderSizePixel = 0
    topbar.Size = UDim2.new(0, 699, 0, 30)

    exit.Name = "exit"
    exit.Parent = topbar
    exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    exit.BackgroundTransparency = 1.000
    exit.BorderSizePixel = 0
    exit.Position = UDim2.new(0.957081556, 0, 0, 0)
    exit.Size = UDim2.new(0, 30, 0, 30)
    exit.Font = Enum.Font.GothamSemibold
    exit.Text = "X"
    exit.TextColor3 = Color3.fromRGB(255, 255, 255)
    exit.TextSize = 18.000

    mini.Name = "mini"
    mini.Parent = topbar
    mini.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mini.BackgroundTransparency = 1.000
    mini.BorderSizePixel = 0
    mini.Rotation = 180
    mini.Position = UDim2.new(0.914163113, 0, 0, 0)
    mini.Size = UDim2.new(0, 30, 0, 30)
    mini.Image = "rbxassetid://6031094687"

    title_2.Name = "title"
    title_2.Parent = topbar
    title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title_2.BackgroundTransparency = 1.000
    title_2.Position = UDim2.new(0.0143061522, 0, 0, 0)
    title_2.Size = UDim2.new(0, 190, 0, 30)
    title_2.Font = Enum.Font.GothamBold
    title_2.Text = options.Text
    title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_2.TextSize = 14.000
    title_2.TextXAlignment = Enum.TextXAlignment.Left

    -- Buttons
    exit.MouseButton1Click:Connect(function()
        sidebar.Visible = false
        if (self.selected_container ~= nil) then self.selected_container.Visible = false end
        Services["TweenService"]:Create(core, TweenInfo.new(0.400, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 1
        }):Play()
        wait(0.4)
        CryoLib:Destroy()
    end)

    mini.MouseButton1Click:Connect(function()
        window_minified = not window_minified
        sidebar.Visible = not window_minified
        if (self.selected_container ~= nil) then self.selected_container.Visible = not window_minified end
        core.Size = UDim2.new(0, 699, 0, (window_minified and 30 or not window_minified and 440))
        wait(0.01)
        Services["TweenService"]:Create(mini, TweenInfo.new(0.250, Enum.EasingStyle.Quint), {
            Rotation = mini.Rotation - 180
        }):Play()
    end)

    -- Dragging
    local userinputservice = Services["UserInputService"]
    local dragInput, dragStart, startPos = nil, nil, nil

    core.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
            dragStart = input.Position
            startPos = core.Position
            windowdrag = true
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    windowdrag = false
                end
            end)
        end
    end)

    core.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    userinputservice.InputChanged:Connect(function(input)
        if input == dragInput and windowdrag and not sliderdrag then
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            Services["TweenService"]:Create(core, TweenInfo.new(0.100), {Position = Position}):Play()
        end
    end)

    -- Window Toggle
    userinputservice.InputBegan:connect(function(input)
        if input.KeyCode == Enum.KeyCode[options.Key] then
            core.Visible = not core.Visible
        end
    end)

    local function ResizeTabList()
        local Y = tab_layout.AbsoluteContentSize.Y + 20
        button_container.CanvasSize = UDim2.new(0, 0, 0, Y)
    end

    -- Title
    function WinTypes:SetTitle(title)
        title_2.Text = title
    end

    function WinTypes:GetTitle(title)
        return title_2.Text
    end

    -- Color
    function WinTypes:SetColor(color)
        options.Color = color
    end

    function WinTypes:GetColor()
        return options.Color
    end

    -- Visibility
    function WinTypes:ToggleVisibility()
        CryoLib.Enabled = not CryoLib.Enabled
    end

    function WinTypes:SetVisibility(visibility)
        CryoLib.Enabled = visibility
    end

    function WinTypes:GetVisibility()
        return CryoLib.Enabled
    end

    -- Tab
    function WinTypes:CreateTabSection(Text)
        local TabTypes = {}
        Text = Text or "TAB SECTION TITLE"

        local tab_section = Instance.new("Frame")
        local title = Instance.new("TextLabel")
        local drop = Instance.new("ImageButton")
        local tab_drop = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")

        tab_section.Name = "tab_section"
        tab_section.Parent = button_container
        tab_section.BackgroundColor3 = options.Color
        tab_section.BorderSizePixel = 0
        tab_section.Size = UDim2.new(0, 200, 0, 31)

        title.Name = "title"
        title.Parent = tab_section
        title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title.BackgroundTransparency = 1.000
        title.BorderSizePixel = 0
        title.Position = UDim2.new(0.0500000007, 0, 0, 0)
        title.Size = UDim2.new(0, 190, 0, 31)
        title.Font = Enum.Font.GothamSemibold
        title.Text = Text
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 14.000
        title.TextXAlignment = Enum.TextXAlignment.Left

        drop.Name = "drop"
        drop.Parent = tab_section
        drop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        drop.BackgroundTransparency = 1.000
        drop.BorderSizePixel = 0
        drop.Rotation = 180
        drop.Position = UDim2.new(0.849163115, 0, 0, 0)
        drop.Size = UDim2.new(0, 30, 0, 30)
        drop.Image = "rbxassetid://6031094687"

        tab_drop.Name = "tab_drop"
        tab_drop.Parent = button_container
        tab_drop.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
        tab_drop.BorderSizePixel = 0
        tab_drop.Position = UDim2.new(0, 0, 0.0756097585, 0)
        tab_drop.Size = UDim2.new(0, 200, 0, 0)
        tab_drop.Visible = false

        UIListLayout.Parent = tab_drop
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        drop.MouseButton1Click:Connect(function()
            tab_drop.Visible = not tab_drop.Visible
            ResizeTabList()
            Services["TweenService"]:Create(drop, TweenInfo.new(0.250, Enum.EasingStyle.Quint), {
                Rotation = drop.Rotation - 180
            }):Play()
        end)

        function TabTypes:CreateTab(Name)
            local tabTypes = {}
            Name = Name or "Tab"

            local tab = Instance.new("TextButton")
            local tab_container = Instance.new("ScrollingFrame")
            local tab_grid = Instance.new("UIGridLayout")
            local tab_padding = Instance.new("UIPadding")

            tab.Name = "tab__" .. Name
            tab.Parent = tab_drop
            tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tab.BackgroundTransparency = 1.000
            tab.BorderSizePixel = 0
            tab.Position = UDim2.new(-0.00499999989, 0, 0, 0)
            tab.Size = UDim2.new(0, 200, 0, 25)
            tab.Font = Enum.Font.Gotham
            tab.Text = Name
            tab.TextColor3 = Color3.fromRGB(255, 255, 255)
            tab.TextSize = 14.000

            tab_container.Name = "tab_" .. Name .. "_container"
            tab_container.Parent = core
            tab_container.Active = true
            tab_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tab_container.BackgroundTransparency = 1.000
            tab_container.BorderSizePixel = 0
            tab_container.Position = UDim2.new(0.286123037, 0, 0.0681818202, 0)
            tab_container.Size = UDim2.new(0, 499, 0, 410)
            tab_container.BottomImage = ""
            tab_container.CanvasSize = UDim2.new(0, 0, 0, 0)
            tab_container.ScrollBarThickness = 4
            tab_container.TopImage = ""
            tab_container.Visible = false

            tab_grid.Name = "tab_grid"
            tab_grid.Parent = tab_container
            tab_grid.SortOrder = Enum.SortOrder.LayoutOrder
            tab_grid.CellPadding = UDim2.new(0, 10, 0, 10)
            tab_grid.CellSize = UDim2.new(0, 229, 0, 390)

            tab_padding.Name = "tab_padding"
            tab_padding.Parent = tab_container
            tab_padding.PaddingLeft = UDim.new(0, 10)
            tab_padding.PaddingTop = UDim.new(0, 10)

            tab.MouseButton1Click:Connect(function()
                tab.TextColor3 = options.Color
                tab_container.Visible = not tab_container.Visible
                self.selected_container = tab_container
                for i,v in pairs(core:GetChildren()) do
                    if (v.Name:find("tab_") and v.Name ~= "tab_" .. Name .. "_container") then
                        v.Visible = false
                    end
                end
                for i,v in pairs(tab_drop:GetChildren()) do
                    if (v.Name:find("tab__") and v.Name ~= "tab__" .. Name) then
                        v.TextColor3 = Color3.new(255, 255, 255)
                    end
                end
            end)

            function tabTypes:CreateGroupbox(Name)
                Name = Name or "GROUPBOX TITLE"
                local GroupTypes = {}

                local groupbox = Instance.new("Frame")
                local titlebox = Instance.new("Frame")
                local title_3 = Instance.new("TextLabel")
                local group_container = Instance.new("ScrollingFrame")
                local UIPadding = Instance.new("UIPadding")
                local UIListLayout_2 = Instance.new("UIListLayout")
                local groupbox_glow = Instance.new("ImageLabel")

                groupbox.Name = "groupbox"
                groupbox.Parent = tab_container
                groupbox.BackgroundColor3 = Color3.fromRGB(27, 27, 40)
                groupbox.BorderSizePixel = 0
                groupbox.Position = UDim2.new(0.02004008, 0, 0.024390243, 0)
                groupbox.Size = UDim2.new(0, 229, 0, 390)

                titlebox.Name = "titlebox"
                titlebox.Parent = groupbox
                titlebox.BackgroundColor3 = options.Color
                titlebox.BorderSizePixel = 0
                titlebox.Size = UDim2.new(0, 229, 0, 30)

                title_3.Name = "title"
                title_3.Parent = titlebox
                title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_3.BackgroundTransparency = 1.000
                title_3.Position = UDim2.new(0.0436681211, 0, 0, 0)
                title_3.Size = UDim2.new(0, 219, 0, 30)
                title_3.Font = Enum.Font.GothamSemibold
                title_3.Text = Name
                title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_3.TextSize = 14.000
                title_3.TextXAlignment = Enum.TextXAlignment.Left

                group_container.Name = "group_container"
                group_container.Parent = groupbox
                group_container.Active = true
                group_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                group_container.BackgroundTransparency = 1.000
                group_container.BorderSizePixel = 0
                group_container.Position = UDim2.new(0, 0, 0.0769230798, 0)
                group_container.Size = UDim2.new(0, 229, 0, 360)
                group_container.BottomImage = ""
                group_container.CanvasSize = UDim2.new(0, 0, 0, 0)
                group_container.ScrollBarThickness = 3
                group_container.TopImage = ""

                UIPadding.Parent = group_container
                UIPadding.PaddingLeft = UDim.new(0, 10)
                UIPadding.PaddingTop = UDim.new(0, 10)

                UIListLayout_2.Parent = group_container
                UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_2.Padding = UDim.new(0, 10)

                groupbox_glow.Name = "groupbox_glow"
                groupbox_glow.Parent = groupbox
                groupbox_glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                groupbox_glow.BackgroundTransparency = 1.000
                groupbox_glow.BorderSizePixel = 0
                groupbox_glow.Position = UDim2.new(0, -15, 0, -15)
                groupbox_glow.Size = UDim2.new(1, 30, 1, 30)
                groupbox_glow.ZIndex = 0
                groupbox_glow.Image = "rbxassetid://4996891970"
                groupbox_glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                groupbox_glow.ScaleType = Enum.ScaleType.Slice
                groupbox_glow.SliceCenter = Rect.new(20, 20, 280, 280)

                function GroupTypes:CreateToggle(Name, Callback)
                    Name = Name or "UI TOGGLE"
                    Callback = Callback or function(x)
                        print(x)
                    end
                    local toggled = false

                    local toggle = Instance.new("Frame")
                    local glow = Instance.new("ImageLabel")
                    local main = Instance.new("Frame")
                    local title_4 = Instance.new("TextLabel")
                    local button = Instance.new("TextButton")

                    toggle.Name = "toggle"
                    toggle.Parent = group_container
                    toggle.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
                    toggle.BorderSizePixel = 0
                    toggle.Position = UDim2.new(0.0436681211, 0, 0.0354700871, 0)
                    toggle.Size = UDim2.new(0, 209, 0, 40)

                    glow.Name = "glow"
                    glow.Parent = toggle
                    glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    glow.BackgroundTransparency = 1.000
                    glow.BorderSizePixel = 0
                    glow.Position = UDim2.new(0, -15, 0, -15)
                    glow.Size = UDim2.new(1, 30, 1, 30)
                    glow.ZIndex = 0
                    glow.Image = "rbxassetid://4996891970"
                    glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                    glow.ScaleType = Enum.ScaleType.Slice
                    glow.SliceCenter = Rect.new(20, 20, 280, 280)

                    main.Name = "main"
                    main.Parent = toggle
                    main.BackgroundColor3 = Color3.fromRGB(14, 14, 21)
                    main.BorderSizePixel = 0
                    main.Position = UDim2.new(0.0334928222, 0, 0.150000006, 0)
                    main.Size = UDim2.new(0, 25, 0, 25)

                    title_4.Name = "title"
                    title_4.Parent = toggle
                    title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.BackgroundTransparency = 1.000
                    title_4.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    title_4.BorderSizePixel = 0
                    title_4.Position = UDim2.new(0.186602876, 0, 0.150000006, 0)
                    title_4.Size = UDim2.new(0, 170, 0, 25)
                    title_4.Font = Enum.Font.Gotham
                    title_4.Text = Name
                    title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.TextSize = 14.000
                    title_4.TextXAlignment = Enum.TextXAlignment.Left

                    button.Name = "button"
                    button.Parent = toggle
                    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    button.BackgroundTransparency = 1.000
                    button.BorderSizePixel = 0
                    button.Position = UDim2.new(0.0334928222, 0, 0.150000006, 0)
                    button.Size = UDim2.new(0, 202, 0, 25)
                    button.Font = Enum.Font.SourceSans
                    button.Text = ""
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.TextSize = 14.000

                    button.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        main.BackgroundColor3 = toggled and options.Color or not toggled and Color3.fromRGB(14, 14, 21)
                    end)

                    group_container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 20)
                end

                tab_container.CanvasSize = UDim2.new(0, 499, 0, tab_grid.AbsoluteContentSize.Y + 20)
                return GroupTypes
            end

            tab_drop.Size = UDim2.new(0, 200, 0, UIListLayout.AbsoluteContentSize.Y)
            ResizeTabList()
            return tabTypes
        end

        return TabTypes
    end

    return WinTypes
end

return Library
