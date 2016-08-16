//
//  WLSnakeView.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnakeView.h"

@implementation WLSnakeView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *blackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, blackColor.CGColor);

    CGContextFillRect(context, rect);
}
@end
