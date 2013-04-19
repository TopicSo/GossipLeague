@class GossipLeagueVC;
@class GossipGamesVC;

@interface GossipLeagueAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) IBOutlet GossipLeagueVC   *viewController;

@end
