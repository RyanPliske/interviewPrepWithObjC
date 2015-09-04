#import <UIKit/UIKit.h>

@interface RPAlbumView : UIView

- (instancetype)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover;
@property (nonatomic) UIImageView *coverImage;

@end
