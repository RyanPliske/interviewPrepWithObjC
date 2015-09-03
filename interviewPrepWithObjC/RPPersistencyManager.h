#import <Foundation/Foundation.h>
#import "RPAlbum.h"

@interface RPPersistencyManager : NSObject

- (NSArray *)getAlbums;
- (void)addAlbum:(RPAlbum *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
