bar.clear()
bar.setBackgroundColor(colors.red)
bar.setCursorPos(windowDim.width-2,windowDim.cpY)
bar.write(" \153\145 ")

tmpIndex = true
while tmpIndex do
    instance.write(windowDim.width .. " " .. windowDim.height .. " " .. windowDim.cpX .. " " .. windowDim.cpY)
    local event, flag, x, y = os.pullEvent("monitor_touch")
    if x>windowDim.width-3 and x<windowDim.width and y==windowDim.cpY then
        instance.setBackgroundColor(env.getBackgroundColor())
        instance.clear()
        bar.setBackgroundColor(env.getBackgroundColor())
        bar.clear()
        instance = nil
        bar = nil
        tmpIndex = false
        return "0X01"
    end
end

return 0
