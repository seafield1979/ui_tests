//
//  MyWebView.m
//  ui_scrollview
//
//  Created by B02681 on 2014/02/07.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView
{
	UIView *_responderView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//-(void)setDelegate2:(id<subViewControllerDelegate>)delegate
//{
//	self.delegate2 = delegate;
//}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    _responderView = [super hitTest:point withEvent:event];//capture the view which actually responds to the touch events
	
	NSLog(@"hitTest %@", _responderView);
	
	return self;//pass self so that the touchesBegan,touchesMoved and other    events will be routed to this class itself
	
}
//-(void)setDelegate:(id<subViewControllerDelegate>)delegate
//{
//	self.delegate = delegate;
//}

//override touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//[ _responderView touchesBegan:touches  withEvent:event];
	[self.delegate2 touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.delegate2 touchesEnded:touches withEvent:event];
}


@end
