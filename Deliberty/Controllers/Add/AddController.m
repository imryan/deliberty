//
//  AddController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "AddController.h"

@interface AddController ()

- (IBAction)add:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation AddController

#pragma mark - Methods

- (IBAction)add:(id)sender {
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
