//
//  GolangTextField.m
//  testKeyBoard
//
//  Created by golang on 2018/9/25.
//  Copyright © 2018年 hisign. All rights reserved.
//

#import "GolangTextField.h"

@interface GolangTextField()

@property(nonatomic,assign)CGRect originalFrame;

@end

@implementation GolangTextField

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addKeyboardNotifications];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addKeyboardNotifications];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addKeyboardNotifications{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (self.isFirstResponder) {
        CGPoint relativePoint = [self convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        CGFloat overstep = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight - CGRectGetHeight([UIScreen mainScreen].bounds);
        overstep += self.offset;
        CGRect changeFrame = self.movingView.frame;
        //注意:第一次弹出键盘会接收到两次通知 willShow
        //初始化 originamFrame 必须在第一次通知的时候且不可再次赋值
        //这里取了个巧, 以高度是否为零作为判断是否已初始化
        if (CGRectGetHeight(self.originalFrame)==0) {
            self.originalFrame = self.movingView.frame;
        }
        
        if (overstep > 0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGRect frame = changeFrame;
            frame.origin.y -= overstep;
            [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                self.movingView.frame = frame;
            } completion: nil];
        }
    }

}

- (void)keyboardWillHide:(NSNotification *)notification{
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            self.movingView.frame = self.originalFrame;
        } completion: nil];
    }

}

@end
