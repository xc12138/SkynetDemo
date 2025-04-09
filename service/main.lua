local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("[start main] hello world")

    -- 启动打工服务
    local worker = skynet.newservice("worker","xuchao",1)
    skynet.name("worker",worker)
    -- 启动买猫粮服务
    local buy1 = skynet.newservice("buy","buy",1)

    -- 开始工作
    skynet.send(worker,"lua","start_work")
    -- 主服务休息2秒
    skynet.sleep(200)
    -- 停止工作
    skynet.send(worker,"lua","stop_work")

    -- 买猫粮
    skynet.send(buy1,"lua","buy")

    skynet.exit()
end)