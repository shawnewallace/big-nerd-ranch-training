//
//  DetailViewController.h
//  Homepwner
//
//  Created by Shawn Ellis Wallace on 4/9/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController
    <UINavigationControllerDelegate,
     UIImagePickerControllerDelegate,
     UITextFieldDelegate>

@property (nonatomic, strong) BNRItem *item;

@end
