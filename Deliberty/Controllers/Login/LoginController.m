//
//  LoginController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *studentIdField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSArray *textFields;

@end

@implementation LoginController

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        _studentIdField.placeholder = @"Student ID";
        [cell.contentView addSubview:_studentIdField];
    }
    
    else if (indexPath.row == 1) {
        _passwordField.placeholder = @"Password";
        [cell.contentView addSubview:_passwordField];
    }
    
    return cell;
}

#pragma mark - Fields

- (UITextField *)cellTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CELL_TEXTFIELD_FRAME];
    textField.returnKeyType = UIReturnKeyNext;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < 1) {
        UITextField *nextTextField = [_textFields objectAtIndex:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    } else {
        NSLog(@"Validate");
    }
    
    return YES;
}

- (BOOL)isEmpty:(NSString *)string {
    if ([string length] == 0) {
        return true;
    }
    
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return true;
    }
    
    return false;
}

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentIdField = [self cellTextField];
    _studentIdField.delegate = self;
    _studentIdField.tag = 0;
    
    _passwordField = [self cellTextField];
    _passwordField.delegate = self;
    _passwordField.secureTextEntry = YES;
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.tag = 1;
    
    _textFields = @[_studentIdField, _passwordField];
    
    [_studentIdField becomeFirstResponder];
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
