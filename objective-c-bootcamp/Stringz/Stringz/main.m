//
//  main.m
//  Stringz
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableString *str = [[NSMutableString alloc] init];
        for (int i = 0; i < 10; i++) {
            [str appendString:@"Shawn is cool!\n"];
        }
        
        // declare a pointer to an NSError object, but don't instantiate it.
        // the NSError instance will only be created if there is, in fact,
        // an error.
        NSError *error = nil;
        
        // pass the NSError point by reference tothe NSString method
        BOOL success = [str writeToFile:@"/tmp/cool.txt"
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&error];
        
        // test the returned BOOL, and wuery the NSError if the write failed
        if (success) {
            NSLog(@"done writing /tmp/cool.txt");
        } else {
            NSLog(@"writing /tmp/cool.txt failed: %@", [error localizedDescription]);
        }
        error = nil;
        
        NSString *strRead = [[NSString alloc]
                             initWithContentsOfFile:@"/etc/resolv.conf"
                             encoding:NSASCIIStringEncoding
                             error:&error];
        
        if (!strRead) {
            NSLog(@"read failed:  %@", [error localizedDescription]);
        } else {
            NSLog(@"resolv.conf looks like this: %@", strRead);
        }
        
        
    }
    return 0;
}

