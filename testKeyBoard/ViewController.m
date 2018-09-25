//
//  ViewController.m
//  testKeyBoard
//
//  Created by golang on 2018/9/25.
//  Copyright © 2018年 hisign. All rights reserved.
//

#import "ViewController.h"

#import "GolangTextField.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GolangTextField *textField = [[GolangTextField alloc]initWithFrame:CGRectMake(30, 400, 315, 44)];

    textField.borderStyle = UITextBorderStyleLine;
    textField.movingView = self.view;
    textField.placeholder = @"开始输入";
    [self.view addSubview:textField];

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 175, 44)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:sureBtn];
    
    // 500 + 44 - 400 - 44 = 100
    textField.offset = 100;
   
}

- (void)sure{
    [self.view endEditing:YES];
}



@end
