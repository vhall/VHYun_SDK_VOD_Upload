//
//  VHUploadModel.h
//  UploadDemo
//
//  Created by vhall on 2019/10/24.
//  Copyright © 2019 vhall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VHUpload/VHUploaderClient.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UploadStatus) {
    UploadStatusUploding,
    UploadStatusComplete,
    UploadStatusPause,
    UploadStatusFailed,
};

@interface VHUploadModel : NSObject

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) VHVodInfo *vodInfo;
@property (nonatomic, assign) float progress;//0~1
@property UploadStatus uploadStatus;

@end

NS_ASSUME_NONNULL_END
