local mon = {}

function mon.space(x,y,x2,y2,marginX,marginY,content,iContent)

    if (marginY == nil) then
        marginY = 0
    end
    if (marginX == nil) then
        marginX = 0
    end

    if (iContent == nil) then
        iContent = (function()end)
    end

    if (content == nil) then
        error("ERROR: Expected content")
    end

    if (x >= x2 and x <= x2+marginX and y >= y2 and y <= y2+marginY) then
        content()
    else
        iContent()
    end

end

return mon

