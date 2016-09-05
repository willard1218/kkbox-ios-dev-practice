//
//  WLWordView.h
//  WordGame
//
//  Created by willard on 2016/9/5.
//  Copyright © 2016年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLWordViewDelegate <NSObject>
- (NSMutableArray<NSMutableArray<NSString *> *> *)viewDidRequestWords;

@end

@interface WLWordView : UIView
@property(weak) id<WLWordViewDelegate> delegate;
- (void)setCellBasicUIView:(UIView *)view;
- (float)convertToPoint:(NSInteger)num;
- (CGRect)getRectWithX:(NSInteger)x y:(NSInteger)y;
@end
