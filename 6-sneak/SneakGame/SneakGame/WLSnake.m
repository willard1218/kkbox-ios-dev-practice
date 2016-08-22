//
//  WLSnake.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnake.h"

@implementation WLSnake
@synthesize points;
@synthesize direction;

- (instancetype)init {
    self = [super init];

    if (self) {
        points = [NSMutableArray array];
        direction = WLMoveDirectionNone;
    }

    return self;
}

- (void)moveByDirection:(WLMoveDirection)newDirection {
    [points removeLastObject];

    WLPoint *oldHead = points[0];
    WLPoint *newHead = [[WLPoint alloc] initWithX:oldHead.x y:oldHead.y];

    switch (newDirection) {
        case WLMoveDirectionNone:
            break;
        case WLMoveDirectionUp:
            newHead.y = oldHead.y - 1;
            break;
        case WLMoveDirectionDown:
            newHead.y = oldHead.y + 1;
            break;
        case WLMoveDirectionLeft:
            newHead.x = oldHead.x - 1;
            break;
        case WLMoveDirectionRight:
            newHead.x = oldHead.x + 1;
            break;
        case WLMoveDirectionCount:
            break;
    }

    [points insertObject:newHead atIndex:0];
}

- (void)growUp {
    WLPoint *oldTail = [points lastObject];
    WLPoint *previousTail = points[[points count] - 2];

    NSInteger dx = oldTail.x - previousTail.x;
    NSInteger dy = oldTail.y - previousTail.y;

    WLPoint *newTail = [[WLPoint alloc] initWithX:oldTail.x y:oldTail.y];
    newTail.x += dx;
    newTail.y += dy;

    [points addObject:newTail];
}

- (bool)headIsTouchBody {
    WLPoint *head = points[0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"x == %d and y == %d", (int)head.x, (int)head.y];

    return ([[points filteredArrayUsingPredicate:predicate] count] > 1);
}

- (bool)headIsTouchPoint:(WLPoint *)point {
    WLPoint *head = points[0];
    return (point.x == head.x && point.y == head.y);
}

@end
