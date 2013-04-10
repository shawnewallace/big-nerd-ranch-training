//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Shawn Ellis Wallace on 4/10/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    [self setView:[[BNRDrawView alloc] initWithFrame:CGRectZero]];
}

@end
