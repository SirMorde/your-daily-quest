function love.conf(c)
  c.title = "Your Daily Quest"
  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  window.width = 1024
  window.height = 660
end