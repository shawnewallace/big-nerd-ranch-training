//
//  main.m
//  BMITime
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Employee *person = [[Employee alloc] init];
        
        [person setWeightInKilos:96];
        [person setHeightInMeters:1.8];
        [person setEmployeeId:15];
        
        float bmi = [person bodyMassIndex];
        NSLog(@"person %d has a BMI of %f",
              [person employeeId],
              bmi);
        
    }
    return 0;
}

