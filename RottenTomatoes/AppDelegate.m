//
//  AppDelegate.m
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "AppDelegate.h"
#import "TopDVDSViewController.h"
#import "UIColor+Expanded.h"
#import "Reachability.h"
#import "BoxOffViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //To check for internet
   // Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    //[reachability startNotifier];
    
    
    TopTenViewController *topTenVC=[[TopTenViewController alloc]initWithEnum:Top_Ten_Url];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:topTenVC];
    navigationController.tabBarItem.title=@"Top DVDs";
    navigationController.tabBarItem.image=[UIImage imageNamed:@"cd"];
    

    TopTenViewController *boxOffVC=[[TopTenViewController alloc]initWithEnum:BoxOfficeUrl];
    UINavigationController *navigationControllerForBoxOffVC = [[UINavigationController alloc]initWithRootViewController:boxOffVC];
    navigationControllerForBoxOffVC.tabBarItem.title=@"Box Office";
    navigationControllerForBoxOffVC.tabBarItem.image=[UIImage imageNamed:@"clapper"];
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[navigationController, navigationControllerForBoxOffVC];
    
    self.window.rootViewController = tabBarController;
    
    
    
    [self customUserInterface];
    
    //For Image caching that is used by AFNetworking
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:200 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper Methods
-(void) customUserInterface {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:@"#3b5999"]]; //background Nav bar color
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];  //the item bar button color
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}]; // title text color
    
    [[UITableView appearance] setBackgroundColor:[UIColor colorFromHexString:@"#eeeff4"]];
    [[UITableView appearance] setTableFooterView:[[UIView alloc] init]];
    
    
    
}

@end
