#import "RPNetworkClient.h"

@implementation RPNetworkClient

- (id)getRequest:(NSString *)url
{
    return nil;
}

- (id)postRequest:(NSString *)url body:(NSString *)body
{
    return nil;
}

- (UIImage *)downloadImage:(NSString *)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
//    NSLog(image);
    return image;
}

@end
