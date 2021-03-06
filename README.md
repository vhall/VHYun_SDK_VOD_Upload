# VHYunSDK-UploadSDK

## 简介

`VHUpload.framework`是微吼云SDK，iOS点播上传SDK，支持上传文件、生成点播功能。

pod 'VHYun_Upload'

## 版本记录
### v2.1.0  2021.03.08
1、新增加密功能

### v2.0.0  2020.05.12
1、移除阿里云依赖

### v1.0.0  2019.10.28
1、文件上传
2、上传回调

## Api说明

* 版本号

```
/**
 获取SDK版本号
 */
+ (NSString *)getSDKVersion;
```

* 设置日志打印

```
/**
 设置日志打印
 */
+ (void)logEnable:(BOOL)enable;
```

* 初始化

```
/**
 初始化
 */
- (instancetype)initWithAccessToken:(NSString *)accessToken;
```

* 上传方法

```
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
```

* 回调

```
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
```

## 使用说明

将`VHUpload.framework`和`VHCore.framework`导入到项目中即可使用，使用详情见Demo。

目前支持上传视频并生自动成点播文件功能。

1、引入有文件`<VHUpload/VHUploaderClient.h>`

```
#import <VHUpload/VHUploaderClient.h>
```

2、初始化上传对象

```
_uploder = [[VHUploaderClient alloc] initWithAccessToken:self.accessToken];
[VHUploaderClient logEnable:YES];//开启日志
```

上传前请提前初始化上传对象，建议进入上传页面就初始化该对象即可。

3、上传

通过文件路径即可上传。上传前可自定义上传信息VHVodInfo，可自定义的信息如下：

```
/**
 设置上传文件名称，不用带文件扩展名，内部会自动拼接文件实际类型扩展名；若不设置此值，默认取文件路径最后文件名+后缀，如：****.mp4
 */
@property (nonatomic, copy) NSString *name;
/**
 文件标识 (SDK内部暂未使用)
 */
@property (nonatomic, copy) NSString *tags;
/**
 文件描述 (SDK内部暂未使用)
 */
@property (nonatomic, copy) NSString *desc;
/**
 用户自定义参数 (SDK内部暂未使用)
 */
@property (nonatomic, copy) NSString *userData;
```

调用相关Api进行上传视频文件，vodInfo可为空，为空时，SDK内部会构建，并默认取文件路径最后部分作为文件名。


#### 示例代码

```
- (void)mutiUploadWithFile:(NSString *)filePath
{
    VHVodInfo *vodInfo = [[VHVodInfo alloc] init];
    vodInfo.name = @"视频名称";
    //分片上传
    __weak typeof(self)weakSelf = self;
    [weakSelf.uploder multipartUpload:filePath vodInfo:nil progress:^(VHUploadFileInfo * _Nonnull fileInfo, int64_t uploadedSize, int64_t totalSize) {
        NSLog(@"上传进度 : %f",1.0 * uploadedSize / totalSize);
    } success:^(VHUploadFileInfo * _Nonnull fileInfo) {
        NSLog(@"上传成功，点播id：%@",fileInfo.recordId);
    } failure:^(VHUploadFileInfo * _Nullable fileInfo, NSError * _Nonnull error) {
        NSLog(@"上传失败:%@",error);
    }];
}
```

