-- function which returns boolean if the number y
-- divides number x, that is in mathematical syntax: y|x
-- x is a base number, y is a number to check if it divides x
-- y divides x, if there exists z such that x = y * z
-- ver. 1.0
function ydivx(y, x)
	-- if x is zero then every number divides zero
	if x == 0 then return true end
	y = math.abs(y)
	x = math.abs(x)
	for z = 1, x do
		if x == y * z then
			return true
		elseif y * z > x then
			return false
		end
	end
	return false
	-- jeden tez jest zawsze dzielnikiem, wiec
	-- nie trzeba caly czas robic petle az do x, moze tylko do x-1
	-- ta sama liczba tez jest zawsze dzielnikiem, wiec
	-- mozna tez zaczac petle od 2 a nie od 1

	-- if x // y == x / y then return true else return false end

	-- sprawdzić jak to działa dla liczb ujemnych!
end

function gcd(a, b)
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

function isprime(x)
	if x == 2 then return true end
	if x % 2 == 0 then return false end
	count = 1
	for i = 3, x, 2 do
		if divides(i, x) then count = count + 1; end
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

arg1 = tonumber(arg[1])
arg2 = tonumber(arg[2])
arg3 = tonumber(arg[3])
arg4 = tonumber(arg[4])
print(ydivx(arg1, arg2))
-- print("gcd: ", gcd(arg1, arg2))
-- print("lcm: ", lcm(arg1, arg2))
-- print("is prime? ", isprime(arg3))
-- print("are relatively prime? ", relprime(arg1, arg2))
-- print("euler ", eulerphi(arg4))
