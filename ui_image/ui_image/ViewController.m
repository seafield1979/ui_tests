//
//  ViewController.m
//  ui_image
//
//  Created by B02681 on 2014/02/17.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Action Method
/**
 * UIViewからUIImageViewに画像をコピーする
 */
-(IBAction)draw1DidTap:(id)sender
{
	//self.imageView.image = [ViewController imageWithView:self.myView];
	//イメージ用グラフィックスコンテクスト開始(320x480の画像を作成)
	UIGraphicsBeginImageContext(CGSizeMake(640, 536));
//	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	
	//イメージ用グラフィックスコンテクスト取得
	CGContextRef context = UIGraphicsGetCurrentContext();

	// 背景
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextFillRect(context, CGRectMake(0, 0, 640, 536));
	

	//画像を描画
	{
		UIImage *bgImage = [UIImage imageNamed:@"cat.jpg"];
		float imageW = bgImage.size.width;
		float imageH = bgImage.size.height;
		float baseRatio = 432.0 / 325.0;		// もとの画像領域の縦横比
		float imageRatio = imageW / imageH;
		float drawW, drawH;
		if(imageRatio > baseRatio){
			// 元の領域の幅に合わせて伸縮
			drawW = 432.0;
			drawH = imageH * (432.0 / imageW);
		}
		else{
			// 元の領域の高さに合わせて伸縮
			drawH = 325.0;
			drawW = imageW * (325.0 / imageH);
		}
		[bgImage drawInRect:CGRectMake(103 + (432 - drawW) / 2, 42 + (324 - drawH) / 2, drawW, drawH)];
	}
	
	// テキスト描画
	{
		// 描画モード
		CGContextSetTextDrawingMode(context, kCGTextFill); // This is the default
		// 描画
		UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:29];
		// フォント、色を指定して文字列を描画
		CGRect rect = CGRectMake(0,400,640.0,150);
		NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
		paragraphStyle.alignment = NSTextAlignmentCenter;
		[@"あああああああ\nいいいいいいい" drawInRect:rect withAttributes: @{NSFontAttributeName: font,
															   NSParagraphStyleAttributeName: paragraphStyle,
															   NSForegroundColorAttributeName: [UIColor whiteColor] }];
	}
	
	// 座布団、ロゴ
	{
		//UIImage *zabutonImg = [UIImage imageNamed:@"icon_very_small_three_zabuton_glod.png"];
		UIImage *logImg = [UIImage imageNamed:@"oogiri_logo.png"];
		
		[logImg drawInRect:CGRectMake(640-120, 536 - 35, 110, 25)];
	}

	
	//何か描画（左上に赤い不透明な100x100の四角を描画）
//	CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
//	CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
	
	//描画内容をUIImageに変換
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
	//イメージ用グラフィックスコンテクスト終了
	UIGraphicsEndImageContext();
	
	self.imageView.image = img;

}


/**
 * ビットマップコンテキストに描画した画像をUIImageで取得する
 */
-(IBAction)draw2DidTap:(id)sender
{
	//イメージ用グラフィックスコンテクスト開始(320x480の画像を作成)
	UIGraphicsBeginImageContext(CGSizeMake(160, 160));

	//イメージ用グラフィックスコンテクスト取得
	CGContextRef context = UIGraphicsGetCurrentContext();

	//画像を描画
	UIImage *bgImage = [UIImage imageNamed:@"cat.jpg"];
	[bgImage drawInRect:CGRectMake(0, 0, 160, 160)];

	//何か描画（左上に赤い不透明な100x100の四角を描画）
	CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextFillRect(context, CGRectMake(0, 0, 100, 100));

	//描画内容をUIImageに変換
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

	//イメージ用グラフィックスコンテクスト終了
	UIGraphicsEndImageContext();

	self.imageView.image = img;

}

-(IBAction)draw3DidTap:(id)sender
{
}

#pragma mark - Private method


#pragma mark - Class method
/**
 * UIViewからUIImageに変換する
 */
+ (UIImage *) imageWithView:(UIView *)view
{
	// ビットマップ画像のコンテキストを作成
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);

	// viewのレイヤーをコンテキストに描画する
	CGContextRef context = UIGraphicsGetCurrentContext();
	[view.layer renderInContext:context];

	//何か描画（左上に赤い不透明な100x100の四角を描画）
//	CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
//	CGContextFillRect(context, CGRectMake(0, 0, 100, 100));

	//コンテキストからImageを取得する
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

	//コンテキストを解除する
	UIGraphicsEndImageContext();
	
    return img;
}

@end
