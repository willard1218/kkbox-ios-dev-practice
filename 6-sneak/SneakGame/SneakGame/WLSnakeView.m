//
//  WLSnakeView.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnake.h"
#import "WLSnakeView.h"
@implementation WLSnakeView
static CGFloat width = 40;

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    WLSnake *snake = [self.delegate viewDidRequestSnake:self];
    NSMutableArray<WLPoint *> *points = snake.points;

    for (WLPoint *point in points) {
        CGContextAddRect(context,
                         CGRectMake(point.x * width + width + 5, point.y * width + width + 5, width - 5, width - 5));
    }

    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
}
@end
