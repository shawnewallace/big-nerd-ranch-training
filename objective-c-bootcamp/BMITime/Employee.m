//
//  Employee.m
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Employee.h"
#import "Asset.h"

@implementation Employee

@synthesize employeeId;

- (void)addAssetsObject:(Asset *)a
{
    if (!assets) {
        assets = [[NSMutableSet alloc] init];
    }
    
    [assets addObject:a];
}

- (unsigned int)valueOfAssets
{
    unsigned int sum = 0;
    for(Asset *a in assets)
    {
        sum += [a resaleValue];
    }
    return sum;
}

- (float)bodyMassIndex
{
    float normalBMI = [super bodyMassIndex];
    return normalBMI * 0.9;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Employee %d: $%d in assets>",
            [self employeeId],
            [self valueOfAssets]];
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
