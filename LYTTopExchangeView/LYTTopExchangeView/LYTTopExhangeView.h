//
//  LYTTopExhangeView.h
//  LYTTopExchangeView
//
//  Created by liuyuntian on 17/3/1.
//  Copyright © 2017年 333. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTTopExhangeView : UIView

@property (nonatomic,strong) NSArray    *dataArray;
@property (nonatomic,copy) void(^tapBlock)(NSInteger);

@end
