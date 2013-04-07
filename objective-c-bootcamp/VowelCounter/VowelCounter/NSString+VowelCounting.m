//
//  NSString+VowelCounting.m
//  VowelCounter
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "NSString+VowelCounting.h"

@implementation NSString (VowelCounting)

- (int)vowelCount
{
    NSCharacterSet *charSet = [NSCharacterSet
                               characterSetWithCharactersInString:@"aeiouyAEIOUY"];
    
    NSUInteger count = [self length];
    int sum = 0;
    for (int i = 0; i < count; i++)
    {
        unichar c = [self characterAtIndex:i];
        if([charSet characterIsMember:c]) {
            sum++;
        }
    }
    
    return sum;
}

@end
