//
//  VHUploadCell.m
//  UploadDemo
//
//  Created by vhall on 2019/10/24.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "VHUploadCell.h"

@implementation VHUploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 3;
        [self addSubview:self.titleLabel];
        
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.progressView.progressTintColor = [UIColor redColor];
        self.progressView.trackTintColor = [UIColor lightGrayColor];
        self.progressView.progressViewStyle = UIProgressViewStyleBar;
        [self addSubview:self.progressView];
        
        self.progressLabel = [[UILabel alloc] init];
        self.progressLabel.textColor = [UIColor redColor];
        self.progressLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.progressLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressView.frame = CGRectMake(8, CGRectGetHeight(self.frame)-8, CGRectGetWidth(self.frame)-16, 16);
    self.titleLabel.frame = CGRectMake(8, 8, self.frame.size.width-16, CGRectGetHeight(self.frame)-32);
    self.progressLabel.frame = CGRectMake(CGRectGetWidth(self.frame)-100-6, CGRectGetHeight(self.frame)-20-6, 100, 20);
}

- (void)setModel:(VHUploadModel *)model
{
    self.titleLabel.text = model.vodInfo.name;
    self.progressView.progress = model.progress;
}

@end
