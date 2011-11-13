//
//  GraphView.m
//  MyGraph
//
//  Created by 山根 理恵 on 11/11/05.
//  Copyright (c) 2011年 Martian77. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

/*** data by hard coded ***/
//float data[] = {0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77};
float data[] = {0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77, 0.99, 0.55};
//float data[] = {135, 134, 142, 143, 139, 145, 139, 145, 139, 137, 136, 142, 152, 133};
/**************************/

CGRect touchAreas[kNumberOfBars];

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Draw line chart
- (void)drawLineGraphWithContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 2.0);
	CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    // Gradient
    
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = {0.0,1.0};
    CGFloat components[8] = {1.0,0.5,0.0,0.2,/* start color */1.0,0.5,0.0,1.0};/* end color */
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    CGPoint startPoint, endPoint;
    startPoint.x = kOffsetX;
    startPoint.y = kGraphHeight;
    endPoint.x = kOffsetX;
    endPoint.y = kOffsetY;
        
    // Drawing the solid fill
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:0.5] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight);
    CGContextAddLineToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);

    for (int i = 1; i < sizeof(data); i++) 
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);

    }
    CGContextAddLineToPoint(ctx, kOffsetX + (sizeof(data) - 1) * kStepX, kGraphHeight);
    CGContextClosePath(ctx);
    
//    CGContextDrawPath(ctx, kCGPathFill);
    CGContextSaveGState(ctx);
	CGContextClip(ctx);
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(ctx);
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    // Drawing the graph itself
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);
    for (int i = 1; i < sizeof(data); i++) 
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);
//                CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, data[i]);
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // Drawing circles
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    
    for (int i = 1; i < sizeof(data) - 1; i++) 
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * data[i];
//        float y = data[i];        
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
    NSLog(@"Touch x:%f, y:%f", point.x, point.y);
	
	for (int i = 0; i < kNumberOfBars; i++) 
    {
		if (CGRectContainsPoint(touchAreas[i], point)) 
        {
            NSLog(@"Tapped a bar with index %d, value %f", i, data[i]);
			break;
		}
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGFloat dash[] = {2.0,2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    // How many lines?(Vertical)
    int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    // Here the lines go
    for (int i = 0; i <= howMany; i++) {
        CGContextMoveToPoint(context, kOffsetX+i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX+i * kStepX, kGraphBottom);
    }
    
    // How many lines?(Horizontal)
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    // Here the lines go
    for (int i = 0; i <= howManyHorizontal; i++) {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i*kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i*kStepY);
    }
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
    
    [self drawLineGraphWithContext:context];
    
}


@end
