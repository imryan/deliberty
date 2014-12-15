//
//  SignUpController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "SignUpController.h"

@interface SignUpController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *studentIdField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSArray *textFields;

- (IBAction)done:(id)sender;
- (void)signUp;

@end

@implementation SignUpController

#pragma mark - Methods

- (void)signUp {
    UIView *dimView = [[UIView alloc] initWithFrame:self.navigationController.view.frame];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.f;
    
    [self.view addSubview:dimView];
    
    [UIView animateWithDuration:0.2 animations:^{
        dimView.alpha = 0.5f;
    }];
    
    PFUser *user = [PFUser user];
    user[@"name"] = _nameField.text;
    user.username = _studentIdField.text;
    user.password = _passwordField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL success, NSError *error) {
        if (error) {
            NSLog(@"Error signing up user: %@", error.localizedDescription);
            
        } else {
            [self performSegueWithIdentifier:@"ToQueue" sender:self];
        }
    }];
}

- (IBAction)done:(id)sender {
    [self signUp];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
        _nameField.placeholder = @"Name";
        [cell.contentView addSubview:_nameField];
    }
    
    else if (indexPath.row == 1) {
        _studentIdField.placeholder = @"Student ID";
        [cell.contentView addSubview:_studentIdField];
    }
    
    else if (indexPath.row == 2) {
        _passwordField.placeholder = @"Password";
        [cell.contentView addSubview:_passwordField];
    }
    
    return cell;
}

#pragma mark - Fields

#pragma mark - Fields

- (UITextField *)cellTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CELL_TEXTFIELD_FRAME];
    textField.returnKeyType = UIReturnKeyNext;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < 2) {
        UITextField *nextTextField = [_textFields objectAtIndex:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    } else {
        if ([self isEmpty:_nameField.text] || [self isEmpty:_studentIdField.text] || [self isEmpty:_passwordField.text]) {
            NSLog(@"Empty");
            
        } else {
            [self signUp];
        }
    }
    
    return YES;
}

- (BOOL)isEmpty:(NSString *)string {
    if (string.length == 0) {
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
    
    _nameField = [self cellTextField];
    _nameField.delegate = self;
    _nameField.tag = 0;
    
    _studentIdField = [self cellTextField];
    _studentIdField.delegate = self;
    _studentIdField.tag = 1;
    
    _passwordField = [self cellTextField];
    _passwordField.delegate = self;
    _passwordField.secureTextEntry = YES;
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.tag = 2;
    
    _textFields = @[_nameField, _studentIdField, _passwordField];
    
    [_nameField becomeFirstResponder];
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
