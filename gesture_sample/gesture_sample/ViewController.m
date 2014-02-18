//
//  ViewController.m
//  gesture_sample
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    initDistance = 0;
    touchPoints = [[NSMutableArray alloc] init];
	
    // View
    view = [[UIView alloc] initWithFrame:CGRectMake(0 ,0 , 320, 450)];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
	
	// タッチイベントをフックするUIWindow
    GestureWindow* tapWindow;
    tapWindow = (GestureWindow*)[[UIApplication sharedApplication].windows
								 objectAtIndex:0];
    tapWindow.wView = view;
    tapWindow.delegate = self;
	
    // URL をロードする
    [webView loadRequest:[NSURLRequest
						  requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}
@end
