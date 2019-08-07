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

- (BOOL)ync_isLeapYear {
    return [NSDate ync_isLeapYear:self];
}

+ (BOOL)ync_isLeapYear:(NSDate *)date {
    NSUInteger year = [date ync_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSInteger)ync_daysInMonth:(NSUInteger)month {
    return [NSDate ync_daysInMonth:self month:month];
}

+ (NSUInteger)ync_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date ync_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSInteger)ync_weekday {
    return [NSDate ync_weekday:self];
}

+ (NSInteger)ync_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)ync_monthWithMonthNumber {
    return [NSDate ync_monthWithMonthNumber:self.ync_month];
}

+ (NSString *)ync_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

- (NSString *)ync_dayFromWeekday {
    return [NSDate ync_dayFromWeekday:self];
}

+ (NSString *)ync_dayFromWeekday:(NSDate *)date {
    switch([date ync_weekday]) {
        case 1:
            return @"Sunday";
            break;
        case 2:
            return @"Monday";
            break;
        case 3:
            return @"Tuesday";
            break;
        case 4:
            return @"Wednesday";
            break;
        case 5:
            return @"Thursday";
            break;
        case 6:
            return @"Friday";
            break;
        case 7:
            return @"Saturday";
            break;
        default:
            break;
    }
    return @"";
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

#pragma mark - Jan 1st. 1970

- (NSString *)ync_getMonDayYear {
    
    return [NSDate ync_getMonDayYearWith:self];
}

+ (NSString *)ync_getMonDayYearWith:(NSDate *)date {
    
    NSString *monthStr = [NSDate ync_monthWithMonthNumber:[date ync_month]];
    if (monthStr.length > 3) {
        monthStr = [monthStr substringToIndex:3];
    }
    NSInteger day = [date ync_day];
    NSString *dayStr = @"";
    if (day == 1) {
        dayStr = @"1st";
    } else if (day == 2) {
        dayStr = @"2nd";
    } else if (day == 3) {
        dayStr = @"3rd";
    } else {
        dayStr = [NSString stringWithFormat:@"%ldth", (long)day];
    }
    NSString *yearStr = @([date ync_year]).stringValue;
    return [NSString stringWithFormat:@"%@. %@ %@", monthStr, dayStr, yearStr];
}

@end
