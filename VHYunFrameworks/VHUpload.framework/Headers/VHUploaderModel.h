//
//  VHUploaderModel.h
//  VHUpload
//
//  Created by vhall on 2019/10/24.
//  Copyright © 2019 vhall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///文件状态 准备上传、正在上传、上传失败、上传成功
typedef NS_ENUM(NSInteger,VHUploadFileState) {
    VHUploadFileStatePrepare,
    VHUploadFileStateUploding,
    VHUploadFileStateFailed,
    VHUploadFileStateUploded,
};

@interface VHVodInfo : NSObject

/** 设置上传文件名称，不用带文件扩展名，内部会自动拼接文件实际类型扩展名；若不设置此值，默认取文件路径最后文件名+后缀，如：****.mp4 */
@property (nonatomic, copy) NSString *name;

/** 文件标识 (SDK内部暂未使用) */
@property (nonatomic, copy) NSString *tags;

/** 文件描述 (SDK内部暂未使用) */
@property (nonatomic, copy) NSString *desc;

/** 用户自定义参数 (SDK内部暂未使用) */
@property (nonatomic, copy) NSString *userData;
@end

@interface VHUploadFileInfo : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFilePath:(NSString *)filePath isSafe:(BOOL)isSafe;
/** 文件状态 */
@property (nonatomic, assign) VHUploadFileState fileState;

/** 传入的文件原始路径 */
@property (nonatomic, copy) NSString *filePath;

/** 文件类型 如：mp4 */
@property (nonatomic, copy ,readonly) NSString *mediaType;

/** 文件大小 */
@property (nonatomic, assign ,readonly) uint64_t totalBytes;

/** 文件MD5 (小写) */
@property (nonatomic, copy ,readonly) NSString *fileMd5;

/** 上传信息 */
@property (nonatomic, strong) VHVodInfo *vodInfo;

/** 上传成功后的回放id */
@property (nonatomic, copy) NSString *recordId;

/** 自定义参数 (SDK内部暂未使用) */
@property (nonatomic, strong, nullable) NSDictionary *callbackParam;


/** 真正上传时的文件路径，SDK内部使用 */
@property (nonatomic, copy ,readonly) NSString *uploadPath;

/**是否生成加密视频，默认为NO */
@property (nonatomic, assign ,readonly) BOOL isSafe;
@end


///上传SDK Model类
@interface VHUploaderModel : NSObject

/**
 获取文件大小，单位Byte
 @param filePath 文件路径
 @warning error 读取出错回调
 */
+ (uint64_t)getSizeWithFilePath:(nonnull NSString *)filePath error:(NSError **)error;


@end

NS_ASSUME_NONNULL_END
