local JSON = {}

function JSON.parse (list,start)
		list = textutils.serializeJSON(list)

        if (start == nil) then
            start = 1
        end

        local tmpList = {}
        local retList = {}
        local iterations = 0
        local tmpS

        local tmpStr = string.gsub(list,'%\\','')
        tmpStr = string.gsub(tmpStr,'%rn','')
        tmpStr = string.gsub(tmpStr,'%s','')
        tmpStr = string.gsub(tmpStr,'%"','')

        tmpS = string.match(tmpStr,'%b{:')
        table.insert(tmpList,1,string.gsub(string.gsub(tmpS,'%{',''),'%:',''))


        tmpS = string.gsub(tmpStr,tmpS,'')
        tmpS = string.match(tmpS,'%b{}')
        print(tmpS)

        print (tmpStr)
        for i=0, #tmpList do
            print(tmpList[i])
        end
        return tmpList
    end

    return JSON
