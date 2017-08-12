-- 说明：为mq模块提供支持函数。

-- 模块化
local global_module_name = ...
local _Module = {}
package.loaded[global_module_name]=_Module
-- 兼容lua5.1/5.2/5.3
local CE = require("sando.compat_env")
setfenv=CE.setfenv
setmetatable(_Module,{__index=_G})
setfenv(1,_Module)


local _setting = require("sando.mq_setting")
-- tap函数的support函数
-- 以当前时间作为随机种子
math.randomseed(os.time())
-- 参数为两个数字
function  tap2( x,y )
  -- 来自badboy库，有改动
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
  local index = math.random(1,5)
  x = x + math.random(-2,2)
  y = y + math.random(-2,2)
  print("成功判定只有两个数字作为参数",x,y)
  -- touchDown(index,x, y)
  -- mSleep(math.random(65,85))                --某些特殊情况需要增大延迟才能模拟点击效果
  -- touchUp(index, x, y)
  if _setting.open_tap_delay==true then
    delay(_setting.tap_delay)
  end
end
-- 四个参数的tap，实际点击的点为四个参数确定范围内的随机一个点
function tap4 (x1,y1,x2,y2)
  tap(math.random(x1,x2),math.random(y1,y2))
end
local tap_t_str = function (t,str)
  print("我去，你提供了个表和字符串!")
  if str=="" then
    tap4(t[1],t[2],t[3],t[4])
  end
end
function delay(time)
  if type(time)~="number" then
    error("参数应为数字")
  end
  local actual_time=_setting.open_random_delay and 
  time+math.random(-_setting.random_delay,_setting.random_delay) or time;
  print("实际延时",actual_time)
  -- msleep(actual_time)
end