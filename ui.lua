local Library = {}
Library.__index = Library
local self = setmetatable({}, Library)

function Library:CreateWindow(winopts)
    -- Create Metatable Variables
    self.options = {}
    self.options.Text = (winopts and winopts.Title) or "UI TITLE"
    self.options.LibColor = (winopts and winopts.LibColor) or Color3.fromRGB(85, 170, 255)
    self.windowdrag = true
    self.sliderdrag = false

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
    local tab_container = Instance.new("ScrollingFrame")
    local tab_grid = Instance.new("UIGridLayout")
    local tab_padding = Instance.new("UIPadding")

    -- Handle Protection
    local Protect = syn and syn.protect_gui or is_electron_function and gethui or function(ui) 
        ui.Parent = game.CoreGui
    end
    
    Protect(CryoLib)

    -- Create Properties
    CryoLib.Name = "CryoLib"
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
    title_2.Text = "UI TITLE"
    title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_2.TextSize = 14.000
    title_2.TextXAlignment = Enum.TextXAlignment.Left

    tab_container.Name = "tab_container"
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

    tab_grid.Name = "tab_grid"
    tab_grid.Parent = tab_container
    tab_grid.SortOrder = Enum.SortOrder.LayoutOrder
    tab_grid.CellPadding = UDim2.new(0, 10, 0, 10)
    tab_grid.CellSize = UDim2.new(0, 229, 0, 390)
end

return Library
