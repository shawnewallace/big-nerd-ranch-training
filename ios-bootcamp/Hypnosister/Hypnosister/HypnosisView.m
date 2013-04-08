//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) return self;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setCircleColor:[UIColor lightGrayColor]];
    
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGRect bounds = [self bounds];
    
    // figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height /2.0;
    
    // the radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
        
    }
    
    // configure line width to 10 points
    [path setLineWidth:10];
    
    // configure the drawing color to gray
    [[self circleColor] setStroke];
    
    // draw the line
    [path stroke];
    
    // create a string
    NSString *text = @"You are getting sleepy.";
    CGRect textRect;
    
    // get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    // create the attributed string
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    // figure our the range of the whole string
    NSRange range = NSMakeRange(0, [attrString length]);
    
    //set the drawing font for the whole string to font
    [attrString addAttribute:NSFontAttributeName
                       value:font
                       range:range];
    
    // create a shadow object
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(4, 3)];
    [shadow setShadowColor:[UIColor darkGrayColor]];
    
    // set the shadow for the whole string
    [attrString addAttribute:NSShadowAttributeName
                       value:shadow
                       range:range];
    
    for(int i = 0; i < [attrString length]; i ++) {
        if (i % 2 == 0) {
            // make even index characters light gray
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor lightGrayColor]
                               range:NSMakeRange(i, 1)];
        } else {
            // make odd index characters black
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor blackColor]
                               range:NSMakeRange(i, 1)];
        }
    }
    
    
    // determine the size of this strong
    textRect.size = [attrString size];
    
    // let's put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    // draw the attributed string
    [attrString drawInRect:textRect];
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"Device started shaking!");
    [self setCircleColor:[UIColor redColor]];
}

@end
