//
//  WLWordView.m
//  WordGame
//
//  Created by willard on 2016/9/5.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "Constants.h"
#import "WLWordView.h"
@implementation WLWordView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kLengthOfSquare = kLengthOfCell - kBorderWidth;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    NSMutableArray<NSMutableArray<NSString *> *> *words = [self.delegate viewDidRequestWords];
    for (int i = 0; i < words.count; i++) {
        for (int j = 0; j < words[i].count; j++) {
            CGRect rect = [self getRectWithX:i y:j];
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            [self setCellBasicUIView:label];
            label.text = words[i][j];
            [self addSubview:label];
        }
    }
}

- (void)setCellBasicUIView:(UIView *)view {
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 2.0;
    [view setValue:@(NSTextAlignmentCenter) forKey:@"textAlignment"];
}

- (CGRect)getRectWithX:(NSInteger)x y:(NSInteger)y {
    float startX = [self convertToPoint:x];
    float startY = [self convertToPoint:y] + [UIApplication sharedApplication].statusBarFrame.size.height;

    return CGRectMake(startX, startY, kLengthOfSquare, kLengthOfSquare);
}

- (float)convertToPoint:(NSInteger)num {
    return num * kLengthOfCell;
}
@end
