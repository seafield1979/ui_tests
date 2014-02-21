//
//  MyViewController.m
//  ui_scrollview
//
//  Created by B02681 on 2014/01/23.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "MyViewController.h"
#import "MyWebView.h"

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

-(void)buttonDidTap: (id)sender
{
	NSLog(@"tap");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.nintendo.co.jp"]];
	[_webView loadRequest:request];
	_webView.userInteractionEnabled=YES;
	
	_webView.delegate2 = self;
	// 生成例
#if 0
	// サイズを指定した生成例
	UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	sv.contentSize = CGSizeMake(1000, 100);
	sv.backgroundColor = [UIColor redColor];
	[_scrollViewArea addSubview:sv];
	
	// viewを追加
	for(int i=0; i<10; i++){
		UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
		NSString *str = [NSString stringWithFormat:@"button %d", (i+1)];
		NSString *str2 = [NSString stringWithFormat:@"button %d *", (i+1)];
		[button setTitle:str forState:UIControlStateNormal];
		[button setTitle:str2 forState:UIControlStateHighlighted];
		button.frame = CGRectMake(100*i, 10, button.frame.size.width, button.frame.size.height);
//		button.backgroundColor = [UIColor blueColor];
		[button addTarget:self action:@selector(buttonDidTap:) forControlEvents:UIControlEventTouchUpInside];

		[sv addSubview:button];
	}
#endif
	
	
	// スクロールビュー例文
#if 0
	UIScrollView *sv2 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	sv2.backgroundColor = [UIColor cyanColor];
	
	UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
	[sv2 addSubview:uv];
	sv2.contentSize = uv.bounds.size;
	[self.view addSubview:sv2];
	
	NSLog(@"%f %f %f %f", sv2.frame.size.width, sv2.frame.size.height, sv2.contentSize.width, sv2.contentSize.height);
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)helloDelegate
{
	NSLog(@"helloDelegate");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//    CGPoint location = [[touches anyObject] locationInView:self.superview];
    NSLog(@"TouchesBegan");
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"TouchesEnded");
//	for(UITouch *touch in touches){
//		NSLog(@"%@", touch);
//	}
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //必要であればevantをチェック
    //superのメソッド呼び出し前後で処理を行う。
	
    UIView  *v = [_webView hitTest:point withEvent:event];
	
    //vは実際にイベントに応答するオブジェクト。イベントを横取りするのでなければvを返す。
	
    return v;
}

@end
