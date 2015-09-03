#import "RPViewController.h"
#import "RPItemModel.h"

@interface RPViewController ()
@property (nonatomic) RPItemModel *itemModel;
@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemModel = [[RPItemModel alloc] init];
}

@end
