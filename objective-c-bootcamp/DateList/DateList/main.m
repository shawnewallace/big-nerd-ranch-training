//
//  main.m
//  DateList
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //create three NSDate objects
        NSDate *now = [NSDate date];
        NSDate *tomorrow = [now dateByAddingTimeInterval:24.0 * 60.0 * 60.0];
        NSDate *yesterday = [now dateByAddingTimeInterval:-24.0 * 60.0 * 60.0];
        
        //create an array containing all three (nil terminates the list)
        NSMutableArray *dateList = [NSMutableArray array];
        
        //Add dates to the array
        [dateList addObject:now];
        [dateList addObject:tomorrow];
        [dateList insertObject:yesterday
                       atIndex:0];
        
        for (NSDate *d in dateList){
            NSLog(@"\tHere is a date: %@", d);
        }
        
        //remove yesterday
        [dateList removeObjectAtIndex:0];
        NSLog(@"Now the first date is %@", [dateList objectAtIndex:0]);
        
    }
    return 0;
}

