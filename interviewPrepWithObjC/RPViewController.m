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
@property (nonatomic) UIToolbar *toolBar;
@property (nonatomic) NSMutableArray *undoStack;

@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemModel = [[RPItemModel alloc] init];
    
    _toolBar = [[UIToolbar alloc] init];
    UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoAction)];
    undoItem.enabled = NO;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAlbum)];
    [self.toolBar setItems:@[undoItem,space,delete]];
    [self.view addSubview:self.toolBar];
    _undoStack = [[NSMutableArray alloc] init];
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

- (void)viewWillLayoutSubviews {
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    self.dataTable.frame = CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height - 200);
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
    [[RPLibraryAPI sharedInstance] saveAlbums];
}

- (void)loadPreviousState
{
    self.currentAlbumIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentAlbumIndex"];
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

- (void)addAlbum:(RPAlbum*)album atIndex:(int)index
{
    [[RPLibraryAPI sharedInstance] addAlbum:album atIndex:index];
    self.currentAlbumIndex = index;
    [self reloadScroller];
}

- (void)deleteAlbum
{
    RPAlbum *deletedAlbum = self.allAlbums[self.currentAlbumIndex];
    
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(addAlbum:atIndex:)];
    NSInvocation *undoAction = [NSInvocation invocationWithMethodSignature:sig];
    [undoAction setTarget:self];
    [undoAction setSelector:@selector(addAlbum:atIndex:)];
    [undoAction setArgument:&deletedAlbum atIndex:2];
    [undoAction setArgument:&_currentAlbumIndex atIndex:3];
    [undoAction retainArguments];
    
    [self.undoStack addObject:undoAction];
    
    [[RPLibraryAPI sharedInstance] deleteAlbumAtIndex:self.currentAlbumIndex];
    [self reloadScroller];
    
    [self.toolBar.items[0] setEnabled:YES];
}

- (void)undoAction
{
    if (self.undoStack.count > 0)
    {
        NSInvocation *undoAction = [self.undoStack lastObject];
        [self.undoStack removeLastObject];
        [undoAction invoke];
    }
    
    if (self.undoStack.count == 0)
    {
        [self.toolBar.items[0] setEnabled:NO];
    }
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
