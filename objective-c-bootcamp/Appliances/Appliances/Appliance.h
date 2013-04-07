//
//  Appliance.h
//  Appliances
//
//  Created by Shawn Ellis Wallace on 4/7/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appliance : NSObject {
//    NSString *productName;
//    int voltage;
}

@property (copy) NSString *productName;
@property int voltage;

// The designated initializer
- (id)initWithProductName:(NSString *)pn;

@end
