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
//    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100, 100, 30)];
//    [startBtn setTitle:@"单文件上传" forState:UIControlStateNormal];
//    [startBtn addTarget:self action:@selector(startBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    startBtn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:startBtn];
//
//    UIButton *listBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100+30*2, 100, 30)];
//    [listBtn setTitle:@"列表上传" forState:UIControlStateNormal];
//    [listBtn addTarget:self action:@selector(listUploadClicked:) forControlEvents:UIControlEventTouchUpInside];
//    listBtn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:listBtn];
    
    UIButton *multiBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.5-50, 100+30*4, 100, 30)];
    [multiBtn setTitle:@"分片上传" forState:UIControlStateNormal];
    [multiBtn addTarget:self action:@selector(multiUploadClicked:) forControlEvents:UIControlEventTouchUpInside];
    multiBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:multiBtn];

    UILabel * explainLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(self.view.frame) - 300, CGRectGetWidth(self.view.frame) - 30, 100)];
    explainLab.font = [UIFont systemFontOfSize:12];
    explainLab.textColor = [UIColor grayColor];
    explainLab.numberOfLines = 0;
//    explainLab.text = @"普通上传：适合小文件上传，当次上传失败时，需要从0开始上传\n列表上传：同单文件上传\n分片上传：适合大文件上传，如果小文件使用分片，反而效率会低，分片默认会将文件以每片1M大小进行分片，当次上传中途失败时，可重试继续上传";
    explainLab.text = @"分片上传：默认会将文件以每片1M大小进行分片，当次上传中途失败时，可重试继续上传";
    [self.view addSubview:explainLab];
    
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
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)listUploadClicked:(UIButton *)sender
{
    VHListUploadViewController *vc = [[VHListUploadViewController alloc] initWithToken:DEMO_AccessToken];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)multiUploadClicked:(UIButton *)sender
{
    MultiPartUploadController *vc = [[MultiPartUploadController alloc] initWithToken:DEMO_AccessToken];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


@end


