//
//  Appliance.m
//  Appliances
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Appliance.h"

@implementation Appliance

- (id)initWithProductName:(NSString *)pn
{
    self = [super init];
    
    if (!self) return self;
    
    [self setProductName:pn];
    [self setVoltage:120];
    
    return self;
}

- (id)init
{
    return [self initWithProductName:@"Unknown"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %d volts>", [self productName], [self voltage]];
}
@end
