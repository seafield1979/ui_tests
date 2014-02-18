//
//  AppDelegate.m
//  draw_test
//
//  Created by 海野 秀祐 on 2013/07/13.
//  Copyright (c) 2013年 海野 秀祐. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ViewController3.h"

#import "ViewController4.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	// Clear and disable cache
	NSURLCache * cache = [NSURLCache sharedURLCache];
	[cache removeAllCachedResponses];
	cache.diskCapacity = 0;
	cache.memoryCapacity = 0;

	// キャッシュを削除する。 debug用
	// これをしないとJavaScriptを差し替えても古いものが呼ばれることがある
	[[NSURLCache sharedURLCache] removeAllCachedResponses];

    // Override point for customization after application launch.
	UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
	UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
	UIViewController *viewController3 = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:nil];
	UIViewController *viewController4 = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];

	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3, viewController4];
	self.window.rootViewController = self.tabBarController;
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
