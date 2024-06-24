local Width,Height = term.getSize(term.current())


local mon = {}

function mon.area(x,y,xCorner,XCornerDisplace,yCorner,YCornerDisplace,Callback,iCallback)


    if (x == nil) then x = Width end

    if (y == nil) then y = Height end

    if (xCorner == nil) then xCorner = Width end

    if (yCorner == nil) then yCorner = Height end

    if (YCornerDisplace == nil) then YCornerDisplace = 0 end

    if (XCornerDisplace == nil) then XCornerDisplace = 0 end

    if (iCallback == nil) then iCallback = (function()end) end

    if (Callback == nil) then error("ERROR: Expected content") end


    if (x >= xCorner and x <= XCornerDisplace and y <= yCorner and y >= YCornerDisplace) then
        Callback()
    else
        iCallback()
    end

end

return mon

