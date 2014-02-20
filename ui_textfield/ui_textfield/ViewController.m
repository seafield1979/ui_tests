//
//  ViewController.m
//  ui_textfield
//
//  Created by B02681 on 2014/02/20.
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
	
	_commentTextView.delegate = self;
	
	// 画像の表示モード設定(アスペクト比を維持したままimageViewに収まるようにリサイズ)
	[_bokeImageView setContentMode:UIViewContentModeScaleAspectFit];

	//角丸テスト
	_popupView.layer.cornerRadius = 10;
	_popupView.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -Action Method


-(IBAction)showButtonDidTap:(id)sender
{
	
	// 投稿画像の設定
	_bokeImageView.image = [UIImage imageNamed:@"cat.jpg"];
	
	// ポップアップを表示
	_popupView.frame = CGRectMake(10, 20+10, _popupView.frame.size.width, _popupView.frame.size.height);
	[self.view addSubview: _popupView];
	[_popupView setHidden:NO];
	
	//　textViewにフォーカスを当てる
	[_commentTextView becomeFirstResponder];
	
	[_textField logFrame];
}

/**
 * キャンセルボタンを押したときの処理
 * ポップアップを非表示にする
 */
-(IBAction)cancelButtonDidTap:(id)sender
{
	[_popupView setHidden: YES];
	[_popupView removeFromSuperview];
	
}

/**
 * 投稿ボタンを押したときの処理
 */
-(IBAction)postButtonDidTap:(id)sender
{
	[_popupView setHidden: YES];
	[_popupView removeFromSuperview];
	
	NSString *str = _commentTextView.text;
	_commentTextView.text = @"";
	
	NSLog(@"%@", str);
	
}


#pragma mark - UITextViewDelegate
/**
 * 文字入力時にコールされるデリゲートメソッド
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    int maxInputLength = 100;
	
    // 入力済みのテキストを取得
    NSMutableString *str = [_commentTextView.text mutableCopy];
	
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:text];
	
    if ([str length] > maxInputLength) {
        return NO;
    }
	
	_remainTextNum.text = [NSString stringWithFormat:@"%d", (maxInputLength - [str length])];
	
    return YES;
}

@end
