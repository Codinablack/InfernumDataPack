local dataTypes = {
	number = result.getNumber,
	string = result.getString,
	stream = result.getStream
}
 
function queryToTable(id, values)
	local ret = {}
	if not id then
		return ret
	end
	repeat
		local t = {}
		for i = 1, #values do
			local column, dataType = values[i]:match('(%a+):(%a+)')
			t[column] = dataTypes[dataType](id, column)
		end
		table.insert(ret, t)
	until not result.next(id)
	return ret
end

function printfmt(fmt, ...)
	return print(fmt:format(...))
end

function py_exec(cmd)
	local results = {}
	for line in io.popen('python -c "'.. cmd ..'"'):lines() do
		results[#results + 1] = line
	end
	return setmetatable(results, {__index = {print = function() return print(table.concat(results, ", ")) end}})
end

function serialize(s)
	local isTable = type(s) == 'table'
	local ret = {(isTable and "{" or nil)}
	local function doSerialize(s)
		if isTable then
			local size = table.size(s)
			local index = 0
			for k, v in pairs(s) do
				index = index + 1
				local addComma = index < size
				local key = ((type(k) == 'string') and ('"'..k..'"') or k)
				local val = ((type(v) == 'string') and ('"'..v..'"') or v)
				local comma = (addComma and ', ' or '')
				if type(v) == 'table' then
					ret[#ret+1] = ('[%s] = {'):format(key)
					doSerialize(v)
					ret[#ret+1] = ('}%s'):format(comma)
				else
					ret[#ret+1] = ('[%s] = %s%s'):format(key, val, comma)
				end
			end
		else
			ret[#ret+1] = s
		end
	end
	doSerialize(s)
	return (table.concat(ret) .. (isTable and "}" or ""))
end

function unserialize(str)
	local f = loadstring("return ".. str)
	return f and f() or nil
end