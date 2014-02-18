//
//  GestureView.h
//  gesture_sample
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureView : UIView {
	NSMutableArray* touchPoints;
}
- (void) drawGestureLine:(NSMutableArray*)points;

@end
