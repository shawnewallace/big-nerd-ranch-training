//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RSSChannel;
@interface BNRFeedStore : NSObject

+ (BNRFeedStore *)sharedStore;

- (void)fetchTopSongs:(int)count
       withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

- (void)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (void)fetchRSSClassFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

@end
