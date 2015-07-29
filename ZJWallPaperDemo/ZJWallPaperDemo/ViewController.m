//
//  ViewController.m
//  ZJWallPaperDemo
//
//  Created by onebyte on 15/7/17.
//  Copyright (c) 2015年 onebyte. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ZJWallPaper.h"
#import "MBProgressHUD.h"

typedef enum {
    ImageActionAsHomeScreen = 0,
    ImageActionAsLockScreen,
    ImageActionAsBoth,
    ImageActionAsPhoto
}ImageAction;

@interface ViewController ()<UIActionSheetDelegate>

@property(nonatomic, strong) NSMutableArray * btns;
@property(nonatomic, strong) UIImage *currentImage;
@property(nonatomic, strong) UIActionSheet *sheet;
@property(nonatomic, strong) MBProgressHUD *progressHUD;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat w = 160;
    CGFloat h = 240;
    CGFloat y = self.view.center.y - h/2;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - self.btns.count * w )/2;
    for (int i = 0 ; i < self.btns.count; i++)
    {
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(x + w * i,y, w, h);
    }
}

#pragma mark  --------------------------------
#pragma mark  UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case ImageActionAsHomeScreen:
        {
            [self.currentImage zj_saveAsHomeScreen];
            [self countDown];
        }
            break;
        case ImageActionAsLockScreen:
        {
            [self.currentImage zj_saveAsLockScreen];
            [self countDown];
        }
            break;
        case ImageActionAsBoth:
        {
            [self.currentImage zj_saveAsHomeScreenAndLockScreen];
            [self.currentImage zj_saveToPhotos];
            [self countDown];
        }
            break;
        case ImageActionAsPhoto:
        {
            [self.currentImage zj_saveToPhotos];
            [self countDown];
        }
            break;
        default:
            break;
    }
}



#pragma mark  --------------------------------
#pragma mark  action

-(void)countDown
{
    self.progressHUD.labelText = @"设置成功!";
    [self.progressHUD show:YES];
    [self timer];
}

-(void)timerAction
{
    static NSInteger i = 3;
    _progressHUD.labelText = [NSString stringWithFormat:@"倒计时退出 %lu",(unsigned long)i];
    i--;

    if (i < 0)
    {
       
        [self.progressHUD hide:YES];
        [self.timer invalidate];
        self.timer = nil;
        i = 3;
        
        [[UIApplication sharedApplication] performSelector:@selector(suspend)];
    }
    
}
-(void)btnClicked:(UIButton *)btn
{
    self.currentImage = [btn currentImage];
    [self.sheet showInView:[UIApplication sharedApplication].keyWindow];
}


#pragma mark  --------------------------------
#pragma mark  getter

-(NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
        
        UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn0 setImage:[UIImage imageNamed:@"img1.jpg"] forState:UIControlStateNormal];
        [self.view addSubview:btn0];
        [_btns addObject:btn0];
        [btn0.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [btn0 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setImage:[UIImage imageNamed:@"img2.jpg"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:
         UIControlEventTouchUpInside];
        [btn1.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:btn1];

        [_btns addObject:btn1];
    }
    return _btns;
}

-(UIActionSheet *)sheet
{
    if (_sheet == nil) {
        _sheet =  [[UIActionSheet alloc] initWithTitle:@"设置壁纸" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil   otherButtonTitles:@"设为桌面壁纸",@"设为锁屏壁纸",@"设为锁屏和桌面壁纸",@"保存到照片库", nil];
    }
    return _sheet;
}

-(MBProgressHUD *)progressHUD
{
    if (_progressHUD == nil)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.mode = MBProgressHUDModeText;
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

-(NSTimer *)timer
{
    if (_timer == nil)
    {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
