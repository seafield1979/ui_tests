//
//  ViewController.m
//  sns_share
//
//  Created by B02681 on 2014/02/14.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()
{
	UIImage *_sendImage;
}

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
 * 画像をダウンロードする
 */
-(IBAction)downloadImageDidTap:(id)sender
{
	[_loadIndicator startAnimating];
	[self downloadImage:@"https://ssl-ustat.amebame.com/exc/1392301146240/m2s4V.jpg?width=320&height=480"];
	[_loadIndicator stopAnimating];
}

-(IBAction)actionSheetDidTap:(id)sender
{
	NSLog(@"actionSheet");
	
	// 生成例
	UIActionSheet *as = [[UIActionSheet alloc] init];
	int itemCount = 0;
	// デリゲートを設定する
	as.delegate = self;
	
	as.title = @"選択してください。";
	[as addButtonWithTitle:@"Ameba"];
	itemCount++;

	if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Twitter:"]]){
		[as addButtonWithTitle:@"Twitter"];
		itemCount++;
	}
	if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb:"]]){
		[as addButtonWithTitle:@"Facebook"];
		itemCount++;
	}
	if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"LINE:"]]){
		[as addButtonWithTitle:@"LINE(link)"];
		[as addButtonWithTitle:@"LINE(image)"];
		itemCount+=2;
	}
	[as addButtonWithTitle:@"キャンセル"];
	as.cancelButtonIndex = itemCount;
	[as showInView:self.view];
	
	
}

#pragma mark - UIActionSheet Delegate

// アクションシートのボタンが押された時に呼ばれるデリゲート例文
-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *clieckedButtonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	if ([clieckedButtonTitle isEqualToString:@"Ameba"]) {
		// Ameba
	}
	else if([clieckedButtonTitle isEqualToString:@"Twitter"]) {
		// Twitter
		[self postToTwitter];
	}
	else if([clieckedButtonTitle isEqualToString:@"Facebook"]) {
		// Facebook
		[self postToFacebook];
	}
	else if([clieckedButtonTitle isEqualToString:@"LINE(link)"]) {
		// LINE  リンク
		[self postToLINE:1];
	}
	else if([clieckedButtonTitle isEqualToString:@"LINE(image)"]) {
		// LINE  画像
		[self postToLINE:2];
	}

}

#pragma Private Method


// Twitterに投稿
- (void)postToTwitter
{
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
		SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
#if 1
		SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
			if (result == SLComposeViewControllerResultCancelled) {

				NSLog(@"Cancelled");

			} else

			{
				NSLog(@"Done");
			}

			[twitterPostVC dismissViewControllerAnimated:YES completion:Nil];
		};
		twitterPostVC.completionHandler =myBlock;

		[twitterPostVC setInitialText:@"Check out my Christmas Gift!"];
		//[controller addImage:[UIImage imageNamed:@"cat.jpg" ]];
		[self downloadImage:@"https://ssl-ustat.amebame.com/exc/1392301146240/m2s4V.jpg?width=320&height=480"];
		[twitterPostVC addImage:_sendImage];

		[self presentViewController:twitterPostVC animated:YES completion:Nil];

#else
		[twitterPostVC setInitialText:@"iOSのSocialFrameworkから投稿テスト。\nSLComposeViewController簡単。"];
		[self presentViewController:twitterPostVC animated:YES completion:nil];
#endif
	}
}


// Facebookに投稿
- (void)postToFacebook
{
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
			
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
			
            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultCancelled) {
					
                    NSLog(@"Cancelled");
					
                } else
					
                {
                    NSLog(@"Done");
                }
				
                [controller dismissViewControllerAnimated:YES completion:Nil];
            };
            controller.completionHandler =myBlock;
			
            [controller setInitialText:@"Check out my Christmas Gift!"];
            //[controller addImage:[UIImage imageNamed:@"cat.jpg" ]];
			[self downloadImage:@"https://ssl-ustat.amebame.com/exc/1392301146240/m2s4V.jpg?width=320&height=480"];
			[controller addImage:_sendImage];
			
            [self presentViewController:controller animated:YES completion:Nil];
			
        }
	}
#if 0
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
	UIImage *resultImage = [UIImage imageNamed:@"cat.png"];
    [vc setInitialText:@"猫！！"];
    [vc addImage:resultImage];
    [vc addURL:[NSURL URLWithString:@"http://www.nintendo.co.jp/"]];
    [self presentViewController:vc animated:YES completion:nil];
#endif
}

// LINEに投稿
// @param mode  1:リンク / 2:画像
-(void)postToLINE:(int)mode
{
	if(mode == 1){  // 画像投稿
		// テキスト本文の中にURLを入れておくと、そのページのサムネイルを表示してくれる！
		NSString* str = @"LINE使ってるとかリア充だろwwww http://www.nintendo.co.jp";
		NSString *escapedStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		NSString* urlStr = [NSString stringWithFormat:@"line://msg/text/%@", escapedStr];
		NSURL* url = [NSURL URLWithString:urlStr];
		if ([[UIApplication sharedApplication] canOpenURL:url]) {
			[[UIApplication sharedApplication] openURL:url];
		} else {
			//LINEインストールされていないか、仕様が変わったか。アラートなりを出しましょう
		}
	}
	else{  // テキスト投稿
		UIPasteboard *board = [UIPasteboard generalPasteboard];
		
		[self downloadImage:@"https://ssl-ustat.amebame.com/exc/1392301146240/m2s4V.jpg?width=320&height=480"];
		
		[board setData:UIImagePNGRepresentation(_sendImage) forPasteboardType:@"public.png"];
		NSString *urlStr = [NSString stringWithFormat:@"line://msg/image/%@?text/aaa", board.name];
		NSURL* url = [NSURL URLWithString:urlStr];
		if ([[UIApplication sharedApplication] canOpenURL:url]) {
			[[UIApplication sharedApplication] openURL:url];
		} else {
			//LINEインストールされていないか、仕様が変わったか。アラートなりを出しましょう
		}
	}
}

/**
 * 画像をダウンロード
 */
-(void)downloadImage:(NSString*)imageUrl
{
	NSURL *url = [NSURL URLWithString:imageUrl];
	NSData *data = [NSData dataWithContentsOfURL:url];
	_sendImage = [[UIImage alloc] initWithData:data];
	[_imageView setImage:_sendImage];
}
@end
