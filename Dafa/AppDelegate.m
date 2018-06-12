//
//  AppDelegate.m
//  Dafa
//
//  Created by jan on 2018/6/8.
//  Copyright © 2018 Unity. All rights reserved.
//

#import "AppDelegate.h"
#import "ngg_webViewController.h"
#import "ngg_commonMacro.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    ngg_webViewController *controller = [ngg_webViewController new];
    _window.rootViewController = controller;
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

        [[NSNotificationCenter defaultCenter] postNotificationName:kScreenCallbackNotification object:nil userInfo:@{@"code" : @0}];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kScreenCallbackNotification object:nil userInfo:@{@"code" : @1}];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
