//
//  ViewController.h
//  ui_webview
//
//  Created by B02681 on 2014/02/19.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;

-(IBAction)loadButtonDidTap:(id)sender;


@end
