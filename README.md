# ZJLogSDK

设置代理：
[ZJLogSDK setDelegate:self];
关闭日志输出：
[ZJLogSDK setLogOFF];
关闭日志上报：
[ZJLogSDK setLogOut];

文件功能内容如下：
ZJLogSDK(h、mm)：主体部分，包括代理设置、日志总开关、日志上报开关，在此用mm后缀可兼容m、mm(C++类)两种OC文件使用CLog，若使用m后缀则在mm文件中无法使用；

ZJLogSDKExt(h)：即ZJLogSDK类的扩展，主要是实现单例和封装外部不可访问的接口和变量(若不需要单独封装，可将内容合并到ZJLogSDK.h中)；

ZJLogPrintf(h)：CPrintf宏的定义窗口，主要是为C文件使用CPrintf做接口；

ZJLogBridgeC(h、m)：此唯一目的就是桥接C和OC之间的接口，调用路径为CPrintf->CPrintfCallback->ZJLogSDK。
