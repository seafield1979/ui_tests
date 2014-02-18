//
//  ViewController.h
//  ui_image
//
//  Created by B02681 on 2014/02/17.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet MyView *myView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;


-(IBAction)draw1DidTap:(id)sender;
-(IBAction)draw2DidTap:(id)sender;
-(IBAction)draw3DidTap:(id)sender;


@end
