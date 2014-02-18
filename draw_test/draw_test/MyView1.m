//
//  MyView1.m
//  draw_test
//
//  Created by 海野 秀祐 on 2013/07/13.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//
// ※メモリの扱いを勉強するためにMRCを使用している


#import "MyView1.h"

@implementation MyView1

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];

		// 画像をロード
		_image = [[UIImage imageNamed:@"basic.png"] retain];
    }
    return self;
}

-(void)dealloc
{
	// メモリの解放
	[_image release];

	[super dealloc];
}

-(void)drawRect:(CGRect)rect
{
	switch(self.tag){
		case 0:
			[self draw_test1];
			break;
		case 1:
			[self draw_test2];
			break;
		case 2:
			[self draw_test3];
			break;
		case 3:
			[self draw_test4];
			break;
	}
}

// 色の指定
-(void)setColor_r:(int)r g:(int)g b:(int)b {
	// システムに色を設定する
	[[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]set];
}

// 文字列の描画
-(void)drawString:(NSString*)string x:(float)x y:(float)y font:(UIFont*)font
{
	//[self setColor_r:100 g:100 b:100];
	[string drawAtPoint:CGPointMake(x,y) withFont:font];
}

// UIViewにテスト描画
-(void)draw_test1
{
	// フォント生成
	UIFont *font = [UIFont systemFontOfSize:24];

	// 文字の色の設定
	[self setColor_r:255 g:0 b:0];

	// 文字列の描画
	[self drawString:@"test" x:100.0f y:100.0f font:font];

	// 文字幅の取得
	CGSize size = [@"A" sizeWithFont:font];
	[self drawString:[NSString stringWithFormat:@"文字幅 %d %d",(int)size.width,(int)size.height] x:100.0f y:150.0f font:font];

	// 12どっとの文字列の描画
	font = [UIFont systemFontOfSize:12];
	[self drawString:@"12dot" x:100.0f y:200.0f font:font];

	// 16どっとの文字列の描画
	font = [UIFont systemFontOfSize:16];
	[self drawString:@"16dot" x:100.0f y:250.0f font:font];

	// 24どっとの文字列の描画
	font = [UIFont systemFontOfSize:24];
	[self drawString:@"24dot" x:100.0f y:300.0f font:font];

}



// Image描画
-(void)draw_test2
{
	// イメージの描画
	[_image drawAtPoint:CGPointMake(0, 0)];

	// イメージの拡大縮小描画
	[_image drawInRect:CGRectMake(0,160,_image.size.width * 2, _image.size.height * 2)];
}

// 
-(void)draw_test3
{

}

-(void)draw_test4
{

}

@end
