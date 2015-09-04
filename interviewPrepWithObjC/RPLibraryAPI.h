#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RPAlbum.h"

@interface RPLibraryAPI : NSObject

+ (RPLibraryAPI *)sharedInstance;
- (NSArray *)getAlbums;
- (void)addAlbum:(RPAlbum *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;
- (void)downloadImageFor:(UIImageView *)imageView withUrl:(NSString *)coverUrl;

@end
