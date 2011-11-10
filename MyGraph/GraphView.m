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
/**************************/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Draw line chart(本命)
- (void)drawLineGraphWithContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    int maxGraphHeight = kGraphHeight - kOffsetY;
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);
    for (int i = 1; i < sizeof(data); i++)
    {
            CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Ellipse
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    for (int i = 1; i < sizeof(data) - 1; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * data[i];
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

// Draw bar chart
- (void)drawBar:(CGRect)rect context:(CGContextRef)ctx {
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Draw the background image
//    UIImage *image = [UIImage imageNamed:@"background.png"];
//    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
//    CGContextDrawImage(context, imageRect, image.CGImage);
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
    // Draw the bars
//    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    for (int i = 0; i < sizeof(data); i++) {
//        float barX = kOffsetX + kStepX + i * kStepX - kBarWidth / 2;
//        float barY = kBarTop + maxBarHeight - maxBarHeight * data[i];
//        float barHeight = maxBarHeight * data[i];
//        CGRect barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
//        [self drawBar:barRect context:context];
        [self drawLineGraphWithContext:context];
        
    }
    
}


@end
