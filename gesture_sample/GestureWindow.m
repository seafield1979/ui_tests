//
//  GestureWindow.m
//  gesture_sample
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//


#import "GestureWindow.h"

@implementation GestureWindow

@synthesize wView, delegate;

-(void) dealloc {
}

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
	
    if (wView == nil || delegate == nil) {
        return;
    }
    // 2本指でのマルチタッチか
    NSSet *touches = [event allTouches];
//    if (touches.count != 2) {
//        return;
//    }
//
    UITouch *touch = touches.anyObject;
	NSLog(@"aaaaaaaaa %@", touch);
    // 指定のUIWebViewへのタッチか
//    if ([touch.view isDescendantOfView:wView] == NO) {
//        return;
//    }
	
    switch (touch.phase) {
        case UITouchPhaseBegan:
			NSLog(@"touch began");
//            if ([self.delegate
//                 respondsToSelector:@selector(touchesBeganWeb:withEvent:)]) {
//                [self.delegate
//				 performSelector:@selector(touchesBeganWeb:withEvent:)
//				 withObject:touches withObject:event];
//            }
            break;
        case UITouchPhaseMoved:
				NSLog(@"touch moved");
//            if ([self.delegate
//                 respondsToSelector:@selector(touchesMovedWeb:withEvent:)]) {
//                [self.delegate
//				 performSelector:@selector(touchesMovedWeb:withEvent:)
//				 withObject:touches withObject:event];
//            }
            break;
        case UITouchPhaseEnded:
						NSLog(@"touch ended");
//            if ([self.delegate
//                 respondsToSelector:@selector(touchesEndedWeb:withEvent:)]) {
//                [self.delegate
//				 performSelector:@selector(touchesEndedWeb:withEvent:)
//				 withObject:touches withObject:event];
//            }
			break;
        default:
			NSLog(@"touch else");
            return;
            break;
    }
}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
//
@end