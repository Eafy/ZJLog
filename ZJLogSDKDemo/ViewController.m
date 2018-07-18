//
//  ViewController.m
//  ZJLogSDKDemo
//
//  Created by lzj<lizhijian_21@163.com> on 2018/7/4.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#import "ViewController.h"
#import "ZJLogSDK.h"
#import "ZJLogTest.h"
#import <time.h>

@interface ViewController () <ZJLogSDKDelegate>

@end

@implementation ViewController

double xu_wallclock(void)
{
#ifdef __GNUC__
    struct timespec ctime;
    int error;
    
    error = clock_gettime(1, &ctime);
    
    return (1.0e+9 * (double)ctime.tv_sec + (double)ctime.tv_nsec);
#else
    return (double)time(NULL);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [ZJLogSDK setDelegate:self];
    [ZJLogSDK setLogOut];
    [ZJLogSDK setLogOFF];
    
    [ZJLogTest test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZJLogControllerDelegate

- (void)didReceiveLogString:(NSString *)logStr
{
    NSLog(@"%@", logStr);   //在此打印或保存
}


@end
