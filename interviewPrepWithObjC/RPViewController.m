#import "RPViewController.h"
#import "RPItemModel.h"
#import "RPLibraryAPI.h"
#import "RPAlbum+TableRepresentation.h"

@interface RPViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) RPItemModel *itemModel;
@property (nonatomic) UITableView *dataTable;
@property (nonatomic) NSArray *allAlbums;
@property (nonatomic) NSDictionary *currentAlbumData;
@property (nonatomic, unsafe_unretained) int currentAlbumIndex;

@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemModel = [[RPItemModel alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1];
    
    self.currentAlbumIndex = 0;
    self.allAlbums = [[RPLibraryAPI sharedInstance] getAlbums];
    
    self.dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStyleGrouped];
    self.dataTable.delegate = self;
    self.dataTable.dataSource = self;
    self.dataTable.backgroundView = nil;
    [self.view addSubview:self.dataTable];
    
//    self.currentAlbumData = [[NSDictionary alloc] init];
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

- (void)showDataForAlbumAtIndex:(int)albumIndex {
    // defensive code: make sure the requested index is lower than the amount of albums
    if (albumIndex < self.allAlbums.count)
    {
        RPAlbum *album = self.allAlbums[albumIndex];
        self.currentAlbumData = [album tr_tableRepresentation];
    }
    else
    {
        self.currentAlbumData = nil;
    }
    
    [self.dataTable reloadData];
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentAlbumData[@"titles"] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.currentAlbumData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = self.currentAlbumData[@"values"][indexPath.row];
    
    return cell;
}

@end
