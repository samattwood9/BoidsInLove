return function()

    local helper = {}

    helper.addVectors = function(v1x, v1y, v2x, v2y)
        vx = v1x + v2x
        vy = v1y + v2y
        return vx, vy
    end

    helper.divideVectorScalar = function(v1x, v1y, scalar)
        vx = v1x / scalar
        vy = v1y / scalar
        return vx, vy
    end

    return helper

end