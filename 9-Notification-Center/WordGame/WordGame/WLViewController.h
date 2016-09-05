//
//  ViewController.h
//  WordGame
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLWordView.h"
#import <UIKit/UIKit.h>

@interface WLViewController : UIViewController <WLWordViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) NSMutableArray<NSMutableArray<NSString *> *> *words;
@property(nonatomic, strong) WLWordView *wordView;
@end
