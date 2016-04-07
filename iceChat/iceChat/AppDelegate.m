//
//  AppDelegate.m
//  iceChat
//
//  Created by kangbing on 16/4/7.
//  Copyright © 2016年 kangbing. All rights reserved.
//
/*
 
  App Key   pgyu6atqywf3u
 
  App Secret    ciq0RlJfLzlX0
 */

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"

@interface AppDelegate ()<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] initWithAppKey:@"pgyu6atqywf3u"];
    
    
    [[RCIM sharedRCIM] connectWithToken:@"nOgMeXlDBhFfMsx7+xk1HO0N3haOI1oaNQBpAwYv5hk021Cu0M+rMDeuqmu1SkBf/L7tuHUdT5c=" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        
        // 设置用户名字
        [[RCIM sharedRCIM]setUserInfoDataSource:self];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ChatListViewController *chatList = [[ChatListViewController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:chatList];
            
           
            self.window.rootViewController = nav;
            
        });
        
        
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
    
    
    return YES;
}


- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    
    if ([userId isEqualToString:@"000"]) {
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"000";
        user.name = @"kangbing";
        
        
        return completion(user);
        
    }
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
