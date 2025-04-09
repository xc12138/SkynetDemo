local skynet = require "skynet"
local service = require "service"

service.money = 0
service.isWorking = false

service.update = function(frame)
    if service.isWorking then
        service.money = service.money + 1
        skynet.error(worker_name .. tostring(worker_id) .. ", Money：" .. tostring(service.money))
    end
end

service.init = function()
    skynet.fork(service.time)
end

service.time = function()
    local stime = skynet.now()
    local frame = 0
    while true do
        frame = frame + 1
        local isok,err = pcall(update,frame)
        if not isok then
            skynet.error(err)
        end
        local etime = skynet.now()
        local waittime = frame * 20 - (etime - stime)
        if waittime <= 0 then
            waittime = 2
        end
        skynet.sleep(waittime)
    end
end

service.resp.start_work = function(source)
    service.isWorking = true
end

service.resp.stop_work = function(source)
    service.isWorking = false
end

service.resp.change_money = function(source, delta)
    service.money = service.money + delta
    return service.money
end

service.start(...)