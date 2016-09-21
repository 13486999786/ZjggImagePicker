//
//  ChoosePhotosView.h
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePhotosView : UICollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;
@property(nonatomic,strong) UIViewController             *SuperCtl;//传入父kongzhiqi
@property(nonatomic,assign) NSUInteger         MaxPhotosCount;//允许最大的照片张数



@end
