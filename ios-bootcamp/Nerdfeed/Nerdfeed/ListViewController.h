//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

// a forward declaration; we'll import the header in .m
@class RSSChannel;
@class WebViewController;

typedef enum {
    ListViewControllerRSSTypeBNR,
    LIstViewControllerRSSTYpeBNRSchedule,
    ListViewControllerRSSTypeApple
} ListViewControllerRSSType;

@interface ListViewController : UITableViewController
{
    RSSChannel *channel;
    ListViewControllerRSSType rssType;
}

@property (nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;

@end

@protocol ListViewControllerDelegate

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;

@end
