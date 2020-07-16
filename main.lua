require 'simple-slider'

function love.load()

    local width, height = love.window.getMode()

    love.graphics.setBackgroundColor(0.253, 0.767, 0.982)

    state = 1
    time = 0

    title = require('title')
    title = title()
    title.load()

    sliderText = require('sliderText')
    sliderText = sliderText()
    sliderText.load()

    world = require('world')

    clouds = require('clouds')
    clouds = clouds()
    clouds.load()

    flock = require('flock')
    flock = flock(20)

    sliderConfig = {}
    sliderConfig.width = 0.05 * 300
    sliderConfig.track = 'line'
    sliderConfig.knob = 'heart'

    slider = newSlider(width * 0.5 - 100, height - 50, width - 300, 0.5, 0, 1, function (v) flock.adjustLove(v) end, sliderConfig)

    select = love.audio.newSource("select.wav", "static")
end

function love.update(dt)
    local width, height = love.window.getMode()
    time = time + dt
    clouds.update(dt)
    if state == 1 then
        title.update(width, height)
    else
        flock:update()
        slider:update()
        sliderText:update(width, height, slider.value)
        world:update(dt)
    end
end

function love.draw()
    clouds.draw()
    if state == 1 then
        title:draw()
    else
        flock:draw()
        slider:draw()
        sliderText:draw()
    end
end

function love.mousereleased(x, y, button)
    if (state == 1) then 
        state = 0
        flock.load()
    else 
        flock.add(x, y)
    end
 end

 function love.resize(x, y)
    clouds:resetEmissionArea()
 end

 function love.keypressed(key, scancode, isRepeat)
    if key == 'space' then
        if state == 0 then
            state = 1
        end
    end 
 end
