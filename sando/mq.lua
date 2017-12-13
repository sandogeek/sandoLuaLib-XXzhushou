local ms=require("sando.mq_support")
local _setting = require("sando.mq_setting")
local global_module_name = ...
local _Module = {}
if register_global_module_table then
  _G[global_module_name] = _Module
end
-- 如果模块没有返回值，则会return package.loaded[moduleName]
package.loaded[global_module_name]=_Module
-- 兼容lua5.1/5.2/5.3
local CE = require("sando.compat_env")
setfenv=CE.setfenv
-- 使用环境后，旧环境的内容将无法访问，接下来声明依赖
-- local random,randomseed = math.random,math.randomseed
-- local os=os
-- local print=print
-- 偷波懒，直接设置可以用所有的全局变量，性能有微弱下降
local oprint = print or syslog
setmetatable(_Module,{__index=_G})
setfenv(1,_Module)
-- 将表转化为字符串表，如{11,22,33,"99",tt=55},
-- 转化为{'[1]','11','[2]','22','[3]','33','[4]','"99"','["tt"]','55'}
tableToTableStr = function ( t )
  local strTable = {}
  local column1,column2
  for k,v in pairs(t) do
    column1= type(k)=="number" and ('['..k..']') or ('["'..k..'"]')
    column2= type(v)=="string" and ('"'..v..'"') or tostring(v)
    table.insert(strTable,column1)
    table.insert(strTable,column2)
  end
  -- 空一行，因为叉叉第一行前自动输出时间

  return strTable
end
-- 覆写print
print=function( ... )
    local msg = ''
    for k,v in pairs({...}) do
      if type(v)=="table" then

      end
      msg = string.format('%s %s ', msg, tostring(v))
    end
    oprint(msg)
  end


-- 模拟一次点击
function tap(a,b,...)
  local other={...}
  local length = #other
  if type(a)=="number" and type(b)=="number" then
    if length==0 then
      ms.tap2(a,b)
    elseif length==2 then
      local x1,x2,x3,x4 = a,b,other[1],other[2]
      if type(x3)=="number" and type(x4)=="number" then
        ms.tap4(x1,x2,x3,x4)
      else
        error("提供四个参数时四个参数都应为数字")
      end
    end
  elseif type(a)=="table" and type(b)=="nil" and length==0 then
    if #a==4 then
      ms.tap4(a[1],a[2],a[3],a[4])
    elseif #a==2 then
      ms.tap2(a[1],a[2])
    elseif ms.manyErea(a) then-- 上面已经确认a为table,b为空,只需要传入a
      ms.tapRandomErea(a)
    else
      error("提供的table元素个数有误")
    end
  else
    error("提供的参数有误")
  end
end

function delay(time)
  ms.delay(time)
end
function get(t,str)
  
end
function set( t,str,value )
  
end
