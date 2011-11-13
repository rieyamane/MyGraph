//
//  ViewController.h
//  MyGraph
//
//  Created by 山根 理恵 on 11/11/05.
//  Copyright (c) 2011年 Martian77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "PointerView.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet PointerView *pointerView;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@end
