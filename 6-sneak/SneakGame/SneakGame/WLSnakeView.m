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
static CGFloat kLengthOfCell = 40;
static CGFloat kBorderWidth = 5;
static CGFloat kLengthOfSquare;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kLengthOfSquare = kLengthOfCell - kBorderWidth;
        _numOfColumns = (self.frame.size.width ) / kLengthOfCell;
        _numOfRows = (self.frame.size.height ) / kLengthOfCell;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self removeSubviews];
    [self drawSnake];
    [self drawFruit];
}

- (void)removeSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)drawFruit {
    WLPoint *fruitPoint = [self.delegate viewDidRequestFruit:self];
    CGRect rect = [self getRectWithPoint:fruitPoint];
    UIImage *image = [UIImage imageNamed:@"fruit"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:rect];

    [self addSubview:imageView];
}

- (void)drawSnake {
    WLSnake *snake = [self.delegate viewDidRequestSnake:self];
    NSMutableArray<WLPoint *> *points = snake.points;

    for (WLPoint *point in points) {
        CGRect rect = [self getRectWithPoint:point];
        UIView *body = [[UIView alloc] initWithFrame:rect];
        body.layer.cornerRadius = 20;
        body.backgroundColor = [UIColor greenColor];
        [self addSubview:body];
    }
}

- (CGRect)getRectWithPoint:(WLPoint *)point {
    float startX = [self convertToPoint:point.x];
    float startY = [self convertToPoint:point.y];

    return CGRectMake(startX, startY, kLengthOfSquare, kLengthOfSquare);
}

- (float)convertToPoint:(NSInteger)num {
    return num * kLengthOfCell;
}

@end
