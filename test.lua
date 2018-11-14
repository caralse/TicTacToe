function timeConversion(s)
	local val = s:match(".M")
	local new = s:sub(3, 8)
	local hour = s:sub(1, 2)
	if val == "PM" then
		return (hour + 12 == 24 and "12" or tostring(tonumber(hour)+12)) .. new
	else return (hour + 12 == 24 and "00" or tostring(hour)) .. new end
end

local s = "06:40:03AM"

--local result = timeConversion(s)

print(timeConversion(s))
