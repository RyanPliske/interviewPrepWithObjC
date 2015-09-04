#import "RPViewController.h"
#import "RPItemModel.h"
#import "RPLibraryAPI.h"
#import "RPAlbum+TableRepresentation.h"
#import "RPHorizontalScroller.h"
#import "RPAlbumView.h"

@interface RPViewController () <UITableViewDataSource, UITableViewDelegate, RPHorizontalScrollerDelegate>

@property (nonatomic) RPItemModel *itemModel;
@property (nonatomic) UITableView *dataTable;
@property (nonatomic) NSArray *allAlbums;
@property (nonatomic) NSDictionary *currentAlbumData;
@property (nonatomic, unsafe_unretained) int currentAlbumIndex;
@property (nonatomic) RPHorizontalScroller *scroller;

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
    
    self.scroller = [[RPHorizontalScroller alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    self.scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    self.scroller.delegate = self;
    [self.view addSubview:self.scroller];
    
    
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [self loadPreviousState];
    [self reloadScroller];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showDataForAlbumAtIndex:(int)albumIndex {
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

- (void)reloadScroller
{
    self.allAlbums = [[RPLibraryAPI sharedInstance] getAlbums];
    if (self.currentAlbumIndex < 0) self.currentAlbumIndex = 0;
    else if (self.currentAlbumIndex >= self.allAlbums.count) self.currentAlbumIndex = self.allAlbums.count-1;
    [self.scroller reload];
    
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

- (void)saveCurrentState
{
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentAlbumIndex forKey:@"currentAlbumIndex"];
}

- (void)loadPreviousState
{
    self.currentAlbumIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentAlbumIndex"];
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
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

#pragma mark - RPHorizontalScrollerDelegate methods

- (void)horizontalScroller:(RPHorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    self.currentAlbumIndex = index;
    [self showDataForAlbumAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(RPHorizontalScroller*)scroller
{
    return self.allAlbums.count;
}

- (UIView *)horizontalScroller:(RPHorizontalScroller*)scroller viewAtIndex:(int)index
{
    RPAlbum *album = self.allAlbums[index];
    RPAlbumView *albumView = [[RPAlbumView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) albumCover:album.coverUrl];
    [self downloadImageFor:albumView.coverImage withUrl:album.coverUrl];
    return albumView;
}

-(NSInteger)initialViewIndexForHorizontalScroller:(RPHorizontalScroller *)scroller {
    return self.currentAlbumIndex;
}

#pragma mark - RPAlbumViewDelegate

- (void)downloadImageFor:(UIImageView *)imageView withUrl:(NSString *)coverUrl {
    [[RPLibraryAPI sharedInstance] downloadImageFor:imageView withUrl:coverUrl];
}

@end
