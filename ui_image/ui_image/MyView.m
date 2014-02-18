//
//  MyView.m
//  ui_image
//
//  Created by B02681 on 2014/02/17.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "MyView.h"

@implementation MyView
{
	UIImage *_image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self){
		_image = [UIImage imageNamed:@"cat.jpg"];
	}
	return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
	// 色を定義
    CGFloat green[4] = {0.0f, 1.0f, 0.0f, 1.0f};
	
	// イメージの拡大縮小描画
//	[_image drawInRect:CGRectMake(0, 0,_image.size.width * 2, _image.size.height * 2)];
	[_image drawInRect:CGRectMake(0, 0, 160, 160)];

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// 矩形を描画
    CGContextSetFillColor(context, green);
    CGContextFillRect(context, CGRectMake(50, 50, 50, 50));
	
	
	// テキスト描画
	{
		// 描画モード
		CGContextSetTextDrawingMode(context, kCGTextFill); // This is the default
		// 描画
		UIFont *font = [UIFont fontWithName:@"Helvetica" size:19];
		CGPoint point = CGPointMake(50,50);
		// フォント、色を指定して文字列を描画
		[@"Some text"   drawAtPoint: point
					 withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor yellowColor]}];
	}
}
*/



@end
