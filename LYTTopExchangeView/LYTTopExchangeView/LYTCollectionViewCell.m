//
//  LYTCollectionViewCell.m
//  LYTTopExchangeView
//
//  Created by liuyuntian on 17/3/1.
//  Copyright © 2017年 333. All rights reserved.
//

#import "LYTCollectionViewCell.h"

@interface LYTCollectionViewCell ()

@property (nonatomic,strong) UIImageView    *imageView;

@end

@implementation LYTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)configuarWithStr:(NSString *)str
{
    self.imageView.image = [UIImage imageNamed:str];
}

@end
