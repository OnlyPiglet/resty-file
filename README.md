# file-log
A pure lua for writing file log efficiently.

# Status

This library is still under early development and is still experimental.

# Description

This Lua library is for writing file log efficiently.

# Synopsis

```lua

local log = require("log")
local logger = log:new({log_name = "/tmp/test.log",log_level = log.level.info})

logger:info("this is a info msg")

logger:warn("this is a info msg")

logger:error("this is a info msg")

logger:fatal("this is a info msg")

logger:destory()

```

# API

## new

`syntax: logger,err = log:new({log_name=xxx,log_level=log.level.trace})`  
Creates the logger object with config,log_name is the log file path,log_level is the lowest log level to be written into log file.if create logger failed,return nil and err msg

## reopen

`syntax: logger:reopen()`  
reopen the file log which definded in log_name.

## destory

`syntax: logger:destory()`  
close the file logger and flush the buffer.

## trace

`syntax: err = logger:trace("this is a trace msg")`  
Write a trace msg into logger file,if logger write failed return error msg,otherwise return nil.the msg can be a string or number type.

## info

`syntax: err = logger:info("this is a info msg")`  
Write a info msg into logger file,if logger write failed return error msg,otherwise return nil.the msg can be a string or number type.

## warn

`syntax: err = logger:warn("this is a warn msg")`  
Write a warn msg into logger file,if logger write failed return error msg,otherwise return nil.
the msg can be a string or number type.

## error

`syntax: err = logger:error("this is a error msg")`  
Write a error msg into logger file,if logger write failed return error msg,otherwise return nil.
the msg can be a string or number type.
## fatal

`syntax: err = logger:fatal("this is a fatal msg")`  
Write a fatal msg into logger file,if logger write failed return error msg,otherwise return nil.
the msg can be a string or number type.