
#import "OBTabBarController.h"

@class LeagueVC;
@class GamesVC;

@interface GossipLeagueAppDelegate : NSObject <UIApplicationDelegate, OBTabBarControllerDelegate> {

}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) OBTabBarController *tabBarController;
@property (nonatomic, strong) IBOutlet LeagueVC   *viewController;

@end
