//
//  Logger.h
//  Callbacks
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject {
    NSMutableData *incomingData;
}
- (void)sayOuch:(NSTimer *) t;
@end
