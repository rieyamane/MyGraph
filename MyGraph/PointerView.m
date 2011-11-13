//
//  PointerView.m
//  MyGraph
//
//  Created by 山根 理恵 on 11/11/13.
//  Copyright (c) 2011年 Martian77. All rights reserved.
//

#import "PointerView.h"



@implementation PointerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// handling touches:

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    pointerX = point.x;
    drawPointer = YES;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    if (drawPointer) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect frame = self.frame;
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context,  [[UIColor colorWithRed:0.4 green:0.8 blue:0.4 alpha:1.0] CGColor]);
        CGContextMoveToPoint(context, pointerX, 0);
        CGContextAddLineToPoint(context, pointerX, frame.size.height);
        CGContextStrokePath(context);
    }
}


@end
