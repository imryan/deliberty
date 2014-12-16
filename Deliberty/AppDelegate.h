//
//  AppDelegate.h
//  Deliberty
//
//  Created by Ryan Cohen on 12/15/14.
//  Copyright (c) 2014 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#define RED_COLOR [UIColor colorWithRed:204/255.f green:0/255.f blue:15/255.f alpha:1.f]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *item;

@end

