local JSON = {}

function JSON.parse (list)
		list = textutils.serializeJSON(list)
		return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(list,'[%b\\]',''),'%rnt*',''),'%:"*','="'),'%,"*',','),'%{"*','{'),'%"{', '{'),'%"=','='),'%}}"','}}')
end

return JSON
