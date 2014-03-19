//
//  AppDelegate.h
//  facebook
//
//  Created by B02681 on 2014/02/26.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Facebook.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) FBSession *session;

@property (readonly)Facebook *facebook;
@end
