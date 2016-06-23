//
//  KNViewController.m
//  工藤新一
//
//  Created by JobsHowie on 16/6/23.
//  Copyright © 2016年 KeNan. All rights reserved.
//

#import "KNViewController.h"
#import "UIImageView+KNBannerAnimation.h"
#import <ImageIO/ImageIO.h>


@interface KNViewController ()

/**
 *  Banner View
 */
@property (strong, nonatomic) UIImageView * bannerImageView;

@end

@implementation KNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载gif动画
    [self loadKeNanGif];
    
    // 添加bannerView
    [self.view addSubview:self.bannerImageView];
    
//    // 碎片化滚动视图
//    [self bannerFadeAnimate];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 碎片化滚动视图
    [self bannerFadeAnimate];
}

/**
 *  碎片化广告页轮播效果
 */
- (void)bannerFadeAnimate {
    
    NSMutableArray * images = [[NSMutableArray alloc] init];
    
    for (int idx = 1; idx < 5; idx ++) {
        [images addObject:[NSString stringWithFormat:@"banner%d.jpg",idx]];
    }
    
    [self.bannerImageView fadeBannerWithImages:[images copy]];
}

- (void)loadKeNanGif {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"keNan" ofType:@"gif"];
    // 设定位置和大小
    CGRect frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    frame.size = [UIImage imageNamed:@"keNan.gif"].size;
    UIImageView *imageView = [self imageViewWithGIFFile:path frame:frame];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

#pragma mark - #import <ImageIO/ImageIO.h>

- (UIImageView *)imageViewWithGIFFile:(NSString *)file frame:(CGRect)frame {
    return [self imageViewWithGIFData:[NSData dataWithContentsOfFile:file] frame:frame];
}

- (UIImageView *)imageViewWithGIFData:(NSData *)data frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    // 加载gif文件数据
    //NSData *gifData = [NSData dataWithContentsOfFile:file];
    
    // GIF动画图片数组
    NSMutableArray *frames = nil;
    // 图像源引用
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    // 动画时长
    CGFloat animationTime = 0.f;
    if (src) {
        // 获取gif图片的帧数
        size_t count = CGImageSourceGetCount(src);
        // 实例化图片数组
        frames = [NSMutableArray arrayWithCapacity:count];
        
        for (size_t i = 0; i < count; i++) {
            // 获取指定帧图像
            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
            
            // 获取GIF动画时长
            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, i, NULL);
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (image) {
                [frames addObject:[UIImage imageWithCGImage:image]];
                CGImageRelease(image);
            }
        }
        CFRelease(src);
    }
    [imageView setImage:[frames objectAtIndex:0]];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setAnimationImages:frames];
    [imageView setAnimationDuration:animationTime];
    [imageView startAnimating];
    
    return imageView;
}

#pragma mark - lazy

/**
 *  Banner ImageView
 */
- (UIImageView *)bannerImageView {
    if (_bannerImageView == nil) {
        _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 125)];
    }
    return _bannerImageView;
}

@end
