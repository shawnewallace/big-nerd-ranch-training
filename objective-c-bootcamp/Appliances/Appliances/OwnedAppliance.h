//
//  OwnedAppliance.h
//  Appliances
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Appliance.h"

@interface OwnedAppliance : Appliance {
    NSMutableSet *ownerNames;
}

// The designated initializer
- (id)initWithProductName:(NSString *)pn
           firstOwnerName:(NSString *)n;
- (void)addOwnerNamesObject:(NSString *)n;
- (void)revmoeOwnerNamesObject:(NSString *)n;

@end
