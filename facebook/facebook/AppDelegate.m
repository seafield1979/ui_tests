//
//  AppDelegate.m
//  facebook
//
//  Created by B02681 on 2014/02/26.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
#if 1
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	RootViewController *rootViewController = [[RootViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [_window setRootViewController:rootViewController];
    
    [_window makeKeyAndVisible];

#else
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
#endif
	//facebookインスタンスの作成
//	NSString *appId = [FBSettings defaultAppID];
//    _facebook = [[Facebook alloc]initWithAppId:appId andDelegate:_viewController];
//    
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


// FBSample logic
// It is possible for the user to switch back to your application, from the native Facebook application,
// when the user is part-way through a login; You can check for the FBSessionStateCreatedOpenening
// state in applicationDidBecomeActive, to identify this situation and close the session; a more sophisticated
// application may choose to notify the user that they switched away from the Facebook application without
// completely logging in
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
	
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
//    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Facebook SDK
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
#if 1
	return [FBSession.activeSession handleOpenURL:url];
#else
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
#endif
}


@end
