//
//  MyViewController.h
//  ui_scrollview
//
//  Created by B02681 on 2014/01/23.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebView.h"

@interface MyViewController : UIViewController <subViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *scrollViewArea;

@property (strong, nonatomic) IBOutlet MyWebView *webView;


@end
