//
//  ViewController.h
//  image_picker1
//
//  Created by 海野 秀祐 on 2013/07/28.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (retain, nonatomic) IBOutlet UIButton *buttonstart1;
- (IBAction)push_button1:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UIImageView *imageview1;

@end
