//
//  MultiPartUploadController.m
//  UploadDemo
//
//  Created by vhall on 2019/10/29.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "MultiPartUploadController.h"
#import "JXTAlertView.h"

@interface MultiPartUploadController ()

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation MultiPartUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 100)];
    [addBtn setTitle:@"点击添加视频上传" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = [UIColor brownColor];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];

    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.frame = CGRectMake(0, 264, CGRectGetWidth(self.view.frame), 0.5);
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
}

- (void)addBtnClick:(UIButton *)sender
{
    //************相册/拍照***************
    [super uploadBtnClick:sender];
    
    
    
    
    //************上传本地文件***************
    //[self mutiUploadWithFile:[[NSBundle mainBundle] pathForResource:@"" ofType:@""]];
}


//选择上传
- (void)addUploadFileWithPath:(NSString *)filePath
{
    [super addUploadFileWithPath:filePath];
    
//    NSError *error;
//    uint64_t fileSize = [VHUploaderModel getSizeWithFilePath:filePath error:&error];
//    if (error) {
//        [JXTAlertView showToastViewWithTitle:@"文件读取失败" message:error.domain duration:2 dismissCompletion:^(NSInteger buttonIndex) {
//
//        }];
//        return;
//    }
//    if (fileSize < 0.1 * 1024 * 1024 * 1024) {
//        [JXTAlertView showToastViewWithTitle:@"文件较小，建议使用简单上传" message:error.domain duration:2 dismissCompletion:^(NSInteger buttonIndex) {
//
//        }];
//        return;
//    }
    
    [self mutiUploadWithFile:filePath];
}



//上传
- (void)mutiUploadWithFile:(NSString *)filePath
{
    NSLog(@"mutiUploadWithFile start %@",filePath);
    
    VHVodInfo *vodInfo = [[VHVodInfo alloc] init];
    vodInfo.name = [NSString stringWithFormat:@"分片上传_%.f",[[NSDate date] timeIntervalSince1970]];
    //分片上传
    __weak typeof(self)weakSelf = self;
    [weakSelf.uploder multipartUpload:filePath vodInfo:vodInfo progress:^(VHUploadFileInfo * _Nullable fileInfo, int64_t uploadedSize, int64_t totalSize) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"milti progress : %f",1.0 * uploadedSize / totalSize);
            [weakSelf.progressView setProgress:1.0 * uploadedSize / totalSize animated:NO];
            weakSelf.logtextview.text = [NSString stringWithFormat:@"%f",weakSelf.progressView.progress];
        });
    } success:^(VHUploadFileInfo * _Nullable fileInfo) {
        [JXTAlertView showToastViewWithTitle:nil message:@"上传成功" duration:2 dismissCompletion:^(NSInteger buttonIndex) {

        }];
    } failure:^(VHUploadFileInfo * _Nullable fileInfo, NSError * _Nonnull error) {
        NSLog(@"分片上传error:%@",error);
        [JXTAlertView showToastViewWithTitle:@"上传失败" message:error.domain duration:2 dismissCompletion:^(NSInteger buttonIndex) {

        }];
    }];
}



@end
