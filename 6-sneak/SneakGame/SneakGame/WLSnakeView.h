//
//  WLSnakeView.h
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLSnake;
@class WLPoint;
@protocol WLSnakeViewDelegate <NSObject>
- (WLSnake *)viewDidRequestSnake:(UIView *)view;
- (WLPoint *)viewDidRequestFruit:(UIView *)view;
@end

@interface WLSnakeView : UIView
@property(weak) id<WLSnakeViewDelegate> delegate;

@property NSUInteger numOfRows;
@property NSUInteger numOfColumns;

@end
