#import "RPViewController.h"
#import "RPItemModel.h"

@interface RPViewController ()
@property (nonatomic) RPItemModel *itemModel;
@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemModel = [[RPItemModel alloc] init];
    NSString *ryanReversed = [self reverseItemName:@"Ryan"];
    NSLog(@"Ryan reversed %@", ryanReversed);
}

- (NSString *)reverseItemName:(NSString *)itemName {
    NSUInteger charactersRemaining = itemName.length;
    NSMutableString *reversedString = [[NSMutableString alloc] init];
    
    while (charactersRemaining > 0) {
        charactersRemaining--;
        [reversedString appendString:[itemName substringWithRange:NSMakeRange(charactersRemaining, 1)]];
    }
    
    return reversedString;
}

@end
