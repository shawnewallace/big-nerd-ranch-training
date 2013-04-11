//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "TimeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TimeViewController()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *theButton;

- (IBAction)showCurrentTime:(id)sender;
- (void)spinTimeLabel;
- (void)bounceTimeLabel;

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
    
    [self bounceTimeLabel];
}

- (void)bounceTimeLabel
{
    // Create a key frame animation
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    // Create the values it will pass through
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1);
    CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
    [bounce setValues:@[
                         [NSValue valueWithCATransform3D:CATransform3DIdentity],
                         [NSValue valueWithCATransform3D:forward],
                         [NSValue valueWithCATransform3D:back],
                         [NSValue valueWithCATransform3D:forward2],
                         [NSValue valueWithCATransform3D:back2],
                         [NSValue valueWithCATransform3D:CATransform3DIdentity],
                         ]];
    
    // Set the duration
    //[bounce setDuration:0.6];
    
    CABasicAnimation *fader = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //[fader setDuration:0.6];
    [fader setFromValue:@(1.0)];
    [fader setToValue:@(1.0)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:0.6];
    [group setAnimations:@[bounce, fader]];
    
    // Animate the layer
    [[[self timeLabel] layer] addAnimation:group forKey:@"bounceAnimation"];
}

- (void)spinTimeLabel
{
    // Create a basic animation
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    [spin setDelegate:self];
    
    // fromValue is implied
    [spin setToValue:@(M_PI * 2.0)];
    [spin setDuration:1.0];
    
    // Set the timing function
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [spin setTimingFunction:tf];
    
    // Kick off the animation by adding it to the layer
    [[[self timeLabel] layer] addAnimation:spin forKey:@"spinAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@ finished: %d", anim, flag);
}

- (void) viewDidLoad
{
    // always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"TimeViewController loaded its view.");
    NSLog(@"timeLabel = %@",[self timeLabel]);
    
    // make button come in from right
    CABasicAnimation *mover = [CABasicAnimation animationWithKeyPath:@"position"];
    [mover setDuration:1.0];
        UIButton *b = [self theButton];
    [mover setFromValue:[NSValue valueWithCGPoint:CGPointMake(0.0, b.frame.origin.y)]];
    
    // Set the timing function
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [mover setTimingFunction:tf];
    
    [[[self theButton] layer] addAnimation:mover forKey:@"moveButtonIn"];
}

@end
