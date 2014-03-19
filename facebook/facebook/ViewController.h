//
//  ViewController.h
//  facebook
//
//  Created by B02681 on 2014/02/26.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Facebook.h"

@interface ViewController : UIViewController <FBRequestDelegate, FBDialogDelegate, FBSessionDelegate>
@property (nonatomic)Facebook *facebook;
@property (nonatomic) IBOutlet UITextView *textView;

-(IBAction)loginButtonDidTap:(id)sender;
-(IBAction)fbButtonDidTap:(id)sender;
-(IBAction)fbButton2DidTap:(id)sender;
-(IBAction)fbButton3DidTap:(id)sender;
@end
