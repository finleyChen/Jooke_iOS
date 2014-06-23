//
//  SongObj.h
//  myapp
//
//  Created by Daniel Yang on 5/24/14.
//
//

#import <Foundation/Foundation.h>

@interface SongObj : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int duration;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *selector;

@end
