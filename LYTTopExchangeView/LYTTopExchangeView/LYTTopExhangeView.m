//
//  LYTTopExhangeView.m
//  LYTTopExchangeView
//
//  Created by liuyuntian on 17/3/1.
//  Copyright © 2017年 333. All rights reserved.
//

#import "LYTTopExhangeView.h"
#import "LYTCollectionViewCell.h"

#define KTimeInterval 3.0f
#define MAXCOUNT      9999999

@interface LYTTopExhangeView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl    *pageControl;
@property (nonatomic,assign) NSInteger        currentPage;
@property (nonatomic,strong) NSTimer          *timer;

@end

@implementation LYTTopExhangeView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.frame.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[LYTCollectionViewCell class] forCellWithReuseIdentifier:@"LYTCollectionViewCell"];
        self.collectionView = collectionView;
        [self addSubview:collectionView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 100)*0.5, self.frame.size.height - 10, 100, 5)];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.pageControl.numberOfPages = dataArray.count > 1 ?dataArray.count:0;
    self.pageControl.currentPage = 0;
    self.currentPage = 0;
    [self.collectionView reloadData];
    
    if (dataArray.count < 2) return;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.currentPage = 0;
    [self initialTimer];
}

- (void)initialTimer {
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:KTimeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage:(NSTimer *)timer {
    if (self.dataArray.count < 2) return;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:++self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.pageControl.currentPage = self.currentPage % self.dataArray.count;
    NSLog(@"%ld",self.currentPage);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count > 1?MAXCOUNT:self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYTCollectionViewCell" forIndexPath:indexPath];
    [cell configuarWithStr:self.dataArray[indexPath.item % self.dataArray.count]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tapBlock)
    {
        self.tapBlock(indexPath.item);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = scrollView.contentOffset.x / self.frame.size.width;
    
    self.pageControl.currentPage = self.currentPage % self.dataArray.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 暂停定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 多少秒后恢复
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
}

////开启定时器
//- (void)timerStar
//{
//    [self.timer setFireDate:[NSDate distantPast]];
//}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
