//
//  ListViewController.m
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"
#import "ChannelViewController.h"
#import "BNRFeedStore.h"

@implementation ListViewController

@synthesize webViewController;

- (void)showInfo:(id)sender
{
    ChannelViewController *channelViewController = [[ChannelViewController alloc] initWithStyle:UITableViewStyleGrouped];

    if ([self splitViewController]) {
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:channelViewController];
        [[self splitViewController] setViewControllers:@[[self navigationController], nvc]];
        [[self splitViewController] setDelegate:channelViewController];
        NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
        if (selectedRow)
            [[self tableView] deselectRowAtIndexPath:selectedRow animated:YES];
    } else {
        [[self navigationController] pushViewController:channelViewController
                                               animated:YES];
    }
    
    NSLog(@"==>  Channel Title: '%@'", [channel title]);
    
    [channelViewController listViewController:self handleObject:channel];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (!self) return self;
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Info"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(showInfo:)];
    [[self navigationItem] setRightBarButtonItem:bbi];
    
    UISegmentedControl *rssTypeControl = [[UISegmentedControl alloc] initWithItems:@[@"BNR", @"Apple"]];
    [rssTypeControl setSelectedSegmentIndex:0];
    [rssTypeControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [rssTypeControl addTarget:self
                       action:@selector(changeType:)
             forControlEvents:UIControlEventValueChanged];
    [[self navigationItem] setTitleView:rssTypeControl];
    
    [self fetchEntries];
 
    return self;
}

- (void)changeType:(id)sender
{
    rssType = [sender selectedSegmentIndex];
    [self fetchEntries];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) return YES;
    
    return io == UIInterfaceOrientationPortrait;
}

- (void)fetchEntries
{
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    void (^completionBlock)(RSSChannel *obj, NSError *err) =
     ^(RSSChannel *obj, NSError *err) {
         NSLog(@"Completion block called!");
         
         [[self navigationItem] setTitleView:currentTitleView];
         
         if(!err) {
             channel = obj;
             [[self tableView] reloadData];
         } else {
            NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                                     [err localizedDescription]];
             
             UIAlertView *av = [[UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:errorString
                                delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
             [av show];
         }
     };
    
    if (rssType == ListViewControllerRSSTypeBNR) {
        channel = [[BNRFeedStore sharedStore] fetchRSSFeedWithCompletion:
                   ^(RSSChannel *obj, NSError *err) {
                       [[self navigationItem] setTitleView:currentTitleView];
                       if (!err) {
                           int currentItemCount = [[channel items] count];
                           channel = obj;
                           
                           int newItemCount = [[channel items] count];
                           
                           int itemDelta = newItemCount - currentItemCount;
                           if (itemDelta > 0) {
                               NSMutableArray *rows = [NSMutableArray array];
                               for(int i = 0; i < itemDelta; i++) {
                                   NSIndexPath *ip = [NSIndexPath indexPathForRow:i
                                                                        inSection:0];
                                   [rows addObject:ip];
                               }
                               
                               [[self tableView] insertRowsAtIndexPaths:rows
                                                       withRowAnimation:UITableViewRowAnimationTop];
                           }
                       }
                   }];
        
        [[self tableView] reloadData];
    }
    else if (rssType == ListViewControllerRSSTypeApple)
        [[BNRFeedStore sharedStore] fetchTopSongs:10 withCompletion:completionBlock];
    
    NSLog(@"Executing code at the end of fetchEntries");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    
    RSSItem *item = [channel items][[indexPath row]];
    [[cell textLabel] setText:[item title]];
    
    if([[BNRFeedStore sharedStore] hasItemBeenRead:item]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self splitViewController])
        [[self navigationController] pushViewController:webViewController animated:YES];
    else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webViewController];
        
        [[self splitViewController] setViewControllers:@[[self navigationController], nav]];
        [[self splitViewController] setDelegate:webViewController];
    }
    
    RSSItem *entry = [channel items][[indexPath row]];
    
    [[BNRFeedStore sharedStore] markItemAsread:entry];
    
    [[[self tableView] cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    [webViewController listViewController:self handleObject:entry];
}

@end
