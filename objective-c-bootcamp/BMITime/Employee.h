//
//  Employee.h
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Person.h"
@class Asset;

@interface Employee : Person
{
    NSMutableSet *assets;
}

@property int employeeId;
- (void)addAssetsObject:(Asset *)a;
- (unsigned int) valueOfAssets;

@end
