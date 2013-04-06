//
//  main.m
//  ComputerName
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *computerName = [[[NSHost alloc] init] localizedName];
        
        NSLog(@"Computer Name: %@", computerName);
        
    }
    return 0;
}

