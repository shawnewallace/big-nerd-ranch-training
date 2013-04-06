//
//  main.m
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *person = [[Person alloc] init];
        
        [person setWeightInKilos:96];
        [person setHeightInMeters:1.8];
        
        float bmi = [person bodyMassIndex];
        NSLog(@"person (%d, %f) has a BMI of %f",
              [person weightInKilos],
              [person heightInMeters],
              bmi);
        
    }
    return 0;
}

