--[[
Author: jackwu
Date: 2022-03-10 20:35:32
LastEditTime: 2022-03-10 20:35:32
LastEditors: jackwu
Description: for write msg into file
FilePath: /resty-file/file.lua
--]]

local _M = {}

_M.level = {
    trace = 0,
    info = 1,
    warn = 2,
    error = 3,
    fatal = 4,
}

local level_num_name = {}

level_num_name[0] = "trace"
level_num_name[1] = "info"
level_num_name[2] = "warn"
level_num_name[3] = "error"
level_num_name[4] = "fatal"

local function write(self,log_level,msg)
    
    if self.config.shutdown or log_level < self.config.log_level then
        return nil
    end

    local line = table.concat({" Time: ",os.time() ," Level: ",level_num_name[log_level]," Msg: ",msg,"\n"})
  
    if not self.fd or not io.type(self.fd) or io.type(self.fd) ~= "file"  then
        self:reopen_fd()
    end
    
    local file,message =  self.fd:write(line)

    if message then
        return "log plugin info of ".. self.config.log_name .. " failed with error : "..message
    else
        return nil
    end
end


function _M:trace(msg)
    return write(self,0,msg)
end

function _M:info(msg)
    return write(self,1,msg)
end

function _M:warn(msg)
    return write(self,2,msg)
end

function _M:error(msg)
    return write(self,3,msg)
end

function _M:fatal(msg)
    return write(self,4,msg)
end

local function close_fd(self)
    if self.fd and  io.type(self.fd) and io.type(self.fd) == "file"  then
        self.fd:flush()
        self.fd:close()
    end
end

function _M:new(conf)
    self.config = {
        log_name = conf.log_name,
        log_level = conf.log_level,
        shutdown = false,
    }
    self:reopen_fd()

    return self
end

function _M:destory()
    self.config.shutdown = true
    close_fd(self)
end

function _M:reopen_fd()
    close_fd(self)
    self.fd = io.open(self.config.log_name,"a+")
    self.fd:setvbuf("full")
end

return _M