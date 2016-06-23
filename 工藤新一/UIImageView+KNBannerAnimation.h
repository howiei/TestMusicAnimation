//
//  UIImageView+KNBannerAnimation.h
//  工藤新一
//
//  Created by JobsHowie on 16/6/23.
//  Copyright © 2016年 KeNan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+KNFadeAnimation.h"


@interface UIImageView (KNBannerAnimation)

/**
 *  设置后停止动画
 */
@property (nonatomic, assign) BOOL stop;

/**
 *  每次切换图片的动画时长1.5~2.5
 */
@property (nonatomic, assign) NSTimeInterval fadeDuration;

/**
 *  轮播图片数组
 */
@property (nonatomic, strong) NSArray * bannerImages;


- (void)fadeBanner;
- (void)fadeBannerWithImages: (NSArray *)images;
- (void)stopBanner;

@end
