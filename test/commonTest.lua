local m=require("sando.mq")
local json = require("sando.dkjson")
setmetatable(m,{__index=_G})
setfenv(1,m)
local cor = {100,200,350,450}
-- tap正确调用示例
tap(500,300)
tap(200,300,400,600)
tap(cor)
tap(cor,"")
-- 错误调用
local tof,errmsg=pcall(function (  )
  tap(123)
  tap()
  tap("111",2)
end)
print(errmsg)
tap(cor)
for i=1,10 do
  delay(200)
end
-- function test(  )
--   function  shit(  )
--     print("内部函数")
--   end
--   return shit
-- end
-- test()()
