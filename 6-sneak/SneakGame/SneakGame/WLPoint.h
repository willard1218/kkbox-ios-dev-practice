//
//  WLPoint.h
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLPoint : NSObject
@property NSInteger x;
@property NSInteger y;
- (instancetype)initWithX:(NSInteger)x y:(NSInteger)y;
@end
