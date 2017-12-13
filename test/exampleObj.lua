local json = require ("sando.dkjson")
-- 模块化
local global_module_name = ...
local _Module = {}
package.loaded[global_module_name]=_Module
-- 兼容lua5.1/5.2/5.3
local CE = require("sando.compat_env")
setfenv=CE.setfenv
setmetatable(_Module,{__index=_G})
setfenv(1,_Module)

local data = [[
  {
    "主页":[28,1740,176,1886],
    "主页按钮存在":"判定主页按钮是否存在",
    "元神":[723,1775,821,1867],
    "元神培养":[113,1540,186,1599],
    "元神进阶":[291,1534,374,1594],
    "元神技能":[291,1534,374,1594],
    "加号":[35,1501,124,1581],
    "加号已展开":"确认加号是否展开",
    "天元心法":[177,1354,250,1426],
    "修炼":[937,1476,1006,1568],
    "足够升级":"确认是否足够升级",
    "升级":[493,1474,580,1557],
    "迷仙阵":[340,1370,413,1450],
    "活动副本":[493,1489,593,1590],
    "通天塔":[822,1499,904,1587],
    "进入战斗":"假设此点不固定，那么绑定的函数需要找到按钮所在区域并返回一个table",
    "宝箱1":[338,550,417,608],
    "宝箱2":[495,550,587,607],
    "宝箱3":[821,553,908,603]
  }
]]
obj, pos, err = json.decode (data)
if err then
  error("出错："..err)
else
  -- 在此处进行函数绑定
  obj["主页按钮存在"]=function()
    print("成功调用主页按钮存在函数")
    return true
  end
  obj["进入战斗"]=function()
    -- 寻找按钮位置的代码省略
    print("成功点击进入战斗")
    return {100,22,200,300}
  end
end