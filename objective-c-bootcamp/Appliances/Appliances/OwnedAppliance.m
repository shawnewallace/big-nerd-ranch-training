//
//  OwnedAppliance.m
//  Appliances
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "OwnedAppliance.h"

@implementation OwnedAppliance

- (id)initWithProductName:(NSString *)pn
{
    return [self initWithProductName:pn firstOwnerName:nil];
}

- (id)initWithProductName:(NSString *)pn
           firstOwnerName:(NSString *)n
{
    self = [super initWithProductName:pn];
    
    if (!self) return self;
    
    ownerNames = [[NSMutableSet alloc] init];
    
    if (n){
        [ownerNames addObject:n];
    }
    
    return self;
}

- (void)addOwnerNamesObject:(NSString *)n
{
    [ownerNames addObject:n];
}

- (void)revmoeOwnerNamesObject:(NSString *)n
{
    [ownerNames removeObject:n];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %d volts, %@>", [self productName], [self voltage], ownerNames];
}

@end
