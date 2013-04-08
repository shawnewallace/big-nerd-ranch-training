//
//  AwesomeMap.m
//  HypnoTime
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "AwesomeMap.h"

@interface AwesomeMap()

@end

@implementation AwesomeMap

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (!self) return self;
    
    // get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    // give it a label
    [tbi setTitle:@"Map"];
    
    return self;
}


@end
