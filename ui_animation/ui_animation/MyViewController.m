//
//  MyViewController.m
//  ui_animation
//
//  Created by B02681 on 2014/01/28.
//  Copyright (c) 2014年 B02681. All rights reserved.
//
/**
	UIViewのサブクラスなら以下の方法でアニメーションができる
	
-(void)startAnimation:(id)sender{
	UIView *view = (UIView *)sender;

	//アニメーションの対象となるコンテキスト
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	//アニメーションを実行する時間
	[UIView setAnimationDuration:1.0];
	//アニメーションイベントを受け取るview
	[UIView setAnimationDelegate:self];
	//アニメーション終了後に実行される
	[UIView setAnimationDidStopSelector:@selector(endAnimation)];

	//TODO:
	ここにアニメーション後のviewの状態を設定する1
	
	// アニメーション開始
	[UIView commitAnimations];
}
 
 */

#import "MyViewController.h"

@interface MyViewController ()
{
	int _mode;
}
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

-(IBAction)button1DidTap:(id)sender
{
	[self startAnimation:_view1];
}

-(IBAction)button2DidTap:(id)sender
{
	[self startAnimation2:_view2];
}


#pragma mark - Animation

-(void)startAnimation:(id)sender{
	UIView *view = (UIView *)sender;
	
	//アニメーションの対象となるコンテキスト
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	//アニメーションを実行する時間
	[UIView setAnimationDuration:1.0];
	//アニメーションイベントを受け取るview
	[UIView setAnimationDelegate:self];
	//アニメーション終了後に実行される
	[UIView setAnimationDidStopSelector:@selector(endAnimation)];
	
	//TODO:
	//-----------------------------------
	CGRect rect = [view frame];
	if(_mode == 0){
		rect.origin.y = 300;
		view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
	}
	else{
		view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
		rect.origin.y = 100;
	}
	_mode = (_mode + 1)%2;
	[view setFrame:rect];
	//------------------------------------
	
	// アニメーション開始
	[UIView commitAnimations];
}



-(void)startAnimation2:(id)sender{
	UIView *view = (UIView *)sender;

	//アニメーションの対象となるコンテキスト
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	//アニメーションを実行する時間
	[UIView setAnimationDuration:1.0];
	//アニメーションイベントを受け取るview
	[UIView setAnimationDelegate:self];
	//アニメーション終了後に実行される
	[UIView setAnimationDidStopSelector:@selector(endAnimation)];

	//TODO:
	//-----------------------------------
	CGRect rect = [view frame];
	if(_mode == 0){
		rect.origin.y = 100;
	}
	else{
		rect.origin.y = 0;
	}
	_mode = (_mode + 1)%2;
	[view setFrame:rect];
	//------------------------------------

	// アニメーション開始
	[UIView commitAnimations];
}


-(void)endAnimation
{
	NSLog(@"enAnimation!!");
}

@end
