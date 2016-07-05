#!/user/bin/env lua


print("hello, lua")

function say(num) 
	if num == 0 then
		print("It's zero")
	else
		print("It's ", num)
	end
end

say(33)


b = 333
--delete global var
b = nil


---------
print("non-value",  nil)

print("false value", nil , false)

print("true value, which isn't nil or false:", true, 111, "33")

print("lua only has real number, no int , no float. if  you need, compile lua by yourself")

print("lua string is immutable string")
a="hello"
b='hello'


print("10" + 1)   --11
print("10" .. 20) -- 1020  连接符, space should before .., else it will be treat as decimal point
print("aa" .. "bb")

----------
days = {"Sunday", "Monday", "Tuesday"}

print(days[0])
print(days[1])

a= {x = 10 , y = 20}

print("a.x", a.x)
print("a.x", a["x"])

b={}; 
b.x = 10;
 b.y = 10;
print("b.x", b.x)


polyline = {{blue="blue"},{x = 0, y= 1}}
print(polyline[1].blue)

optnames = {["h"] = "hi", ["w"]= "what"} --重点在于key要用[]包含起来
i=20; s = "h"
a = {[i+0] = s,[i+1]= s..s, [i+2]= s..s..s}

print(optnames[s])
print(a[22])


--------
-- t.x = "first use t.a"  -- t (a nil value)
-- print(t)
-- print(t.x)
a = nil;b = nil;c= nil;-- reset values
a, b, c = 0;
print(a, b, c) -- 0,nil, nil
a, b, c = 0,0,0;
print(a, b, c) -- 0,0, 0


-----
i = nil;
do 
--local varible
	local i = 20;
	do 
	local i = 40;
		print("local varible:",i)
	end
	print("local varible:",i)
end 
print("local varible:",i)

---
a= 3
if a < 0 then 
	print("a< 3")
	elseif a < 4 then
		print("a<4")
	else
		print("a>=4")
end
--- no switch, so only if then elseif then  elseif then else end
a = {"ni", "hao", "a"}
local i = 1;
while a[i] do 
	print(a[i])
	i= i+1;
end

repeat 
	local ii = 0;
	print("repeat once")
until  true and ii == 0

for i = 10, 1,-1 do
	print("p:", i)
end

for i =1, math.huge do 
	if (i > 10) then
		print("i from 1 to 10, break");
		break
	end
end

for i, v in ipairs(days) do 
	print("ipairs show idx and value ", i, v )
end

revDays = {}
for i, v in pairs(days) do 
	revDays[v] = i
end
print(revDays);


print("break, return should be last line of one block.")
function showReturn(  )
	return; -- error
	do return end; --right
end

