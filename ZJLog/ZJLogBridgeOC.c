//
//  ZJLogBridgeOC.c
//  ZJLog
//
//  Created by eafy on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#include "ZJLogBridgeOC.h"

#ifdef kNeedDifLevelValue
int mCPrintfLevelValue = CPrintf_VERBOSE;

void SetCPrintfLogLevel(int level)
{
    if (CPrintf_VERBOSE <= level && level <= CPrintf_ERROR) {
        mCPrintfLevelValue = level;
    }
}
#endif
