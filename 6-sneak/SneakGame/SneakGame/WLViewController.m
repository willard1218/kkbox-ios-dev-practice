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

    float width = 50;
    WLSnakeView *demoView = [[WLSnakeView alloc] initWithFrame:CGRectMake(60, 100, width, width)];
    [self.view addSubview:demoView];
    [self initSwipeRecognizer];
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

//    UISwipeGestureRecognizer *swipeLeft =
//        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:swipeLeft];
//
//    UISwipeGestureRecognizer *swipeRight =
//        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
//    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:swipeRight];
//
//    UISwipeGestureRecognizer *swipeUp =
//        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
//    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:swipeUp];
//
//    UISwipeGestureRecognizer *swipeDown =
//        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
//    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:swipeDown];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer {
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gestureRecognizer {
}

- (void)swipeUp:(UISwipeGestureRecognizer *)gestureRecognizer {
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gestureRecognizer {
}

- (WLSnake *)viewDidRequestSnake:(UIView *)view {
    return _snake;
}

- (WLPoint *)viewDidRequestFruit:(UIView *)view {
    return _fruit;
}
@end
