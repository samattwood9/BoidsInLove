return function()

    local landing_screen = {}
    local window_width, window_height

    landing_screen.load = function()
        title_font = love.graphics.newFont("indieflower.ttf", 100)
        
        landing_screen.title = love.graphics.newText(title_font, "Boids In Love!")

        heading_font = love.graphics.newFont("indieflower.ttf", 66)
        landing_screen.controls = love.graphics.newText(heading_font, "Click to begin")
        landing_screen.restart = love.graphics.newText(heading_font, "Press space to get back here")

    end

    landing_screen.update = function(width, height)
        window_width = width
        window_height = height
    end

    landing_screen.draw = function(self)
        love.graphics.draw(self.title,  math.floor(window_width / 2) - (self.title:getWidth()/2), 150)
        love.graphics.draw(self.controls,  math.floor(window_width / 2) - (self.controls:getWidth()/2), 350)
        love.graphics.draw(self.restart,  math.floor(window_width / 2) - (self.restart:getWidth()/2), 550)
    end

    return landing_screen

end