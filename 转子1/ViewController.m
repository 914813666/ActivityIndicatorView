//
//  ViewController.m
//  转子1
//
//  Created by qzp on 15/12/16.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import "ViewController.h"
#import "ZzView.h"
#define  RGBA(r,g,b,a)  [UIColor colorWithRed: r /255.0 green: g / 255.0 blue: b /255.0 alpha:a]
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray * dataSource;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@property (nonatomic, strong) ZzView * zv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView.hidden = YES;
    
    _dataSource = [NSMutableArray array];
    for (NSInteger i = 1; i <= 16; i++) {
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld",(long)i]];
        [_dataSource addObject: img];
    }
   
    
    self.imageView.animationImages = self.dataSource;
    self.imageView.animationDuration = 1;
    self.imageView.animationRepeatCount = -1;
    [self.imageView startAnimating];
    
    NSArray * colors = @[RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1),
                         RGBA(253.0,133.0,135,1)];
    
    
    NSArray * colors2 = @[RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1),
                         RGBA(112.0,196.0,245.0,1)];
    
    NSArray * colors3 = @[[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0] ,
                          [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0],
                          [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0],
                          [UIColor colorWithRed:0.6 green:0.4 blue:0.2 alpha:1.0],
                          [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0]];
    
    _zv =({
        ZzView * zv = [[ZzView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds)) addColors:colors];
        [self.view addSubview: zv];
        zv;
    });

    
    
    ZzView * zv2 = [[ZzView alloc] initWithFrame: CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 200) addColors: colors3];
//    zv2.backgroundColor = [UIColor grayColor];
    [zv2 start];
    [self.view addSubview: zv2];
    
    
//    ZzView * zv3 = [[ZzView alloc] initWithFrame: CGRectMake(0, 400, 100, 100) addColors:colors3];
//    [self.view addSubview: zv3];
//    [zv3 start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender == _startBtn) {
        [_zv start];
    }
    else if (sender == _stopBtn) {
        [_zv stop];
    }
}


@end
