//
//  ViewController.m
//  ui_webview
//
//  Created by B02681 on 2014/02/19.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_webView.scalesPageToFit = YES;
	

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
	// iOS7ならステータスバーの分だけwebviewを下にスライド
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
		CGRect rect =CGRectMake(0, 20, _webView.frame.size.width, _webView.frame.size.height - 20);
		_webView.frame = rect;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 * webページをロードする
 */
-(IBAction)loadButtonDidTap:(id)sender
{
	NSString *url =  @"http://localhost.ameba-oogiri.jp:8080/oogiri_web/boke";
	NSString *url2 = @"localhost.ameba-oogiri.jp:8080/oogiri_web/boke";
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	[_webView loadRequest:request];
}

#pragma mark - UIWebView Delegate

//ロード要求 a hrefタグをクリックしたとき、window.hrefに値が設定されたときなんかに呼ばれる
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSLog(@"shouldStartLoadWithRequest");
	return YES;
}

//ページ読み込み完了
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"webViewDidFinishLoad");
	//フリックのスクロールを速くする
	self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

@end
