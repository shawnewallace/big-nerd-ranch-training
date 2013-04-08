//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (!self) return self;
    
    // get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    // give it a label
    [tbi setTitle:@"Hypnosis"];
    
    // create a UIImage from a file
    // this will use Hypno@2x.png on reticna display devices
    UIImage *i = [UIImage imageNamed:@"Hypno.png"];
    
    // put that image on the tab bar item
    [tbi setImage:i];
    
    return self;
}

- (void)loadView
{
    // create a view
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView *v = [[HypnosisView alloc] initWithFrame:frame];
    
    // set it as *the* view of this controller
    [self setView:v];
}

- (void) viewDidLoad
{
    // always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"HypnosisViewController loaded its view.");
}

@end
