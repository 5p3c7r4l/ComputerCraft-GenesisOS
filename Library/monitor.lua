local Width,Height = term.getSize(term.current())


local mon = {}

function mon.space(x,y,xCorner,yCorner,XCornerDisplace,YCornerDisplace,content,iContent)


    if (x == nil) then x = Width end

    if (y == nil) then y = Height end

    if (xCorner == nil) then xCorner = Width end

    if (yCorner == nil) then yCorner = Height end

    if (YCornerDisplace == nil) then YCornerDisplace = 0 end

    if (XCornerDisplace == nil) then XCornerDisplace = 0 end

    if (iContent == nil) then iContent = (function()end) end

    if (content == nil) then error("ERROR: Expected content") end

    if (x >= xCorner and x <= xCorner + XCornerDisplace and y >= yCorner and y <= yCorner + YCornerDisplace) then
        content()
    else
        iContent()
    end

end

return mon

