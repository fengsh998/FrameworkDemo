//
//  FKUIProgressView.m
//  SDProgressView
//
//  Created by fengsh on 16/6/12.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "FKUIProgressView.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@implementation FKUIProgressView

///设置进度0~1 之间
- (void)setProgressValue:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

// /设置需要显示的内容
- (void)setProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes
{
    CGFloat xCenter = CGRectGetMidX(self.frame);
    CGFloat yCenter = CGRectGetMidY(self.frame);
    
    // 判断系统版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        CGSize strSize = [text sizeWithAttributes:attributes];
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        [text drawAtPoint:CGPointMake(strX, strY) withAttributes:attributes];
    } else {
        CGSize strSize;
        NSAttributedString *attrStr = nil;
        if (attributes[NSFontAttributeName]) {
            strSize = [text sizeWithFont:attributes[NSFontAttributeName]];
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        } else {
            strSize = [text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]}];
        }
        
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        
        [attrStr drawAtPoint:CGPointMake(strX, strY)];
    }
}

@end


@implementation FKUIPieProgressView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = CGRectGetMidX(rect);
    CGFloat yCenter = CGRectGetMidY(rect);
    
    //以最短边矩-10作为圆的半径
    CGFloat radius = MIN(xCenter, yCenter) - 10.0;
    
    // 背景圆
    [RGBA(240, 240, 240, 1) set];
    
    CGFloat w = radius * 2 + 4;
    CGFloat h = w;
    CGFloat x = (xCenter - w) * 0.5;
    CGFloat y = (yCenter - h) * 0.5;
    
    //绘一个宽高相等的椭圆即圆,(位置为x,y)
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
    CGContextFillPath(ctx);
    
    // 进程圆
    [RGBA(150, 150, 150, 0.8) set];
    
    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 1);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

@end

