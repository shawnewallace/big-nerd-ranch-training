//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Joe Conway on 10/25/12.
//  Copyright (c) 2012 Big Nerd Ranch. All rights reserved.
//

#import "HypnosisView.h"
#import <QuartzCore/QuartzCore.h>

@interface HypnosisView ()
{
    CALayer *_boxLayer;
}
@end

@implementation HypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All HypnosisViews start with a clear background color
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
        
        // Create the new layer object
        _boxLayer = [[CALayer alloc] init];
        // Give it a size
        [_boxLayer setBounds:CGRectMake(0.0, 0.0, 85.0, 85.0)];
        // Give it a location
        [_boxLayer setPosition:CGPointMake(160.0, 100.0)];
        // Make half-transparent red the background color for the layer
        UIColor *reddish = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        // Get a CGColor object with the same color values
        CGColorRef cgReddish = [reddish CGColor];
        [_boxLayer setBackgroundColor:cgReddish];
        
        // Create a UIImage
        UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];
        // Get the underlying CGImage
        CGImageRef image = [layerImage CGImage];
        // Put the CGImage on the layer
        [_boxLayer setContents:(__bridge id)image];
        // Inset the image a bit on each side
        [_boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];
        // Let the image resize (without changing the aspect ratio)
        // to fill the contentRect
        [_boxLayer setContentsGravity:kCAGravityResizeAspect];
        
        // Make it a sublayer of the view's layer
        [[self layer] addSublayer:_boxLayer];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    [_boxLayer setPosition:p];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [_boxLayer setPosition:p];
    [CATransaction commit];
}

- (void)setCircleColor:(UIColor *)clr
{
    _circleColor = clr;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGRect bounds = [self bounds];
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    // The radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    UIBezierPath *path = [[UIBezierPath alloc] init];
    // Add an arc to the path at center, with radius of maxRadius,
    // from 0 to 2*PI radians (a circle)
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius // note this is currentRadius!
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
 
         // Configure line width to 10 points
    [path setLineWidth:10];
    // Configure the drawing color to gray
    [[self circleColor] set];
    // Draw the line!
    [path stroke];
    
    // Create a string
    NSString *text = @"You are getting sleepy.";
    CGRect textRect;
    
    // Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
// Create the attributed string
    NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:text];
    // Figure out the range of the whole string
    NSRange range = NSMakeRange(0, [attrString length]);
    // Set the drawing font for the whole string to font
    [attrString addAttribute:NSFontAttributeName value:font range:range];
    // Create a shadow object
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(4, 3)];
    [shadow setShadowColor:[UIColor darkGrayColor]];
    // Set the shadow for the whole string
    [attrString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    for(int i = 0; i < [attrString length]; i++) {
        if(i % 2 == 0) {
            // Make even index characters light gray
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor lightGrayColor]
                               range:NSMakeRange(i, 1)];
        } else {
            // Make odd index characters black
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor blackColor]
                               range:NSMakeRange(i, 1)];
        }
    }

    // Determine the size of this strong
    textRect.size = [attrString size];

    // Let's put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;

    // Draw the ATTRIBUTED string
    [attrString drawInRect:textRect];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake) {
        NSLog(@"Device started shaking!");
        [self setCircleColor:[UIColor redColor]];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
