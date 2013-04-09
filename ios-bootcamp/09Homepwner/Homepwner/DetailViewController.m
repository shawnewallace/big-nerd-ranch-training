//
//  DetailViewController.m
//  Homepwner
//
//  Created by Shawn Ellis Wallace on 4/9/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)deletePicture:(id)sender;

@end

@implementation DetailViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // if our device has a camera, we want to take a picture, otherwise,
    // we just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // warning generated, ignore for now
    [imagePicker setDelegate:self];
    
    [imagePicker setAllowsEditing:YES];
    
    [self presentViewController:imagePicker
                       animated:YES
                     completion:nil];
}

- (IBAction)deletePicture:(id)sender {
    NSString *key = [[self item] imageKey];
    if (!key) return;
    
    [[self imageView] setImage:nil];
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [[self item] setImageKey:Nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [[self item] imageKey];
    
    // did the item already have an image?
    if (oldKey) [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    
    // get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (editedImage) image = editedImage;
    
    // create a nsuuid object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    
    [[self item] setImageKey:key];
    
    // store the image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:[[self item] imageKey]];
    
    // put that image onto the screen in our image view
    [[self imageView] setImage:image];
    
    // take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    [[self navigationItem] setTitle:[[self item] itemName]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRItem *item = [self item];
    
    [[self nameField] setText:[item itemName]];
    [[self serialNumberField] setText:[item serialNumber]];
    [[self valueField] setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    
    // create an NSDateFormatter that will turn a datea into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // use filtered NSDate object to set dateLabel contents
    [[self dateLabel] setText:[dateFormatter stringFromDate:[item dateCreated]]];
    
    NSString *imageKey = [[self item] imageKey];
    
    if (imageKey) {
        // get image for image key for image store
        UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
        
        // use that image to put on the screen in imageView
        [[self imageView] setImage:imageToDisplay];
    } else {
        // clear the imageView
        [[self imageView] setImage:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // clear the first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = [self item];
    [item setItemName:[[self nameField] text]];
    [item setSerialNumber:[[self serialNumberField] text]];
    [item setValueInDollars:[[[self valueField] text] intValue]];
    
}
@end
