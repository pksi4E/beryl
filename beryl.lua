-- blu.lua
local bint = require 'bint'(2048)

function ydivx(y, x)
--[[
	Function that check if number y divides number x.
	function which returns boolean if the number y
	divides number x, that is in mathematical syntax: y|x
	x is a base number, y is a number to check if it divides x
	y divides x, if there exists z such that x = y * z
]]
	if x > math.maxinteger then
		if (not bint.isbint(x)) then
			error("NotBintError")
		end
		return bint.iszero(x % y)
	end
	return x % y == 0
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
	
	while y ~= bint.zero() do
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
	if isreversible(x, n) then
		g, s, t = eea(x, n)
		if s < 0 then
			return n + s
		else
			return s
		end
	else
		return 'not reversible'
	end
end

function eea (a, b)
--[[
	Function...
]]--
	a0 = a
	b0 = b
	t0 = 0
	t = 1
	s0 = 1
	s = 0
	q = a0 // b0
	r = a0 - q * b0
	while r > 0 do
		temp = t0 - q * t
		t0 = t
		t = temp
		temp = s0 - q * s
		s0 = s
		s = temp
		a0 = b0
		b0 = r
		q = a0 // b0
		r = a0 - q * b0
	end
	r = b0
	return r, s, t
end
-- a, b = 200, 136
-- r,s,t = eea(a, b)
-- io.write(string.format("%d = nwd(%d, %d) = %d * a + %d * b = %d\n", r, a, b, s, t, r))

function rank(g, n)
--[[
	Function that checks the rank of an element
	modulo n.
]]
	if g == 1 then return 1 end
	w = g
	i = 1
	while true do
		i = i + 1
		w = w * g
		if w % n == 1 then
			return i
		end
	end
end

function iscyclic(group, n)
--[[
	...
]]
	local group_rank = #group
	for i, g in ipairs(group) do
		if rank(g, n) == group_rank then
			return true, g
		end
	end
	return false
end

