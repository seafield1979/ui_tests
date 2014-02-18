//
//  ViewController.h
//  gesture_sample
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gesturewindow.h"
#import "GestureView.h"

#define GESTURE_LENGTH  50
#define BLUR_LENGTH     50
#define PINCH_DELTA     100

@interface ViewController : UIViewController <GestureWindowDelegate> {
    UIWebView* webView;
	UIView *view;
    GestureView* gestureView;
    NSMutableArray* touchPoints;
    CGFloat initDistance;
}

@end
