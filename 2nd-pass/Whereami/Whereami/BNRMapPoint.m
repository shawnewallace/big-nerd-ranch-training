//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/29/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32)
                              title:@"Hometown"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (!self) return self;
    
    _coordinate = c;
    [self setTitle:t];
    
    return self;
}

@end
