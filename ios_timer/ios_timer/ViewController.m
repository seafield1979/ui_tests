//
//  ViewController.m
//  ios_timer
//
//  Created by 海野 秀祐 on 2013/03/22.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label1 = _label1;
@synthesize text1 = _text1;
@synthesize seg1 = _seg1;

@synthesize timer_count = _timer_count;
@synthesize seg1_select = _seg1_select;
@synthesize timer1 = _timer1;

//
// 	指定時間経過後、連続して指定メソッドがコールされ、停止メッセージを受け付けるまで停止しないタイマーを起動する。
//



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_seg1.selectedSegmentIndex = 1;
}

//
// タイマー初期化、開始
//
- (void)initTimer
{
	//userInfo タイマーのイベントが発生した時に呼び出されるメソッド内で利用するデータを作成する。
	NSDictionary *userInfo =[NSDictionary dictionaryWithObjectsAndKeys:
							 @"my value is 1",@"key1",
							 @"my value is 2",@"key2",
							 @"my value is 3",@"key3",
							 nil
							 ];

	//自動でタイマーはスタートします。
	_timer1 = [NSTimer
			   //タイマーイベントを発生させる感覚。「1.5」は 1.5秒 型は float
			   scheduledTimerWithTimeInterval:1.0
			   //呼び出すメソッドの呼び出し先(selector) self はこのファイル(.m)
			   target:self
			   //呼び出すメソッド名。「:」で自分自身(タイマーインスタンス)を渡す。
			   //インスタンスを渡さない場合は、「timerInfo」
			   selector:@selector(timerInfo:)
			   //呼び出すメソッド内で利用するデータが存在する場合は設定する。ない場合は「nil」
			   userInfo:userInfo
			   //上記で設定した秒ごとにメソッドを呼び出す場合は、「YES」呼び出さない場合は「NO」
			   repeats:YES
			   ];

	//タイマーを開始、再開する場合
	[_timer1 fire];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//呼び出しメソッド
-(void) timerInfo:(NSTimer *)timer
{
	_timer_count++;
	NSDictionary *dic = [timer userInfo];
	NSString *key = [NSString stringWithFormat:@"key%d", _timer_count];
	if([dic objectForKey:key]){
		NSLog(@"timer %@", [dic objectForKey:key]);
	}

	NSString *str = [NSString stringWithFormat:@"%d", _timer_count];
	[_label1 setText:str];
	[_text1 setText:str];
}



// Action
-(IBAction) buttonAction:(id)sender
{
	if(_seg1.selectedSegmentIndex == 1){
		_seg1_select = 1;
		//タイマーを停止したい場合
		[_timer1 invalidate];
		NSLog(@"Timer Status : %d",[_timer1 isValid]);
	}
	else {
		_seg1_select = 0;
		//タイマーを開始、再開する場合
		[self initTimer];
		NSLog(@"Timer Status : %d",[_timer1 isValid]);

	}
	NSLog(@"segment:%d", _seg1.selectedSegmentIndex);
}


@end
