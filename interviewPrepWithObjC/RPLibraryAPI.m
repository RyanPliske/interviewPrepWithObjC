#import "RPLibraryAPI.h"
#import "RPPersistencyManager.h"
#import "RPNetworkClient.h"

@interface RPLibraryAPI ()

@property (nonatomic, readonly) RPPersistencyManager *persistencyManager;
@property (nonatomic, readonly) RPNetworkClient *networkClient;
@property (nonatomic, unsafe_unretained) BOOL isOnline;

@end

@implementation RPLibraryAPI

+ (RPLibraryAPI *)sharedInstance {
    static RPLibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[RPLibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _persistencyManager = [[RPPersistencyManager alloc] init];
        _networkClient = [[RPNetworkClient alloc] init];
    }
    return self;
}

- (NSArray *)getAlbums {
    return [self.persistencyManager getAlbums];
}

- (void)addAlbum:(RPAlbum *)album atIndex:(int)index {
    [self.persistencyManager addAlbum:album atIndex:index];
    if (self.isOnline) {
        [self.networkClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index {
    [self.persistencyManager deleteAlbumAtIndex:index];
    if (self.isOnline) {
        [self.networkClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

@end
