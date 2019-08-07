//
//  YNCSaveDataManager.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCSaveDataManager.h"
// pod
#import "YYCache.h"
#import "YYModel.h"

#define YNCSaveDataManagerDataDB @"YNCSaveDataManagerDataDB"

@implementation YNCSaveDataManager

+ (YNCSaveDataManager *)share {
    
    static YNCSaveDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YNCSaveDataManager new];
    });
    return instance;
}

#pragma mark - Disk Cache for complex model

- (id)getDiskCacheWithModelClass:(Class)className Key:(NSString *)key {
    
    return [self getDiskCacheWithModelClass:className Key:key isCreate:YES];
}

- (id)getDiskCacheWithOutCreateWithModelClass:(Class)className Key:(NSString *)key {
    
    return [self getDiskCacheWithModelClass:className Key:key isCreate:NO];
}

- (id)getDiskCacheWithModelClass:(Class)className Key:(NSString *)key isCreate:(BOOL)isCreate {
    
    YYCache *cache = [YYCache cacheWithName:YNCSaveDataManagerDataDB];
    NSData *saveData = (NSData *)[cache objectForKey:key];
    id dataModel;
    if (saveData) {
        NSDictionary *dict;
//        if (@available(iOS 12.0, *)) {
//            dict = [NSKeyedUnarchiver unarchivedObjectOfClass:className fromData:saveData error:nil];
//        } else {
            dict = [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
//        }
        dataModel = [className yy_modelWithJSON:dict];
    }
    if (!dataModel && isCreate) {
        dataModel = [className new];
    }
    return dataModel;
}

- (void)saveDiskCacheWithModel:(id)model Key:(NSString *)key {
    
    YYCache *cache = [YYCache cacheWithName:YNCSaveDataManagerDataDB];
    NSDictionary *dic = [model yy_modelToJSONObject];
    NSData *data;
    if (@available(iOS 12.0, *)) {
        data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:NO error:nil];
    } else {
        data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    }
    [cache setObject:data forKey:key];
}

@end
