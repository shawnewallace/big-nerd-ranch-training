//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject<MKAnnotation>

// a new designated initializer for instances of BNRMapPoint
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

// this is a required property for MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// this is an optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@end
