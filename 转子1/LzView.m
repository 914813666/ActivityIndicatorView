//
//  LzView.m
//  转子1
//
//  Created by qzp on 16/1/11.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "LzView.h"


@interface LzView ()
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) CAReplicatorLayer * replicatorLayer;

@end

@implementation LzView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [self initializeUserInterface];
        [self animation];
    }
    return self;
}

- (void) initializeUserInterface {
    
    _imageView = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        [self addSubview: imgView];
        imgView;
    });
    
    _replicatorLayer = ({
        CAReplicatorLayer * rlayer = [ CAReplicatorLayer layer];
        rlayer.bounds = self.bounds;
        rlayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        rlayer.preservesDepth = YES;
        [rlayer addSublayer: _imageView.layer];
        [self.layer addSublayer: rlayer];
        rlayer;
    });
 }

- (void) animation {
    
    _imageView.frame = CGRectMake(CGRectGetWidth(self.bounds)/3, CGRectGetHeight(self.bounds)/3, 10, 10);
//  _imageView.frame = CGRectMake(250, 250, 20, 20);
    _imageView.backgroundColor = [UIColor colorWithRed:0.0 green:0.502 blue:0.502 alpha:1.0];
    _imageView.layer.cornerRadius = CGRectGetHeight(_imageView.bounds)/2;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.transform = CATransform3DMakeScale(0.01, 0.2, 0.2);
    
    CGFloat count = 10;
    _replicatorLayer.instanceDelay = 1.0 / count;
    _replicatorLayer.instanceCount = count;
    
    //相对于_replicatorLayer.position旋转
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI * 2 / count, 0, 0, 1);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath: @"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = @1;
    animation.toValue = @0.01;
    
    [_imageView.layer addAnimation: animation forKey: nil];
    
    
    
    

}
@end
