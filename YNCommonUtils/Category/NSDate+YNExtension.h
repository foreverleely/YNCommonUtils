//
//  NSDate+YNExtension.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YNExtension)

#pragma mark - base
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)ync_day;
- (NSUInteger)ync_month;
- (NSUInteger)ync_year;
- (NSUInteger)ync_hour;
- (NSUInteger)ync_minute;
- (NSUInteger)ync_second;
+ (NSUInteger)ync_day:(NSDate *)date;
+ (NSUInteger)ync_month:(NSDate *)date;
+ (NSUInteger)ync_year:(NSDate *)date;
+ (NSUInteger)ync_hour:(NSDate *)date;
+ (NSUInteger)ync_minute:(NSDate *)date;
+ (NSUInteger)ync_second:(NSDate *)date;

- (BOOL)ync_isLeapYear;
+ (BOOL)ync_isLeapYear:(NSDate *)date;

- (NSInteger)ync_daysInMonth:(NSUInteger)month;
+ (NSUInteger)ync_daysInMonth:(NSDate *)date month:(NSUInteger)month;
- (NSInteger)ync_weekday;
+ (NSInteger)ync_weekday:(NSDate *)date;
- (NSString *)ync_monthWithMonthNumber;
+ (NSString *)ync_monthWithMonthNumber:(NSInteger)month;
- (NSString *)ync_dayFromWeekday;
+ (NSString *)ync_dayFromWeekday:(NSDate *)date;

#pragma mark - Constellation

+ (NSString *)getConstellationNameByMonthIndex:(NSInteger)monthIndex
                                      dayIndex:(NSInteger)dayIndex;

#pragma mark - Jan 1st. 1970

- (NSString *)ync_getMonDayYear;
+ (NSString *)ync_getMonDayYearWith:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
