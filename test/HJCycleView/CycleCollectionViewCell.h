//
//  CycleCollectionViewCell.h
//  test
//
//  Created by chen on 2018/2/6.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) NSDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;
@end
