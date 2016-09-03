//
//  WLSnake.h
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLPoint.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WLMoveDirection) {
    WLMoveDirectionNone,
    WLMoveDirectionUp,
    WLMoveDirectionDown,
    WLMoveDirectionLeft,
    WLMoveDirectionRight,
    WLMoveDirectionCount
};

@interface WLSnake : NSObject
@property(nonatomic, strong) NSMutableArray<WLPoint *> *points;
@property(nonatomic) WLMoveDirection direction;

- (void)moveByDirection:(WLMoveDirection)direction;
- (void)growUp;
- (bool)headIsTouchBody;
- (bool)headIsTouchPoint:(WLPoint *)point;
- (bool)isTouchBodyWithPoint:(WLPoint *)point;
@end
