//
//  ViewController1.m
//  test
//
//  Created by chen on 2017/12/19.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "ViewController1.h"
#import "HJCycleView.h"
@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * array = @[
                        @{@"image" :@"HomePage_0",@"title":@"第一个"},
                        @{@"image" :@"HomePage_1",@"title":@"第二个"},
                        @{@"image" :@"HomePage_2",@"title":@"第三个"},
                        @{@"image" :@"HomePage_3",@"title":@"第四个"}
                        ];
    HJCycleView *view = [[HJCycleView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height  -64) andData:array];
    view.backgroundColor = [UIColor redColor];
    view.returnBlock = ^(NSInteger index) {
        NSLog(@"点击了%ld",index);
    };
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
