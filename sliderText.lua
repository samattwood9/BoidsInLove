return function()

    local slider_text = {}
    local window_width, window_height, text_width, text_height

    slider_text.load = function()
        title_font = love.graphics.newFont("indieflower.ttf", 100)
        slider_text.title = love.graphics.newText(title_font, "50" .. "%")
    end

    slider_text.update = function(self, width, height, value)
        window_width = width
        window_height = height
        percent = math.floor((value * 100) + 0.5)
        self.title:set(percent .. "%")
        text_width, text_height = self.title:getDimensions()
    end

    slider_text.draw = function(self)
        love.graphics.draw(self.title, window_width - text_width - 30, window_height - text_height + 15)
    end

    return slider_text

end