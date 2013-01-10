//
//  AppDelegate.m
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import "AppDelegate.h"
#import "PostsViewController.h"

#import "NSRConfig.h"

@implementation AppDelegate

@synthesize window, navigationController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSRConfig defaultConfig] setAppURL:@"http://localhost:3000"];
    
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    
    PostsViewController *posts = [[PostsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:posts];
    
    self.window.rootViewController = self.navigationController;
    
    [window makeKeyAndVisible];
    
    return YES;
    
}

+ (void) alertForError:(NSError *)e
{
    NSString *errorString;
    
    NSDictionary *validationErrors = [[e userInfo] objectForKey:NSRValidationErrorsKey];
    
    if (validationErrors)
    {
        errorString = [NSString string];
        
        for (NSString *failedProperty in validationErrors)
        {
            for (NSString *reason in [validationErrors objectForKey:failedProperty])
            {
                errorString = [errorString stringByAppendingFormat:@"%@ %@. ", [failedProperty capitalizedString], reason];
            }
        }
    }
    else
    {
        if (e.domain == NSRRemoteErrorDomain)
        {
            errorString = @"Something went wrong.  Please try again later or contact us if this error continues.";
        }
        else
        {
            errorString = @"There was an error connecting to the server.";
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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

@end
