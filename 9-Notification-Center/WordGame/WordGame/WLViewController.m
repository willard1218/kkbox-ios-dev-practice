//
//  ViewController.m
//  WordGame
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "Constants.h"
#import "WLViewController.h"
@interface WLViewController ()

@end

@implementation WLViewController {
    NSUInteger highlightedX, highlightedY;
}

static const int kNumOfRows = 8;
static const int kNumOfColumns = 10;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWords];
    [self initWordView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];

    tapRecognizer.numberOfTapsRequired = 1;

    [_wordView addGestureRecognizer:tapRecognizer];
}

- (void)initWords {
    _words = [NSMutableArray arrayWithCapacity:kNumOfRows];

    for (int i = 0; i < kNumOfRows; i++) {
        _words[i] = [NSMutableArray arrayWithCapacity:kNumOfColumns];
        for (int j = 0; j < kNumOfColumns; j++) {
            _words[i][j] = @"帥";
        }
    }
}
- (void)initWordView {
    _wordView = [[WLWordView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _wordView.delegate = self;
    [self.view addSubview:_wordView];
}

#pragma mark keyboard show/hide notification
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGSize keyboardSize = keyboardFrame.size;

    CGRect touchedRect = [_wordView getRectWithX:highlightedX + 1 y:highlightedY + 1];
    if (!CGRectContainsRect(keyboardFrame, touchedRect)) {
        return;
    }

    NSTimeInterval showDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:showDuration
                     animations:^{
                       _wordView.frame =
                           CGRectMake(0, -keyboardSize.height, _wordView.frame.size.width, _wordView.frame.size.height);
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval hideDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:hideDuration
                     animations:^{
                       _wordView.frame = CGRectMake(0, 0, _wordView.frame.size.width, _wordView.frame.size.height);
                     }];
}

- (void)respondToTapGesture:(UITapGestureRecognizer *)tapRecognizer {
    CGPoint point = [tapRecognizer locationInView:_wordView];
    highlightedX = point.x / kLengthOfCell;
    highlightedY = (point.y - [UIApplication sharedApplication].statusBarFrame.size.height) / kLengthOfCell;

    CGRect rect = [_wordView getRectWithX:highlightedX y:highlightedY];

    NSPredicate *predicate =
        [NSPredicate predicateWithBlock:^BOOL(UILabel *label, NSDictionary<NSString *, id> *_Nullable bindings) {
          return CGRectEqualToRect(label.frame, rect);
        }];

    NSArray *highlightedLabels = [_wordView.subviews filteredArrayUsingPredicate:predicate];

    if (highlightedLabels.count == 0) {
        return;
    }

    [self drawTextFieldWithUILabel:highlightedLabels[0]];
}

- (void)drawTextFieldWithUILabel:(UILabel *)highlightedLabel {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kLengthOfCell, kLengthOfCell)];
    [_wordView setCellBasicUIView:textField];
    textField.textColor = [UIColor whiteColor];
    textField.text = highlightedLabel.text;
    textField.backgroundColor = [UIColor blackColor];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    [textField becomeFirstResponder];
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [highlightedLabel addSubview:textField];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 1) {
        textField.text = [textField.text substringToIndex:1];
    }
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
    return (range.location < 1);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        return NO;
    }

    _words[highlightedX][highlightedY] = textField.text;
    [_wordView setNeedsDisplay];
    [textField removeFromSuperview];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark WLWordViewDelegate
- (NSMutableArray<NSMutableArray<NSString *> *> *)viewDidRequestWords {
    return _words;
}
@end
