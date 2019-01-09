//
//  ViewController.m
//  ZJLogDemo
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/3.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "ViewController.h"
#import <ZJLog/ZJLog.h>
#import "Test.h"

@interface ViewController () <ZJLogDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [ZJLog setDelegate:self];     //若没有将SDK日志写入文件的需求，不需要设置代理，一旦设置代理，SDK日志走代理方法
    [ZJLog setSave:YES];

    CLog(@"123");
    CPrintf("%s", "12345");
    testLog();
}

- (void)didReceiveLogString:(NSString *)logStr
{
    NSLog(@"%@", logStr);
}

@end
