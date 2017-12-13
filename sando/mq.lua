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
  ms.otap(a,b,...)
end

-- 把lua文件对象化
function obj(objName)
  if type(objName)~="string" then
    error("参数必须为string")
  else
    moudule=require(objName)
    function moudule:tap(key)
      -- 支持点击不固定的位置
      if type(self.obj[key])=="table" then
        ms.otap(self.obj[key])
      elseif type(self.obj[key])=="function" then
        ms.otap(self.obj[key]())
      else
        error("参数有误")
      end
    end
    function moudule:call(key)
      self.obj[key]()
    end
  end
  return moudule
end

function delay(time)
  ms.delay(time)
end
function get(t,str)
  
end
function set( t,str,value )
  
end
