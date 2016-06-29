//
//  FKUIProgressView.h
//  SDProgressView
//
//  Created by fengsh on 16/6/12.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIProgressViewInterface <NSObject>

///设置进度0~1 之间
- (void)setProgressValue:(CGFloat)progress;
// /设置需要显示的内容
- (void)setProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes;

@end

@interface FKUIProgressView : UIView<UIProgressViewInterface>
///进度值:0~1
@property (nonatomic,readonly)              CGFloat                 progress;
///进度条背影色
@property (nonatomic,readonly)              UIColor                 *progressBackgroudColor;
///进度条填充色

@end


@interface FKUIPieProgressView : FKUIProgressView

@end