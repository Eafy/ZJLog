//
//  JMLogBridgeOC.c
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#include "JMLogBridgeOC.h"

#ifdef kNeedDifLevelValue
int mCPrintfLevelValue = CPrintf_VERBOSE;

void SetCPrintfLogLevel(int level)
{
    if (CPrintf_VERBOSE <= level && level <= CPrintf_ERROR) {
        mCPrintfLevelValue = level;
    }
}
#endif
