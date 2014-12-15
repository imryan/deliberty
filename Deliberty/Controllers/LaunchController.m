//
//  LaunchController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "LaunchController.h"

@interface LaunchController ()

@property (nonatomic, strong) IBOutlet UIButton *signUpButton;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

@end

@implementation LaunchController

#pragma mark - Buttons

- (UIButton *)customButton:(UIButton *)button {
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 6.f;
    
    return button;
}

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customButton:_loginButton];
    [self customButton:_signUpButton];
    [_signUpButton setTitleColor:self.view.backgroundColor forState:UIControlStateNormal];
    _signUpButton.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
