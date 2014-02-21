//
//  ModalView1.m
//  ui_modalviewcontroller
//
//  Created by B02681 on 2014/01/22.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ModalView1.h"

@interface ModalView1 ()

@end

@implementation ModalView1

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

//イメージピッカー起動ボタンを押した
-(IBAction)button1DidTap
{
	//生成
	UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
	ipc.delegate = self;
	ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	ipc.allowsEditing = NO;
	ipc.navigationBarHidden = YES;
	//	ipc.navigationBar.tintColor = [UIColor redColor];
	
	//ステータスバーの色変更 (効かない)
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	
	//モーダル起動
    [self presentViewController:ipc animated:YES completion:nil];

}

-(IBAction)closeButtonDidTap
{
	[self dismissViewControllerAnimated:YES completion: nil];
}


#pragma mark - Delegate Method

//画像選択時に呼ばれるデリゲートメソッド
- (void)imagePickerController:
(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo
{
	NSLog(@"didFinishPIckingImage");
}

//新しいViewControllerをナビゲーションにプッシュするボタン
-(IBAction)pushButtonDidTap
{
	ModalView1 *viewController = [[ModalView1 alloc]initWithNibName:@"ModalView1" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
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
	NSLog(@"imagePickerControllerDidCancel");
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
