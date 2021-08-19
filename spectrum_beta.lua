if _G.IsSpectrumLoaded then 
    local b = Instance.new("TextLabel")
    b.Text = "Spectrum already loaded!"
    b.Font = Enum.Font.SourceSansLight
    b.TextStrokeColor3 = Color3.fromRGB(4,  4, 6)
    b.TextStrokeTransparency = 0
    b.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    b.TextColor3 = Color3.fromRGB(254, 254, 255)
    b.BackgroundTransparency = 0
    b.BorderSizePixel = 1
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.TextYAlignment = Enum.TextYAlignment.Top
    b.Parent = Instance.new("ScreenGui",game.CoreGui)
    b.TextWrapped = true
    b.Position = UDim2.new(0, 5, 0.95, -5)
    b.Size = UDim2.new(0.15, 0, 0.05, 0)
    b.Visible = true
    b.TextSize = 30
    b.BorderColor3 = Color3.fromHSV(math.random(0,360), 1, 1)
   
   
    wait(3)
   
    b.Parent:Destroy()
   
   
    return
end


if not game:IsLoaded() then game.Loaded:Wait() end


local plrs    = game:GetService("Players")
local teams   = game:GetService("Teams")
local ts      = game:GetService("TweenService")
local rs      = game:GetService("RunService")
local ms      = game:GetService("MarketplaceService")
local uis     = game:GetService("UserInputService")
local ctx     = game:GetService("ContextActionService")
local deb     = game:GetService("Debris")

uis.MouseIconEnabled = true

local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local simradius = setsimulationradius or set_simulation_radius or setsimradius
local fireclick = fireclickdetector or fire_click_detector or click_detector
local iscaller = checkcaller or isourclosure or isexecutorclosure or is_protosmasher_closure
local setreadonly = setreadonly or make_writeable or make_readonly


