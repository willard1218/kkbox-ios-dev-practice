//
//  KKNotificationCenter.h
//  WordGame
//
//  Created by willard on 2017/2/3.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KKNotificationCenter : NSObject
+ (KKNotificationCenter *)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)postNotification:(NSNotification *)notification;
- (void)removeObserver:(id)observer;
@end
