//
//  SongObj.m
//  myapp
//
//  Created by Daniel Yang on 5/24/14.
//
//

#import "SongObj.h"

@implementation SongObj

- (NSComparisonResult)compare:(SongObj *)otherObject {
    return [self.name compare:otherObject.name];
}

@end
