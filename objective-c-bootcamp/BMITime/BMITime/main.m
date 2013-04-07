//
//  main.m
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"
#import "Asset.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        //create an array of employee objects
        NSMutableArray *employees = [[NSMutableArray alloc] init];
        
        //create a dictionary of executives
        NSMutableDictionary *executives = [[NSMutableDictionary alloc] init];
        
        for(int i = 0; i < 10; i++) {
            Employee *person = [[Employee alloc] init];
            
            [person setWeightInKilos:90 + i];
            [person setHeightInMeters:1.8 - i/10.0];
            [person setEmployeeId:i];
            
            [employees addObject:person];
            
            //is this the first employee?
            if (i == 0) {
                [executives setObject:person forKey:@"CEO"];
            }
            
            //is this the 2nd employee?
            if (i == 1) {
                [executives setObject:person forKey:@"CTO"];
            }
        }
        
        NSMutableArray *allAssets = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < 10; i++) {
            Asset *asset = [[Asset alloc] init];
            NSString *currentLabel = [NSString stringWithFormat:@"Laptop %d", i];
            [asset setLabel:currentLabel];
            [asset setResaleValue:i * 17];
            
            //get a random number between 0 and 9 inclusive
            NSUInteger randomIndex = random() % [employees count];
            
            Employee *randomEmployee = [employees objectAtIndex:randomIndex];
            
            [randomEmployee addAssetsObject:asset];
            [allAssets addObject:asset];
        }
        
        NSSortDescriptor *voa = [NSSortDescriptor sortDescriptorWithKey:@"valueOfAssets"
                                                              ascending:YES];
        NSSortDescriptor *ei = [NSSortDescriptor sortDescriptorWithKey:@"employeeId"
                                                             ascending:YES];
        
        [employees sortUsingDescriptors:[NSArray arrayWithObjects:voa, ei, nil]];
        
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of one employee");
        [employees removeObjectAtIndex:5];
        
        NSLog(@"allAssets: %@", allAssets);
        
        NSLog(@"executives: %@", executives);
        executives = nil;
        
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"holder.valueOfAssets > 70"];
        //        NSArray *toBeReclaimed = [allAssets filteredArrayUsingPredicate:predicate];
        //        NSLog(@"toBeReclained: %@", toBeReclaimed);
        //        toBeReclaimed = nil;
        
        NSLog(@"Giving up ownership of array");
        allAssets = nil;
        employees = nil;
        
    }
    return 0;
}

