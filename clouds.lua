return function()

    local clouds = {}

    clouds.load = function()
        local width, height = love.window.getMode()
        
        cloud = love.graphics.newImage("cloud_sprite.png")

        clouds = love.graphics.newParticleSystem(cloud, 32)

        clouds:setParticleLifetime(20)
        clouds:setEmissionRate(0.7)
        clouds:setSizes(0.5)          
        clouds:setLinearAcceleration(-3, -3, 3, 3) -- Random movement in all directions.
        clouds:setColors(1,1,1,1,1,1,1,0.75,1,1,1,0.5,1,1,1,0.25,1,1,1,0)
        clouds:setEmissionArea('borderrectangle', width/2 + ((width/2) * 0.1), height/2 + ((height/2) * 0.1), 0, true)
    end

    clouds.resetEmissionArea = function()
        local width, height = love.window.getMode()
        clouds:setEmissionArea('borderrectangle', width/2 + ((width/2) * 0.1), height/2 + ((height/2) * 0.1), 0, true)
    end    
    
    clouds.update = function(dt)
        clouds:update(dt)
    end

    clouds.draw = function()
        love.graphics.setColor(1, 1, 1, 1)
        local width, height = love.window.getMode()
        love.graphics.draw(clouds, width * 0.5, height * 0.5)
    end

    return clouds

end