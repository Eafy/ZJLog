//
//  JMLogWriteManager.h
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMLogWriteManager : NSObject
singleton_h(Write);

- (void)close;

- (void)writeLog:(NSString *_Nullable)content;

- (void)writeWrap;

@end

NS_ASSUME_NONNULL_END
