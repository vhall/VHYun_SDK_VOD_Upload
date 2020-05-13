//
//  VHListUploadViewController.m
//  UploadDemo
//
//  Created by vhall on 2019/10/24.
//  Copyright © 2019 vhall. All rights reserved.
//

#import "VHListUploadViewController.h"
#import <VHUpload/VHUploaderClient.h>
#import "VHUploadModel.h"
#import "VHUploadCell.h"

@interface VHListUploadViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation VHListUploadViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 100)];
    [addBtn setTitle:@"点击添加视频上传" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-100-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

- (void)addBtnClick:(UIButton *)addBtn
{
    [super uploadBtnClick:addBtn];
}


#pragma mark - 上传
- (void)addUploadFileWithPath:(NSString *)filePath
{
    [super addUploadFileWithPath:filePath];
    
//    VHUploadModel *model = [[VHUploadModel alloc] init];
//    model.vodInfo = [[VHVodInfo alloc] init];
//    model.vodInfo.name = [filePath lastPathComponent];
//    model.vodInfo.desc = [NSString stringWithFormat:@"测试上传_iOS_%f",[[NSDate date] timeIntervalSince1970]];
//    model.filePath = filePath;
//    
//    [self.dataSource addObject:model];
//    [self.tableView reloadData];
//    
//    __weak typeof(self)weakSelf = self;

//    [self.uploder uploadFilePath:model.filePath vodInfo:model.vodInfo progress:^(VHUploadFileInfo * _Nonnull fileInfo, int64_t uploadedSize, int64_t totalSize) {
//
//        NSInteger index = [weakSelf.dataSource indexOfObject:model];
//        model.progress = 1.f * uploadedSize / totalSize;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        //主线程刷新progress
//        dispatch_async(dispatch_get_main_queue(), ^{
//            VHUploadCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
//            cell.progressView.progress = model.progress;
//            cell.progressLabel.text = [NSString stringWithFormat:@"%f",model.progress];
//        });
//    } success:^(VHUploadFileInfo * _Nonnull fileInfo) {
//
//    } failure:^(VHUploadFileInfo * _Nullable fileInfo, NSError * _Nonnull error) {
//
//    }];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"VHUploadCell";
    VHUploadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VHUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setModel:self.dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
