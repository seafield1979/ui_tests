//
//  GestureWindow.h
//  gesture_sample
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureWindowDelegate

- (void) touchesBeganWeb:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMovedWeb:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEndedWeb:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface GestureWindow : UIWindow {
    UIWebView* wView;
//    id delegate;
}

@property (nonatomic, retain) UIWebView* wView;
@property (nonatomic, assign) id delegate;

@end