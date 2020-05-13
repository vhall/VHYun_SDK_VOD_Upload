//
//  VHUploaderClient.h
//  VHVODUpload
//
//  Created by vhall on 2019/10/22.
//  Copyright © 2019 vhall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHUploaderModel.h"

@class VHUploaderClient;

NS_ASSUME_NONNULL_BEGIN

/**
 文件上传进度回调
 @param fileInfo     当前上传的文件
 @param uploadedSize 当前已上传段长度
 @param totalSize    一共需要上传的总长度，即当前文件大小
 @warning 上传进度计算：float progress = 1.f * uploadedSize / totalSize;
 */
typedef void (^OnUploadProgressCallback) (VHUploadFileInfo* fileInfo, int64_t uploadedSize, int64_t totalSize);

///上传成功回调
typedef void (^OnUploadSucessCallback) (VHUploadFileInfo* fileInfo);

///上传失败回调
typedef void (^OnUploadFailedCallback) (VHUploadFileInfo* _Nullable fileInfo, NSError *error);


///上传SDK 上传类
@interface VHUploaderClient : NSObject

/**
 获取SDK版本号
 */
+ (NSString *)getSDKVersion;

/**
 是否开启日志打印，默认NO
 */
+ (void)logEnable:(BOOL)enable;

/**
 初始化
 */
- (instancetype)initWithAccessToken:(NSString *)accessToken;


/**
 分片上传 默认会将文件以每片1M大小进行分片
 当次上传失败时，可重试继续上传
 @param filePath 文件路径，不可为空
 @param vodInfo  文件扩展信息，可为空
 @param progressCallback 上传进度回调
 @param successCallback  上传成功回调
 @param failedCallback   上传失败回调
 @warning 支持文件大小 < 5g。上传进度回调是在子线程中，如果有UI处理请注意返回主线程。
 */
- (void)multipartUpload:(NSString *)filePath
                vodInfo:(nullable VHVodInfo *)vodInfo
               progress:(OnUploadProgressCallback)progressCallback
                success:(OnUploadSucessCallback)successCallback
                failure:(OnUploadFailedCallback)failedCallback;



@end

NS_ASSUME_NONNULL_END