function generator(group)
--[[

]]
	_, gen = iscyclic(group, group[#group]+1)
	return gen
end

function isquadraticresidue(a, p)
--[[
	Function.
]]
	for i = 1, p - 1 do
		local w = i ^ 2
		if w % p == a then
			return true
		end
	end
	return false
end

function quadres(p)
--[[
	Function that returns the table with
	all quadratic residues modulo p,
	i.e. from the multiplicative group Z_p,
	where p is a prime number.
]]
	local t = {}
	for i = 1, p - 1 do
		local w = (i ^ 2) % p
		t[w] = true
	end
	return t
end

function _eulcrit(a, p)
--[[ Euler criterium to calculate quadratic residue. ]]
	local pow = (p - 1) / 2
	local w = a ^ pow
	if w % p == 1 then
		return true
	else
		return false
	end
end

function counttime(f, ...)
	local starttime = os.clock()
	f(...)
	io.write(string.format("Time: %s seconds", os.clock() - starttime))
end

function tobin(num)
--[[
	Function returns string with binary representation of a number num.
]]
	-- if type(num) == type({}) then zero = bint(0) else zero = 0 end
	-- local zero = bint.zero()
	-- if num > math.maxinte(ger then zero = bint(0) end
	if (not bint.isbint(num)) then
		error("NotBintError")
	else
		return (num == bint.zero()) and '' or tobin(num // 2) .. tostring(num % 2)
	end
end

function binlength(num)
--[[
	Function returns number of bits of a decimal number.
]]
	return math.floor(math.log(num, 2)) + 1
end

function bin2dec(s)
	local n = 0
	for i = 0, #s - 1 do
		n = n + (2 ^ i) * tonumber(string.sub(s, #s-i, #s-i))
	end
	return n
end
	
function repr64bit(binarystr)
	local lenstr = #binarystr
	local len = 64
	if lenstr < 64 then
		len = len - lenstr
	end
	local braki = ''
	for i = 1, len do braki = braki .. 0 end
	print(#braki)
	return braki .. binarystr
end

function hamm(x)
--[[
	Hamming distance.
]]
	local b = tobin(x)
	local count = 0
	for i = 1, string.len(b) do
		if string.sub(b, i, i) == '1' then count = count + 1 end
	end 
	return count
end

function ifpow2(num)
--[[
	Function checks if num is a power of 2.
]]
	local b = tobin(num)
	local count = 0
	for i = 1, #b do
		if b:sub(i, i) == '1' then count = count + 1 end
	end
	return count == 1
end

function _millerrabin(num)
	local nmin1 = num - 1
	local m = tobin(nmin1)
	-- while string.sub(m, #m, #m) == '0' do
	-- 	m = string.sub(m, 1, #m-1)
	-- end
	-- return m
	local pow2count = 0
	while string.sub(m, #m, #m) == '0' do
		pow2count = pow2count + 1
		m = string.sub(m, 1, #m-1)
	end
	m = nmin1 >> pow2count
	local a = math.random(1, nmin1)
	local b = (a ^ m) % num
	if b % num == 1 then return num .. " pierwsza" end
	for i = 0, pow2count - 1 do
		if b % num == num - 1 then
			return num .. " pierwsza"
		else
			b = (b ^ 2) % num
		end
	end 
	return num .. " zlozona"
end

function randombits(n, forceodd)
	local odd = forceodd or false
	local s = ''
	if odd then
		s = '1'
		n = n - 1
	end 
	for i = 1, n do
		local b = math.random(0, 1)
		s = tostring(b) .. s
	end
	return s
end

function posdivisors(n)
--[[
	Function returns a set of positive divisors
	of a number n.
]]
	local t = {}
	for i = 1, n // 2 do
		if ydivx(i, n) then
			table.insert(t, i)
		end
	end
	return t
end

function sumdivisors(n)
	local t = posdivisors(n)
	local sum = 0
	for _, i in ipairs(t) do
		sum = sum + i
	end
	return sum
end

function sumdivisors2(n)
	--[[
		Function returns a set of positive divisors
		of a number n.
	]]
	local sum = 0
	for i = 1, n // 2 do
		if ydivx(i, n) then
			sum = sum + i
		end
	end
	return sum
end

function _rhopollard (n, x1, f)
--[[
	function that 
]]
	-- local x = x1
	-- local xprim = f(x) % n
	-- local p = gcd(x - xprim, n)
	-- while p == 1 do
	-- 	x = f(x) % n
	-- 	xprim = f(xprim) % n
	-- 	xprim = f(xprim) % n
	-- 	p = gcd(x - xprim, n)
	-- end
	-- if p == n then
	-- 	return "error"
	-- else
	-- 	return p
	-- end
	local x = 2
	local y = 2
	local d = 1
	while d == 1 do
		x = f(x)
		y = f(f(y))
		d = gcd(math.abs(x - y), n)
	end
	if d == n then
		return "error"
	else
		return d
	end
end

function primeset(k)
--[[
	function returns the set of first k primes, the number of primes is k
]]
	local i = 0
	local p = 2
	local t = {}
	while true do
		if isprime(p) then
			table.insert(t, p)
			i = i + 1
			if i == k then
				break
			end
		end
		p = p + 1
	end
	return t
end

function continued_fraction_expansion(a, b)
--[[
	Function that calculated continued fraction expansion
	of a fraction a/b.
]]
	local x = a
	local y = b
	local t = {}
	while y ~= 0 do
		local e = x // y
		local r = x % y
		x = y
		y = r
		table.insert(t, e)
		end

	return t
end

function pow_mod(x, c, n)
--[[
	function that performs exponentiation modulo n
]]
	local c_bin = tobin(c)
	local l = #c_bin
	print(l)
	local z = 1
	for i = l - 1, 0, -1 do
		z = z^2 % n
		if string.sub(c_bin, i, i) == '1' then
			z = (z*x) % n
		end
	end
	return z
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

-- sets
function isadmissible(t)
	for i = 1, #t-1 do
		if not (t[i] < t[i+1]) then
			return false
		end
	end
	if #t <= t[1] then
		return true
	else
		return false
	end
end

function factorial(n)
--[[
	Function that return a factorial of a number.
]]
	if n <= 2 then
		return n
	else
		return n * factorial(n - 1)
	end
end

function powmod(x, c, n)
--[[
	Function that permorms x^c % n.
]]
	local z = 1
	local binc = tobin(c)
	for i = 1, #binc do
		z = z*z % n
		if tonumber(binc:sub(i, i)) == 1 then z = z*x % n end
	end
	return z
end
-- return {
-- 	tobin = tobin,
-- 	ydivx = ydivx,
-- 	gcd = gcd,
-- }

function fibonaccinumber(n)
	local f = {0, 1}
	local pom
	for i = 1, n do
		pom = f[1] + f[2]
		f[1] = f[2]
		f[2] = pom
	end
	return f[1]
end

function fermatnumber(n)
	local p = 2^n
	return 2^p + 1
end

-- TODO: implement meertens function
function meertens(base, num)
--[[
	meertens function
]]
	local k = math.log(num, base) + 1
	-- for i = 1, k - 1 do
		
	-- end
end