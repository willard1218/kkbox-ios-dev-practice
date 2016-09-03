//
//  ViewController.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnakeView.h"
#import "WLViewController.h"

@interface WLViewController () <WLSnakeViewDelegate>
@property(nonatomic, strong) NSTimer *drawTimer;
@property(nonatomic) NSTimeInterval drawTimeInterval;
@end

@implementation WLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSwipeRecognizer];
    [self initSnake];
    [self initSnakeView];
    [self rearrangeFruit];

    _drawTimeInterval = 1;
    [self setTimer:_drawTimeInterval];
}

- (void)initSnake {
    _snake = [[WLSnake alloc] init];
    _snake.direction = WLMoveDirectionRight;
    WLPoint *center = [[WLPoint alloc] initWithX:0 y:1];
    WLPoint *center2 = [[WLPoint alloc] initWithX:1 y:1];
    [_snake.points addObject:center];
    [_snake.points addObject:center2];
}

- (void)initSnakeView {
    _snakeView = [[WLSnakeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _snakeView.delegate = self;
    [self.view addSubview:_snakeView];
}

- (void)setTimer:(NSTimeInterval)timeInterval {
    [_drawTimer invalidate];
    _drawTimer = nil;
    _drawTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(move)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)move {
    [_snake moveByDirection:_snake.direction];
    [_snakeView setNeedsDisplay];

    bool isGameOver = ([_snake headIsTouchBody]);

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"x < 0 or "
                                                               "y < 0 or "
                                                               "x > %d or "
                                                               "y > %d",
                                                              (int)_snakeView.numOfColumns, (int)_snakeView.numOfRows];
    isGameOver = isGameOver || [_snake.points filteredArrayUsingPredicate:predicate].count > 0;

    if (isGameOver) {
        UIImage *image = [UIImage imageNamed:@"Game_Over"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width / 2, imageView.frame.size.height / 2);

        [self.view addSubview:imageView];
        [_drawTimer invalidate];
        _drawTimer = nil;
    } else if ([_snake headIsTouchPoint:_fruit]) {
        [self rearrangeFruit];
        [_snake growUp];
    }
}

- (void)rearrangeFruit {
    WLPoint *point;
    do {
        NSUInteger x = arc4random() % (_snakeView.numOfColumns);
        NSUInteger y = arc4random() % (_snakeView.numOfRows);
        point = [[WLPoint alloc] initWithX:x y:y];
    } while ([_snake isTouchBodyWithPoint:point]);

    _fruit = point;

    _drawTimeInterval -= 0.1;
    [self setTimer:_drawTimeInterval];
}

- (void)initSwipeRecognizer {
    NSArray *selectors = @[ @"swipeLeft:", @"swipeRight:", @"swipeUp:", @"swipeDown:" ];
    NSArray<NSNumber *> *directions = @[
        @(UISwipeGestureRecognizerDirectionLeft),
        @(UISwipeGestureRecognizerDirectionRight),
        @(UISwipeGestureRecognizerDirectionUp),
        @(UISwipeGestureRecognizerDirectionDown)
    ];

    [selectors enumerateObjectsUsingBlock:^(NSString *selector, NSUInteger idx, BOOL *_Nonnull stop) {
      UISwipeGestureRecognizer *swipeGestureRecognizer =
          [[UISwipeGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(selector)];
      swipeGestureRecognizer.direction = (UISwipeGestureRecognizerDirection)[directions[idx] integerValue];
      [self.view addGestureRecognizer:swipeGestureRecognizer];
    }];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer {
    if (_snake.direction == WLMoveDirectionRight) {
        return;
    }

    _snake.direction = WLMoveDirectionLeft;
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gestureRecognizer {
    if (_snake.direction == WLMoveDirectionLeft) {
        return;
    }

    _snake.direction = WLMoveDirectionRight;
}

- (void)swipeUp:(UISwipeGestureRecognizer *)gestureRecognizer {
    if (_snake.direction == WLMoveDirectionDown) {
        return;
    }

    _snake.direction = WLMoveDirectionUp;
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gestureRecognizer {
    if (_snake.direction == WLMoveDirectionUp) {
        return;
    }

    _snake.direction = WLMoveDirectionDown;
}

- (WLSnake *)viewDidRequestSnake:(UIView *)view {
    return _snake;
}

- (WLPoint *)viewDidRequestFruit:(UIView *)view {
    return _fruit;
}
@end
