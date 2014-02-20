//
//  UIView+Debug.m
//  ui_textfield
//
//  Created by B02681 on 2014/02/20.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "UIView+Debug.h"

@implementation UIView (Debug)

-(void)logFrame
{
	CGRect frame = self.frame;
	NSLog(@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}
@end
