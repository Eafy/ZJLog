//
//  ZJLogWriteManager.h
//  ZJLog
//
//  Created by eafy on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJLogWriteManager : NSObject
singleton_h(Write);

- (void)close;

- (void)writeLog:(NSString *_Nullable)content;

- (void)writeWrap;

@end

NS_ASSUME_NONNULL_END
