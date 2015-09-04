#import "RPPersistencyManager.h"

@interface RPPersistencyManager () {
    NSMutableArray *_albums;
}
@end

@implementation RPPersistencyManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _albums = [self dummyListOfAlbums];
    }
    return self;
}

- (NSArray *)getAlbums {
    return _albums;
}

- (void)addAlbum:(RPAlbum *)album atIndex:(int)index {
    if (_albums.count >= index) {
        [_albums insertObject:album atIndex:index];
    } else {
        [_albums addObject:album];
    }
}

- (void)deleteAlbumAtIndex:(int)index {
    [_albums removeObjectAtIndex:index];
}



#pragma Helpers
- (NSMutableArray *)dummyListOfAlbums {
    return [NSMutableArray arrayWithArray:
     @[[[RPAlbum alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png" year:@"1992"],
       [[RPAlbum alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png" year:@"2003"],
       [[RPAlbum alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png" year:@"1999"],
       [[RPAlbum alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png" year:@"2000"],
       [[RPAlbum alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png" year:@"2000"]]];
}

- (void)saveImage:(UIImage*)image filename:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage*)getImage:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

@end
