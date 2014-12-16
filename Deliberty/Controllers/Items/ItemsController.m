//
//  ItemsController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/16/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "ItemsController.h"

@interface ItemsController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *snacks;
@property (nonatomic, strong) NSArray *drinks;
@property (nonatomic, strong) NSArray *iceCreams;

- (IBAction)cancel:(id)sender;

@end

@implementation ItemsController

#pragma mark - Methods

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = _snacks.count;
    }
    
    else if (section == 1) {
        rows = _drinks.count;
        
    } else {
        rows = _iceCreams.count;
    }
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Snacks";
    }
    
    else if (section == 1) {
        title = @"Drinks";
        
    } else {
        title = @"Ice Cream";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [_snacks objectAtIndex:indexPath.row];
    }
    
    else if (indexPath.section == 1) {
        cell.textLabel.text = [_drinks objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = [_iceCreams objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^{
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (indexPath.section == 0) {
            delegate.item = [_snacks objectAtIndex:indexPath.row];
        }
        
        else if (indexPath.section == 1) {
            delegate.item = [_drinks objectAtIndex:indexPath.row];
            
        } else {
            delegate.item = [_iceCreams objectAtIndex:indexPath.row];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateItemNotification" object:nil];
    }];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _snacks = @[
                @"Lays Oven Baked Chips (Original)",
                @"Lays Oven Baked Chips (Barbecue)",
                @"Lays Oven Baked Chips (SC & O)",
                @"Lays Oven Baked Chips (Cheese)",
                @"Doritos (Cool Ranch)",
                @"Doritos (Nach Cheese)",
                @"PopCorners (White Cheddar)",
                @"PopCorners (Kettle)",
                @"PopCorners (Sweet Chili)",
                @"Oven Baked Cheetos",
                @"Trail Mix",
                @"Trix Cereal Bar",
                @"Nutrigrain (Raspberry)",
                @"Nutrigrain (Blueberry)",
                @"Nutrigrain (Strawberry)",
                @"Welch's Fruit Snacks"
               ];
    
    _drinks = @[
                @"Dasani Water",
                @"Dasani Water (Lemon)",
                @"Dasani Water (Strawberry)",
                @"Dasani Water (Raspberry)"
                ];
    
    _iceCreams = @[
                @"Scribblers",
                @"Strawberry Shortcake",
                @"Chocolate Eclair",
                @"Sour Swell",
                @"Cotton Candy",
                @"Ice Cream Sandwich",
                @"Sour Cherry"
                ];
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
