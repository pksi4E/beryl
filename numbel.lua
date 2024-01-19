-- numbel.lua

function ydivx(y, x)
--[[
	Function that check if number y divides number x.
	function which returns boolean if the number y
	divides number x, that is in mathematical syntax: y|x
	x is a base number, y is a number to check if it divides x
	y divides x, if there exists z such that x = y * z
	@ver. 1.00
]]

	-- if x is zero then every number divides zero
	-- if x == 0 then return true end
	-- y = math.abs(y)
	-- x = math.abs(x)
	-- for z = 1, x do
	-- 	if x == y * z then
	-- 		return true
	-- 	elseif y * z > x then
	-- 		return false
	-- 	end
	-- end
	-- return false
	-- jeden tez jest zawsze dzielnikiem, wiec
	-- nie trzeba caly czas robic petle az do x, moze tylko do x-1
	-- ta sama liczba tez jest zawsze dzielnikiem, wiec
	-- mozna tez zaczac petle od 2 a nie od 1

	return x // y == x / y

	-- sprawdzić jak to działa dla liczb ujemnych!
end

function gcd(a, b)
--[[
	Function that returns greatest common divisor
	of two numbers. Algorithm is based on Euclid algorithm.
]]

	if a == b then
		return a; end

	if a > b then 
		x = a
		y = b
	else
		x = b
		y = a; end
	
	while y ~= 0 do
		r = x % y
		x = y
		y = r ;end

	return x
end

function lcm(a, b)
	return a * b / gcd(a, b)
end

function isreversible(b, n)
--[[
	Function that check if the number b has an inverse
	in Z_n ring.
]]
	return gcd(b, n) == 1
end

function isprime(x)
	if x == 2 then return true end
	if x % 2 == 0 then return false end
	count = 1
	for i = 3, x, 2 do
		if ydivx(i, x) then count = count + 1; end
		end
	return count == 2
end

function relprime(x, y)
	return gcd(x, y) == 1
end

function eulerphi(n)
	count = 0
	for i = 1, n do
		if relprime(i, n) then count = count + 1; end
		end
	return count
end

function mulgroup(n)
--[[
	Function that returns a table with
	all relatively prime numbers to number n.
	Every element in this table has mod n inverse element
	which also is an element of this table.
]]
	Zstar = {}
	for i = 2, n do
		if relprime(i, n) then
			table.insert(Zstar, i)
		end
	end
	return Zstar
end

function findinverse(x, n)
--[[
	Function finds an inverse number mod n
	to number x. Algorithm is based on
	Extended Euclid algorithm.
]]

	-- to be done
end

-- arg1 = tonumber(arg[1])
-- arg2 = tonumber(arg[2])
-- arg3 = tonumber(arg[3])
-- arg4 = tonumber(arg[4])
-- print(ydivx(arg1, arg2))


-- print("gcd: ", gcd(arg1, arg2))
-- print("lcm: ", lcm(arg1, arg2))
-- print("is prime? ", isprime(arg3))
-- print("are relatively prime? ", relprime(arg1, arg2))
-- print("euler ", eulerphi(arg4))
