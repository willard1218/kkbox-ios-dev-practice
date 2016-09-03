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
        _numOfRows = self.frame.size.height / kLengthOfCell;
        _numOfColumns = self.frame.size.width / kLengthOfCell;
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
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
}

- (void)drawSnake {
    WLSnake *snake = [self.delegate viewDidRequestSnake:self];
    NSMutableArray<WLPoint *> *points = snake.points;

    for (WLPoint *point in points) {
        CGRect rect = [self getRectWithPoint:point];
        UIView *body = [[UIView alloc] initWithFrame:rect];

        body.backgroundColor = [UIColor greenColor];
        [self addSubview:body];
    }
}

- (void)drawGameOver {
    UIImage *image = [UIImage imageNamed:@"Game_Over"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(100 , 100, 50, 50)];
    // [self removeSubviews];
    [self addSubview:imageView];
}

- (CGRect)getRectWithPoint:(WLPoint *)point {
    float startX = [self convertToPoint:point.x];
    float startY = [self convertToPoint:point.y];

    return CGRectMake(startX, startY, kLengthOfSquare, kLengthOfSquare);
}

- (float)convertToPoint:(NSInteger)num {
    return num * kLengthOfCell + kLengthOfCell + kBorderWidth;
}

@end
