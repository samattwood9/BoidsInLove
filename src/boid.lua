local world = require('world')

return function(x_pos, y_pos, vx, vy)

    local boid = {}
    angle_adjustment = math.rad(360*(2/3))
    max = 600
    min = 100
    boid.body = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
    boid.shape = love.physics.newPolygonShape(15,30, 10, 10, 20, 10)
    boid.fixture = love.physics.newFixture(boid.body, boid.shape)
    boid.fixture:setUserData(boid)
    boid.red = love.math.random(80, 100) * 0.01
    boid.green = love.math.random(20, 40) * 0.01
    boid.blue = love.math.random(50, 70) * 0.01

    boid.body:setLinearVelocity(vx, vy)

    boid.draw = function(self, v1, v2, v3)
        love.graphics.setColor(self.red, self.green, self.blue)
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    end

    -- rule one: move towards perceived center
    boid.getCohesion = function(self, neighbours, thresh)

        distX = 0
        distY = 0
        num_neighbours = 0

        for i, neighbour in ipairs(neighbours) do
            seperationX = math.abs(self.body:getX() - neighbour.body:getX())
            seperationY = math.abs(self.body:getY() - neighbour.body:getY())

            seperation = math.sqrt(math.pow(seperationX, 2) + math.pow(seperationY, 2))
            if (seperation < thresh) then
                num_neighbours = num_neighbours + 1
                distX = distX + neighbour.body:getX()
                distY = distY + neighbour.body:getY()
            end
        end

        distX = distX / num_neighbours
        distY = distY / num_neighbours

        distX = (distX - self.body:getX()) * 0.01
        distY = (distY - self.body:getY()) * 0.01

        return distX, distY
    end

    -- rule two: move away from neighbours
    boid.getRepulsion = function(self, neighbours, thresh)

        distX = 0
        distY = 0

        for i, neighbour in ipairs(neighbours) do
            seperationX = math.abs(self.body:getX() - neighbour.body:getX())
            seperationY = math.abs(self.body:getY() - neighbour.body:getY())

            seperation = math.sqrt(math.pow(seperationX, 2) + math.pow(seperationY, 2))

            if (seperation < thresh) then
                distX = distX - (neighbour.body:getX() - self.body:getX()) -- - seperationX
                distY = distY - (neighbour.body:getY() - self.body:getY()) -- - seperationY
            end
        end

        return distX, distY
    end

    -- rule three: match velocity of neighbours
    boid.getVelocity = function(self, neighbours, thresh)
        
        velocityX = 0
        velocityY = 0
        num_neighbours = 0

        for i, neighbour in ipairs(neighbours) do

            seperationX = math.abs(self.body:getX() - neighbour.body:getX())
            seperationY = math.abs(self.body:getY() - neighbour.body:getY())

            seperation = math.sqrt(math.pow(seperationX, 2) + math.pow(seperationY, 2))

            if (seperation < thresh) then
                num_neighbours = num_neighbours + 1
                neighbourX, neighbourY = neighbour.body:getLinearVelocity()
                velocityX = velocityX + neighbourX
                velocityY = velocityY + neighbourY
            end

        end

        velocityX = velocityX / num_neighbours
        velocityY = velocityY / num_neighbours

        myVelocityX, myVelocityY = self.body:getLinearVelocity()

        velocityX = (velocityX - myVelocityX) / 8
        velocityY = (velocityY - myVelocityY) / 8

        return velocityX, velocityY

    end

    boid.keepInBounds = function(self)
        
        adjustX = 0
        adjustY = 0

        if (self.body:getX() > 1600) then
            adjustX = adjustX - 30
        elseif (self.body:getX() < 0) then
            adjustX = adjustX + 30
        end

        if (self.body:getY() > 900) then
            adjustY = adjustY - 30
        elseif (self.body:getY() < 0) then
            adjustY = adjustY + 30
        end

        return adjustX, adjustY
    end

    boid.getHeading = function(self)

        myVelocityX, myVelocityY = self.body:getLinearVelocity()
        return angle_adjustment + math.atan2(myVelocityY, myVelocityX)

    end

    boid.applyLimits = function(vx, vy)
    
        speed = math.sqrt(math.pow(x, 2) + math.pow(y, 2))
            
        -- stop the boids going to fast
        if (speed > max) then
            if (x > 0) then
                x = x - min
            elseif (x < 0) then
                x = x + min
            end

            if (y > 0) then
                 y = y - min
            elseif (y < 0) then
                y = y + min
            end
        end

        -- stop the boids stopping
        if (speed < min) then
            if (x < 0) then
                x = x - min
            elseif (x > 10) then
                x = x + min
            end

            if (y < 0) then
                y = y - min
            elseif (y > 10) then
                y = y + min
            end
        end

        return x, y
    
    end

    boid.update = function(self, vx, vy, heading)

        self.body:setAngle(heading)

        self.body:setLinearVelocity(vx, vy)

    end

    return boid

end