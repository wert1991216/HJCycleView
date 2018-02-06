//
//  HJCycleView.h
//  test
//
//  Created by chen on 2018/2/6.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCycleView : UIView

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray*)dataArr;

@property (nonatomic,copy)void(^returnBlock)(NSInteger index);

@end
