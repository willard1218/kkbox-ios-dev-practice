//
//  WLPoint.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLPoint.h"

@implementation WLPoint
- (instancetype)initWithX:(NSInteger)x y:(NSInteger)y {
    self = [self init];
    if (self) {
        self.x = x;
        self.y = y;
    }

    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:self.class]) {
        return false;
    }

    WLPoint *point = (WLPoint *)object;
    return (point.x == self.x && point.y == self.y);
}
@end
