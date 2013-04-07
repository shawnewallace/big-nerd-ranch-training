//
//  FizzBuzzCalc.m
//  FizzBuzz
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "FizzBuzzCalc.h"

@implementation FizzBuzzCalc

+ (NSString *)Calculate:(long)i
{
    if (i % 5 == 0 && i % 3 == 0) return @"FizzBuzz";
    if (i % 5 == 0) return @"Buzz";
    if (i % 3 == 0) return @"Fizz";
    
    return [[NSString alloc] initWithFormat:@"%lu", i];
}

@end
