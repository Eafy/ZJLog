//
//  ZJLogWriteManager.m
//  ZJLog
//
//  Created by eafy on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "ZJLogWriteManager.h"
#import "ZJLogEx.h"

@interface ZJLogWriteManager()

@property (nonatomic,strong) NSString *logFilePath;
@property (nonatomic,strong) NSFileHandle *wirteFileHandle;
@property (nonatomic,assign) BOOL isHadFile;

@property (nonatomic,strong) NSMutableDictionary *uploadFileDic;
@property (nonatomic,strong) NSMutableArray *uploadFileArray;

@end

@implementation ZJLogWriteManager
singleton_m(Write);

- (void)initData
{
    _logFilePath = nil;
    _wirteFileHandle = nil;
}

- (void)dealloc
{
    [self close];
}

- (NSFileHandle *)wirteFileHandle
{
    if (!_wirteFileHandle) {
        _wirteFileHandle = [NSFileHandle fileHandleForWritingAtPath:self.logFilePath];
    }
    return _wirteFileHandle;
}

- (NSString *)logFilePath
{
    if (!_logFilePath) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *logFilePath = [documentsPath stringByAppendingString:@"/ZJLog"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:logFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];   //GMT UTC
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormat stringFromDate:[NSDate date]];

        logFilePath = [NSString stringWithFormat:@"%@/%@_%@.txt", logFilePath, [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey], timeStr];

        self.isHadFile = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            self.isHadFile = NO;
            [@"" writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            [self updateCurrentLogFile:timeStr];
        }

        _logFilePath = logFilePath;
    }

    return _logFilePath;
}

- (void)close
{
    if (_wirteFileHandle) {
        [self.wirteFileHandle closeFile];
        _wirteFileHandle = nil;
    }
    [self saveUploadFileDic:self.uploadFileDic];
    _uploadFileDic = nil;
}

- (void)writeLog:(NSString *)content
{
#ifdef DEBUG
    if (content.length > 0) {
        [self.wirteFileHandle seekToEndOfFile];
        if ([content isEqualToString:@"\n"]) {
            [self.wirteFileHandle writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
        } else {
            NSString *log = [NSString stringWithFormat:@"%@    %@\n", [self getLogTime], content];
            [self.wirteFileHandle writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
#endif
}

- (NSString *)getLogTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];   //GMT UTC
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSS"];
    return [dateFormat stringFromDate:[NSDate date]];
}

- (void)writeWrap
{
    [self writeLog:@"\n"];
}

#pragma mark - 日志上传

- (NSMutableDictionary *)uploadFileDic
{
    if (!_uploadFileDic) {
        _uploadFileDic = [self readUploadFileDic];
    }

    return _uploadFileDic;
}

- (NSMutableArray *)uploadFileArray
{
    if (!_uploadFileArray) {
        _uploadFileArray = [NSMutableArray arrayWithArray:[self.uploadFileDic objectForKey:@"kZJLogFileList"]];
    }

    return _uploadFileArray;
}

/**
 读取未上传或正在记录的日志文件

 @return 日志文件字典
 */
- (NSMutableDictionary *)readUploadFileDic
{
    NSMutableDictionary *fileDic = nil;
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *logFilePath = [documentsPath stringByAppendingString:@"/ZJLog/ZJLogUploadDic.DAT"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:logFilePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        fileDic = [NSMutableDictionary dictionaryWithDictionary:[unarchiver decodeObjectForKey:@"kZJLogUploadDic"]];
        [unarchiver finishDecoding];
    }
    if (!fileDic) {
        fileDic = [NSMutableDictionary dictionary];
    }

    return fileDic;
}

/**
 保存未上传或正在记录的日志文件

 @param fileDic 日志文件字典
 */
- (void)saveUploadFileDic:(NSMutableDictionary *)fileDic
{
    if (fileDic) {
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:fileDic forKey:@"kZJLogUploadDic"];
        [archiver finishEncoding];

        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *logFilePath = [documentsPath stringByAppendingString:@"/ZJLog/ZJLogUploadDic.DAT"];

        BOOL success = [data writeToFile:logFilePath atomically:YES];
        ZLog(@"Write log data to file: %d", success);
    }
}

/**
 更新当前日志记录应该写入哪个文件

 @param fileName 文件名称
 */
- (void)updateCurrentLogFile:(NSString *)fileName
{
    NSString *preFileName = [self.uploadFileDic objectForKey:@"kZJLogCurrentFile"];
    [self.uploadFileDic setObject:fileName forKey:@"kZJLogCurrentFile"];
    if (preFileName) {
        NSMutableArray *fileArray = [NSMutableArray arrayWithArray:[self.uploadFileDic objectForKey:@"kZJLogFileList"]];
        [fileArray addObject:preFileName];
        [self.uploadFileDic setObject:fileArray forKey:@"kZJLogFileList"];
    }
}


@end
