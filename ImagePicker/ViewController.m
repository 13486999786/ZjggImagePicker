//
//  ViewController.m
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import "ViewController.h"
#import "ChoosePhotosView.h"
#import "MyLayout.h"

@interface ViewController ()
@property(nonatomic,strong)ChoosePhotosView * ChooseView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MyLayout*Layout = [[MyLayout alloc]init];
            Layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _ChooseView = [[ChoosePhotosView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120) collectionViewLayout:Layout];
    _ChooseView.SuperCtl = self;//把控制器传进去，以便于退出控制器
    _ChooseView.MaxPhotosCount = 3;//允许最大照片的数量
    [self.view addSubview:_ChooseView];
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    ImagePickerCtl* Ip = [[ImagePickerCtl alloc]init];
//    [self presentViewController:Ip animated:YES completion:nil];
//    
//}
@end
