#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RPAlbum.h"

@interface RPPersistencyManager : NSObject

- (NSArray *)getAlbums;
- (void)addAlbum:(RPAlbum *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;
- (void)saveAlbums;
- (void)saveImage:(UIImage *)image filename:(NSString *)filename;
- (UIImage *)getImage:(NSString *)filename;

@end
