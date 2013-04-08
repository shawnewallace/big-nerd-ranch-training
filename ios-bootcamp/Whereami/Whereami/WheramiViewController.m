//
//  WheramiViewController.m
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "WheramiViewController.h"

@interface WheramiViewController ()

@end

@implementation WheramiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!self) return self;
    
    // create the location manager object
    _locationManager = [[CLLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    
    // and we want it to be as accurate as possible
    // regardless of how much power it takes
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // bronze challenge: distance filter
    [_locationManager setDistanceFilter:50.0];
    
    // tell our manager to start looking for its location immediately
    [_locationManager startUpdatingLocation];
    
    return self;
}

// silver challange: heading
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Heading Updated: %@", newHeading);
}
// end silver challenge

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager
    didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)dealloc
{
    // tell the location manager to stop sending us messages
    [_locationManager setDelegate:nil];
}

@end
