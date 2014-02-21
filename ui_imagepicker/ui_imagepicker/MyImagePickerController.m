//
//  MyImagePickerController.m
//  ui_imagepicker
//
//  Created by B02681 on 2014/01/21.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "MyImagePickerController.h"

@interface MyImagePickerController ()

@end

@implementation MyImagePickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//ステータスバーの色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//ステータスバーの表示状態
- (BOOL)prefersStatusBarHidden
{
	return YES;
}

@end
