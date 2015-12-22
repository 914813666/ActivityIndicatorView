
//
//  ZzVIew.m
//  转子1
//
//  Created by qzp on 15/12/16.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import "ZzView.h"


#define Radius 5 //半径
#define Distance  (16 + Radius) // 距离中心点距离
#define AnimationTime 0.1 //执行一次动画的时间

@interface ZzView ()

@property (nonatomic, strong) NSMutableArray * labels;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) NSMutableArray * currentScaleArray;
@property (nonatomic, strong) NSMutableArray * tmdArray;
@property (nonatomic, strong) NSArray * colors;

@property (nonatomic, strong) UILabel * textLabel;

@end

@implementation ZzView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame addColors:(NSArray *)colos {
    self = [super initWithFrame: frame];
    if (self) {
        _colors = colos;
        [self initializeUserInterface];
    }
    return self;
}

- (void) initializeUserInterface {
    _labels = [NSMutableArray array];
    _currentScaleArray = [NSMutableArray array];
    _tmdArray = [NSMutableArray array];
    
    CGFloat centerX = CGRectGetWidth(self.bounds)/2;
    CGFloat centerY = CGRectGetHeight(self.bounds)/2;
    //计算到45°角的位置距离
    /*
     x = y =  √￣(Distance * Distance/2)
     
     */
    CGFloat distance = sqrt(Distance * Distance/2);
    
    //    NSLog(@"%f",distance);
    
 
    
    for (NSInteger i = 0 ;i < 8; i++) {
        UIColor * cColor = _colors[i];
        UILabel * colorLabel = [self createCircleLabel: cColor];
     
        switch (i) {
            case 0: //右上
                colorLabel.center = CGPointMake(centerX + distance, centerY - distance);
                break;
                case 1: //右
                colorLabel.center = CGPointMake(centerX + Distance, centerY);
                break;
                case 2: //右下
                colorLabel.center = CGPointMake(centerX + distance, centerY + distance);
                break;
                case 3: //下
                colorLabel.center = CGPointMake(centerX, centerY + Distance);
                break;
                case 4: //左下
                colorLabel.center  = CGPointMake(centerX - distance, centerY + distance);
                break;
                case 5: //左
                colorLabel.center = CGPointMake(centerX - Distance , centerY);
                break;
                case 6: //左上
                colorLabel.center = CGPointMake(centerX - distance, centerY - distance);
                break;
                case 7: //上
                colorLabel.center = CGPointMake(centerX, centerY - Distance );
                break;
            default:
                break;
        }
        [self addSubview: colorLabel];
        [_labels addObject: colorLabel];
        
        
    }

    
    //将原来大小分配为0.5 - 1.2 线性变化
    //透明度为 0.5 - 1 线性变化
    CGFloat multiple = (1.2 - 0.5) / _labels.count;
    CGFloat tmd = 0.8 / _labels.count;
    
//    NSLog(@"multiple =%f",multiple);
//    NSLog(@"temd =%f",tmd);
    
    CGFloat currentScale = 0.5;
    CGFloat currentAlpha = 0.2;
    for (NSInteger i = 0; i < _labels.count; i++) {
        UILabel * cLabel = (UILabel *) _labels[i];
        cLabel.alpha = currentAlpha;
        cLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, currentScale, currentScale);
        
        currentAlpha =  tmd * i  + 0.3;
        currentScale = fabs(multiple * i + 0.5);
        
        NSLog(@"第%d个 currentAlpha =%f ,currentScale=%f",i+1,currentAlpha,currentScale);
        [_currentScaleArray addObject: [NSNumber numberWithFloat:currentScale]];
        [_tmdArray addObject: [NSNumber numberWithFloat: currentAlpha]];
    }
    
    
    CGFloat maxHeight = CGRectGetMaxY(((UILabel *)_labels[3]).frame);
    _textLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, maxHeight, CGRectGetWidth(self.bounds), 40)];
        label.numberOfLines = -1;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = _colors[0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.showText;
        [self addSubview: label];
        label;
    });
    

}



- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setShowText:(NSString *)showText {
    if (_textLabel) {
        _textLabel.text = showText;
    }
}

- (void)start {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:AnimationTime target:self selector:@selector(myStart) userInfo:nil repeats:YES];
}

/**
 *  开始
 */
- (void) myStart {
 
    [_currentScaleArray insertObject: _currentScaleArray[_currentScaleArray.count-1] atIndex:0];
    [_currentScaleArray removeLastObject];
    
    [_tmdArray insertObject: _tmdArray[_tmdArray.count - 1] atIndex: 0];
    [_tmdArray removeLastObject];
    
    for (NSInteger i = 0 ; i < _labels.count; i++) {
        UILabel * cLabel = (UILabel *) _labels[i];
        CGFloat currentScale = [_currentScaleArray[i] floatValue];
        cLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, currentScale, currentScale);
        cLabel.alpha = [_tmdArray[i] floatValue];
    }
}



/**
 *  结束动画
 */
- (void) stop {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    

}


- (UILabel *) createCircleLabel:(UIColor *) bgColor {
    UILabel * label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, Radius * 2, Radius *2);
    label.backgroundColor = bgColor;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = CGRectGetWidth(label.bounds)/2;
    return label;
}

@end
