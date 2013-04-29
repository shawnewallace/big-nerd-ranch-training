//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/25/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

@interface WhereamiViewController ()
{
    CLLocationManager *_locationManager;
}

@property (nonatomic, strong) IBOutlet MKMapView *worldView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UITextField *locationTitleField;
@property (weak, nonatomic)   IBOutlet UISegmentedControl *selector;

- (void)findLocation;
- (void)foundLocation:(CLLocation *)loc;
@end

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if(!self) return self;
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDistanceFilter:50];
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"%@", newLocation);
    
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    if (t < -180) {
        return;
    }
    
    [self foundLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Heading Changed: %@", newHeading);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
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
    [[self worldView] setMapType:MKMapTypeSatellite];
    
    [_selector addTarget:self
                  action:@selector(selectMap:)
       forControlEvents:UIControlEventValueChanged];
}

- (void) selectMap:(id)sender{
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    int selectedIndex = [segmentedControl selectedSegmentIndex];
    
    switch (selectedIndex) {
        case 0:
            [[self worldView] setMapType:MKMapTypeStandard];
            break;
        case 1:
            [[self worldView] setMapType:MKMapTypeHybrid];
            break;
        default:
            [[self worldView] setMapType:MKMapTypeSatellite];
            break;
    }
}

- (void)dealloc
{
    [_locationManager setDelegate:nil];
}

- (void)findLocation
{
    [_locationManager startUpdatingLocation];
    [[self activityIndicator] startAnimating];
    [[self locationTitleField] setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord
                                                         title:[_locationTitleField text]];
    [[self worldView] addAnnotation:mp];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [[self worldView] setRegion:region animated:YES];
    
    [[self locationTitleField] setText:@""];
    [[self activityIndicator] stopAnimating];
    [[self locationTitleField] setHidden:NO];
    [_locationManager stopUpdatingLocation];
}

@end