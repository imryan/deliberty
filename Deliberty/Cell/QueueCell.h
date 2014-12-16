//
//  QueueCell.h
//  Deliberty
//
//  Created by Ryan Cohen on 12/16/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *roomLabel;
@property (nonatomic, strong) IBOutlet UILabel *itemLabel;

@end
