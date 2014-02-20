//
//  ViewController.h
//  ui_textfield
//
//  Created by B02681 on 2014/02/20.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate>


@property (nonatomic) IBOutlet UIView *popupView;
@property (nonatomic) IBOutlet UITextField *textField;

@property (strong) IBOutlet UIButton *cancelButton;
@property (strong) IBOutlet UIButton *postButton;
@property (strong) IBOutlet UIImageView *bokeImageView;
@property (strong) IBOutlet UITextView *commentTextView;


/// 残り入力可能文字数
@property (strong) IBOutlet UILabel *remainTextNum;


-(IBAction)showButtonDidTap:(id)sender;
-(IBAction)cancelButtonDidTap:(id)sender;
-(IBAction)postButtonDidTap:(id)sender;


@end
