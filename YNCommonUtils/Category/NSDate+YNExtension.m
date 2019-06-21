//
//  NSDate+YNExtension.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSDate+YNExtension.h"

@implementation NSDate (YNExtension)

#pragma mark - base

- (NSUInteger)ync_day {
    return [NSDate ync_day:self];
}

- (NSUInteger)ync_month {
    return [NSDate ync_month:self];
}

- (NSUInteger)ync_year {
    return [NSDate ync_year:self];
}

- (NSUInteger)ync_hour {
    return [NSDate ync_hour:self];
}

- (NSUInteger)ync_minute {
    return [NSDate ync_minute:self];
}

- (NSUInteger)ync_second {
    return [NSDate ync_second:self];
}

+ (NSUInteger)ync_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)ync_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)ync_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)ync_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)ync_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)ync_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

#pragma mark - Constellation

+ (NSString *)getConstellationNameByMonthIndex:(NSInteger)monthIndex
                                      dayIndex:(NSInteger)dayIndex {
    
    NSArray *constellations = @[@"Capricorn", @"Aquarius", @"Pisces", @"Aries", @"Taurus", @"Gemini", @"Cancer", @"Leo", @"Virgo", @"Libra", @"Scorpio", @"Sagittarius", @"Capricorn"];
    NSInteger index;
    NSArray *conIndexs = @[@(22),@(20),@(19),@(21),@(20),@(21),@(22),@(23),@(23),@(23),@(24),@(23),@(22)];
    if ([[conIndexs objectAtIndex:monthIndex] integerValue] <= dayIndex + 1) {
        index = monthIndex;
    } else index = (monthIndex - 1 + 12) % 12;
    return [constellations objectAtIndex:index];
}

@end
