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

@end

@implementation WLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _snakeView = [[WLSnakeView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    _snakeView.delegate = self;
    [self.view addSubview:_snakeView];
    [self initSwipeRecognizer];
    _snake = [[WLSnake alloc] init];
    _snake.direction = WLMoveDirectionRight;
    WLPoint *center = [[WLPoint alloc] initWithX:0 y:1];
    WLPoint *center2 = [[WLPoint alloc] initWithX:1 y:1];
    [_snake.points addObject:center];
    [_snake.points addObject:center2];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void)move {
    [_snake moveByDirection:_snake.direction];
    [_snakeView setNeedsDisplay];

    if ([_snake headIsTouchBody]) {
        NSLog(@"Game over");
    }
}

- (void)initSwipeRecognizer {
    NSArray *selectors = @[ @"swipeLeft:", @"swipeRight:", @"swipeUp:", @"swipeDown:" ];
    NSArray *directions = @[
        @(UISwipeGestureRecognizerDirectionLeft),
        @(UISwipeGestureRecognizerDirectionRight),
        @(UISwipeGestureRecognizerDirectionUp),
        @(UISwipeGestureRecognizerDirectionDown)
    ];

    [selectors enumerateObjectsUsingBlock:^(NSString *selecror, NSUInteger idx, BOOL *_Nonnull stop) {
      UISwipeGestureRecognizer *swipeGestureRecognizer =
          [[UISwipeGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(selecror)];
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
