local hyper = {"cmd", "alt", "ctrl", "shift"}

-- reload shortcut
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- highlight window after moving focus
local function highlightWindow(win)
  if not win then return end
  local rect = win:frame()
  local highlight = hs.drawing.rectangle(rect)
  highlight:setStrokeColor({["red"]=1,["green"]=0,["blue"]=0,["alpha"]=1})
  highlight:setFill(false)
  highlight:setStrokeWidth(6)
  highlight:setRoundedRectRadii(10.0, 10.0)
  highlight:bringToFront(true)
  highlight:setLevel(hs.drawing.windowLevels.overlay)
  highlight:show()

  -- Remove after 0.3 seconds
  hs.timer.doAfter(0.3, function()
    highlight:delete()
  end)
end

-- Focus logic
  -- Define zones using QWER
local zoneBindings = {
  {key = "q", screenIndex = 1, side = "left"},
  {key = "w", screenIndex = 1, side = "right"},
  {key = "e", screenIndex = 2, side = "left"},
  {key = "r", screenIndex = 2, side = "right"},
  {key = "t", screenIndex = 3, side = "left"},
  {key = "y", screenIndex = 3, side = "right"},
  -- Add more if needed, like:
}

for _, binding in ipairs(zoneBindings) do
  hs.hotkey.bind(hyper, binding.key, function()
    local screens = hs.screen.allScreens()
    local targetScreen = screens[binding.screenIndex]
    if not targetScreen then return end

    local targetFrame = targetScreen:frame()
    local isLeft = binding.side == "left"

    for _, win in ipairs(hs.window.orderedWindows()) do
      if win:screen() == targetScreen then
        local wf = win:frame()
        local centerX = wf.x + wf.w / 2
        if (isLeft and centerX < targetFrame.x + targetFrame.w / 2) or
           (not isLeft and centerX >= targetFrame.x + targetFrame.w / 2) then
          win:focus()
          highlightWindow(win)
          return
        end
      end
    end
  end)
end


-- Arrow keys: Move current window to left or right half of current screen
local function moveWindowTo(side)
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local frame = screen:frame()
  local newFrame = win:frame()

  if side == "left" then
    newFrame.x = frame.x
    newFrame.w = frame.w / 2
  elseif side == "right" then
    newFrame.x = frame.x + frame.w / 2
    newFrame.w = frame.w / 2
  end

  newFrame.y = frame.y
  newFrame.h = frame.h
  win:setFrame(newFrame)
end
hs.hotkey.bind(hyper, "left", function() moveWindowTo("left") end)
hs.hotkey.bind(hyper, "right", function() moveWindowTo("right") end)

-- Move window to the next display
hs.hotkey.bind(hyper, "N", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():next())
end)

-- FInd mouse pointer on screen
hs.hotkey.bind(hyper, "M", function()
  local pos = hs.mouse.getAbsolutePosition()
  local circle = hs.drawing.circle(hs.geometry.rect(pos.x - 40, pos.y - 40, 80, 80))
  circle:setStrokeColor({red=1,green=0,blue=0,alpha=0.9})
  circle:setStrokeWidth(4)
  circle:show()
  hs.timer.doAfter(0.6, function() circle:delete() end)
end)

-- Hyper + C → Google Chrome
hs.hotkey.bind(hyper, "C", function()
  hs.application.launchOrFocus("Google Chrome")
end)

-- Hyper + V → VS Code
hs.hotkey.bind(hyper, "V", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)

-- Hyper + G → ChatGPT
hs.hotkey.bind(hyper, "G", function()
  hs.application.launchOrFocus("ChatGPT")
end)

-- Hyper + T → iTerm
hs.hotkey.bind(hyper, "T", function()
  hs.application.launchOrFocus("ITerm")
end)

-- Show config loaded screen
hs.alert.show("Config loaded")