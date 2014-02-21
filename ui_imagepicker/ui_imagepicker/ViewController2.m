//
//  ViewController2.m
//  ui_imagepicker
//
//  Created by B02681 on 2014/01/20.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

UINavigationController *pickerNavi = nil;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) button1DidTap
{
	NSLog(@"button1 tap!!");
	
	//生成
	MyImagePickerController *ipc = [[MyImagePickerController alloc] init];
	ipc.delegate = self;
	ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	ipc.allowsEditing = NO;
	ipc.navigationBarHidden = YES;

	//モーダル起動
    [self presentViewController:ipc animated:YES completion:nil];
}

//左ボタンが押されたときの処理
-(void)leftButtonDidTap
{
	NSLog(@"leftButtonDidTap:%d", [pickerNavi.viewControllers count]);
	if( 1 < [pickerNavi.viewControllers count]){
		//ポップする
		[pickerNavi popViewControllerAnimated:YES];
	}
	else{
		//ImagePickerを閉じる
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

//右ボタンが押されたときの処理
-(void)rightButtonDidTap
{
	NSLog(@"rightButtonDidTap");
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate method
//画像選択時に呼ばれるデリゲートメソッド
- (void)imagePickerController:
(UIImagePickerController *)picker
			didFinishPickingImage:(UIImage *)image
			editingInfo:(NSDictionary *)editingInfo
{
	NSLog(@"didFinishPIckingImage");
}

//キャンセル時に呼ばれるデリゲートメソッド
- (void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
	NSLog(@"imagePickerControllerDidCancel");
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
}


//表示前に呼ばれるデリゲートメソッド
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	UINavigationItem *ipcNavBarTopItem;
	
	NSLog(@"leftButtonDidTap:%d", [pickerNavi.viewControllers count]);
		
	pickerNavi = navigationController;
	UINavigationBar *bar = navigationController.navigationBar;
//	ipcNavBarTopItem = bar.topItem;
//	ipcNavBarTopItem.title = @"";
	
	//デフォルトのボタン類をすべて無効化
	viewController.navigationItem.title = @"";
	viewController.navigationItem.leftBarButtonItem = nil;
	viewController.navigationItem.rightBarButtonItem = nil;
	viewController.navigationItem.hidesBackButton = YES;

#if 1
	//ナビゲーションバーの背景に画像を設定
    UIImage *backgroundImage = [UIImage imageNamed:@"navigationbar"];
    [bar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
#else
	//背景色
//	[bar setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
	bar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9];
#endif
	
	//タイトルに画像を設定
    UIImage *image = [UIImage imageNamed:@"title_imageselect.png"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
	//[iv sizeToFit];
    iv.frame = CGRectMake(160-(80/2),0,80,44);
	[bar addSubview:iv];
	
	NSLog(@"aaa:%f %f %f %f", bar.frame.size.width, bar.frame.size.height, bar.frame.origin.x, bar.frame.origin.y);


//	ipcNavBarTopItem.titleView = iv;
	
	//左ボタンを変更
	UIBarButtonItem *btnL = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStylePlain target:self action:nil];
	ipcNavBarTopItem.leftBarButtonItem = btnL;
    
	//左ボタンを変更
	UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(0,0,70,44);
    [buttonL setImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
	[buttonL setImage:[UIImage imageNamed:@"button1_on"] forState:UIControlStateHighlighted];
    [buttonL addTarget:self action:@selector(leftButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:buttonL];
	
	//右ボタンを変更
	UIButton *buttonR = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonR.frame = CGRectMake(250,0,70,44);
    [buttonR setImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
	[buttonR setImage:[UIImage imageNamed:@"button1_on"] forState:UIControlStateHighlighted];
    [buttonR addTarget:self action:@selector(rightButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:buttonR];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	NSLog(@"didShowViewController");
}
@end
