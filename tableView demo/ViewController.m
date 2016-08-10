//
//  ViewController.m
//  tableView demo
//
//  Created by 王玉翠 on 16/7/19.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import "ViewController.h"

#import "WYCTableViewCell.h"

//分辨率
#define kDeviceScale [UIScreen mainScreen].scale

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGPoint cellPoint;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) CGPoint middlePoint;



@end

@implementation ViewController

static NSString *identifie = @"identifie";
static NSString *identifieCollection = @"identifieCollection";
static CGFloat heigthForRow = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

//tableView的创建
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
    
}

#pragma mark ----tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.两种情况
    //1)cell不复用的情况比较简单
    //2)cell服用的情况
    //cell不复用
#pragma mark ---cell不复用
    WYCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
#pragma mark ---cell服用
   //WYCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifie];
    
    
    if (!cell) {
        cell = [[WYCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifie];
    }
    
    cell.clipsToBounds = YES;
    
    return cell;
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return heigthForRow;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.userInteractionEnabled = NO;
    //获取cell的位置
    CGRect rectIntableView = [tableView   rectForRowAtIndexPath:indexPath];
    //获取cell在屏幕中的位置
    CGRect rectInSuperView = [tableView convertRect:rectIntableView toView:[tableView superview]];
    self.cellPoint = CGPointMake(0, rectInSuperView.origin.y + rectInSuperView.size.height/ 2.0);
    
    if (self.collectionView != nil) {
        
        [self.collectionView removeFromSuperview];
        self.collectionView = nil;
        self.middlePoint = CGPointMake(0, 0);
        
    }
    
    
    
  [self creationimageViewInCellAtIndexPath:indexPath andTableView:tableView andNumberOfImageView:0];
  [self creationimageViewInCellAtIndexPath:indexPath andTableView:tableView andNumberOfImageView:1];
  [self addCollectViewAtCellOfIndexPath:indexPath andTableView:tableView];
   
}





/**
 *在cell上添加裁剪的图片
 */
- (void)creationimageViewInCellAtIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView andNumberOfImageView:(NSInteger)numberOfImageView{
    
    WYCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //当前点击cell的位置
    //_cellPoint = cell.frame.origin;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.WYCimageView.frame.origin.x,cell.WYCimageView.frame.size.height / 2.0 * numberOfImageView, cell.WYCimageView.frame.size.width, cell.WYCimageView.frame.size.height/ 2.0)];

    imageView.image = [self clipImagewithBorderWithImage:cell.WYCimageView and:numberOfImageView];
    imageView.contentMode = UIViewContentModeScaleToFill;
   
    [cell.contentView addSubview:imageView];
    //图片的动画
    [UIView animateWithDuration:3.0f animations:^{
        heigthForRow = numberOfImageView == 0 ? - fabs(heigthForRow) :fabs(heigthForRow);
        
        imageView.transform = CGAffineTransformMakeTranslation(0, heigthForRow/ 2.0);
        
       
    }];
    
}
/**
 *在cell上添加collectionView
 */

-(void)addCollectViewAtCellOfIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView{
    
    WYCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 2;
    flowLayout.itemSize = CGSizeMake(100, 50);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height / 2.0, cell.frame.size.width, 0) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifieCollection];
   
    [cell.contentView addSubview:self.collectionView];
     self.collectionView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    //图片动画
    [UIView animateWithDuration:3.0f animations:^{
        self.collectionView.frame = CGRectMake(0, 0,cell.frame.size.width , cell.frame.size.height);
    }];
  
}

#pragma mark ----collectionView的代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 30;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifieCollection forIndexPath:indexPath];
  
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, collectionCell.frame.size.width, collectionCell.frame.size.height)];
    label.text = @"测试";
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.layer.backgroundColor = [UIColor orangeColor].CGColor;
    
    [collectionCell.contentView addSubview:label];
    
    return collectionCell;
   
}





#pragma mark ----图像的裁剪
/**
 *图像的裁剪
 */
- (UIImage *)clipImagewithBorderWithImage:(UIImageView *)image and:(NSInteger)inter{
    
    CGSize subImageSize = CGSizeMake(image.frame.size.width , image.frame.size.height);
    
    //定义裁剪的区域相对于原图片的位置
    CGRect subImageRect;
    if (inter == 0) {
        subImageRect = CGRectMake(image.bounds.origin.x * kDeviceScale, image.bounds.origin.y * kDeviceScale, image.bounds.size.width * kDeviceScale , image.bounds.size.height * kDeviceScale / 2.0);
    }else {
        subImageRect = CGRectMake(image.bounds.origin.x * kDeviceScale, (image.bounds.origin.y + image.bounds.size.height / 2.0) * kDeviceScale, image.bounds.size.width * kDeviceScale, image.bounds.size.height / 2.0 * kDeviceScale);
    }

    CGImageRef imageRef = image.image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);

    UIGraphicsBeginImageContextWithOptions(subImageSize, NO, kDeviceScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    
    //返回裁剪的部分图像
    return subImage;
    
}


#pragma mark ---cell复用情况
//拖动即可出发的设置,记录tableView的contentOffset
//1.拖动的距离 > cell的起始位置 ，collectionView移除
//2.来回，不停的拖动，拖动松手，松手拖动的情况，计算总体的拖动距离 > cell的起始位置

/**
 *开始拖动时，tableView的距离，和拖动时tableView的距离，如果拖动的距离
 *
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%@",NSStringFromCGPoint(self.tableView.contentOffset));
    
//    if (self.endPoint.y > self.startPoint.y) {
//        
    
        if (self.tableView.contentOffset.y - self.startPoint.y >= self.cellPoint.y) {
            
            [self.collectionView removeFromSuperview];
            self.collectionView = nil;
            self.middlePoint = CGPointMake(0, 0);
        }
//    }else{
//        
//        
//        if (self.startPoint.y - self.tableView.contentOffset.y >= fabs(self.cellPoint.y)) {
//            
//            [self.collectionView removeFromSuperview];
//            self.collectionView = nil;
//            self.middlePoint = CGPointMake(0, 0);
//        }
//        
//    }
    

    
    
    
    
}
//停止拖动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    self.endPoint = self.tableView.contentOffset;
    
    if (self.endPoint.y - self.startPoint.y >= self.cellPoint.y) {
        [self.collectionView removeFromSuperview];
        self.collectionView = nil;
        self.middlePoint = CGPointMake(0, 0);
        
    }else/* if(self.endPoint.y > self.startPoint.y)*/{
        //移动的距离 cell往上走时
        self.middlePoint = CGPointMake(0, self.endPoint.y - self.startPoint.y);
        
        
        //cell往下走时，self.endPoint.y < self.startPoint.y
        
    }
//    else{
//        
//        //移动的距离 cell往上走时
//        self.middlePoint = CGPointMake(0, self.startPoint.y - self.endPoint.y);
//  
//    }
    
}

//开始拖动时，记录下tablView的contentOffSet
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    NSLog(@"%@",NSStringFromCGPoint(self.tableView.contentOffset));
    
    self.startPoint = self.tableView.contentOffset;
   
    if (self.middlePoint.y != 0) {
        if (self.endPoint.y > self.startPoint.y) {
            self.startPoint = CGPointMake(0, self.startPoint.y - self.middlePoint.y);
        }else{
             self.startPoint = CGPointMake(0, self.startPoint.y + self.middlePoint.y);
            
        }
        

        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
