//
//  YNCSaveDataManager.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCSaveDataManager : NSObject

+ (YNCSaveDataManager *)share;

- (id)getDiskCacheWithModelClass:(Class)className Key:(NSString *)key;

- (id)getDiskCacheWithOutCreateWithModelClass:(Class)className Key:(NSString *)key;

- (void)saveDiskCacheWithModel:(id)model Key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
