//
//  MyViewController.m
//  ui_modalviewcontroller
//
//  Created by B02681 on 2014/01/22.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "MyViewController.h"
#import "ModalView1.h"

@interface MyViewController ()

@end

@implementation MyViewController

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

#pragma mark - Action

//ボタン１を押したときの処理
//ViewControllerをモーダルを立ち上げる
-(IBAction)button1DidTap
{
	//表示させる画面のView Controllerのインスタンスを作成する。
    ModalView1 *modalViewVC = [[ModalView1 alloc] initWithNibName:@"ModalView1" bundle:nil];
	
#if 1
	//ナビゲーションをモーダルで表示
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:modalViewVC];
	
    //画面を表示させる。
    //[self presentModalViewController:modalViewVC animated:YES];
	[self presentViewController:nav animated:YES completion: nil];

#else
	//ViewControllerをモーダルで表示
    //modalViewVCからModalViewCloseButtonPressをコールするために、自分自身のオブジェクトをdelegateとして登録する。
    //[modalViewVC setDelegate:self];
	
    //画面表示時のアニメーションを指定
    modalViewVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical; //  デフォルト設定
	
    //画面を表示させる。
    //[self presentModalViewController:modalViewVC animated:YES];
	[self presentViewController:modalViewVC animated:YES completion: nil];
#endif
}

@end
