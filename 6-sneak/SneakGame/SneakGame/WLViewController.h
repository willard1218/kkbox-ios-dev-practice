//
//  ViewController.h
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnake.h"
#import <UIKit/UIKit.h>
@interface WLViewController : UIViewController
@property(nonatomic, strong) WLSnake *snake;
@property(nonatomic, strong) WLPoint *fruit;
@property(nonatomic, strong) WLSnakeView *snakeView;
@end
