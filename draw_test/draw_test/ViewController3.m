//
//  ViewController3.m
//  draw_test
//
//  Created by 海野 秀祐 on 2013/07/13.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//
// ボタンの作成
//  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//  その後 button に対し座標やテキストを設定する
//
// UITextViewの作成
//  UITextView *textView = [[UITextView alloc] init];
//  その後 textViewに対し座標やテキスト、キーボードのタイプ等を設定する
//
// SubViewを登録する
//  [self.view addSubView:add_view];
//
// タグを設定する
// [button setTag:tag_no];
//
// アクションを設定する
// [button addTarget:self action:@selector(clickButton:)
//					forControlEvents:UIControlEventTouchUpInside];
//

#import "ViewController3.h"

#define BTN_START	0
#define BTN_END		1
#define BTN_SHOW	2
#define BTN_SHOW2	3

@interface ViewController3 ()

@end

@implementation ViewController3



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Third", @"Thirda");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// ビューの生成
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
	view.backgroundColor = [UIColor darkGrayColor];
	[self.view addSubview:view];

	// テキストビューの生成
	_textView = [self makeTextView:CGRectMake(1, 1, 298, 98) text:@""];
	[_textView setDelegate:self];
	[view addSubview:_textView];

	// 編集開始ボタンの生成
	UIButton* btnStart = [self makeButton:CGRectMake(0, 110, 90, 40) text:@"編集開始" tag:BTN_START];
	[view addSubview:btnStart];

	// 編集完了ボタンの生成
	UIButton *btnEnd = [self makeButton:CGRectMake(100, 110, 90, 40) text:@"編集完了" tag:BTN_END];
	[view addSubview:btnEnd];

	// 表示ボタンの生成
	UIButton *btnShow = [self makeButton:CGRectMake(200, 110, 90, 40) text:@"表示" tag:BTN_SHOW];
	[view addSubview:btnShow];


	// スライダーの生成
	_slider = [[UISlider alloc]init];
	[_slider setFrame:CGRectMake(0, 150, 250, 32	)];
	[_slider setMinimumValue:0];
	[_slider setMaximumValue:100];
	[_slider setValue:50];
	[view addSubview:_slider];

	[_slider addTarget:self action:@selector(changeSliderValue:) forControlEvents:UIControlEventValueChanged];

	// ラベルの生成
	_label = [[UILabel alloc]init];
	[_label setFrame:CGRectMake(250, 150, 100, 32)];
	[_label setTextColor:[UIColor whiteColor]];
	[_label setBackgroundColor:[UIColor darkGrayColor]];
	[_label setText:@""];
	[view addSubview:_label];

	// スイッチの生成
	_switch = [[UISwitch alloc]init];
	[_switch setFrame:CGRectMake(0, 232, 200, 32)];
	[_switch setOn:YES];
	[view addSubview:_switch];

	// 表示ボタンの生成
	//UIButton *btnShow2 = [self makeButton:CGRectMake(0, 200, 90, 40) text:@"表示" tag:BTN_SHOW2];
	//[view addSubview:btnShow2];
}

// ボタンクリック時のイベント処理
-(void)clickButton:(UIButton*)sender
{
	switch(sender.tag){
		case BTN_START:
			[_textView becomeFirstResponder];
			break;
		case BTN_END:
			[_textView resignFirstResponder];
			break;
		case BTN_SHOW:
			[self showAlert:@"" text:[NSString stringWithFormat:@"テキストビューの文字列\n%@",_textView.text]];
			break;
		case BTN_SHOW2:
			{
				NSString *switchON = _switch.on ? @"ON" : @"OFF";
				[self showAlert:@""
					text:[NSString stringWithFormat:@"switch %@ slider %d",switchON, (int)_slider.value]];
				break;
			 }
	}
}

// スライダーの値がかわったときに呼ばれる
-(IBAction) changeSliderValue:(UISlider*)sender
{
	//NSLog(@"%d", (int)sender.value);
	[_label setText:[NSString stringWithFormat:@"%d", (int)sender.value]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// アラートの表示
-(void)showAlert:(NSString*)title text:(NSString*)text {
	UIAlertView *alert = [[UIAlertView alloc]
						   initWithTitle:title
						   message:text delegate:self
						   cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

// テキストビューの表示
-(UITextView*)makeTextView:(CGRect)rect text:(NSString*)text {
	UITextView *textView = [[UITextView alloc] init];
	[textView setFrame:rect];
	[textView setText:text];
	[textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
	[textView setKeyboardType:UIKeyboardTypeDefault];
	[textView setReturnKeyType:UIReturnKeyDefault];
	return textView;
}

// テキストボタンの生成
-(UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setFrame:rect];
	[button setTitle:text forState:UIControlStateNormal];
	[button setTag:tag];
	[button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
	return button;
}

//-----------------------------------------------------------------
// UITextViewDelegate
//-----------------------------------------------------------------
// テキスト変更時に呼ばれる
// UITextViewのデリゲートメソッド
-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	// 最大140文字制限
	if (text.length > 0 && textView.text.length + text.length > 140) {
		return NO;
	}
	return YES;
}

// 選択変更時に呼ばれるデリゲートメソッド
// カーソル位置が変化した際に呼ばれるもよう
-(void)textViewDidChangeSelection:(UITextView *)textView
{
	NSLog(@"textViewDidChangeSelection");
}

@end
