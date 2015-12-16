//
//  ViewController.m
//  转子1
//
//  Created by qzp on 15/12/16.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = [NSMutableArray array];
    for (NSInteger i = 1; i <= 16; i++) {
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld",(long)i]];
        [_dataSource addObject: img];
    }
    
    self.imageView.animationImages = self.dataSource;
    self.imageView.animationDuration = 1;
    self.imageView.animationRepeatCount = -1;
    [self.imageView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
