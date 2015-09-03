#import <Foundation/Foundation.h>
#import "RPAlbum.h"

@interface RPLibraryAPI : NSObject

+ (RPLibraryAPI *)sharedInstance;
- (NSArray *)getAlbums;
- (void)addAlbum:(RPAlbum *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
