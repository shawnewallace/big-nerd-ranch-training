//
//  Asset.m
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Asset.h"

@implementation Asset

@synthesize label;
@synthesize resaleValue;

- (NSString *) description
{
    return [NSString stringWithFormat:@"<%@: $%d >",
            [self label],
            [self resaleValue]];
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
