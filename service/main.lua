local skynet = require "skynet"
-- require "skynet.manager"
local sprotoloader = require "sprotoloader"

local max_client = 64

skynet.start(function()
    -- skynet.error("[start main] hello world")

    -- -- 启动打工服务
    -- local worker = skynet.newservice("worker","xuchao",1)
    -- skynet.name("worker",worker)
    -- -- 启动买猫粮服务
    -- local buy1 = skynet.newservice("buy","buy",1)

    -- -- 开始工作
    -- skynet.send(worker,"lua","start_work")
    -- -- 主服务休息2秒
    -- skynet.sleep(200)
    -- -- 停止工作
    -- skynet.send(worker,"lua","stop_work")

    -- -- 买猫粮
    -- skynet.send(buy1,"lua","buy")
	skynet.error("Server start")
	skynet.uniqueservice("protoloader")
	if not skynet.getenv "daemon" then
		local console = skynet.newservice("console")
	end
	skynet.newservice("debug_console",8000)
	skynet.newservice("simpledb")
	local watchdog = skynet.newservice("watchdog")
	local addr,port = skynet.call(watchdog, "lua", "start", {
		port = 8888,
		maxclient = max_client,
		nodelay = true,
	})
	skynet.error("Watchdog listen on " .. addr .. ":" .. port)
    skynet.exit()
end)