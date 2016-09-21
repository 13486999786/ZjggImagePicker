//
//  ChoosePhotosView.m
//  ImagePicker
//
//  Created by zj on 16/9/21.
//  Copyright © 2016年 zj. All rights reserved.
//

#import "ChoosePhotosView.h"
#import "MyLayout.h"
#import "TZImagePickerController.h"
#import "ImageCell.h"
#import "ScanImagesCtr.h"
@interface ChoosePhotosView()<UICollectionViewDataSource,UICollectionViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) NSMutableArray               * AllImages;
@end
@implementation ChoosePhotosView
-(NSMutableArray *)AllImages
{
    if (!_AllImages)
    {
        _AllImages = [NSMutableArray array];
    }
    return _AllImages;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self=[super initWithFrame:frame collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator =NO;
        [self registerClass:[ImageCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_AllImages.count == self.MaxPhotosCount)
    {
        return self.MaxPhotosCount;
    }
    else
    {
        return _AllImages.count+1;
    }
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_AllImages.count != 0)
    {
        if (indexPath.row != _AllImages.count)
        {
            ImageCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
            cell.Im.image = _AllImages[indexPath.row];
            cell.Im.contentMode = 2;
            cell.Im.clipsToBounds = YES;
            cell.DeleteButton.hidden = NO;
            cell.DeleteButton.tag = indexPath.row;
            [cell.DeleteButton addTarget:self action:@selector(DeleteBus:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else
        {
            ImageCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
            cell.Im.contentMode = 0;
            cell.Im.image = [UIImage imageNamed:@"b"];
            cell.DeleteButton.hidden = YES;
            return cell;
        }
        
    }
    else
    {
        ImageCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
         cell.Im.image = [UIImage imageNamed:@"b"];
        cell.DeleteButton.hidden = YES;
        cell.Im.contentMode = 0;
        return cell;
    }
}
//
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-20)/3, 80);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_AllImages.count > indexPath.row)//浏览图片
    {
        ScanImagesCtr * ImaPicker = [[ScanImagesCtr alloc]init];
        ImaPicker.AllImages = _AllImages;
        ImaPicker.SelectedImageNum = indexPath.row;
        [self.SuperCtl presentViewController:ImaPicker animated:YES completion:nil];
    }
    else
    {
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction*TakePhoto=[UIAlertAction actionWithTitle:@"相册中选取" style:0 handler:^(UIAlertAction * _Nonnull action){
            TZImagePickerController * Picker = [[TZImagePickerController alloc]initWithMaxImagesCount:self.MaxPhotosCount-_AllImages.count delegate:self];
            Picker.delegate = self;
            [self.SuperCtl presentViewController:Picker animated:YES completion:nil];
        }];
        UIAlertAction*Images   =[UIAlertAction actionWithTitle:@"拍照片"    style:0 handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController * Picker = [[UIImagePickerController alloc]init];
            Picker.delegate = self;
            Picker.allowsEditing = YES;
            Picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.SuperCtl presentViewController:Picker animated:YES completion:nil];
        }];
        UIAlertAction*Cancel   =[UIAlertAction actionWithTitle:@"取消"      style:2 handler:nil];
        [alert addAction:TakePhoto];
        [alert addAction:Images];
        [alert addAction:Cancel];
        [self.SuperCtl presentViewController:alert animated:YES completion:nil];
        
    }
}
//选好照片
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets
{
    [self.AllImages addObjectsFromArray:photos];
    [self reloadData];
    
}
//拍照选好照片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.AllImages addObject:image];
    [self reloadData];
}
//删除照片
-(void)DeleteBus:(UIButton*)Bu
{
    NSLog(@"删除照片");
    [_AllImages removeObjectAtIndex:Bu.tag];
    [self reloadData];
    
}

@end
