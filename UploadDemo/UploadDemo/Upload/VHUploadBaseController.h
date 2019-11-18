//
//  VHUploadBaseController.h
//  UploadDemo
//
//  Created by vhall on 2019/10/28.
//  Copyright © 2019 vhall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VHUpload/VHUploaderClient.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHUploadBaseController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//初始化
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithToken:(NSString *)accessToken;

//VH Token
@property (nonatomic, strong) NSString *accessToken;

//上传对象
@property (nonatomic, strong) VHUploaderClient *uploder;

//返回按钮事件
- (void)leftNavBtnClick:(UIButton *)sender;

//上传按钮执行事件
- (void)uploadBtnClick:(UIButton *)sender;

//选择上传
- (void)addUploadFileWithPath:(NSString *)filePath;

@property (nonatomic, strong) UITextView *logtextview;

@end

NS_ASSUME_NONNULL_END
