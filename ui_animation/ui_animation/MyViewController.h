//
//  MyViewController.h
//  ui_animation
//
//  Created by B02681 on 2014/01/28.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView* view1;
@property (nonatomic, strong) IBOutlet UIView* view2;


-(IBAction)button1DidTap:(id)sender;
-(IBAction)button2DidTap:(id)sender;

-(void)startAnimation:(id)sender;
@end
