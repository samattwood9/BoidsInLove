local boid = require('boid')

return function(size)

    num_boids = 0
    local flock = {}
    m1 = 1
    m2 = 1
    m3 = 1
    lv = 0.5

    flock.load = function()

        flock = {}
        num_boids = 0

        width = love.graphics.getWidth()
        height = love.graphics.getHeight()

        for number = 0, num_boids do

            x = love.math.random(1,width) --pick random X position within screen 
            y = love.math.random(1,height) --pick random Y position within screen

            flock[#flock + 1] = boid(x, y, x, y)
        end
    end

    flock.draw = function()

        for number = 1, num_boids+1 do
            flock[number]:draw()
        end

    end

    flock.update = function(self)

        loveCohesion = 1600 * lv
        loveVelocity = 200 * lv
        loveRepulsion = 100 * (1 - lv)

        for number = 1, num_boids+1 do

            cohesionX, cohesionY = flock[number]:getCohesion(flock, loveCohesion)

            repulsionX, repulsionY = flock[number]:getRepulsion(flock, loveRepulsion)

            velocityX, velocityY = flock[number]:getVelocity(flock , loveVelocity)

            adjustX, adjustY = flock[number]:keepInBounds()

            currentX, currentY = flock[number].body:getLinearVelocity()

            x = currentX + cohesionX * m1 + repulsionX * m2 + velocityX * m3 + adjustX
            y = currentY + cohesionY * m1 + repulsionY * m2 + velocityY * m3 + adjustY

            x, y = flock[number]:applyLimits(x, y)

            heading = flock[number]:getHeading()

            flock[number]:update(x, y, heading)
        end
    end

    flock.add = function(x,y)

        vx = love.math.random(-100,100)
        vy = love.math.random(-100,100)

        num_boids = num_boids + 1

        flock[#flock + 1] = boid(x, y, vx, vy)
    end

    flock.adjustLove = function(v)
        lv = v
    end

    return flock

end