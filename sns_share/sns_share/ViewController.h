//
//  ViewController.h
//  sns_share
//
//  Created by B02681 on 2014/02/14.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

-(IBAction)downloadImageDidTap:(id)sender;

-(IBAction)actionSheetDidTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

@end
