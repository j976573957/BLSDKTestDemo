//
//  ViewController.m
//  DemoPod1
//
//  Created by Mac on 2019/3/18.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ViewController.h"
#import <HorderCatcherFramework/HorderCatcherFramework.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>


@interface ViewController (){
    UITextField* naviBarColorTextField;
    UITextField* liveRoomColorTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络链接通知：%@",AFStringFromNetworkReachabilityStatus(status));
    }];
    
    UIButton* enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
    enterBtn.backgroundColor = [UIColor blackColor];
    [enterBtn setTitle:@"进入部落" forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterBtn];
    
    naviBarColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 30)];
    naviBarColorTextField.textColor = [UIColor blackColor];
    naviBarColorTextField.placeholder = @"标题栏颜色，6位16进制(FFFFFF)";
    [self.view addSubview:naviBarColorTextField];
    
    
    liveRoomColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 30)];
    liveRoomColorTextField.textColor = [UIColor blackColor];
    liveRoomColorTextField.placeholder = @"直播间背景颜色，6位16进制(FFFFFF)";
    [self.view addSubview:liveRoomColorTextField];
    
    
    UIButton* personalBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 300, 30)];
    personalBgBtn.backgroundColor = [UIColor blackColor];
    [personalBgBtn setTitle:@"个人主页背景(未选择)" forState:UIControlStateNormal];
    [personalBgBtn addTarget:self action:@selector(personalBgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:personalBgBtn];
}

- (void)enterBtnClick{
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSLog(@"还没有网络链接通知，请稍后");
        return;
    }
    NSDictionary* dict = @{@"appId":@"1234",@"thirdId":@"56113234"};
    [BLSDKManager shareInstance].navigationBarColorHexStr = naviBarColorTextField.text;
    [BLSDKManager shareInstance].liveRoomBgColorHexStr = liveRoomColorTextField.text;
    [[BLSDKManager shareInstance] enterWithNavigationController:self.navigationController userInfo:dict];
    
    [liveRoomColorTextField resignFirstResponder];
    [naviBarColorTextField resignFirstResponder];
    
}

- (void)personalBgBtnClick:(UIButton*)btn{
    if ([btn.titleLabel.text isEqualToString:@"个人主页背景(未选择)"]) {
        [btn setTitle:@"个人主页背景(已选择)" forState:UIControlStateNormal];
        [BLSDKManager shareInstance].personalBgImageName = @"ww_weitijiao_bg.png";
    }else{
        [btn setTitle:@"个人主页背景(未选择)" forState:UIControlStateNormal];
        [BLSDKManager shareInstance].personalBgImageName = @"";
    }
}
@end
