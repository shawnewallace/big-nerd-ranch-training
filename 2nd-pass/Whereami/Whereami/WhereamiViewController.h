//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/25/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController
    <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    
}
@end
