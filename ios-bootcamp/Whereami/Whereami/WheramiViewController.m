//
//  WheramiViewController.m
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "WheramiViewController.h"
#import "BNRMapPoint.h"

@interface WheramiViewController () {
    CLLocationManager *_locationManager;
}

@property (nonatomic, strong) IBOutlet MKMapView *worldView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UITextField *locationTitleField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *mapSelector;

- (void)findLocation;
- (void)foundLocation:(CLLocation *)loc;

@end

@implementation WheramiViewController

- (void)findLocation
{
    [_locationManager startUpdatingLocation];
    [[self activityIndicator] startAnimating];
    [[self locationTitleField] setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    // create an instance of BNRMapPoint with current data
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord
                                                        title:[_locationTitleField text]];
    
    // add it to the map view
    [[self worldView] addAnnotation:mp];
    
    // zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [[self worldView] setRegion:region animated:YES];
    
    // reset the UI
    [[self locationTitleField] setText:@""];
    [[self activityIndicator] stopAnimating];
    [[self locationTitleField] setHidden:NO];
    [_locationManager stopUpdatingLocation];
}

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
    
    // how many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    // CLLocationManagers will return the last found location of the
    // device first, you do't want that data in thsi case.
    // if this location was made more than 3 minutes ago, ignore it.
    if (t < -180) {
        // this is cached data, you don't want it, keep looking
        return;
    }
    
    [self foundLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

-(void)mapView:(MKMapView *)mapView
    didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc,
                                                                   250,
                                                                   250);
    [[self worldView] setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)viewDidLoad
{
    [[self worldView] setShowsUserLocation:YES];
}

- (void)dealloc
{
    // tell the location manager to stop sending us messages
    [_locationManager setDelegate:nil];
}

@end
