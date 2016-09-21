//
//  ImageCell.h
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView             *Im;

@property(nonatomic,strong) UIButton                *DeleteButton;//删除按钮


-(id)initWithFrame:(CGRect)frame;

@end
