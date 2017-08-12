-- mq模块的设置文件

--[==[
设置器：（用来防行为检测）
如果同时打开tap函数自带延迟和delay函数带随机延迟,、
则tap函数的延迟也是随机的，因为tap函数使用的延迟函数是delay
delay例子：
delay(400)不打开随机延迟，则延迟400毫秒
打开随机延迟，则延迟在400+random_delay和400-random_delay之间
--]==]
local _setting = {
  -- 是否注册全局模块名
  register_global_module_table = false,

  -- 是否使tap函数自带延迟
  open_tap_delay=true,
  -- tap函数延迟的毫秒数
  tap_delay = 250,

  -- 是否使delay函数带随机延迟
  open_random_delay=true,
  -- 随机延迟的毫秒数
  random_delay = 30,

  -- 是否打开print输出
  open_print=true,
  -- 当一张table的值是table时，是否打印表中表
  print_inner_table=false
}
return _setting
