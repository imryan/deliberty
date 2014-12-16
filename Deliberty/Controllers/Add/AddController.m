//
//  AddController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "AddController.h"

@interface AddController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *roomField;

- (IBAction)add:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation AddController

#pragma mark - Methods

- (IBAction)add:(id)sender {
    // Store request in Queue class
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = 2;
    } else {
        rows = 1;
    }
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Request Item";
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _roomField.placeholder = @"Room #";
            [cell.contentView addSubview:_roomField];
        }
        
        else if (indexPath.row == 1) {
            // Item selection
            cell.textLabel.text = @"Select Item";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    } else {
        if (indexPath.row == 0) {
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            cell.textLabel.text = @"Total: $0";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fields

- (UITextField *)cellTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CELL_TEXTFIELD_FRAME];
    textField.returnKeyType = UIReturnKeyNext;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    
    return textField;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _roomField = [self cellTextField];
    [_roomField becomeFirstResponder];
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
