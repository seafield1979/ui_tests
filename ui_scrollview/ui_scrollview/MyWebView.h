//
//  MyWebView.h
//  ui_scrollview
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol subViewControllerDelegate;

@interface MyWebView : UIWebView
{
}
@property (nonatomic, strong) id <subViewControllerDelegate> delegate2;

@end

@protocol subViewControllerDelegate
-(void)helloDelegate;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
