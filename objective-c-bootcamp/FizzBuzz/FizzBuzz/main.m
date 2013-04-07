//
//  main.m
//  FizzBuzz
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FizzBuzzCalc.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        for (int i = 0; i <= 100; i++) {
            NSLog(@"out: %@", [FizzBuzzCalc Calculate:i]);
        }
        
    }
    return 0;
}

