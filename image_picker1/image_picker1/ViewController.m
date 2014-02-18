//
//  ViewController.m
//  image_picker1
//
//  Created by 海野 秀祐 on 2013/07/28.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label1 = _label1;
@synthesize imageview1 = _imageview1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//	UIImagePickerController* imagePicker;
//	imagePicker = [[UIImagePickerController init]alloc];
//	[imagePicker setCameraOverlayView:_imageview1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[_buttonstart1 release];
	[_label1 release];
	[_imageview1 release];
	[super dealloc];
}


// カメラ起動
- (IBAction)push_button1:(id)sender {

	UIActionSheet *as = [[UIActionSheet alloc] init];
	as.delegate = self;
	as.title = @"title";
	as.cancelButtonIndex = 2;			// キャンセルボタンを設定
	as.destructiveButtonIndex = 0;		// 赤くするボタンを設定
	as.actionSheetStyle = UIActionSheetStyleBlackOpaque;		// 背景色
	[as addButtonWithTitle:@"camera"];
	[as addButtonWithTitle:@"album"];
	[as addButtonWithTitle:@"cancel"];

	[as showInView:self.view];
}

// カメラがキャンセルされたときの処理
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	_label1.text = @"canceled";
	//[self dismissModalViewControllerAnimated:YES];
	// ios6
	[self dismissViewControllerAnimated:YES completion:nil];
}


// 撮影されたときに呼ばれる処理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

	[self dismissViewControllerAnimated:YES completion:nil];

	// imageviewに表示する
	if (true) {
		// リサイズ例文（サイズを指定する方法）
		UIImage *img_mae = image;
		UIImage *img_ato;  // リサイズ後UIImage
		CGSize size_dst = _imageview1.frame.size;

		// 縦横比の調整
		// 元画像の縦横比と表示画像の縦横比が異なる場合はアスペクト比が崩れないように元画像をトリミングする
		

		UIGraphicsBeginImageContext(CGSizeMake(size_dst.width, size_dst.height));
		[img_mae drawInRect:CGRectMake(0, 0, size_dst.width, size_dst.height)];
		img_ato = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		_imageview1.image = img_ato;
	}
	if (false) {
		// 表示するUIImageViewのサイズを取得
		CGSize size_dst = _imageview1.frame.size;

		// 縦横比が維持されるようにサイズを調整する
		UIImage *img_mae = image;  // 切り取り前UIImage
		UIImage *img_ato;  // 切り取り後UIImage
		CGSize size1 = img_mae.size;
		NSLog(@"widht:%f height:%f", size1.width, size1.height);
		CGRect rect = CGRectMake(0, 0, size_dst.width, size_dst.height);  // 切り取る場所とサイズを指定

		UIGraphicsBeginImageContext(rect.size);
		[img_mae drawAtPoint:rect.origin];
		img_ato = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		_imageview1.image = img_ato;
	}

	// ファイルに保存する
	if (false){
		UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
	}
}

// 保存完了時のイベント
-(void)targetImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context
{
	if (error) {
		_label1.text = @"save error";
	}
	else {
		_label1.text = @"save ok";
	}
}



//---------------------------------------------------
// アクションシートのDelegate
//---------------------------------------------------
// アクションシートが表示されるときに実行される
-(void)willPresentActionSheet:
(UIActionSheet*)actionSheet
{

}

// 閉じた直後に呼ばれるメソッド
-(void)actionSheet:
(UIActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{

}

// ボタンが押されたときに呼ばれるメソッド
-(void)actionSheet:
(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			//カメラ機能をチェック
			if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
			{
				UIImagePickerController *ip = [[UIImagePickerController alloc]init];
				ip.sourceType = UIImagePickerControllerSourceTypeCamera;
				ip.delegate = self;
				ip.allowsEditing = NO;
				//[self presentModalViewController:ip animated:YES];
				[self presentViewController: ip animated:YES completion: nil];
			}
			break;
		case 1:
			// ２番目のボタンが押されたときの処理を記述する
			_label1.text = @"album";
			{
				UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
				ipc.delegate = self;
				ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				[self presentViewController:ipc animated:YES completion:nil];
			}
			break;
		case 2:
			// ３番目のボタンが押されたときの処理を記述する
			_label1.text = @"cancel";
			break;
	}
}

@end
