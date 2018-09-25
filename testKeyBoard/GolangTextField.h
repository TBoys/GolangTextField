//
//  GolangTextField.h
//  testKeyBoard
//
//  Created by golang on 2018/9/25.
//  Copyright © 2018年 hisign. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GolangTextField : UITextField

@property(nonatomic,assign)CGFloat offset;
@property(nonatomic,weak)UIView *movingView;

@end

NS_ASSUME_NONNULL_END
