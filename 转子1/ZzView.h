//
//  ZzVIew.h
//  转子1
//
//  Created by qzp on 15/12/16.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzView : UIView

@property (nonatomic, strong) NSString * showText;
/**
 *  初始化
 *
 *  @param frame 位置
 *  @param colos 8个颜色，从右上开始顺时针方向
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame addColors:(NSArray<UIColor *>*) colos;

- (void) start;
- (void) stop;
@end
