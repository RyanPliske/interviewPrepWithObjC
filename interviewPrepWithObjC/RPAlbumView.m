#import "RPAlbumView.h"

@implementation RPAlbumView
{
    UIActivityIndicatorView *_indicator;
}

- (instancetype)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:_coverImage];
        
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.center = self.center;
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [_indicator startAnimating];
        [self addSubview:_indicator];
        
        [_coverImage addObserver:self forKeyPath:@"image" options:0 context:nil];
    }
    return self;
}

- (void)dealloc
{
    [_coverImage removeObserver:self forKeyPath:@"image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        [_indicator stopAnimating];
    }
}

@end
