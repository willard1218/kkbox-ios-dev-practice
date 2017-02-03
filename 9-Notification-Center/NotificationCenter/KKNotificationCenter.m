//
//  KKNotificationCenter.m
//  WordGame
//
//  Created by willard on 2017/2/3.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "KKNotificationCenter.h"
@interface KKNotificationObserverInfo : NSObject
@property id observer;
@property SEL selector;
@property (copy) NSString *name;
@property id object;
@end

@implementation KKNotificationObserverInfo
@end


@implementation KKNotificationCenter
{
    NSMutableArray <KKNotificationObserverInfo *> *observerInfos;
}


+ (KKNotificationCenter *)defaultCenter {
    static dispatch_once_t onceToken;
    static KKNotificationCenter *center;
    dispatch_once(&onceToken, ^{
        center = [[KKNotificationCenter alloc] init];
    });
    
    return center;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    if (!observerInfos) {
        observerInfos = [NSMutableArray array];
    }
    
    if (![observer respondsToSelector:aSelector]) {
        return;
    }
    
    KKNotificationObserverInfo *observerInfo = [[KKNotificationObserverInfo alloc] init];
    observerInfo.observer = observer;
    observerInfo.selector = aSelector;
    observerInfo.name = aName;
    observerInfo.object = anObject;
    
    [observerInfos addObject:observerInfo];
}

- (void)removeObserver:(id)observer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"observer == %@",observer];
    
    NSArray<KKNotificationObserverInfo *> *filteredObserverInfo = [observerInfos filteredArrayUsingPredicate:predicate];
    
    for (KKNotificationObserverInfo *observerInfo in filteredObserverInfo) {
        [observerInfos removeObject:observerInfo];
    }
}

- (void)postNotification:(NSNotification *)notification {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",notification.name];
    
    NSArray<KKNotificationObserverInfo *> *filteredObserverInfo = [observerInfos filteredArrayUsingPredicate:predicate];
    
    for (KKNotificationObserverInfo *observerInfo in filteredObserverInfo) {
        if (observerInfo.object &&
            observerInfo.object != notification.object) {
            continue;
        }
        
        [observerInfo.observer performSelector:observerInfo.selector withObject:notification afterDelay:0.0f];
    }
}
@end
