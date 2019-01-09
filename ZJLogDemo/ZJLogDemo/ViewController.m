//
//  ViewController.m
//  ZJLogDemo
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/9.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJLog.h"
#include "TestLog.h"

@interface ViewController () <ZJLogDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [ZJLog setEnable:YES];
    [ZJLog setDelegate:self];
    [ZJLog setLevel:ZJLOG_LEVEL_WARN];

    CLog(@"CLog");
    CPrintfV("OCFile: CPrintfV");
    CPrintfD("OCFile: CPrintfD");
    CPrintfI("OCFile: CPrintfI");
    CPrintfW("OCFile: CPrintfW");
    CPrintfE("OCFile: CPrintfE");

    testLog();
}

- (void)didReceiveLogString:(NSString *)logStr
{
    NSLog(@"%@", logStr);
}

@end
