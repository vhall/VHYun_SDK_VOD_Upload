//
//  VHUploadBaseController.m
//  UploadDemo
//
//  Created by vhall on 2019/10/28.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "VHUploadBaseController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "JXTAlertView.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface VHUploadBaseController ()

@property (nonatomic, strong) UIButton *uploadBtn;

@end

@implementation VHUploadBaseController

- (instancetype)initWithToken:(NSString *)accessToken {
    if (self = [super init]) {
        self.accessToken = accessToken;
        //初始化上传
        [self uploder];
    }
    return self;
}

- (VHUploaderClient *)uploder {
    if (!_uploder) {
        [VHUploaderClient logEnable:YES];
        _uploder = [[VHUploaderClient alloc] initWithAccessToken:self.accessToken];
    }
    return _uploder;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftNavBtnClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.logtextview = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-200, CGRectGetWidth(self.view.frame), 200)];
    self.logtextview.backgroundColor = [UIColor lightGrayColor];
    self.logtextview.editable = NO;
    [self.view addSubview:self.logtextview];
}

- (void)leftNavBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)uploadBtnClick:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //兼容iPad
    alert.popoverPresentationController.sourceView = sender;
    alert.popoverPresentationController.sourceRect = sender.bounds;
    
    [alert addAction:[UIAlertAction actionWithTitle:@"选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openPhotosAlbum];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openCamera];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    alert.modalPresentationStyle = UIModalPresentationFullScreen;
    [weakSelf presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)openPhotosAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;//设置转码视频质量
    //picker.videoExportPreset = AVAssetExportPreset1280x720;
    picker.delegate = self;
    picker.editing = NO;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)openCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];//设定相机为录像
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;//设置相机后摄像头
    //pickerCon.videoMaximumDuration = 15;//最长拍摄时间
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;//拍摄质量
    picker.allowsEditing = NO;
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)openICloud {
    if (![VHUploadBaseController ICloudEnable]) {
        NSLog(@"iCloud没有开启");
        [JXTAlertView showToastViewWithTitle:nil message:@"iCloud没有开启" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
            
        }];
        return;
    }
    NSArray *documentTypes = @[@"public.content",
                               @"public.text",
                               @"public.source-code",
                               @"public.image",
                               @"public.jpeg",
                               @"public.png",
                               @"com.adobe.pdf",
                               @"com.apple.keynote.key",
                               @"com.microsoft.word.doc",
                               @"com.microsoft.excel.xls",
                               @"com.microsoft.powerpoint.ppt"];
    UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    //picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}

+ (BOOL)ICloudEnable {
    NSURL *url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    return url != nil;
}

#pragma mark - UIImagePickerControllerDelegate
//selected
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //此处需要先dismiss掉picker，然后再present出alert，佛否则alert显示会出bug
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"*******info*******%@",info);
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //媒体库
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        //视频文件
        if ([mediaType isEqualToString:@"public.movie"])
        {
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
            NSString *videoPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[self getVideoNameBaseCurrentTime]];
            [self compressVideo:url outputFilePath:videoPath success:^{
                //上传
                [self addUploadFileWithPath:videoPath];
            }];
        }
        else {
            [JXTAlertView showToastViewWithTitle:nil message:@"不是视频文件" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
                
            }];
        }
    }
    //相机文件
    else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        //如果是拍照
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            [JXTAlertView showToastViewWithTitle:nil message:@"不是视频文件" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
                
            }];
        }
        //如果是录制视频
        else if([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
            NSString *videoPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[self getVideoNameBaseCurrentTime]];
            
            //判断能不能保存到相簿
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)) {
                NSLog(@"可以保存视频");
                //保存视频到相簿
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
                //导出mp4
                [self compressVideo:url outputFilePath:videoPath success:^{
                    //上传
                    [self addUploadFileWithPath:videoPath];
                }];
            } else {
                NSLog(@"不可以保存视频");
                [JXTAlertView showToastViewWithTitle:nil message:@"视频文件保存失败，不能上传" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
                }];
            }
        }
    }
    //相册
    else if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum)
    {
        //视频文件
        if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
            NSString *videoPath = url.path;
            //上传
            [self addUploadFileWithPath:videoPath];
        } else {
            NSLog(@"不是视频文件");
            [JXTAlertView showToastViewWithTitle:nil message:@"不是视频文件" duration:2 dismissCompletion:^(NSInteger buttonIndex) {
                
            }];
        }
    }
}

//cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存视频完成");
}


//mov格式视频，压缩/导出mp4格式
- (void)compressVideo:(NSURL*)url outputFilePath:(NSString *)path success:(void(^)(void))success {
    NSString *prePath = [url path];
    unsigned long long size = [[NSFileManager defaultManager] attributesOfItemAtPath:prePath error:nil].fileSize;
    NSLog(@"压缩之前大小:%.2fM---路径:%@",size/1024.0/1024.0,prePath);
    //使用媒体工具(AVFoundation框架下的)
    //Asset 资源可以是图片音频视频
    AVAsset *asset = [AVAsset assetWithURL:url];
    //设置压缩的格式
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetHighestQuality];//AVAssetExportPresetHighestQuality：高质量 AVAssetExportPresetMediumQuality：中等质量
    //创建文件管理类
    NSFileManager *manager = [[NSFileManager alloc]init];
    //删除已经存在的同名文件
    [manager removeItemAtPath:path error:NULL];
    //设置导出路径
    session.outputURL = [NSURL fileURLWithPath:path];
    //设置输出文件的类型 mp4
    session.outputFileType = AVFileTypeMPEG4;
    //开辟子线程处理耗时操作
    [session exportAsynchronouslyWithCompletionHandler:^{
        unsigned long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
        NSLog(@"压缩导出完成!路径:%@---压缩之后视频大小%.2fM",path,fileSize/1024.0/1024.0);
        if ([session status] == AVAssetExportSessionStatusCompleted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success ? success() : nil;
            });
        }
    }];
    
}

- (NSString *)getVideoNameBaseCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".mp4"];
}

//删除上传成功的文件
- (BOOL)deletefile:(NSString *)uploadPath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:uploadPath]) {
        BOOL removed = [[NSFileManager defaultManager] removeItemAtPath:uploadPath error:nil];
        NSLog(@"removed file %@ %@",uploadPath,removed?@"sucess":@"failed");
        return removed;
    }
    return NO;
}

#pragma mark -
- (void)addUploadFileWithPath:(NSString *)filePath
{
    
}

@end
