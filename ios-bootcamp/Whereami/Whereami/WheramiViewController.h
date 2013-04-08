//
//  WheramiViewController.h
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WheramiViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
}

@end
