#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RPNetworkClient : NSObject

- (id)getRequest:(NSString *)url;
- (id)postRequest:(NSString *)url body:(NSString *)body;
- (UIImage *)downloadImage:(NSString *)url;

@end
