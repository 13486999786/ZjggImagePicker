//
//  ScanImagesCtr.m
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import "ScanImagesCtr.h"

@interface ScanImagesCtr ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * ScanImagesView;
@property(nonatomic,strong) UILabel     * TitleLabel;
@end

@implementation ScanImagesCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
    _TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    _TitleLabel.textAlignment = 1;
    _TitleLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)_SelectedImageNum+1,(unsigned long)_AllImages.count];
    _TitleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_TitleLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
    _ScanImagesView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
    _ScanImagesView.pagingEnabled = YES;
    _ScanImagesView.bounces = NO;
    _ScanImagesView.delegate = self;
    _ScanImagesView.contentSize =CGSizeMake(_AllImages.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
    [self.view addSubview:_ScanImagesView];
    for (int i = 0; i <_AllImages.count; i++)
    {
        UIImageView * Im = [[UIImageView alloc]initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
        UITapGestureRecognizer *CloseSc = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CloseSC)];
        Im.userInteractionEnabled = YES;
        [Im addGestureRecognizer:CloseSc];
        Im.contentMode = 1;
        Im.image = _AllImages[i];
        [_ScanImagesView addSubview:Im];
    }
    [self scrollViewDidEndScrollingAnimation:_ScanImagesView];
    
}
-(void)CloseSC
{
    [self dismissViewControllerAnimated:YES  completion:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger Num = scrollView.contentOffset.x/scrollView.frame.size.width;
    _TitleLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)Num+1,(unsigned long)_AllImages.count];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointMake(_SelectedImageNum * [UIScreen mainScreen].bounds.size.width, 0);
    
}
@end
