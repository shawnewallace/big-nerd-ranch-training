//
//  BNRLine.m
//  TouchTracker
//
//  Created by Shawn Ellis Wallace on 4/10/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Start: %f, %f End: %f, %f",
            _begin.x,
            _begin.y,
            _end.x,
            _end.y];
}

@end
