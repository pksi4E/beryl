require "..blu"
luaunit = require("luaunit")
local bint = require[[bint]](1024)

function test_ydivx_positives()
    luaunit.assertEquals(ydivx(7, 21), true)
    luaunit.assertEquals(ydivx(7.0, 21.0), true)
    luaunit.assertEquals(ydivx(7.0, 21), true)
    luaunit.assertEquals(ydivx(7, 21.0), true)
end

function test_ydivx_negatives()
    luaunit.assertEquals(ydivx(-7, 21), true)
    luaunit.assertEquals(ydivx(7, -21), true)
    luaunit.assertEquals(ydivx(-7, -21), true)

    luaunit.assertEquals(ydivx(-7, 1024), false)
    luaunit.assertEquals(ydivx(7, -1024), false)
    luaunit.assertEquals(ydivx(-7, -1024), false)
end

function test_ydivx_bint()
    luaunit.assertEquals(ydivx(99, factorial(bint(100)):__tostring()), true)
-- 93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
end

os.exit(luaunit.LuaUnit.run())