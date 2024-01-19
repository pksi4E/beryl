require "..numbel"
luaunit = require("luaunit")

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

os.exit(luaunit.LuaUnit.run())