local skynet = require "skynet"
local service = require "service"

service.price = 5
service.cnt = 0

service.resp.buy = function()
    -- 先扣费
    local left_money = skynet.call("worker","lua","change_money",-service.price)
    if left_money >= 0 then
        service.cnt = service.cnt + 1
        skynet.error("buy store success cnt: " .. tostring(service.cnt))
        return true
    end
    -- 购买失败
    skynet.error("buy store failed,money not enough!")
    skynet.call("worker","lua","change_money",service.price)

    return false
end

service.start(...)