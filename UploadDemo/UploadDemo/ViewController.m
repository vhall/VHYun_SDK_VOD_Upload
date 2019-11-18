//
//  ViewController.m
//  UploadDemo
//
//  Created by vhall on 2019/10/15.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+vhall.h"
#import "VHSingleFileUploadController.h"
#import "VHListUploadViewController.h"
#import "MultiPartUploadController.h"
#import <VHUpload/VHUploaderClient.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSDKView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showInitSDKVC];
}

- (void)initSDKView
{
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100, 100, 30)];
    [startBtn setTitle:@"单文件上传" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:startBtn];
    
    UIButton *listBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100+30*2, 100, 30)];
    [listBtn setTitle:@"列表上传" forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(listUploadClicked:) forControlEvents:UIControlEventTouchUpInside];
    listBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:listBtn];
    
    UIButton *multiBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100+30*4, 100, 30)];
    [multiBtn setTitle:@"分片上传" forState:UIControlStateNormal];
    [multiBtn addTarget:self action:@selector(multiUploadClicked:) forControlEvents:UIControlEventTouchUpInside];
    multiBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:multiBtn];

    UILabel * label= [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 100, CGRectGetWidth(self.view.frame), 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.text = [NSString stringWithFormat:@"微吼云 Upload SDK v%@",[VHUploaderClient getSDKVersion]];
    [self.view addSubview:label];
}

- (void)startBtnClicked:(UIButton *)sender
{
    VHSingleFileUploadController *vc = [[VHSingleFileUploadController alloc] initWithToken:DEMO_AccessToken];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)listUploadClicked:(UIButton *)sender
{
    VHListUploadViewController *vc = [[VHListUploadViewController alloc] initWithToken:DEMO_AccessToken];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)multiUploadClicked:(UIButton *)sender
{
    MultiPartUploadController *vc = [[MultiPartUploadController alloc] initWithToken:DEMO_AccessToken];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


@end


