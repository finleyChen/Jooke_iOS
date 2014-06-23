//
//  UpcomingViewController.h
//  myapp
//
//  Created by Daniel Yang on 5/24/14.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface UpcomingViewController : UIViewController

@property (nonatomic, strong) NSMutableDictionary *songsDictionary;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlaying;
@property (weak, nonatomic) IBOutlet UILabel *lblPSongName;
@property (weak, nonatomic) IBOutlet UILabel *lblPArtist;
@property (weak, nonatomic) IBOutlet UILabel *lblPTime;
@property (strong, nonatomic) NSString *userType;
@property (strong, nonatomic) NSMutableDictionary *eventInfo;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)onSettingsclicked:(UIButton *)sender;

@end
