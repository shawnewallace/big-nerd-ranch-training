//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

- (IBAction)showCurrentTime:(id)sender;

@end

@implementation TimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (!self) return self;
    
    // get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    // give it a label
    [tbi setTitle:@"Time"];
    
    // create a UIImage from a file
    // this will use Hypno@2x.png on reticna display devices
    UIImage *i = [UIImage imageNamed:@"Time.png"];
    
    // put that image on the tab bar item
    [tbi setImage:i];
    
    return self;
}

- (IBAction)showCurrentTime:(id)sender
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    [[self timeLabel] setText:[formatter stringFromDate:now]];
}

- (void) viewDidLoad
{
    // always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"TimeViewController loaded its view.");
    
    NSLog(@"timeLabel = %@",[self timeLabel]);
    
    [[self timeLabel] setBackgroundColor:[UIColor redColor]];
}

@end
