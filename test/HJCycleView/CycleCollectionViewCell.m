//
//  CycleCollectionViewCell.m
//  test
//
//  Created by chen on 2018/2/6.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "CycleCollectionViewCell.h"

@implementation CycleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _image.layer.shadowColor = [UIColor grayColor].CGColor;
    _image.layer.shadowOpacity = 0.8; // 透明度
    _image.layer.shadowOffset = CGSizeMake(0, 5);
    _image.layer.shadowRadius = 5.0;
    _image.clipsToBounds = NO;
}

-(void)setDataDict:(NSDictionary *)dataDict{
    [_image setImage:[UIImage imageNamed:[dataDict objectForKey:@"image"]]];
    _title.text = [dataDict objectForKey:@"title"];
}

@end
