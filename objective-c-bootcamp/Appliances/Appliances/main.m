//
//  main.m
//  Appliances
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliance.h"
#import "OwnedAppliance.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Appliance *a = [[Appliance alloc] init];
        NSLog(@"a is %@", a);
        [a setProductName:@"Washing Machine"];
        [a setVoltage:240];
        NSLog(@"a is %@", a);
        
        // custom by me
        OwnedAppliance *owned = [[OwnedAppliance alloc] initWithProductName:@"Dryer"
                                                             firstOwnerName:@"Shawn"];
        
        NSLog(@"a is %@", owned);
        
    }
    return 0;
}

