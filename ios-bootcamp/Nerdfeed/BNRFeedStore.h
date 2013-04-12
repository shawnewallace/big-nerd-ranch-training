//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSSChannel;
@class RSSItem;

@interface BNRFeedStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (BNRFeedStore *)sharedStore;

@property (nonatomic, strong) NSDate *topSongsCacheDate;

- (void)fetchTopSongs:(int)count
       withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (void)markItemAsread:(RSSItem *)item;
- (BOOL)hasItemBeenRead:(RSSItem *)item;

@end
