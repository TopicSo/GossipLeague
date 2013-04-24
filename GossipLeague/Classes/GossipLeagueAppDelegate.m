#import <Parse/Parse.h>
#import "GossipLeagueAppDelegate.h"
#import "LeagueVC.h"
#import "GamesVC.h"
#import "ComperatorVC.h"
#import "PlayerEntity.h"

#import <AVFoundation/AVFoundation.h>

@interface GossipLeagueAppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end


@implementation GossipLeagueAppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [self setup:application];
    [self createGossipLeagueTabBarControlloer];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)setup:(UIApplication *)application
{
    [OBConnection registerWithBaseUrl:[NSURL URLWithString:@"http://gossip-league-api.herokuapp.com"]];
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - View Controllers
- (void)createGossipLeagueTabBarControlloer
{
    self.tabBarController  = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[
                                              [self createNavigationChartsController],
                                              [self createNavigationGamesController],
                                              [self createNavigationComperatorController]
                                              ];
   [self easterEggPEPE];
}

- (UINavigationController *)createNavigationChartsController
{
    UINavigationController *navigationChartsController = [[UINavigationController alloc] initWithRootViewController:[[LeagueVC alloc] init]];
    navigationChartsController.tabBarItem.image = [UIImage imageNamed:@"sock"];
    return navigationChartsController;
}

- (UINavigationController *)createNavigationGamesController
{
    UINavigationController *navigationGamesController = [[UINavigationController alloc] initWithRootViewController:[[GamesVC alloc] init]];
    navigationGamesController.tabBarItem.image = [UIImage imageNamed:@"soccer"];
    return navigationGamesController;
}

- (UINavigationController *)createNavigationComperatorController
{
    UINavigationController *navigationComperatorController = [[UINavigationController alloc] initWithRootViewController:[[ComperatorVC alloc] init]];
    navigationComperatorController.tabBarItem.image = [UIImage imageNamed:@"vs"];
    navigationComperatorController.tabBarItem.title = @"Comperator";
    return navigationComperatorController;
}

#pragma mark - Easter egg
- (void) easterEggPEPE
{
    self.tabBarController.delegate = self;
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"champions-theme"
                                                                  ofType:@"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        NSError *theError = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                             error:&theError];
    });
    
    static NSUInteger tabTaps;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        tabTaps = 0;
    });
    
    tabTaps += 1;
    
    if (tabTaps == 5) {
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }
    
    if (tabTaps == 2) {
        if (self.player.isPlaying) {
            [self.player stop];
        }

    }
}

@end
