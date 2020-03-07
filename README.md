# ZJLogSDK
Log redirection output tool for iOS, support for c、c++、m、mm code files.</br>
[![CI Status](https://img.shields.io/travis/Eafy/ZJLog.svg?style=flat)](https://travis-ci.org/Eafy/ZJLog)
[![Version](https://img.shields.io/cocoapods/v/ZJLog.svg?style=flat)](https://cocoapods.org/pods/ZJLog)
[![License](https://img.shields.io/cocoapods/l/ZJLog.svg?style=flat)](https://cocoapods.org/pods/ZJLog)
[![Platform](https://img.shields.io/cocoapods/p/ZJLog.svg?style=flat)](https://cocoapods.org/pods/ZJLog)

# Use Description
## Log Level
  verbose > debug > info > warn > error
  |     parameter     |  level  |  description      |
  | :----------: | :------: | :---: |
  |  `ZJLOG_LEVEL_VERBOSE`  | 0 |  verbose  |
  | `ZJLOG_LEVEL_DEBUG`  | 1 |  debug   |   
  |   `ZJLOG_LEVEL_INFO`   | 2 |  info   |  
  | `ZJLOG_LEVEL_WARN` | 3 |  warn   |   
  | `ZJLOG_LEVEL_ERROR` | 4 |  error   |  
  
# ZJLog API
- `+setLogOFF`  
  Turn off log output, default on.
  
- `+setLevel:`  
  Setting the log level, default verbose.

- `+setDelegate:`  
  Setting delegate: ZJLogDelegate for didReceiveLogString.
  
- `+saveLog:`  
  Switch for save log to sandbox.
  
# Use Print API
## For OC
`#import <ZJLog/ZJLog.h>`</br>
`CLog(@"This is a log1");`</br>
`CLog(@"This is a log2:%@", @"Hello World!");`
## For C、C++
`#include <ZJLog/ZJPrintfLog.h>`</br>
`CPrintf("This is a log for debug")`</br>
`CPrintfV("This is a log for verbose")`</br>
`CPrintfD("This is a log for debug")`</br>
`CPrintfI("This is a log for info")`</br>
`CPrintfW("This is a log for warn")`</br>
`CPrintfE("This is a log for error")`
