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
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *totalCost;

- (IBAction)add:(id)sender;
- (IBAction)cancel:(id)sender;
- (void)updateItem;

@end

@implementation AddController

#pragma mark - Methods

- (IBAction)add:(id)sender {
    if ([self isEmpty:_roomField.text] || [_itemName isEqualToString:@"Select Item"]) {
        NSLog(@"Incomplete");
        
    } else {
        PFObject *object = [PFObject objectWithClassName:@"Queue"];
        object[@"name"] = [PFUser currentUser][@"name"];
        object[@"room"] = _roomField.text;
        object[@"item"] = _itemName;
        object[@"claimed"] = @(NO);
        object[@"user"] = [PFUser currentUser].objectId;
        
        [object saveInBackgroundWithBlock:^(BOOL success, NSError *error) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                NSLog(@"Error: %@", error.localizedDescription);
            }
        }];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateItem {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _itemName = delegate.item;
    _totalCost = @"$2.00";
    
    [self.tableView reloadData];
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
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Request Item";
    } else {
        title = @"Total";
    }
    
    return title;
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
            cell.textLabel.text = _itemName;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    } else {
        if (indexPath.row == 0) {
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            cell.textLabel.text = _totalCost;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ToItems" sender:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fields

- (UITextField *)cellTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CELL_TEXTFIELD_FRAME];
    textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    
    return textField;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemName = @"Select Item";
    _totalCost = @"$0.00";
    
    _roomField = [self cellTextField];
    [_roomField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateItem) name:@"UpdateItemNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
