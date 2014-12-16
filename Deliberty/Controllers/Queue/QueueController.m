//
//  QueueController.m
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import "QueueController.h"

@interface QueueController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *requests;

- (void)refresh;

@end

@implementation QueueController

#pragma mark - Methods

- (void)refresh {
    [_refreshControl beginRefreshing];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Queue"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            
        } else {
            _requests = [NSArray arrayWithArray:objects];
            [self.tableView reloadData];
            [_refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _requests.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Queue";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    QueueCell *cell = (QueueCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[QueueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    PFObject *object = [_requests objectAtIndex:indexPath.row];
    cell.nameLabel.text = object[@"name"];
    cell.itemLabel.text = object[@"item"];
    cell.roomLabel.text = object[@"room"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    self.navigationItem.hidesBackButton = YES;
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