local ui = {} do
    --Object types
    ui.ObjectTypes = {
        Toggle    = "Toggle",
        Slider    = "Slider",
        Dropdown  = "Dropdown",
        Input     = "Input",
        Color     = "Color",
        Hotkey    = "Hotkey",
        
        Menu      = "Menu",  --Menu that contains modules
        Button    = "Button" --Module within a menu
        
    }
    
    ui.Height = 40 --The height of every button, textlabel, etc. Change it to see what this does.
    
    ui.Objects = {} --A table for gui objects. Don't directly access it for safety, use :GetObject and :GetChild
    ui.MenuCount = 0 --How many menus there are. Only used internally
    
    ui.RGB = {} --A table for instances that need to have their RGB values updated. Use ui:AddRGB and ui:RemoveRGB
    ui.RGBhue = 0 --Current hue
    
    
    ui.Connections = {} --Connections table, both used internally and externally
    ui.ExtInstances = {} --A table for external instances. On exit, all instances inside of here will be cleared.
    ui.ExtDInstances = {} --A table for external drawing instances. On exit, all instances inside of here will be removed.
    ui.Boundsteps = {} --A table for external RunService binds. On exit, all binds inside of here will be unbound.
    ui.Boundactions = {} --A table for external ContextActionService binds. On exit, all binds inside of here will be unbound.
    
    ui.Colors = { --The table for all of the colors
        menu = Color3.fromRGB(24, 24, 26),
        button = Color3.fromRGB(20, 20, 22),
        normal = Color3.fromRGB(16, 16, 18),
        enum = Color3.fromRGB(12, 12, 14),
        
        button_high = Color3.fromRGB(40, 40, 42),
        normal_high = Color3.fromRGB(36, 36, 38),
        
        textoutline = Color3.fromRGB(4, 4, 6)
        
    }
    
    ui.EnabledMods = {} --A table for enabled mods. Used for AddMod and RemoveMod
    
    function ui:GetObject(item)
        return ui.Objects[item]
    end
    
    function ui:GetChild(parent, childname)
        
        return (parent["menu"]["objects"][childname])
    end
    
    function ui:Init()
        _G.IsSpectrumLoaded = true
        
        local sc = Instance.new("ScreenGui")
        
        if syn then 
            syn.protect_gui(sc)
        end
        
        sc.Parent = (gethui and gethui() or get_hidden_gui and get_hidden_gui()) or game.CoreGui
        sc.Name = "sussy"
        sc.DisplayOrder = 69
        sc.IgnoreGuiInset = true
        
        local main = Instance.new("Frame")
        main.Parent = sc
        main.Size = UDim2.new(1, 0, 1, 0)
        main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        main.BackgroundTransparency = 0.6
        main.Position = UDim2.new(0, 0, 0, 0)
        main.Active = true
        main.Visible = false
        main.BorderSizePixel = 0 
        main.ZIndex = 200
        
        local b = Instance.new("TextLabel")
        b.Text = "sus"
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 0
        b.BorderSizePixel = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextYAlignment = Enum.TextYAlignment.Top
        b.TextWrapped = true
        b.Position = UDim2.new(0, 0, 0, 0)
        b.Visible = false
        b.TextScaled = true
        b.Size = UDim2.new(0.5, 0, 0.5, 0)
        b.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
        b.ZIndex = 900
        b.Parent = main
        
        ui:TextLock(b, 25, 0)
        ui:AddRGB(b, "BorderColor3")

        local c = Instance.new("ColorCorrectionEffect")
        c.Name = "DX_EFFECT_DONTTOUCH"
        c.Saturation = 0
        c.Parent = game:GetService"Lighting"
        
        local d = Instance.new("TextButton")
        d.Text = "<i>spectrum</i>"
        d.Font = Enum.Font.SourceSansLight
        d.TextStrokeColor3 = ui.Colors["textoutline"]
        d.TextStrokeTransparency = 0
        d.TextColor3 = Color3.fromRGB(254, 254, 255)
        d.BackgroundTransparency = 1
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.TextYAlignment = Enum.TextYAlignment.Top
        d.Position = UDim2.new(0, 40, 0, 40)
        d.TextScaled = true
        d.Size = UDim2.new(0.1, 0, 0.075, 0)
        d.ZIndex = 888
        d.RichText = true
        d.AutoButtonColor = false
        d.Modal = false
        d.Parent = main
        
        local e = Instance.new("TextLabel")
        e.Text = "by topit"
        e.Font = Enum.Font.SourceSansLight
        e.TextStrokeColor3 = ui.Colors["textoutline"]
        e.TextStrokeTransparency = 0
        e.TextColor3 = Color3.fromRGB(254, 254, 255)
        e.BackgroundTransparency = 1
        e.TextXAlignment = Enum.TextXAlignment.Left
        e.TextYAlignment = Enum.TextYAlignment.Top
        e.Position = UDim2.new(0, 40, 0.075, 40)
        e.TextScaled = true
        e.Size = UDim2.new(0.1, 0, 0.05, 0)
        e.ZIndex = 888
        e.RichText = true
        e.Parent = main
        
        local f = Instance.new("ImageLabel")
        f.ZIndex = 1000
        f.Size = UDim2.new(0, 64, 0, 64)
        f.BackgroundTransparency = 1
        f.Image = "rbxassetid://7226366089"
        f.Parent = main
        
        local g = Instance.new("Frame")
        g.Size = UDim2.new(0.15, 0, 1, 0)
        g.Position = UDim2.new(1-0.15, 0, 0, 0)
        g.BackgroundColor3 = Color3.new(1, 1, 1)
        g.BackgroundTransparency = 1
        g.ZIndex = 200
        g.BorderSizePixel = 0
        g.ClipsDescendants = true
        g.Parent = sc
        
        
        
        local h = Instance.new("TextLabel")
        h.Size = UDim2.new(0.95, 0, 0.04, 0)
        h.Position = UDim2.new(0, 0, 0, 0)
        h.Font = Enum.Font.SourceSansLight
        h.TextStrokeColor3 = ui.Colors["textoutline"]
        h.TextStrokeTransparency = 0
        h.TextColor3 = Color3.fromRGB(254, 254, 255)
        h.BackgroundTransparency = 1
        h.BorderSizePixel = 0
        h.TextXAlignment = Enum.TextXAlignment.Right
        h.TextYAlignment = Enum.TextYAlignment.Center
        h.TextWrapped = false
        h.TextScaled = true
        h.ZIndex = 205
        h.Text = "Spectrum"
        h.Parent = g
        
        
        ui.Objects["SCREENGUI"] = sc
        ui.Objects["MAIN"] = main
        ui.Objects["DESCRIPTOR"] = b
        ui.Objects["WATERMARK"] = d
        ui.Objects["CCEFFECT"] = c
        ui.Objects["CURSOR"] = f
        ui.Objects["MODULELIST"] = g
        
        ui:TextLock(d, 80, 5)
        ui:TextLock(e, 35, 5)
        ui:TextLock(h, 40, 10)
        
        ui:ListLock(g, "Left")
        
        
        ui:AddRGB(d, "TextColor3")
        ui:AddRGB(e, "TextColor3")
    end
    
    function ui:Ready()
        local cursor_enabled
        ctx:BindActionAtPriority("TOGGLE",function(_, state, obj)
            if state == Enum.UserInputState.Begin then
                ui:GetObject("MAIN").Visible = not ui:GetObject("MAIN").Visible
                if ui:GetObject("MAIN").Visible then
                    cursor_enabled = uis.MouseIconEnabled
                    uis.MouseIconEnabled = false
                    
                    
                    ui:GetObject("WATERMARK").Modal = true
                    ui:GetObject("CCEFFECT").Saturation = -0.4
                    ui:GetObject("CCEFFECT").TintColor = Color3.new(0.5, 0.5, 0.5)
                    
                    
                    --mouse.Button1Down:Connect(function()
                    --    local mouseloc = uis:GetMouseLocation()
                    --    
                    --    local cl = Instance.new("ImageLabel")
                    --    cl.BackgroundTransparency = 1
                    --    cl.Position = UDim2.fromOffset(mouseloc.X, mouseloc.Y)
                    --    cl.Image = "rbxassetid://3570695787"
                    --    cl.Size = UDim2.fromOffset(2, 2)
                    --    cl.Parent = ui.Objects["MAIN"]
                    --    
                    --    ui:Tween(cl, {Position = cl.Position + UDim2.fromOffset(math.random(-15, 15), math.random(-15, 15)), ImageTransparency = 1}, 0.5)
                    --    
                    --    game.Debris:AddItem(cl, 0.5)
                    --end)
                    
                else
                    uis.MouseIconEnabled = cursor_enabled
                    ui:GetObject("WATERMARK").Modal = false
                    ui:GetObject("CCEFFECT").Saturation = 0
                    ui:GetObject("CCEFFECT").TintColor = Color3.new(1, 1, 1)
                end
                
            end
        end, false, 99999, Enum.KeyCode.Insert)
        
        ctx:BindActionAtPriority("CLOSE",function(_, state, obj)
            if state == Enum.UserInputState.Begin then
                ui:Shutdown()
                
            end
        end, false, 99999, Enum.KeyCode.End)
        
        
        rs:BindToRenderStep("RAINBOW", 2000, function(deltatime)
            ui.RGBhue = ui.RGBhue + (50 * deltatime)
            if ui.RGBhue > 1000 then
               ui.RGBhue = 0  
            end
            
            local color = Color3.fromHSV(ui.RGBhue/1000, 1, 1) 
            
            for _,object in pairs(ui.RGB) do
                object["self"][object["param"]] = color
            end
            
            color = nil
        end)
        
        
        rs:BindToRenderStep("DESCRIPTOR", 2000, function() 
            
            local mouseloc = uis:GetMouseLocation()
            ui.Objects["DESCRIPTOR"].Position = UDim2.fromOffset(mouseloc.X+13, mouseloc.Y+13)
            ui.Objects["CURSOR"].Position = UDim2.fromOffset(mouseloc.X-32, mouseloc.Y-32)
        end)
        
        
        table.insert(ui.Boundsteps, "RAINBOW")
        table.insert(ui.Boundsteps, "DESCRIPTOR")
        
        ui:AddRGB(ui:GetObject("CURSOR"),"ImageColor3")
    end
    
    function ui:Async(func) 
        coroutine.resume(coroutine.create(func))
    end
    
    function ui:Tween(object, dest, delay, direction, style)
        delay = delay or 0.5
        direction = direction or "Out"
        style = style or "Exponential"
        
        local tween = ts:Create(object, TweenInfo.new(delay, Enum.EasingStyle[style], Enum.EasingDirection[direction]), dest)
        tween:Play()
        return tween
    end
    
    function ui:TextLock(parent, max, min) 
        local a = Instance.new("UITextSizeConstraint")
        a.MaxTextSize = max or 35
        a.MinTextSize = min or 19
        a.Parent = parent
    end
    
    function ui:Pad(parent, h)
        local a = Instance.new("UIPadding")
        a.Parent = parent
        a.PaddingTop = UDim.new(0, h)
    end
    
    function ui:ListLock(parent, align)
        align = align or "Center"
        
        local a = Instance.new("UIListLayout")
        a.Parent = parent
        a.FillDirection = Enum.FillDirection.Vertical
        a.HorizontalAlignment = Enum.HorizontalAlignment[align]
    end
    
    function ui:AddRGB(obj, param, name)
        name = name or obj
        ui.RGB[name] = {["self"] = obj,["param"] = param}
    end
    
    function ui:RemoveRGB(obj)
        ui.RGB[obj] = nil
    end
    
    
    function ui:Message(message, func) 
        message = message or "sussy"
        func = func or function() end
        
        local a = Instance.new("Frame")
        a.BackgroundTransparency = 0
        a.BorderSizePixel = 0
        a.Position = UDim2.new(-1, 0, 2, -5)
        a.ZIndex = 899
        a.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        a.Parent = ui:GetObject("SCREENGUI")
        
        local b = Instance.new("TextButton")
        b.Text = " "..message
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 0
        b.BorderSizePixel = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextYAlignment = Enum.TextYAlignment.Top
        b.TextWrapped = true
        b.Visible = true
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
        b.ZIndex = 900
        b.Size = UDim2.new(math.clamp(#message, 10, 30)/200, 0, 0.05, 0)
        b.Position = UDim2.new(-b.Size.X.Scale, 0, 1 - b.Size.Y.Scale, -5)
        b.Parent = ui:GetObject("SCREENGUI")
        
        a.Position = b.Position
        a.Size = b.Size
        
        b.MouseButton1Click:Connect(func)
        
        ui:AddRGB(b, "BorderColor3")
        ui:TextLock(b, 25, 0)
        
        
        ui:Async(function()
            pcall(function() 
                ui:Tween(a, {Position = UDim2.new(0, 5, 1 - b.Size.Y.Scale, -5)})
                wait(0.1)
                ui:Tween(b, {Position = UDim2.new(0, 5, 1 - b.Size.Y.Scale, -5)})
                wait(3)
                a:Destroy()
                local sus = ui:Tween(b, {Position = UDim2.new(-b.Size.X.Scale, 0, 1 - b.Size.Y.Scale, -5)}, nil, "In")
                sus.Completed:Wait()
                
                ui:RemoveRGB(b)
                
                b:Destroy()
                a:Destroy()
            end)
        end)
    end
    
    function ui:AddMod(tab)
        
        --args = args or {}
        local a = Instance.new("TextLabel")
        a.Size = UDim2.new(1, 0, 0.04, 0)
        a.Position = UDim2.new(0, 0, 0, 0)
        a.Font = Enum.Font.SourceSansLight
        a.TextStrokeColor3 = ui.Colors["textoutline"]
        a.TextStrokeTransparency = 0
        a.TextColor3 = Color3.fromRGB(254, 254, 255)
        a.BackgroundTransparency = 1
        a.BorderSizePixel = 0
        a.TextXAlignment = Enum.TextXAlignment.Right
        a.TextYAlignment = Enum.TextYAlignment.Center
        a.TextWrapped = false
        a.TextScaled = true
        a.ZIndex = 205
        
        a.Text = tab["id"]
        if tab["linked_dd"] then
            a.Text = a.Text.." ("..tab["linked_dd"]["value"]..")"
        end
        a.Size = UDim2.new(1, #a.Text*20, 0.04, 0)
        
        a.Parent = ui:GetObject("MODULELIST")
        
        ui:TextLock(a, 35, 5)
        ui:AddRGB(a, "TextColor3")
        
        
        
        ui:Tween(a, {Size = UDim2.new(0.95, 0, 0.04, 0)}, 0.2, "Out", "Linear")
        
        
        if ui.EnabledMods[tab["id"]] then
            pcall(function() ui.EnabledMods[tab["id"]]:Destroy() end)
        end
        ui.EnabledMods[tab["id"]] = a
    end
    
    function ui:RemoveMod(name)
        ui:Tween(ui.EnabledMods[name], {Size = UDim2.new(1, #ui.EnabledMods[name].Text*20, 0, 0)}, 0.2, "In", "Linear")
        deb:AddItem(ui.EnabledMods[name], 0.2)
    end
    
    function ui:NewTrim(parent)
        local a = Instance.new("Frame")
        a.Parent = parent 
        a.Size = UDim2.new(1, 2, 0, 1)
        a.Position = UDim2.new(0, -1, 1, 0)
        a.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        a.ZIndex = parent.ZIndex
        a.BackgroundTransparency = 0
        a.BorderSizePixel = 0 
        
        ui:AddRGB(a, "BackgroundColor3")
    end
    
    
    function ui:NewEnum(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Dropdown then error"Attempt to create new Object (type Enum) parented to non-Dropdown Object." return end
        
        local parentself = parent["menu"]["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        local r, g, b = parent["self"].BackgroundColor3.R*255, parent["self"].BackgroundColor3.G*255, parent["self"].BackgroundColor3.B*255
        local color1 = Color3.fromRGB(r - 1, g - 1, b - 1)
        local color2 = Color3.fromRGB(r + 8, g + 8, b + 8)
        
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["enum"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 29
        a.Visible = true
        
        local b = Instance.new("TextButton")
        b.Text = params.Enum
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -20, 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 30
        
        ui:TextLock(b, 25, 0)
        
        
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["button"] = b
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["menu"]["objects"][id]["select"] = function()
            parent.SetValue(parent["menu"]["objects"][id], params.Enum)
            
        end
        

        
        parent["menu"]["objects"][id]["button"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["select"])

        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function() 
            if #(params["Description"] or "") == 0 then return end
            
            
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            
        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            if ui.Objects["DESCRIPTOR"].Text == params["Description"] then 
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        return parent["menu"]["objects"][id]
    end
    
    function ui:NewToggle(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Toggle) parented to non-Button Object." return end
        if not params.Text then error"Attempt to create new Object (type Toggle) without text parameter" return end
        
        local parentself = parent["menu"]["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        local r, g, b = parent["self"].BackgroundColor3.R*255, parent["self"].BackgroundColor3.G*255, parent["self"].BackgroundColor3.B*255
        local color1 = Color3.fromRGB(r - 1, g - 1, b - 1)
        local color2 = Color3.fromRGB(r + 8, g + 8, b + 8)
        
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["normal"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 25
        a.Visible = true
        
        local b = Instance.new("TextButton")
        b.Text = params.Text
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -(20+ui.Height), 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 25
        
        local c = Instance.new("ImageButton")
        c.Size = UDim2.new(0, ui.Height, 0, ui.Height)
        c.Position = UDim2.new(1, -ui.Height, 0, 0)
        c.Image = "rbxassetid://7197977900"
        c.ImageColor3 = Color3.fromRGB(255, 255, 255)
        c.Parent = a 
        c.BackgroundTransparency = 1
        c.BorderSizePixel = 0
        c.ZIndex = parent["menu"]["self"].ZIndex + 26
        
        
        local d = Instance.new("ImageLabel")
        d.Size = UDim2.new(0, ui.Height, 0, ui.Height)
        d.Position = UDim2.new(1, -ui.Height, 0, 0)
        d.Image = "rbxassetid://7202619688"
        d.ImageColor3 = Color3.fromRGB(255, 255, 255)
        d.Parent = a 
        d.BackgroundTransparency = 1
        d.BorderSizePixel = 0
        d.ZIndex = parent["menu"]["self"].ZIndex + 26
        d.Visible = false
        
        
        ui:TextLock(b, 30, 0)
        
        
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["title"] = b
        parent["menu"]["objects"][id]["button"] = c 
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["menu"]["objects"][id]["enablefunc"] = params.Enable
        parent["menu"]["objects"][id]["disablefunc"] = params.Disable
        
        parent["menu"]["objects"][id]["togglestate"] = false
        
        parent["menu"]["objects"][id]["Enable"] = function() 
            
            parent["menu"]["objects"][id]["togglestate"] = true
            ui:Tween(parent["menu"]["objects"][id]["self"], {BackgroundColor3 = ui.Colors["normal_high"]})
            
            ui:AddRGB(d, "ImageColor3")
            d.Visible = true
            
            parent["menu"]["objects"][id]["enablefunc"]()
        end
        
        parent["menu"]["objects"][id]["Disable"] = function() 
            parent["menu"]["objects"][id]["togglestate"] = false
            ui:Tween(parent["menu"]["objects"][id]["self"], {BackgroundColor3 = ui.Colors["normal"]})
            
            ui:RemoveRGB(d, "ImageColor3")
            d.Visible = false
            
            parent["menu"]["objects"][id]["disablefunc"]()
        end
        
        parent["menu"]["objects"][id]["toggle"] = function()
            (
                parent["menu"]["objects"][id]["togglestate"] and 
                parent["menu"]["objects"][id]["Disable"] or 
                parent["menu"]["objects"][id]["Enable"]
            )()
        end
        

        
        parent["menu"]["objects"][id]["button"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle"])
        parent["menu"]["objects"][id]["title"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle"])
        
        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function() 
            if #(params["Description"] or "") == 0 then return end
            
            
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            
        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            if ui.Objects["DESCRIPTOR"].Text == params["Description"] then 
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        return parent["menu"]["objects"][id]
    
    
    end
    
    function ui:NewDropdown(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Toggle) parented to non-Button Object." return end
    
        local parentself = parent["menu"]["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        local r, g, b = parent["self"].BackgroundColor3.R*255, parent["self"].BackgroundColor3.G*255, parent["self"].BackgroundColor3.B*255
        local color1 = Color3.fromRGB(r - 1, g - 1, b - 1)
        local color2 = Color3.fromRGB(r + 8, g + 8, b + 8)
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1 
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["normal"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 25
        
        local b = Instance.new("TextButton")
        b.Text = params.Text
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -(20+ui.Height), 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 25
        
        local c = Instance.new("ImageButton")
        c.Size = UDim2.new(0, ui.Height, 0, ui.Height)
        c.Position = UDim2.new(1, -ui.Height, 0, 0)
        c.Image = "rbxassetid://7184113125"
        c.ImageColor3 = Color3.fromRGB(255, 255, 255)
        c.ZIndex = parent["menu"]["self"].ZIndex + 26
        c.Parent = a 
        c.BackgroundTransparency = 1
        c.BorderSizePixel = 0
        c.Rotation = 180
        
        local d = Instance.new("Frame")
        d.Size = UDim2.new(1, 0, 3, -1)
        d.Parent = a
        d.Position = UDim2.new(0, 0, 0, 0)
        d.BackgroundColor3 = ui.Colors["enum"]
        d.BorderSizePixel = 1
        d.ZIndex = parent["menu"]["self"].ZIndex - 30
        d.ClipsDescendants = true
        
        
        ui:ListLock(d)
        ui:Pad(d, ui.Height)
        ui:TextLock(b, 30, 0)
        
        parent["menu"]["objects"][id] = {}
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["title"] = b
        parent["menu"]["objects"][id]["button"] = c
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["linked_dd"] = parent["menu"]["objects"][id]
        parent["menu"]["objects"][id]["debounce"] = false
        
        parent["menu"]["objects"][id]["value"] = nil
        parent["menu"]["objects"][id]["SetValue"] = function(sender, value) 
            for i,v in pairs(parent["menu"]["objects"][id]["menu"]["objects"]) do
                ui:RemoveRGB(v["button"])
                v["button"]["TextColor3"]=Color3.fromRGB(254, 254, 255)
            end
            ui:AddRGB(sender["button"], "TextColor3") 
            
            parent["menu"]["objects"][id]["value"] = value
            parent["menu"]["objects"][id]["title"].Text = params.Text.." ("..parent["menu"]["objects"][id]["value"]..")"
        end
        
        parent["menu"]["objects"][id]["objecttype"] = ui.ObjectTypes.Dropdown
        
        parent["menu"]["objects"][id]["menu"] = {}
        parent["menu"]["objects"][id]["menu"]["self"] = d
        parent["menu"]["objects"][id]["menu"]["objects"] = {}
        parent["menu"]["objects"][id]["menu"]["objectcount"] = 0
        
        parent["menu"]["objects"][id]["openstate"] = false
        parent["menu"]["objects"][id]["open"] = function() 
            parent["menu"]["objects"][id]["openstate"] = true
            
            
            ui:Tween(parent["bg"], {Size = parent["menu"]["bigsize"] + 
                UDim2.new(0, 0, 0, 
                    ui.Height * 
                    (parent["menu"]["objects"][id]["menu"]["objectcount"]
                        ))})
            ui:Tween(parent["menu"]["objects"][id]["menu"]["self"], {Size = UDim2.new(1, 0, 1 + (1* parent["menu"]["objects"][id]["menu"]["objectcount"]), 0)})
            ui:Tween(parent["menu"]["objects"][id]["button"], {Rotation = 360})
            ui:Tween(parent["menu"]["objects"][id]["bg"], {Size = UDim2.new(1, 0, 0, ui.Height * (1+parent["menu"]["objects"][id]["menu"]["objectcount"]))})
            
        end
        parent["menu"]["objects"][id]["close"] = function() 
            parent["menu"]["objects"][id]["openstate"] = false
            
            if parent["bg"].Size == parent["menu"]["bigsize"] + UDim2.new(0, 0, 0, ui.Height * (parent["menu"]["objects"][id]["menu"]["objectcount"])) then
                ui:Tween(parent["bg"], {Size = parent["menu"]["bigsize"]})
            end
            
            ui:Tween(parent["menu"]["objects"][id]["button"], {Rotation = 180})
            local bruh = ui:Tween(parent["menu"]["objects"][id]["menu"]["self"], {Size = UDim2.new(1, 0, 1, -1)})
            ui:Tween(parent["menu"]["objects"][id]["bg"], {Size = UDim2.new(1, 0, 0, ui.Height)})
            
            bruh.Completed:Connect(function()
                if parent["menu"]["objects"][id]["menu"]["self"].Size.Y.Offset > ui.Height then return end
                --for i,v in pairs(parent["menu"]["objects"][id]["menu"]["objects"]) do
                --    v["self"].Visible = false 
                --end
            end)
            
        end
        parent["menu"]["objects"][id]["toggle"] = function() 
            if debounce then return end
            
            debounce = true
            
            (
                parent["menu"]["objects"][id]["openstate"] and 
                parent["menu"]["objects"][id]["close"] or 
                parent["menu"]["objects"][id]["open"]
            )()
            
            wait(0.5)
            debounce = false
        end
        
        parent["menu"]["objects"][id]["title"].MouseButton2Click:Connect(parent["menu"]["objects"][id]["toggle"])
        parent["menu"]["objects"][id]["title"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle"])
        parent["menu"]["objects"][id]["button"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle"])
        parent["menu"]["objects"][id]["NewEnum"] = function(parent, id, params) return ui:NewEnum(parent, id, params) end
        parent["menu"]["objects"][id]["GetChild"]    = function(parent, childname)  return ui:GetChild(parent, childname) end
        parent["menu"]["objects"][id]["gc"]    = function(parent, childname)  return ui:GetChild(parent, childname) end
        
        for count,value in pairs(params.Enums) do
            parent["menu"]["objects"][id]:NewEnum(id.."_"..count, {Enum = value.Enum, Description = value.Description})
        end

        parent["menu"]["objects"][id].SetValue(parent["menu"]["objects"][id]:gc(id.."_1"), params.Enums[1].Enum)
        
        
        
        return parent["menu"]["objects"][id]
    end
    
    function ui:NewSlider(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Slider) parented to non-Button Object." return end
        
        local parentself = parent["menu"]["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1 
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["normal"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 25
        a.Visible = true
        
        local b = Instance.new("TextLabel")
        b.Text = params.Text
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 0.1
        b.BackgroundColor3 = ui.Colors["normal"]
        b.TextXAlignment = Enum.TextXAlignment.Center
        b.Parent = a
        b.Position = UDim2.new(0, 0, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, 0, 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 27
        b.BorderSizePixel = 0
        b.Visible = true
        b.Active = false
        
        
        local c = Instance.new("Frame")
        c.Size = UDim2.new(0.8, 0, 0, 5)
        c.BackgroundColor3 = Color3.new(1,1,1)
        c.BackgroundTransparency = 0
        c.BorderSizePixel = 0
        c.Parent = a
        c.Position = UDim2.new(0.1, 0, 0.5, -2.5)
        c.ZIndex = parent["menu"]["self"].ZIndex + 25
        c.ClipsDescendants = true
        c.Active = true
        
        
        
        local d = Instance.new("ImageLabel")
        d.Size = UDim2.new(1, 0, 1, 0)
        d.AnchorPoint = Vector2.new(1, 0)
        d.BackgroundColor3 = Color3.new(1,1,1)
        d.BackgroundTransparency = 0
        d.BorderSizePixel = 0
        d.Parent = c
        d.ImageTransparency = 1
        d.Position = UDim2.new(0, 0, 0, 0)
        d.ZIndex = parent["menu"]["self"].ZIndex + 26
        d.Active = false
        
        
        local e = Instance.new("TextLabel")
        e.Text = tostring(params.Min)
        e.Font = Enum.Font.SourceSansLight
        e.TextStrokeColor3 = ui.Colors["textoutline"]
        e.TextStrokeTransparency = 0
        e.TextColor3 = Color3.fromRGB(254, 254, 255)
        e.BackgroundTransparency = 1
        e.TextXAlignment = Enum.TextXAlignment.Left
        e.Parent = a
        e.Position = UDim2.new(0, 5, 0, 0)
        e.TextScaled = true
        e.Size = UDim2.new(0.1, -5, 0, ui.Height)
        e.ZIndex = parent["menu"]["self"].ZIndex + 26
        e.BorderSizePixel = 0
        
        
        
        
        ui:AddRGB(d, "BackgroundColor3")
        ui:TextLock(b, 30, 0)
        ui:TextLock(e, 19, 5)
        
        
        parent["menu"]["objects"][id]["bg"] = bg
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["title"] = b
        
        parent["menu"]["objects"][id]["slider1"] = c
        parent["menu"]["objects"][id]["slider2"] = d
        parent["menu"]["objects"][id]["counter"] = e
        
        
        
        parent["menu"]["objects"][id]["min"] = params.Min
        parent["menu"]["objects"][id]["max"] = params.Max
        parent["menu"]["objects"][id]["ratio"] = (params.Max - params.Min) / math.floor(d.AbsoluteSize.X)
        parent["menu"]["objects"][id]["value"] = params.Min
        
        parent["menu"]["objects"][id]["objecttype"] = ui.ObjectTypes.Slider
        
        
        
        
        c.InputBegan:Connect(function(input1)
            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                
                local x = math.floor(math.clamp(((input1.Position.X - c.AbsolutePosition.X)), 0, d.AbsoluteSize.X))
                ui:Tween(d, {Position = UDim2.new(0, x, 0, 0)})
                
                parent["menu"]["objects"][id]["value"] = params.Min + math.floor(x * parent["menu"]["objects"][id]["ratio"])
                e.Text = parent["menu"]["objects"][id]["value"] 
                local sussy = UDim2.new(0, x, 0, 0)
                
                ui.Connections["SLIDER_"..id] = uis.InputChanged:Connect(function(input2)
                    if input2.UserInputType == Enum.UserInputType.MouseMovement then
                        local delta = (input2.Position - input1.Position)
                        local x = math.floor(math.clamp(sussy.X.Offset + delta.X, 0, d.AbsoluteSize.X))
                        
                        parent["menu"]["objects"][id]["value"] = params.Min + math.floor(x * parent["menu"]["objects"][id]["ratio"])
                        e.Text = parent["menu"]["objects"][id]["value"] 
                        
                        ui:Tween(d, {Position = UDim2.new(0, x, 0, 0)}, 0.25, "Out", "Circular")
                    end
                end)
            end
        end)
        
        c.InputEnded:Connect(function(input1)
            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                ui.Connections["SLIDER_"..id]:Disconnect()
                
            end
        end) 
        
        
        
        
        parent["menu"]["objects"][id]["GetValue"] = function()
            return parent["menu"]["objects"][id]["value"]
        end
        
        parent["menu"]["objects"][id]["SetValueFromX"] = function(_,val)
            --X 89 ends up being value 50 with:
            --a size of 230 by 5
            --a min of 20 and max of 100
            
            local x = math.floor(math.clamp(val, 0, parent["menu"]["objects"][id]["slider2"].AbsoluteSize.X))
            
            parent["menu"]["objects"][id]["value"] = parent["menu"]["objects"][id]["min"] + math.floor(x * parent["menu"]["objects"][id]["ratio"])
            e.Text = parent["menu"]["objects"][id]["value"] 
            
            ui:Tween(d, {Position = UDim2.new(0, x, 0, 0)}, 0.25, "Out", "Circular")
            
        end
        
        
        
        
        
        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function()
            ui:Tween(b, {BackgroundTransparency = 1, TextTransparency = 1, TextStrokeTransparency = 1})
            if #(params["Description"] or "") == 0 then return end
            
            
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true
            ui.Objects["DESCRIPTOR"].Text = params["Description"]

        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            ui:Tween(b, {BackgroundTransparency = 0.1, TextTransparency = 0, TextStrokeTransparency = 0})
            if ui.Objects["DESCRIPTOR"].Text == params["Description"] then 
                
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        
        
        return parent["menu"]["objects"][id]
        
        
    end
    
    function ui:NewHotkey(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Hotkey) parented to non-Button Object." return end
        
        local parentself = parent["self"]
        
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        
        
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["normal"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 25
        a.Visible = true
        
        local b = Instance.new("TextButton")
        b.Text = "hotkey: none"
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -20, 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 25
        
        
        
        ui:TextLock(b, 30, 0)
        
        
        
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["button"] = b
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["menu"]["objects"][id]["hotkey"] = nil
        
        parent["menu"]["objects"][id]["objecttype"] = ui.ObjectTypes.Hotkey
        
        
        parent["menu"]["objects"][id]["capture"] = function() 
            b.Text = "Waiting for key press..."
            ui.Connections["GetNewHotkey"] = uis.InputBegan:Connect(function(io) 
                parent["menu"]["objects"][id]["hotkey"] = io.KeyCode
                
                if parent["menu"]["objects"][id]["hotkey"].Name == "Unknown" or parent["menu"]["objects"][id]["hotkey"].Name == "Escape" then
                    ui.Boundactions[id.."HK"] = nil
                    ctx:UnbindAction(id.."HK")
                    b.Text = "hotkey: none"
                else
                    ui.Boundactions[id.."HK"] = id.."HK"
                    ctx:BindActionAtPriority(id.."HK",function(_, state, obj)
                        if state == Enum.UserInputState.Begin then
                            parent["toggle"]()
                        end
                    end, false, 69696, parent["menu"]["objects"][id]["hotkey"])
                    b.Text = "hotkey: "..parent["menu"]["objects"][id]["hotkey"].Name
                end
                ui.Connections["GetNewHotkey"]:Disconnect()
            end)
            
            
            
        end
        
        
        
        
        
        parent["menu"]["objects"][id]["button"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["capture"])
        
        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function() 
            
            
            ui.Objects["DESCRIPTOR"].Text = "Click to assign a new hotkey to this module."
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true
        
        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            if ui.Objects["DESCRIPTOR"].Text == "Click to assign a new hotkey to this module." then 
                
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        return parent["menu"]["objects"][id]
    end
    

    
    function ui:NewInput(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Toggle) parented to non-Button Object." return end
        
        local parentself = parent["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1 
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["normal"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 25
        a.Visible = true
        
        local b = Instance.new("TextBox")
        b.Text = params.Text
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -20, 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 25
        
        
        
        ui:TextLock(b, 30, 0)
        
        
        
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["input"] = b
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["menu"]["objects"][id]["text"] = nil
        parent["menu"]["objects"][id]["onfocuslost"] = params.Function or function() end
        
        parent["menu"]["objects"][id]["objecttype"] = ui.ObjectTypes.Input
        
        
        
        
        
        
        parent["menu"]["objects"][id]["input"].FocusLost:Connect(parent["menu"]["objects"][id]["onfocuslost"])
        
        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function() 
            if #(params["Description"] or "") == 0 then return end
            
            
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true

        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            if ui.Objects["DESCRIPTOR"].Text == params["Description"] then 
                
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        return parent["menu"]["objects"][id]
    end
    
    function ui:NewColor(parent, id, params)
        if parent["objecttype"] ~= ui.ObjectTypes.Button then error"Attempt to create new Object (type Toggle) parented to non-Button Object." return end
    end
    
    
    function ui:NewButton(parent,id,params)
        if parent["objecttype"] ~= ui.ObjectTypes.Menu then error"Attempt to create new Object (type Button) parented to non-Menu Object." return end
        
        params.Enable = params.Enable or function() end
        params.Disable = params.Disable or nil
        
        local single = false 
        if params.Enable and not params.Disable then
            single = true
        end
        
        
        local parentself = parent["self"]
        
        parent["menu"]["objectcount"] = parent["menu"]["objectcount"] + 1
        parent["menu"]["objects"][id] = {}
        
        
        local r, g, b = parent["self"].BackgroundColor3.R*255, parent["self"].BackgroundColor3.G*255, parent["self"].BackgroundColor3.B*255
        local color1 = Color3.fromRGB(r - 2, g - 2, b - 2)
        local color2 = Color3.fromRGB(r + 16, g + 16, b + 16)
        local color3 = Color3.fromRGB(r - 4, g - 4, b - 4)
        
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 0, ui.Height)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.Parent = parent["menu"]["self"]
        bg.Position = UDim2.new(0, 0, 0, 0)
        bg.BackgroundTransparency = 1
        bg.ClipsDescendants = true
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(1, 0, 0, ui.Height)
        a.BackgroundColor3 = ui.Colors["button"]
        a.BorderSizePixel = 0
        a.Parent = bg
        a.Position = UDim2.new(0, 0, 0, 0)
        a.ZIndex = parent["menu"]["self"].ZIndex + 28
        a.Active = true
        
    
        
        local b = Instance.new("TextButton")
        b.Text = params.Text
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -(ui.Height+20), 1, 0)
        b.ZIndex = parent["menu"]["self"].ZIndex + 28
        
        local c = Instance.new("ImageButton")
        c.Size = UDim2.new(0, ui.Height, 0, ui.Height)
        c.Position = UDim2.new(1, -ui.Height, 0, 0)
        c.Image = "rbxassetid://7184227434"
        c.ImageColor3 = Color3.fromRGB(255, 255, 255)
        c.Parent = a 
        c.BackgroundTransparency = 1
        c.BorderSizePixel = 0
        c.ZIndex = parent["menu"]["self"].ZIndex + 29
        
        local d = Instance.new("ScrollingFrame")
        d.Size = UDim2.new(1, 0, 1, 0)
        d.Parent = a
        d.BackgroundTransparency = 1 
        d.Position = UDim2.new(0, 0, 0, 0)
        d.BorderSizePixel = 0
        d.CanvasSize = UDim2.new(1, 0, 0, 0)
        d.ZIndex = parent["menu"]["self"].ZIndex + 1
        d.ClipsDescendants = false
        
        d.AutomaticCanvasSize = Enum.AutomaticSize.Y
        d.ScrollBarThickness = 0
        d.ScrollingEnabled = false
        d.ScrollingDirection = Enum.ScrollingDirection.Y
        
        ui:TextLock(b)
        ui:ListLock(d)
        ui:Pad(d, ui.Height)
        
        
        
        parent["menu"]["objects"][id]["self"] = a
        parent["menu"]["objects"][id]["title"] = b
        parent["menu"]["objects"][id]["settings"] = c 
        parent["menu"]["objects"][id]["bg"] = bg
        
        parent["menu"]["objects"][id]["objecttype"] = ui.ObjectTypes.Button
        parent["menu"]["objects"][id]["linked_dd"] = nil
        parent["menu"]["objects"][id]["id"] = id
        
        parent["menu"]["objects"][id]["menu"] = {}
        parent["menu"]["objects"][id]["menu"]["self"] = d
        parent["menu"]["objects"][id]["menu"]["objectcount"] = 0
        parent["menu"]["objects"][id]["menu"]["objects"] = {}
        
        
        parent["menu"]["objects"][id]["openstate"] = false
        parent["menu"]["objects"][id]["open"] = function() 
            parent["menu"]["objects"][id]["openstate"] = true
            
            parent["menu"]["objects"][id]["menu"]["bigsize"] = UDim2.new(1, 0, 0, ui.Height * (1 + parent["menu"]["objects"][id]["menu"]["objectcount"]))
            ui:Tween(parent["menu"]["objects"][id]["bg"], {Size = parent["menu"]["objects"][id]["menu"]["bigsize"]})
            ui:Tween(parent["menu"]["objects"][id]["menu"]["self"], {Size = UDim2.new(1, 0, 1, 0)})
            ui:Tween(parent["menu"]["objects"][id]["settings"], {Rotation = 90})
        end
        parent["menu"]["objects"][id]["close"] = function() 
            parent["menu"]["objects"][id]["openstate"] = false
            
            ui:Tween(parent["menu"]["objects"][id]["menu"]["self"], {Size = UDim2.new(1, 0, 0, ui.Height)})
            ui:Tween(parent["menu"]["objects"][id]["settings"], {Rotation = 0})
            local bruh = ui:Tween(parent["menu"]["objects"][id]["bg"], {Size = UDim2.new(1, 0, 0, ui.Height)})
            
            
            bruh.Completed:Connect(function()
                if parent["menu"]["objects"][id]["bg"].Size.Y.Offset > ui.Height then return end
                for i,v in pairs(parent["menu"]["objects"][id]["menu"]["objects"]) do
                    
                    if v["objecttype"] == ui.ObjectTypes.Dropdown and v["openstate"] then
                        v["close"]()
                    end
                end
            end)
        end
        
        
        parent["menu"]["objects"][id]["toggle_open"] = function() 
            (
                parent["menu"]["objects"][id]["openstate"] and 
                parent["menu"]["objects"][id]["close"] or 
                parent["menu"]["objects"][id]["open"]
            )()
        end
        
        
        if not single then
            parent["menu"]["objects"][id]["togglestate"] = false
            parent["menu"]["objects"][id]["enable"] = function() 
                
                parent["menu"]["objects"][id]["togglestate"] = true
                
                ui:Tween(parent["menu"]["objects"][id]["self"], {BackgroundColor3 = ui.Colors["button_high"]}, 0.25)
                
                params.Enable()
                ui:AddMod(parent["menu"]["objects"][id])
            end
            
            parent["menu"]["objects"][id]["disable"] = function() 
                parent["menu"]["objects"][id]["togglestate"] = false
                ui:Tween(parent["menu"]["objects"][id]["self"], {BackgroundColor3 = ui.Colors["button"]}, 0.25)
                
                
                params.Disable()
                ui:RemoveMod(id)
            end
            
            
            
            
            parent["menu"]["objects"][id]["toggle"] = function()
                (
                    parent["menu"]["objects"][id]["togglestate"] and 
                    parent["menu"]["objects"][id]["disable"] or 
                    parent["menu"]["objects"][id]["enable"]
                )()
            end
        
        else
            parent["menu"]["objects"][id]["enable"] = params.Enable
            
            parent["menu"]["objects"][id]["toggle"] = function() 
                parent["menu"]["objects"][id]["enable"]()
            end
        end
        

        

        
        parent["menu"]["objects"][id]["settings"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle_open"])
        parent["menu"]["objects"][id]["title"].MouseButton1Click:Connect(parent["menu"]["objects"][id]["toggle"])
        parent["menu"]["objects"][id]["title"].MouseButton2Click:Connect(parent["menu"]["objects"][id]["toggle_open"])
        
        parent["menu"]["objects"][id]["self"].MouseEnter:Connect(function() 
            if #(params["Description"] or "") == 0 then return end
            
            
            ui.Objects["DESCRIPTOR"].Text = params["Description"]
            ui.Objects["DESCRIPTOR"].Size = UDim2.new(0.1, b.TextBounds.X, 0.04, b.TextBounds.Y)
            
            ui.Objects["DESCRIPTOR"].Visible = true
            ui.Objects["DESCRIPTOR"].Text = params["Description"]

        end)
        
        parent["menu"]["objects"][id]["self"].MouseLeave:Connect(function()
            if ui.Objects["DESCRIPTOR"].Text == params["Description"] then 
                
                ui.Objects["DESCRIPTOR"].Visible = false
            end
        end)
        
        parent["menu"]["objects"][id]["NewSlider"]   = function(parent, id, params) return ui:NewSlider(parent, id, params) end
        parent["menu"]["objects"][id]["NewDropdown"] = function(parent, id, params) return ui:NewDropdown(parent, id, params) end
        parent["menu"]["objects"][id]["NewInput"]    = function(parent, id, params) return ui:NewInput(parent, id, params) end
        parent["menu"]["objects"][id]["NewColor"]    = function(parent, id, params) return ui:NewColor(parent, id, params) end
        parent["menu"]["objects"][id]["NewToggle"]   = function(parent, id, params) return ui:NewToggle(parent, id, params) end
        parent["menu"]["objects"][id]["NewHotkey"]   = function(parent, id, params) return ui:NewHotkey(parent, id, params) end
        
        
        
        parent["menu"]["objects"][id]["GetChild"]    = function(parent, childname)  return ui:GetChild(parent, childname) end
        parent["menu"]["objects"][id]["gc"]    = function(parent, childname)  return ui:GetChild(parent, childname) end
        
        return parent["menu"]["objects"][id]
    end
    
    function ui:NewMenu(title, objects)
        ui.MenuCount = ui.MenuCount + 1
        
        local a = Instance.new("Frame")
        a.Size = UDim2.new(0.15, 0, 0, ui.Height)
        a.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
        a.BorderSizePixel = 0
        a.Parent = ui:GetObject("MAIN")
        
        if ui.MenuCount > 8 then
            a.Position = UDim2.new(0, 350 * ((ui.MenuCount-8)-0.3), 0.2, 50)
        elseif ui.MenuCount > 4 then
            a.Position = UDim2.new(0, 350 * ((ui.MenuCount-4)-0.3), 0.1, 50)
        else
            a.Position = UDim2.new(0, 350 * (ui.MenuCount-0.3), 0, 50)
        end
        
        
        a.ZIndex = 300 + (ui.MenuCount+2)*30
        
        
        local b = Instance.new("TextButton")
        b.Text = title
        b.Font = Enum.Font.SourceSansLight
        b.TextStrokeColor3 = ui.Colors["textoutline"]
        b.TextStrokeTransparency = 0
        b.TextColor3 = Color3.fromRGB(254, 254, 255)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Parent = a
        b.Position = UDim2.new(0, 20, 0, 0)
        b.TextScaled = true
        b.Size = UDim2.new(1, -20, 1, 0)
        b.ZIndex = a.ZIndex
        b.AutoButtonColor = false
        
        local c = Instance.new("ImageButton")
        c.Size = UDim2.new(0, ui.Height, 0, ui.Height)
        c.Position = UDim2.new(1, -ui.Height, 0, 0)
        c.Image = "rbxassetid://7184113125"
        c.ImageColor3 = Color3.fromRGB(255, 255, 255)
        c.ZIndex = a.ZIndex + 1
        c.BackgroundTransparency = 1
        c.BorderSizePixel = 0
        c.Rotation = 180
        c.Parent = a
        
        local d = Instance.new("ScrollingFrame")
        d.Size = UDim2.new(1, 0, 1, -1)
        d.Position = UDim2.new(0, 0, 0, 0)
        d.BackgroundColor3 = ui.Colors["menu"]
        d.BackgroundTransparency = 0
        d.BorderSizePixel = 1
        d.CanvasSize = UDim2.new(1, 0, 0, 0)
        d.ZIndex = a.ZIndex - 30
        d.ClipsDescendants = true
        d.Active = true
        d.Parent = a
        
        d.AutomaticCanvasSize = Enum.AutomaticSize.Y
        d.ScrollBarThickness = 0
        d.ScrollingEnabled = true
        d.ScrollingDirection = Enum.ScrollingDirection.Y
        
        
        ui:ListLock(d)
        ui:Pad(d, ui.Height)
        ui:NewTrim(a)
        ui:AddRGB(b, "TextColor3")
        ui:TextLock(b)
        
        ui:AddRGB(d, "BorderColor3")
        
        
        ui.Objects[title] = {}
        ui.Objects[title]["self"] = a
        ui.Objects[title]["title"] = b
        ui.Objects[title]["button"] = c
        
        ui.Objects[title]["objecttype"] = ui.ObjectTypes.Menu
        
        ui.Objects[title]["menu"] = {}
        ui.Objects[title]["menu"]["self"] = d
        ui.Objects[title]["menu"]["objects"] = {}
        ui.Objects[title]["menu"]["objectcount"] = 0
        
        ui.Objects[title]["openstate"] = false
        ui.Objects[title]["open"] = function() 
            ui.Objects[title]["openstate"] = true
            
            ui:Tween(ui.Objects[title]["menu"]["self"], {Size = UDim2.new(1, 0, 1 + (1* ui.Objects[title]["menu"]["objectcount"]), 0)})
            ui:Tween(ui.Objects[title]["button"], {Rotation = 360})
            
            
        end
        ui.Objects[title]["close"] = function() 
            ui.Objects[title]["openstate"] = false
            ui:Tween(ui.Objects[title]["menu"]["self"], {Size = UDim2.new(1, 0, 1, -1)})
            ui:Tween(ui.Objects[title]["button"], {Rotation = 180})
            
        end
        ui.Objects[title]["toggle"] = function() 
            (
                ui.Objects[title]["openstate"] and 
                ui.Objects[title]["close"] or 
                ui.Objects[title]["open"]
            )()
        end
        
        ui.Objects[title]["button"].MouseButton1Click:Connect(ui.Objects[title]["toggle"])
        ui.Objects[title]["title"].MouseButton2Click:Connect(ui.Objects[title]["toggle"])
        
        
        ui.Objects[title]["NewButton"] = function(parent, id, params)    return ui:NewButton(parent, id, params) end
        ui.Objects[title]["GetChild"] = function(parent, childname)      return ui:GetChild(parent, childname) end
        ui.Objects[title]["gc"] = function(parent, childname)      return ui:GetChild(parent, childname) end
        
        b.InputBegan:Connect(function(input1)
            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                local sussy = a.Position
                
                ui.Connections["DRAGGING_"..title] = game:GetService("UserInputService").InputChanged:Connect(function(input2)
                    if input2.UserInputType == Enum.UserInputType.MouseMovement then
                        local delta = (input2.Position - input1.Position)
                        
                        ui:Tween(a, {Position = UDim2.new(sussy.X.Scale, sussy.X.Offset + delta.X, sussy.Y.Scale, sussy.Y.Offset + delta.Y)}, 0.25, "Out", "Circular")
                    end
                end)
            end
        end)
        
        b.InputEnded:Connect(function(input1)
            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                ui.Connections["DRAGGING_"..title]:Disconnect()
                
            end
        end) 
        
        return ui.Objects[title]
    end
    
    
    function ui:Shutdown() 
        ui:GetObject("WATERMARK").Modal = false
        
        ui:GetObject("SCREENGUI"):Destroy()
        ctx:UnbindAction("TOGGLE")
        ctx:UnbindAction("CLOSE")
        rs:UnbindFromRenderStep("RAINBOW")
        rs:UnbindFromRenderStep("DESCRIPTOR")
        ui:GetObject("CCEFFECT"):Destroy()
        
        for _,con in pairs(ui.Connections) do
            pcall(function() 
                con:Disconnect()
            end)
        end
        
        for _,bind in pairs(ui.Boundsteps) do
            rs:UnbindFromRenderStep(bind) 
        end
        for _,bind in pairs(ui.Boundactions) do
            ctx:UnbindAction(bind) 
        end
        
        for _,inst in pairs(ui.ExtInstances) do
            pcall(function() 
                inst:Destroy()
            end)
        end
        
        
        pcall(function() workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid end)
        
        ui.Connections = nil
        ui.Boundsteps = nil
        ui.Boundactions = nil
        ui.ExtInstances = nil
        ui.Objects = nil
        ui.ObjectTypes = nil 
        ui = nil
        
        uis.MouseIconEnabled = true
        
        
        _G.IsSpectrumLoaded = false
    end
    
    
end

if not plr.Character then plr.CharacterAdded:Wait() end

ui:Init()

local cfn = CFrame.new
local cfa = CFrame.Angles
local v3 = Vector3.new


local crosshair
local movement
local speed
local applied_speedspoof = false
local speedspoof_active = false
local flight
local flight_sit
local flight_smooth
local flight_fmethod
local flight_speed
local flight_cctrls
local phase
local phase_idle
local phase_facecenter
local phase_speed
local gravity
local quickfall
local render
local esp
local esp_self = false
local esp_transparency
local esp_method
local remotespam
local remotespam_enable = false
local remotespam_delay


movement = ui:NewMenu("movement")

speed = movement:NewButton("speed", {Text = "speed", Description = "Lets you move insanely fast. Has several anticheat bypass modes",
    Enable = function()
        local mode = movement:gc("speed"):gc("speedmethod")["value"]
        local a = movement:gc("speed"):gc("speedval")
        
        if mode == "WalkSpeed" then
            rs:BindToRenderStep("diff-speed", 205, function() 
                pcall(function() 
                    plr.Character.Humanoid.WalkSpeed = a["value"] 
                    
                end)
            end)
        elseif mode == "CFrame" then
            rs:BindToRenderStep("diff-speed", 205, function() 
                pcall(function() 
                    plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + (plr.Character.Humanoid.MoveDirection * (a["value"]/75))
                    
                end)
            end)
        elseif mode == "Velocity" then
            if not plr.Character then plr.CharacterAdded:Wait() end
            
            local bf
            
            ui.Connections["SVRespawn"] = plr.CharacterAdded:Connect(function(chr) 
                bf = Instance.new("BodyForce")
                bf.Name = "VEL"
                bf.Parent = chr:WaitForChild("HumanoidRootPart")
                
                ui.ExtInstances["SpeedVelocity"] = bf
            end)
            
            bf = Instance.new("BodyForce")
            bf.Name = "VEL"
            bf.Parent = plr.Character.HumanoidRootPart
            
            ui.ExtInstances["SpeedVelocity"] = bf
            
            
            rs:BindToRenderStep("diff-speed", 205, function() 
                pcall(function() 
                    bf.Force = (plr.Character.Humanoid.MoveDirection * 1500) * (a["value"] * 0.1)
                    
                end)
            end)
        elseif mode == "Bhop" then
            if not plr.Character then plr.CharacterAdded:Wait() end
            
            local bf
            
            ui.Connections["SVRespawn"] = plr.CharacterAdded:Connect(function(chr) 
                bf = Instance.new("BodyForce")
                bf.Name = "VEL"
                bf.Parent = chr:WaitForChild("HumanoidRootPart")
                
                ui.ExtInstances["SpeedVelocity"] = bf
            end)
            bf = Instance.new("BodyForce")
            bf.Name = "VEL"
            bf.Parent = plr.Character.HumanoidRootPart
            
            ui.ExtInstances["SpeedVelocity"] = bf
            
            
            rs:BindToRenderStep("diff-speed", 205, function() 
                pcall(function() 
                    if plr.Character.Humanoid.MoveDirection.Magnitude ~= 0 then
                        plr.Character.Humanoid.Jump = true
                    end
                end)
                pcall(function() 
                    bf.Force = (plr.Character.Humanoid.MoveDirection * 400) * (a["value"] * 0.4) - v3(0, 200, 0)
                    
                end)
            end)
        else    
            ui:Message("Unknown speed mode")
        end
        
        mode = nil
        ui.Boundsteps["diff-speed"] = "diff-speed"
    end,
    Disable = function() 
        rs:UnbindFromRenderStep("diff-speed")
        
        if plr.Character then 
            pcall(function() 
                plr.Character.Humanoid.WalkSpeed = 16
            end)
            pcall(function()
                plr.Character.HumanoidRootPart["VEL"]:Destroy()
            end)
        end
        if ui.Connections["SVRespawn"] then
            ui.Connections["SVRespawn"]:Disconnect()
        end
        
        ui.Connections["SVRespawn"] = nil
        ui.Boundsteps["diff-speed"] = nil
        ui.ExtInstances["SpeedVelocity"] = nil
    end
})


speed:NewToggle("speedspoof", {
    Text = "walkspeed spoofer", 
    Description = "This setting prevents walkspeed changes from being detected, but may lag your game! DON'T COMBINE WITH ANY METATABLE HOOK SCRIPTS!",
    Enable = function()
        if not hookfunction then
            speed:gc("speedspoof"):Disable()
            ui:Message("Your exploit doesn't support hookfunction")
            return 
            
        end
        
        
        if applied_speedspoof == false then
            local a;
            local b=getrawmetatable(game)
            setreadonly(b,false)
            a=hookfunction(b.__index,newcclosure(function(...)
                return (speedspoof_active and ({...})[2]=="WalkSpeed") and not iscaller() and 16 or a(...)
            end))
            setreadonly(b,true)
            
            
            applied_speedspoof = true
        end
        
        speedspoof_active = true
    end,
    Disable = function() 
        speedspoof_active = false
    end
    
})
speed:NewSlider("speedval", {Text = "speed amount", Description = "Amount used in the specified speed mode", Max = 200, Min = 16})
speed:NewDropdown("speedmethod", {Text = "method", Description = "The method Speed should use", Enums = {
    {Enum = "WalkSpeed", Description = "The standard mode. Can be detected unless you use the spoofer"},
    {Enum = "CFrame", Description = "A more advanced mode. Can only be detected through magnitude checking"},
    {Enum = "Velocity", Description = "Increases your XZ velocity with a BodyForce. Can be detected easily, but this mode isn't as common as WalkSpeed"},
    {Enum = "Bhop", Description = "Enables Velocity and constantly jumps to increase your speed. Based off of Bhop from clients like Wurst"}
    
}})
speed:NewHotkey("speedkey")

flight = movement:NewButton("flight",     {Text = "flight", Description = "Lets you fly",
    Enable = function() 
        
        if not plr.Character then plr.CharacterAdded:Wait() end
        
        local e = Instance.new("Part")
        e.CanCollide = false
        e.Anchored = false
        e.Name = "sussy among ussy"
        e.Transparency = 1
        e.CFrame = plr.Character.HumanoidRootPart.CFrame
        e.Parent = workspace
        
        
        local f = Instance.new("BodyPosition")
        f.D = 9999
        f.P = 999999
        f.MaxForce = v3(900000, 900000, 900000)
        f.Parent = e
        
        local g = Instance.new("BodyGyro")
        g.D = 200
        g.P = 9999
        g.MaxTorque = v3(900000, 900000, 900000)
        g.Parent = e
        
        ui.ExtInstances["FlightPart"] = e
        
        
        if not flight_smooth["togglestate"] then
            f.D = 700
            f.P = 99999
            f.MaxForce = v3(90000, 90000, 90000)
        end
        
        
        local cfr = plr.Character.HumanoidRootPart.CFrame
        f.Position = cfr.Position
        
        local float
        
        if flight_fmethod["value"] == "Undetectable" then
            float = function() 
                for i,v in pairs(plr.Character:GetChildren()) do
                    pcall(function() v.Velocity = v3(0, 0, 0) end)
                end
                plr.Character.Humanoid:ChangeState(1)
            end
        elseif flight_fmethod["value"] == "Velocity" then
            local h = Instance.new("BodyVelocity")
            h.Velocity = v3(0, 0, 0)
            h.Parent = plr.Character.HumanoidRootPart
            
            ui.ExtInstances["FloatPart"] = h
            float = function() 
                plr.Character.Humanoid:ChangeState(1)
            end
            
        elseif flight_fmethod["value"] == "Noclip" then
            float = function()
                plr.Character.Humanoid:ChangeState(11)
            end
            
        elseif flight_fmethod["value"] == "None" then
            float = function() 
                plr.Character.Humanoid:ChangeState(1)
            end
        end
        
        
        
        if flight_sit then
            local anim = plr.Character.Humanoid:LoadAnimation(plr.Character.Animate.sit.SitAnim)
            
            if flight_cctrls["togglestate"] then
                rs:BindToRenderStep("diff-flight", 1450, function(delta) 
                    local up = uis:IsKeyDown(Enum.KeyCode.E)
                    local down = uis:IsKeyDown(Enum.KeyCode.Q)
                    local forw = uis:IsKeyDown(Enum.KeyCode.W)
                    local back = uis:IsKeyDown(Enum.KeyCode.S)
                    
                    pcall(function()
                        
                        anim:Play(0, 5, 1)
                        
                        --make float
                        pcall(float)
                        
                        local clv = workspace.CurrentCamera.CFrame.LookVector
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * (flight_speed["value"] * 75) * delta)
                        
                        if up then
                            cfr = cfr + v3(0, (flight_speed["value"] * 50) * delta, 0)
                        elseif down then
                            cfr = cfr - v3(0, (flight_speed["value"] * 50) * delta, 0)
                        end
                        
                        if forw then
                            cfr = cfr + v3(0, ((clv.Y * (flight_speed["value"] * 75) )* delta), 0)
                        elseif back then
                            cfr = cfr - v3(0, ((clv.Y * (flight_speed["value"] * 75) )* delta), 0)
                        end
                        
                        f.Position = cfr.Position
                        g.CFrame = CFrame.lookAt(cfr.Position, cfr.Position + clv)
                        
                        plr.Character.HumanoidRootPart.CFrame = e.CFrame
                    end)
                end)
            
            else
                rs:BindToRenderStep("diff-flight", 1450, function(delta) 
                    local up = uis:IsKeyDown(Enum.KeyCode.E)
                    local down = uis:IsKeyDown(Enum.KeyCode.Q)
                    
                    
                    pcall(function()
                        
                        anim:Play(0, 5, 1)
                        
                        --make float
                        pcall(float)
                        
                        local clv = workspace.CurrentCamera.CFrame.LookVector
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * (flight_speed["value"] * 75) * delta)
                        
                        if up then
                            cfr = cfr + v3(0, (flight_speed["value"] * 50) * delta, 0)
                        elseif down then
                            cfr = cfr - v3(0, (flight_speed["value"] * 50) * delta, 0)
                        end
                        
                        f.Position = cfr.Position
                        g.CFrame = CFrame.lookAt(cfr.Position, cfr.Position + clv)
                        
                        plr.Character.HumanoidRootPart.CFrame = e.CFrame
                    end)
                end)
            end
        else
            if flight_cctrls["togglestate"] then
                rs:BindToRenderStep("diff-flight", 1450, function(delta) 
                    local up = uis:IsKeyDown(Enum.KeyCode.E)
                    local down = uis:IsKeyDown(Enum.KeyCode.Q)
                    local forw = uis:IsKeyDown(Enum.KeyCode.W)
                    local back = uis:IsKeyDown(Enum.KeyCode.S)
                    
                    pcall(function()
                        
                        --stop anims
                        local at = plr.Character.Humanoid:GetPlayingAnimationTracks()
                        for i, track in pairs(at) do
                        	track:Stop()
                        end
                        
                        --make float
                        pcall(float)
                        
                        local clv = workspace.CurrentCamera.CFrame.LookVector
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * (flight_speed["value"] * 75) * delta)
                        
                        if up then
                            cfr = cfr + v3(0, (flight_speed["value"] * 50) * delta, 0)
                        elseif down then
                            cfr = cfr - v3(0, (flight_speed["value"] * 50) * delta, 0)
                        end
                        
                        if forw then
                            cfr = cfr + v3(0, ((clv.Y * (flight_speed["value"] * 50) )* delta), 0)
                        elseif back then
                            cfr = cfr - v3(0, ((clv.Y * (flight_speed["value"] * 50) )* delta), 0)
                        end
                        
                        f.Position = cfr.Position
                        g.CFrame = CFrame.lookAt(cfr.Position, cfr.Position + clv)
                        
                        plr.Character.HumanoidRootPart.CFrame = e.CFrame
                    end)
                end)
            else
            
                rs:BindToRenderStep("diff-flight", 1450, function(delta) 
                    local up = uis:IsKeyDown(Enum.KeyCode.E)
                    local down = uis:IsKeyDown(Enum.KeyCode.Q)
                    
                    pcall(function()
                        
                        --stop anims
                        local at = plr.Character.Humanoid:GetPlayingAnimationTracks()
                        for i, track in pairs(at) do
                        	track:Stop()
                        end
                        
                        --make float
                        pcall(float)
                        
                        local clv = workspace.CurrentCamera.CFrame.LookVector
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * (flight_speed["value"] * 75) * delta)
                        
                        if up then
                            cfr = cfr + v3(0, (flight_speed["value"] * 50) * delta, 0)
                        elseif down then
                            cfr = cfr - v3(0, (flight_speed["value"] * 50) * delta, 0)
                        end
                        
                        
                        f.Position = cfr.Position
                        g.CFrame = CFrame.lookAt(cfr.Position, cfr.Position + clv)
                        
                        plr.Character.HumanoidRootPart.CFrame = e.CFrame
                    end)
                end)
            end
        end

        
        ui.Boundsteps["diff-flight"] = "diff-flight"
    end, 
    Disable = function()
        pcall(function()
        plr.Character.Humanoid:ChangeState(8)
        end)
        
        rs:UnbindFromRenderStep("diff-flight")
        
        if ui.Connections["FlyRespawn"] then
            ui.Connections["FlyRespawn"]:Disconnect()
        end
        if ui.ExtInstances["FlightPart"] then
            ui.ExtInstances["FlightPart"]:Destroy() 
        end
        if ui.ExtInstances["FloatPart"] then
            ui.ExtInstances["FloatPart"]:Destroy()
        end
        
        ui.ExtInstances["FlightPart"] = nil
        ui.ExtInstances["FloatPart"] = nil
        ui.Connections["FlyRespawn"] = nil
        ui.Boundsteps["diff-flight"] = nil
    end
})

flight:NewToggle("flightsit", {Text = "sit", Description = "Makes you sit while you fly :)", 
    Enable = function() 
        if not plr.Character then
            ui:Message("No character found! Please enable this when you're spawned in!")
            return 
        else
            if not pcall(function() return plr.Character.Animate.sit.SitAnim end) then 
                ui:Message("Sit is not compatible with games that don't support the default animations") 
                flight:gc("flightsit")["Disable"]()
            end
        end
        
        flight_sit = true
        
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end, 
    Disable = function() 
        flight_sit = false
        
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end
})


flight_smooth = flight:NewToggle("flightsmooth", {Text = "smooth flight", Description = "Self explanatory", 
    Enable = function() 
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end, 
    Disable = function()
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end
})

flight_smooth:Enable()

flight_cctrls = flight:NewToggle("flightcctrls", {Text = "camera-based", Description = "When enabled, the camera's direction will affect your vertical movement", 
    Enable = function() 
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end, 
    Disable = function()
        if flight["togglestate"] then
            flight["disable"]()
            flight["enable"]()
        end
    end
})
flight_cctrls:Enable()


flight_speed = flight:NewSlider("flightspeed", {Text = "speed", Description = "How fast you fly", Min = 1, Max = 20})
flight_fmethod = flight:NewDropdown("flightfm", {Text = "float method", Description = "Essentially the method Flight uses to remain undetected", Enums = {
    {Enum = "Undetectable", Description = "Completely undetectable, but may effect how your character looks (not as much as None)"},
    {Enum = "Velocity", Description = "Detectable. May glitch out your character"},
    {Enum = "Noclip", Description = "Detectable. If you want to noclip while flying, use this mode!"},
    {Enum = "None", Description = "May glitch your character out!"}
}})

flight:NewHotkey("flightkey")

phase = movement:NewButton("phase",      {Text = "phase", Description = "Teleports you very fast around a central position. Can prevent players from interacting with you",
    Enable = function() 
        local minimum = nil
        local maximum = nil
        local choices = {-1, 1}
        
        local a = Instance.new("Part")
        ui.ExtInstances["phase_campart"] = a
        a.Transparency = 1
        a.CanCollide = false
        a.Anchored = true
        a.Parent = workspace
        
        local cfr = plr.Character.HumanoidRootPart.CFrame
        a.CFrame = cfr
        
        
        ui.Boundsteps["diff-phase"] = "diff-phase"
        if phase_idle then
            if phase_facecenter then
                rs:BindToRenderStep("diff-phase", 2000, function(delta)
                    pcall(function() 
                        workspace.CurrentCamera.CameraSubject = a
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * phase_speed["value"]) * delta
                        a.CFrame = cfr
                        
                        minimum = movement:gc("phase"):gc("phasemin")["value"]
                        maximum = movement:gc("phase"):gc("phasemax")["value"]
                        
                        
                        plr.Character.HumanoidRootPart.CFrame = CFrame.lookAt((cfr + v3(choices[math.random(1,2)] * math.random(minimum, maximum), 0, choices[math.random(1,2)] * math.random(minimum, maximum))).Position, cfr.Position)
                    end)
                end)
            else
                rs:BindToRenderStep("diff-phase", 2000, function(delta)
                    pcall(function() 
                        workspace.CurrentCamera.CameraSubject = a
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * phase_speed["value"]) * delta
                        a.CFrame = cfr
                        
                        minimum = movement:gc("phase"):gc("phasemin")["value"]
                        maximum = movement:gc("phase"):gc("phasemax")["value"]
                        
                        
                        plr.Character.HumanoidRootPart.CFrame = cfr + v3(choices[math.random(1,2)] * math.random(minimum, maximum), 0, choices[math.random(1,2)] * math.random(minimum, maximum))
                    end)
                end)
            end
        else
            if phase_facecenter then
                rs:BindToRenderStep("diff-phase", 2000, function(delta)
                    pcall(function() 
                        workspace.CurrentCamera.CameraSubject = a
                        
                        if plr.Character.Humanoid.MoveDirection.Magnitude == 0 then 
                            plr.Character.HumanoidRootPart.CFrame = cfr
                            return
                        end
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * phase_speed["value"]) * delta
                        a.CFrame = cfr
                        
                        minimum = movement:gc("phase"):gc("phasemin")["value"]
                        maximum = movement:gc("phase"):gc("phasemax")["value"]
                        
                        plr.Character.HumanoidRootPart.CFrame = cfn((cfr + v3(choices[math.random(1,2)] * math.random(minimum, maximum), 0, choices[math.random(1,2)] * math.random(minimum, maximum))).Position, cfr.Position)
                    end)
                end)
            else
                rs:BindToRenderStep("diff-phase", 2000, function(delta)
                    pcall(function() 
                        workspace.CurrentCamera.CameraSubject = a
                        
                        if plr.Character.Humanoid.MoveDirection.Magnitude == 0 then 
                            plr.Character.HumanoidRootPart.CFrame = cfr
                            return
                        end
                        
                        cfr = cfr + (plr.Character.Humanoid.MoveDirection * phase_speed["value"]) * delta
                        a.CFrame = cfr
                        
                        minimum = movement:gc("phase"):gc("phasemin")["value"]
                        maximum = movement:gc("phase"):gc("phasemax")["value"]
                        
                        plr.Character.HumanoidRootPart.CFrame = cfr + v3(choices[math.random(1,2)] * math.random(minimum, maximum), 0, choices[math.random(1,2)] * math.random(minimum, maximum))
                    end)
                end)
            end
        end
    end,
    Disable = function() 
        ui.Boundsteps["diff-phase"] = nil
        rs:UnbindFromRenderStep("diff-phase")
        
        ui.ExtInstances["phase_campart"]:Destroy()
        ui.ExtInstances["phase_campart"] = nil
        
        
        workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
    end

})

phase:NewSlider("phasemin", {Text = "minimum distance", Description = "The minimum amount of distance in studs you can phase to", Min = 0, Max = 30})
phase:NewSlider("phasemax", {Text = "maximum distance", Description = "The maximum amount of distance in studs you can phase to", Min = 1, Max = 50})
phase:NewToggle("phaseidle", {Text = "phase while idle", Description = "When enabled, your character still phases regardless of you standing still or not",
    Enable = function() 
        phase_idle = true
        
        
        if phase["togglestate"] then
            phase["disable"]()
            phase["enable"]()
        end
        
    end,
    Disable = function() 
        phase_idle = false 
        
        if phase["togglestate"] then
            phase["disable"]()
            phase["enable"]()
        end
    end
    
})
phase:NewToggle("phaseface", {Text = "face center", Description = "When enabled, your character will face the center position while phasing",
    Enable = function() 
        phase_facecenter = true
        
        
        if phase["togglestate"] then
            phase["disable"]()
            phase["enable"]()
        end
        
    end,
    Disable = function() 
        phase_facecenter = false 
        
        if phase["togglestate"] then
            phase["disable"]()
            phase["enable"]()
        end
    end
    
})
phase_speed = phase:NewSlider("phasespeed", {Text = "speed", Description = "How fast you move while phasing", Min = 25, Max = 100})
--phase:NewInput("phaseinput", {Text = "Input", Description = "hi"})
phase:NewHotkey("phasekey")




movement:NewButton("noclip",     {Text = "noclip", Description = "Disables wall collision",
    Enable = function() 
        
    end,
    Disable = function() 
        
    end
    
    
})
gravity = movement:NewButton("gravity",  {Text = "gravity", Description = "Applies a low gravity effect, slowing down your fall",
    Enable = function()
        local mode = movement:gc("gravity"):gc("gravitymode")["value"]
        local a = movement:gc("gravity"):gc("gravityeffect")
        
        if mode == "Gravity" then
            --workspace.Gravity = 196.2 - a["value"] 
            rs:BindToRenderStep("diff-gravity", 2000, function() 
                workspace.Gravity = 196.2 - a["value"] 
            end)
        elseif mode == "Velocity" then
            if not plr.Character then plr.CharacterAdded:Wait() end
            
            local function hookchr(chr, bf)
                if not ui.ExtInstances["GravityVelocity"] then return end
                ui.Connections["GVChrHook"] = chr.Humanoid.Jumping:Connect(function(starting)
                    if starting then 
                        bf.Force = v3(0, a["value"]*25, 0)
                        ui:Tween(bf, {Force = v3(0, a["value"]*10, 0)}, 1.5, "Out", "Linear")
                    end
                end)
            end
            
            
            local bf
            
            ui.Connections["GVRespawn"] = plr.CharacterAdded:Connect(function(chr) 
                bf = Instance.new("BodyForce")
                bf.Name = "GVEL"
                bf.Parent = chr:WaitForChild("HumanoidRootPart")
                
                ui.ExtInstances["GravityVelocity"] = bf
                
                hookchr(chr, bf)
            end)
            
            bf = Instance.new("BodyForce")
            bf.Name = "GVEL"
            bf.Parent = plr.Character.HumanoidRootPart
            
            ui.ExtInstances["GravityVelocity"] = bf
            
            hookchr(plr.Character, bf)

        --elseif mode == "Velocity 2" then
        --    if not plr.Character then plr.CharacterAdded:Wait() end
        --    
        --    
        --    rs:BindToRenderStep("diff-gravity", 205, function() 
        --        pcall(function() 
        --            local s = plr.Character.HumanoidRootPart.Velocity
        --            plr.Character.HumanoidRootPart.Velocity = v3(s.X, 0 + a["value"]/150, s.Z)
        --            
        --        end)
        --    end)
        else    
            ui:Message("Unknown gravity mode")
        end
        
        mode = nil
        ui.Boundsteps["diff-gravity"] = "diff-gravity"
    end,
    Disable = function() 
        rs:UnbindFromRenderStep("diff-gravity")
        workspace.Gravity = 196.2
        if plr.Character then 
            pcall(function()
                plr.Character.HumanoidRootPart["GVEL"]:Destroy()
            end)
        end
        if ui.Connections["GVRespawn"] then
            ui.Connections["GVRespawn"]:Disconnect()
        end
        if ui.Connections["GVChrHook"] then
            ui.Connections["GVChrHook"]:Disconnect()    
        end
        
        ui.Connections["GVChrHook"] = nil
        ui.Connections["GVRespawn"] = nil
        ui.Boundsteps["diff-gravity"] = nil
        ui.ExtInstances["GravityVelocity"] = nil
    end
    
    
})
gravity:NewSlider("gravityeffect", {Text = "amount", Description = "How much your gravity gets decreased by", Min = 0, Max = 190})
gravity:NewDropdown("gravitymode", {Text = "method", Enums = { 
    {Enum = "Gravity", Description = "Normal gravity method. Is detectable, but very unlikely"},
    {Enum = "Velocity", Description = "An alternate method that only affects your character. Is more common and thus detected more often, but still unlikely"}--,
    --{Enum = "Velocity 2", Description = "A basically undetectable mode that's much closer to a glide effect than a low gravity effect"}
}})
gravity:NewHotkey("gravityhotkey")


movement:NewButton("swim",       {Text = "swim", Description = "Lets you swim in midair."})
local clicktp = movement:NewButton("clicktp",    {Text = "ctrl-click tp", Description = "Teleports you to your mouse when you press LeftControl and MouseButton1"})
movement:NewButton("jetpack",    {Text = "jetpack", Description = "Like flight, but velocity based"})
movement:NewButton("noslowdown", {Text = "no slowdown", Description = "Prevents you from having too low of a walkspeed. Very limited in scope as every game works different"})
movement:NewButton("parkour",    {Text = "parkour", Description = "Jumps when you reach the end of part"})
movement:NewButton("safewalk",   {Text = "safewalk", Description = "Prevents you from walking off of a part"})
quickfall = movement:NewButton("quickfall",  {Text = "quickfall", Description = "Makes you fall down very fast. May trigger some anti-teleportation anticheats, but may bypass falldamage scripts"})
movement:NewButton("highjump",   {Text = "highjump", Description = "Makes you jump higher"})
movement:NewButton("float",      {Text = "float", Description = "Lets you float. A hotkey is recommended!"})


render = ui:NewMenu("render")

esp = render:NewButton("esp",        {Text = "ESP", Description = "Highlights players with a certain team, username, etc."})
esp_transparency = esp:NewSlider("espt", {Text = "transparency", Description = "The transparency of the ESP", Min = 20, Max = 70})
esp:NewDropdown("espmode", {Text = "method", Enums = { 
    {Enum = "Infinite Yield", Description = "The same ESP Infinite Yield uses"},
    {Enum = "Billboard", Description = "Normal ESP. Could be detected, but pretty much no game ever checks"},
    {Enum = "Skeleton", Description = "Uses Drawing library. Undetectable, but may lag"}
}})
esp:NewHotkey("esphotkey")


render:NewButton("tracers",    {Text = "tracers", Description = "Draws lines onto ESP targets. Requires drawing library"})


crosshair = render:NewButton("crosshair",  {Text = "crosshair", Description = "Displays crosshair at the center of your screen. Requires drawing library", 
    Enable = function()
        local absize = ui:GetObject("SCREENGUI").AbsoluteSize
        
        
        local a = Drawing.new("Line")
        a.Visible = true
        a.Transparency = 1
        a.Thickness = 2
        
        local b = Drawing.new("Line")
        b.Visible = true
        b.Transparency = 1
        b.Thickness = 2
        
        ui:AddRGB(a, "Color", "crosshair1")
        ui:AddRGB(b, "Color", "crosshair2")
        ui.ExtDInstances["crosshair1"] = a
        ui.ExtDInstances["crosshair2"] = b
        
        ui.Boundsteps["diff-crosshair"] = "diff-crosshair"
        
        rs:BindToRenderStep("diff-crosshair", 2000, function() 
            a.From = Vector2.new((absize.X/2)-crosshair:gc("chhsize")["value"], absize.Y/2)
            a.To = Vector2.new((absize.X/2)+crosshair:gc("chhsize")["value"], absize.Y/2)
            
            b.From = Vector2.new((absize.X/2), (absize.Y/2)-crosshair:gc("chvsize")["value"])
            b.To = Vector2.new((absize.X/2), (absize.Y/2)+crosshair:gc("chvsize")["value"])
        end)
        
        
        
        
        
        
    end,
    Disable = function() 
        rs:UnbindFromRenderStep("diff-crosshair")
        ui.Boundsteps["crosshair"] = nil
        
        ui:RemoveRGB("crosshair1")
        ui:RemoveRGB("crosshair2")
        
        ui.ExtDInstances["crosshair1"].Remove()
        ui.ExtDInstances["crosshair1"] = nil
        ui.ExtDInstances["crosshair2"].Remove()
        ui.ExtDInstances["crosshair2"] = nil
    end
})
crosshair:NewSlider("chvsize", {Text = "vertical size", Description = "How tall the crosshair is", Min = 5, Max = 20})
crosshair:NewSlider("chhsize", {Text = "horizontal size", Description = "How wide the crosshair is", Min = 5, Max = 20})
crosshair:NewHotkey("chkey")


local nametags = render:NewButton("nametags",   {Text = "nametags", Description = "Enables custom nametags that show username, distance, and other specified options"})

local fullbright = render:NewButton("fullbright", {Text = "fullbright", Description = "Disables lighting effects; works for most games"})

render:NewButton("nofog",      {Text = "nofog", Description = "Disables fog effects; works for most games"})
render:NewButton("xray",       {Text = "xray", Description = "Sets every part's transparency to a specified value"})
render:NewButton("chroma",     {Text = "chroma", Description = "Tints everything chroma",
    Enable = function() 
        ui:AddRGB(ui:GetObject("CCEFFECT"), "TintColor") 
    end,
    Disable = function() 
        ui:RemoveRGB(ui:GetObject("CCEFFECT")) 
        ui:GetObject("CCEFFECT").TintColor = Color3.new(1, 1, 1) 
    end
})
render:NewButton("freecam",     {Text = "freecam", Description = "Lets you control your camera separately from your player"})
render:NewButton("breadcrumbs", {Text = "breadcrumbs", Description = "Leaves a trail behind you as you walk"})
render:NewButton("fov",         {Text = "FOV", Description = "Changes your game's FOV"})
render:NewButton("radar",       {Text = "radar", Description = "Displays nearby players and npcs"})


local player = ui:NewMenu("player")

player:NewButton("faceclosest",   {Text = "face closest plr", Description = "Faces your character towards closest player"})
player:NewButton("hbe",           {Text = "hitbox expander", Description = "Increases the size of a specified part in every character (except for you)"})
player:NewButton("playertp",      {Text = "TP to player", Description = "Teleports you to a specified player. Has options for delay, offset, etc."})
player:NewButton("fling",         {Text = "fling", Description = "Flings players you walk into"})
player:NewButton("antifling",     {Text = "antifling", Description = "Stops skids from flinging you. Works best against standard modes but may stop netbypass flings"})
player:NewButton("antitp",        {Text = "antitp", Description = "Self explanatory. Useful against anticheats that warp you back if you speed."})
player:NewButton("flashback",     {Text = "flashback", Description = "Teleports you back upon death. Has optional delay, and tweening"})
player:NewButton("follow",        {Text = "follow", Description = "Follows a specified player. If it cannot reach them, it will immediately quit"})
player:NewButton("alto",          {Text = "alto", Description = "Baritone but for roblox"})

local misc = ui:NewMenu("misc")


misc:NewButton("shiftlock",  {Text = "force shiftlock", Description = "Force enables shiftlock in games that dont allow it"})
misc:NewButton("thirdp",     {Text = "force third person", Description = "Force enables third person in games that dont allow it"})
misc:NewButton("enableall",  {Text = "force all HUDs", Description = "Enables all roblox CoreGuis, such as chat, inventory, etc."})
remotespam = misc:NewButton("remotespam", {Text = "remote spam", Description = "Spams all remotes with random args. May lag server; may get you banned", 
    Enable = function() 
        remotespam_enable = true
        local rems = {}
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                table.insert(rems, v) 
            end
        end
        
        if #rems == 0 then
            ui:Message("No remotes found in game!")
            remotespam["disable"]() 
            return
        end
        
        ui:Async(function()
            while remotespam_enable do
                wait(remotespam_delay["value"]/1000)
                for _,rem in pairs(rems) do
                    print("Sent packets to "..rem.Name)
                    rem:FireServer("戜成戍懈戏戚戍戉戜懈戔戍戉", "戜成戍懈戏戚戍戉戜懈戔戍戉", "戜成戍懈戏戚戍戉戜懈戔戍戉", "戜成戍懈戏戚戍戉戜懈戔戍戉") 
                end
            end
            rems = nil
            ui:Message("Finished")
        end)
        
        
    end, 
    Disable = function() 
        remotespam_enable = false
    end
    
})

remotespam_delay = remotespam:NewSlider("remotedelay", {Text = "delay", Description = "The delay between spamming all remotes. Value in ms", Min = 0, Max = 500})
remotespam:NewHotkey("remotekey")


misc:NewButton("fakelag",    {Text = "fakelag", Description = "Makes you look laggy. However, everything else looks laggy for you!"})
misc:NewButton("lagswitch",  {Text = "lagswitch", Description = "(R6 ONLY) Makes you look frozen / laggy. However, everything else (tools, interactions, etc.) works fine"})



local util = ui:NewMenu("utilities")

util:NewButton("pickupall",       {Text = "pickup all", Description = "Attempts to pick up every item in Workspace. Useful for games with items you click to pickup"})
util:NewButton("acidentify",      {Text = "anticheat detector", Description = "Detects anticheat scripts in your game. Optionally destroys local anticheats"})
util:NewButton("antiafk",         {Text = "antiafk", Description = "Prevents you from being detected for AFK"})
util:NewButton("selfkill",        {Text = "selfkill", Description = "Kills yourself. Has various methods, letting you potentially glitch out games"})
util:NewButton("constantstate",   {Text = "8state", Description = "Constantly sets your HumanoidState to 8, stopping you from ragdolling, getting in chairs, or similar states"})


local chat = ui:NewMenu("chat")

chat:NewButton("chatlogs",   {Text = "chat logs", Description = "Enables chat logs. Highlights admin commands, pms, and /e commands"})
chat:NewButton("customchat",   {Text = "custom chat", Description = "Enables a custom version of the Roblox chat gui. Should be compatible with scripts that require the roblox chat gui"})
chat:NewButton("chatspammer",   {Text = "chat spammer", Description = "Spams the chat with a custom message and delay"})
chat:NewButton("chatbypass",   {Text = "chat bypass", Description = "Bypasses chat. Has various settings"})
chat:NewButton("fancychat",   {Text = "fancy chat", Description = "Sends your chat messages with a different font than normal"})


--local fun = ui:NewMenu("fun")
--fun:NewButton("notorso",    {Text = "notorso", Description = "(R15 ONLY) Detaches your upper body from your legs (skidded from IY)"})



ui:Ready()

ui:Message("Thanks for using Spectrum!", nil) 


