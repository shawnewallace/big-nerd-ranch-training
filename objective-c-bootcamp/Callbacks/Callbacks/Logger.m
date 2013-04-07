//
//  Logger.m
//  Callbacks
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Logger.h"

@implementation Logger

- (void)sayOuch:(NSTimer *)t
{
    NSLog(@"Ouch!");
}

// called each time a chunk of data arrives
- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"received %lu byes", [data length]);
    
    // create mutable data if it doesn't already exist
    if(!incomingData) {
        incomingData = [[NSMutableData alloc] init];
    }
    
    [incomingData appendData:data];
}

// called when last chuck of data has been processed
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Got it all!");
    NSString *string = [[NSString alloc] initWithData:incomingData
                                             encoding:NSUTF8StringEncoding];
    
    incomingData = nil;
    NSLog(@"string has %lu characters", [string length]);
    
    // uncomment the next line to see the entire fetched file
    //NSLog(@"The whole string is %@", string);
}

// called if the fetch failes
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"connection failed: %@", [error localizedDescription]);
    incomingData = nil;
}

- (void)zoneChange:(NSNotification *)note
{
    NSLog(@"The system time zone has changed!");
}

@end
