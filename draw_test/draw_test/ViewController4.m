//
//  ViewController4.m
//  draw_test
//
//  Created by 海野 秀祐 on 2013/07/13.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import "ViewController4.h"
#import "SBJson.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"Fourth", @"Fourth");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// WEBビューの生成
	_webView = [self makeWebView:self.view.frame];
	[_webView setDelegate:self];
	[self.view addSubview:_webView];

	// インジケーターの表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	// WEB上のHTMLの読み込み
	[self webView:_webView res:@"basic.html"];
	//[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://npaka.net"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// WEBビューの生成
-(UIWebView*)makeWebView:(CGRect)rect {
	// WEBビューの生成
	UIWebView *webView = [[UIWebView alloc]init];
	[webView setFrame:rect];
	[webView setBackgroundColor:[UIColor blackColor]];
	[webView setScalesPageToFit:NO];

	// ビューのサイズ自動調整
	webView.autoresizingMask =
			UIViewAutoresizingFlexibleWidth |
			UIViewAutoresizingFlexibleHeight |
			UIViewAutoresizingFlexibleLeftMargin |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin |
			UIViewAutoresizingFlexibleBottomMargin;
	return webView;
}

// 文字列の前方一致検索
-(int)indexOf:(NSString*)str c:(NSString*)c {
	NSRange range = [str rangeOfString:c];
	if (range.location == NSNotFound) return -1;
	return range.location;
}

// HTML読み込み開始時に呼ばれる
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSString *scheme = [[request URL]scheme];
	NSString *url = [[request URL]relativeString];
	NSURL *nsurl = [request URL];

	// クリック時
	if(navigationType == UIWebViewNavigationTypeLinkClicked ||
	   navigationType == UIWebViewNavigationTypeFormSubmitted)
	{
		// 通信中は再度URLジャンプさせない
		if([UIApplication sharedApplication].networkActivityIndicatorVisible){
			return NO;
		}

		// リクエストからURL文字列取得
		NSLog(@"scheme>%@",scheme);
		NSLog(@"url>%@",url);

		// メーラーの起動
		if ([self indexOf:url c:@"mailto:"]==0){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
		}

		// ページ内リンクのときはインジケーターを表示しない
		if ([self indexOf:url c:@"#"]>=0) {
			return YES;
		}

		// インジケーターの表示
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	}
	// javascriptからのメソッド呼び出し
	if ([[nsurl scheme] isEqualToString:@"webview"]) {
		NSRange del_range = [url rangeOfString:[NSString stringWithFormat:@"%@://", scheme]];
		NSMutableString *murl = [[NSMutableString alloc]initWithString:url];
		[murl deleteCharactersInRange:del_range];
		NSLog(@"params:%@", murl);

		NSArray *param_array = [murl componentsSeparatedByString:@"?"];
		NSString* method = [param_array objectAtIndex:0];
		NSString* params = [param_array objectAtIndex:1];
		//decoding
		//decoding
		NSString *decoded_params
		= [params stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"%@", decoded_params);
		SBJsonParser *parser = [[SBJsonParser alloc]init];
		NSArray *decoded_params_array = [parser objectWithString:decoded_params];

		// メソッドをコール
		[self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:", method]) withObject:decoded_params_array];
		return NO;
	}

	// jsonパーステスト
//	NSString *json_string = @"{\"aaa\":\"100\", \"bbb\":\"200\", \"ccc\": {\"ddd\":300}}";
//	SBJsonParser *parser = [[SBJsonParser alloc]init];
//	NSDictionary *jsonDic = [parser objectWithString:json_string];
//	NSDictionary *ccc = [jsonDic objectForKey:@"ccc"];
//
//	NSLog(@"%@ %@ %@", [jsonDic objectForKey:@"aaa"], [jsonDic objectForKey:@"bbb"], [ccc objectForKey:@"ddd"]);

	return YES;
}

// HTML読み込み成功時に呼ばれる
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	// インジケーターの非表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// HTML読み込み失敗時に呼ばれる
-(void)webView:(UIWebView*)webView didFailLoadWithError:(NSError *)error
{
	// インジケーターの非表示
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	// アラート
	[self showAlert:@"" text:@"通信失敗しました"];
}


// リソースからHTMLを読み込み
-(void)webView:(UIWebView*)webView res:(NSString*)res {
	NSString *file = [[NSBundle mainBundle]pathForResource:res ofType:@""];
	NSData	*data = [NSData dataWithContentsOfFile:file];
	NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	NSString *path = [[NSBundle mainBundle]resourcePath];
	path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
	path = [path stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	path = [NSString stringWithFormat:@"file:/%@//",path];
	[_webView loadHTMLString:html baseURL:[NSURL URLWithString:path]];
}


// 画面を端末の向きに会わせて回転
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

// アラートの表示
-(void)showAlert:(NSString*)title text:(NSString*)text {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title
						  message:text delegate:self
						  cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}


// javascriptのメソッド
-(void)dosample:(NSArray*)params
{
	NSDictionary *param1 = [params objectAtIndex:0];
	int val1 = [[param1 objectForKey:@"aaa"] intValue];
	NSLog(@"dosample:%d", val1);
}

@end
