//
//  ViewController.m
//  facebook
//
//  Created by B02681 on 2014/02/26.
//  Copyright (c) 2014年 B02681. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DEFacebookComposeViewController.h"
#import "UIDevice+DEFacebookComposeViewController.h"

@interface ViewController ()
{
	BOOL m_postingInProgress;
}
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self updateView];
#if 0
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
		
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction method

-(IBAction)fbButtonDidTap:(id)sender
{
	// Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
	
    NSURL *urlToShare = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
	
    // This code demonstrates 3 different ways of sharing using the Facebook SDK.
    // The first method tries to share via the Facebook app. This allows sharing without
    // the user having to authorize your app, and is available as long as the user has the
    // correct Facebook app installed. This publish will result in a fast-app-switch to the
    // Facebook app.
    // The second method tries to share via Facebook's iOS6 integration, which also
    // allows sharing without the user having to authorize your app, and is available as
    // long as the user has linked their Facebook account with iOS6. This publish will
    // result in a popup iOS6 dialog.
    // The third method tries to share via a Graph API request. This does require the user
    // to authorize your app. They must also grant your app publish permissions. This
    // allows the app to publish without any user interaction.
	
    // If it is available, we will first try to post using the share dialog in the Facebook app
#if 0
	UIImage *image = [UIImage imageNamed:@"cat.jpg"];
	[FBDialogs presentOSIntegratedShareDialogModallyFrom:self initialText:@"titleText" image:image url:nil handler:nil];
	

#else
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:urlToShare
                                                          name:@"Hello Facebook"
                                                       caption:nil
                                                   description:@"The 'Hello Facebook' sample application showcases simple Facebook integration."
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"Error: %@", error.description);
                                                           } else {
                                                               NSLog(@"Success!");
                                                           }
                                                       }];
	
    if (!appCall) {
        // Next try to post using Facebook's iOS6 integration
        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                                              initialText:nil
                                                                                    image:nil
                                                                                      url:urlToShare
                                                                                  handler:nil];
		
        if (!displayedNativeDialog) {
            // Lastly, fall back on a request for permissions and a direct post using the Graph API
            [self performPublishAction:^{
                NSString *message = [NSString stringWithFormat:@"Updating status for %@ at %@", self.loggedInUser.first_name, [NSDate date]];
				
                FBRequestConnection *connection = [[FBRequestConnection alloc] init];
				
                connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
                | FBRequestConnectionErrorBehaviorAlertUser
                | FBRequestConnectionErrorBehaviorRetry;
				
                [connection addRequest:[FBRequest requestForPostStatusUpdate:message]
                     completionHandler:^(FBRequestConnection *innerConnection, id result, NSError *error) {
                         [self showAlert:message result:result error:error];
                         //self.buttonPostStatus.enabled = YES;
                     }];
                [connection start];
				
                //self.buttonPostStatus.enabled = NO;
            }];
        }
    }
#endif

}

-(IBAction)fbButton2DidTap:(id)sender
{
	//デリゲートの取得
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    // ダイアログを使用して投稿する場合
	 NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://ameba-oogiri.jp/",@"link",@"caption test",@"caption",@"description test",@"description", nil];
	 
	 [[delegate facebook] dialog:@"feed" andParams:params andDelegate:self];
}

-(IBAction)fbButton3DidTap:(id)sender
{
	DEFacebookComposeViewController *facebookViewComposer = [[DEFacebookComposeViewController alloc] init];
    
    // If you want to use the Facebook app with multiple iOS apps you can set an URL scheme suffix
	//    facebookViewComposer.urlSchemeSuffix = @"facebooksample";
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [facebookViewComposer setInitialText:@"Look on this"];
    
    // optional
    [facebookViewComposer addImage:[UIImage imageNamed:@"1.jpg"]];
    // and/or
    // optional
	//    [facebookViewComposer addURL:[NSURL URLWithString:@"http://applications.3d4medical.com/heart_pro.php"]];
    
    [facebookViewComposer setCompletionHandler:^(DEFacebookComposeViewControllerResult result) {
        switch (result) {
            case DEFacebookComposeViewControllerResultCancelled:
                NSLog(@"Facebook Result: Cancelled");
                break;
            case DEFacebookComposeViewControllerResultDone:
                NSLog(@"Facebook Result: Sent");
                break;
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    if ([UIDevice de_isIOS4]) {
        [self presentModalViewController:facebookViewComposer animated:YES];
    } else {
        [self presentViewController:facebookViewComposer animated:YES completion:^{ }];
    }
    
    //[facebookViewComposer release];
	

}

/**
 * ログイン/ログアウト
 */
- (IBAction)loginButtonDidTap:(id)sender {
    // get the app delegate so that we can access the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        [appDelegate.session closeAndClearTokenInformation];
		
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
		
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    }
}

// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        //[self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [self.textView setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",
									  appDelegate.session.accessTokenData.accessToken]];
    } else {
        // login-needed account UI is shown whenever the session is closed
//        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        [self.textView setText:@"Login to create a link to fetch account data"];
    }
}

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void)performPublishAction:(void(^)(void))action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled) {
                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                                        message:@"Unable to get permission to post"
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                    [alertView show];
                                                }
                                            }];
    } else {
        action();
    }
	
}


// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
	
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
			
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
	
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}













-(void) postWithText: (NSString*) message
           ImageName: (NSString*) image
                 URL: (NSString*) url
             Caption: (NSString*) caption
                Name: (NSString*) name
      andDescription: (NSString*) description
{
	
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   url, @"link",
                                   name, @"name",
                                   caption, @"caption",
                                   description, @"description",
                                   message, @"message",
                                   UIImagePNGRepresentation([UIImage imageNamed: image]), @"picture",
                                   nil];
	
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound)
    {
        // No permissions found in session, ask for it
        [FBSession.activeSession requestNewPublishPermissions: [NSArray arrayWithObject:@"publish_actions"]
                                              defaultAudience: FBSessionDefaultAudienceFriends
                                            completionHandler: ^(FBSession *session, NSError *error)
		 {
             if (!error)
             {
                 // If permissions granted and not already posting then publish the story
                 if (!m_postingInProgress)
                 {
                     [self postToWall: params];
                 }
             }
         }];
    }
    else
    {
        // If permissions present and not already posting then publish the story
        if (!m_postingInProgress)
        {
            [self postToWall: params];
        }
    }
}

-(void) postToWall: (NSMutableDictionary*) params
{
    m_postingInProgress = YES; //for not allowing multiple hits
	
    [FBRequestConnection startWithGraphPath:@"me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             //showing an alert for failure
             UIAlertView *alertView = [[UIAlertView alloc]
                                       initWithTitle:@"Post Failed"
                                       message:error.localizedDescription
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
             [alertView show];
         }
         m_postingInProgress = NO;
     }];
}


@end
