//
//  JMLogEx.h
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#ifndef JMLogEx_h
#define JMLogEx_h

#import "JMLog.h"
#import "Singleton.h"

extern void CPrintfSendCallback(char * _Nullable log);
extern int mCPrintfLevelValue;

@interface JMLog ()
singleton_h(Tool)

@property (nonatomic,weak) id<JMLogDelegate> _Nullable delegate;

- (void)sendLogStr:(NSString *_Nullable)content;     //转化为NSString输出

/**
 关闭Log文件
 */
+ (void)writeClose;

/**
 写入Log日志(自动换行、自动添加时间：2018-08-10 23:58:50.3600    这是要写入的日志内容）
 #DEBUG模式下才有效，时间为UTC
 #日志文件在沙盒Documents/ConcoxVideoPlayLog/
 #文件名称:yyyy-MM-dd.txt，文件以当日时间为单位(若App未杀死进行跨天日志写入，则仍然写入上一天的文本中)

 @param content 日志内容
 */
+ (void)writeLog:(NSString *_Nullable)content;

/**
 单独写入换行符(1行)
 */
+ (void)writeWrap;

@end

#endif /* JMLogEx_h */


