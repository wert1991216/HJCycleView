//
//  HJCycleView.m
//  test
//
//  Created by chen on 2018/2/6.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "HJCycleView.h"
#import "CycleCollectionViewCell.h"

#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height

@interface HJCycleView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    NSInteger _currentIndex;
    NSTimer *_timer;
}

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation HJCycleView

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray*)dataArr{
    if (self = [super initWithFrame:frame]) {
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        [self.dataArr insertObject:[dataArr lastObject] atIndex:0];
        [self.dataArr addObject:dataArr[0]];
        _currentIndex = 1;
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        _currentIndex++;
        if (_currentIndex == _dataArr.count - 1) {
            _currentIndex = 1;
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        _pageControl.currentPage = _currentIndex - 1;
    }];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

#pragma mark delegate && dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CycleCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCollectionViewCell" forIndexPath:indexPath];
    cell.dataDict = [_dataArr objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.returnBlock) {
        self.returnBlock(_currentIndex);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x > kSelfWidth * (_dataArr.count - 2)) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (scrollView.contentOffset.x < kSelfWidth) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArr.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    _currentIndex = scrollView.contentOffset.x /kSelfWidth - 1;
    _pageControl.currentPage = _currentIndex;
    [_timer setFireDate:[NSDate date]];
}

#pragma mark getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kSelfWidth, kSelfHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSelfWidth, kSelfHeight) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"CycleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CycleCollectionViewCell"];
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kSelfHeight+self.frame.origin.y - 100, kSelfWidth, 10)];
        _pageControl.currentPage = 1;
        _pageControl.numberOfPages = self.dataArr.count - 2;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
