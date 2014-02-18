//
//  ViewController3.h
//  draw_test
//
//  Created by 海野 秀祐 on 2013/07/13.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController3 : UIViewController <UITextViewDelegate>
{
	UITextView *_textView;
	UISlider *_slider;
	UISwitch *_switch;
	UILabel *_label;
}

-(IBAction)clickButton:(UIButton*)sender;
@end
