//
//  VHUploadCell.h
//  UploadDemo
//
//  Created by vhall on 2019/10/24.
//  Copyright © 2019 vhall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHUploadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VHUploadCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, strong) VHUploadModel *model;

@end

NS_ASSUME_NONNULL_END
