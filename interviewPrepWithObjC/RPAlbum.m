#import "RPAlbum.h"

@interface RPAlbum ()

@end

@implementation RPAlbum

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist coverUrl:(NSString *)coverUrl year:(NSString *)year {
    self = [super init];
    if (self) {
        _title = title;
        _artist = artist;
        _coverUrl = coverUrl;
        _year = year;
        _genre = @"Pop";
    }
    return self;
}

@end
