//
//  VHSingleFileUploadController.m
//  UploadDemo
//
//  Created by vhall on 2019/10/28.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "VHSingleFileUploadController.h"
#import "JXTAlertView.h"

@interface VHSingleFileUploadController ()

@property (nonatomic, strong) UITextField *nameTextFiled;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation VHSingleFileUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 164,  self.view.frame.size.width, 40)];
    self.nameTextFiled.placeholder = @"输入文件名";
    [self.view addSubview:self.nameTextFiled];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor brownColor];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.frame = CGRectMake(0, 164+40+10, CGRectGetWidth(self.view.frame), 0.5);
    [self.view addSubview:self.progressView];

    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-30, 164+40+10+20, 60, 40)];
    [addBtn setTitle:@"上传" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}


- (void)addBtnClick:(UIButton *)addBtn
{
    [super uploadBtnClick:addBtn];
    
    //************上传本地文件***************
    //[self addUploadFileWithPath:[[NSBundle mainBundle] pathForResource:@"40s" ofType:@".mp4"]];
}

#pragma mark -
- (void)addUploadFileWithPath:(NSString *)filePath
{
    [super addUploadFileWithPath:filePath];
    
//    VHVodInfo *model = [[VHVodInfo alloc] init];
//    model.name = self.nameTextFiled.text;
//    model.desc = [filePath lastPathComponent];
//    
//    __weak typeof(self)weakSelf = self;

//    [self.uploder uploadFilePath:filePath vodInfo:model progress:^(VHUploadFileInfo * _Nonnull fileInfo, int64_t uploadedSize, int64_t totalSize) {
//        //主线程刷新progress
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.progressView.progress = 1.f * uploadedSize / totalSize;
//            weakSelf.logtextview.text = [NSString stringWithFormat:@"上传进度：%f",weakSelf.progressView.progress];
//        });
//    } success:^(VHUploadFileInfo * _Nonnull fileInfo) {
//        weakSelf.logtextview.text = [NSString stringWithFormat:@"上传成功，点播id：%@",fileInfo.recordId];
//        [JXTAlertView showToastViewWithTitle:nil message:@"上传成功" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
//            weakSelf.nameTextFiled.text = nil;
//        }];
//        //删除本地文件
//        [weakSelf deletefile:filePath];
//    } failure:^(VHUploadFileInfo * _Nullable fileInfo, NSError * _Nonnull error) {
//        weakSelf.logtextview.text = [NSString stringWithFormat:@"上传失败，error：%@",error];
//        [JXTAlertView showToastViewWithTitle:@"上传失败" message:[NSString stringWithFormat:@"%@",error] duration:2 dismissCompletion:^(NSInteger buttonIndex) {
//
//        }];
//    }];
}

@end
