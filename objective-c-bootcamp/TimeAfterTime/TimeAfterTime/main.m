//
//  main.m
//  TimeAfterTime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *now = [[NSDate alloc] init];
        NSLog(@"The new date is  %@", now);
        
        double seconds = [now timeIntervalSince1970];
        NSLog(@"It has been %f seconds since the start of 1970.", seconds);
        
        NSDate *later = [now dateByAddingTimeInterval:100000];
        NSLog(@"In 100,000 seconds it will be %@", later);
        
        NSDateComponents *dateParams = [[NSDateComponents alloc] init];
        [dateParams setYear:1971];
        [dateParams setMonth:6];
        [dateParams setDay:16];
        [dateParams setHour:20];
        [dateParams setMinute:46];
        
        NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *myBirthDate = [g dateFromComponents:dateParams];
        
        double secondsSinceMyBirth = [[NSDate date] timeIntervalSinceDate:myBirthDate];
        NSLog(@"You were born %f seconds ago", secondsSinceMyBirth);
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSUInteger day = [cal ordinalityOfUnit:NSDayCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                       forDate:now];
        NSLog(@"This is day %lu of the month", day);
        
        bool is = [[NSTimeZone systemTimeZone] isDaylightSavingTime];
        NSLog(@"Is daylight savings time %i", is);
        
        
    }
    return 0;
}

