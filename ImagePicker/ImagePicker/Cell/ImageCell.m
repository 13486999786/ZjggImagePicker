//
//  ImageCell.m
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
         self.Im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _Im.image = [UIImage imageNamed:@"b"];
        [self addSubview:_Im];
        
        _DeleteButton = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-20, 0, 20, 20)];
        [_DeleteButton setImage: [UIImage imageNamed:@"a"] forState:UIControlStateNormal];
        [self addSubview:_DeleteButton];
        
    }
    return self;
}

@end
