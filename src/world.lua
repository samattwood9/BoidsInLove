-- world.lua
local world = love.physics.newWorld(0, 0)

world:setCallbacks(
  nil,
  nil,
  nil,
  nil
)

return world