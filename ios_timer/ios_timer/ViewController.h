//
//  ViewController.h
//  ios_timer
//
//  Created by 海野 秀祐 on 2013/03/22.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSTimer *repeatTimer;

@property (nonatomic, strong) IBOutlet UILabel *label1;
@property (nonatomic, strong) IBOutlet UITextField *text1;
@property (nonatomic, strong) IBOutlet UISegmentedControl *seg1;

// Action
-(IBAction) buttonAction:(id)sender;


@property int timer_count;
@property int seg1_select;
@property NSTimer *timer1;

@end
