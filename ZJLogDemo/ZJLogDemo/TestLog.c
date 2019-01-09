//
//  TestLog.c
//  ZJLogDemo
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/9.
//  Copyright © 2019 ZJ. All rights reserved.
//

#include "TestLog.h"
#include "ZJLogBridgeOC.h"

void testLog()
{
    CPrintfV("OCFile: CPrintfV");
    CPrintfD("OCFile: CPrintfD");
    CPrintfI("OCFile: CPrintfI");
    CPrintfW("OCFile: CPrintfW");
    CPrintfE("OCFile: CPrintfE");
}
