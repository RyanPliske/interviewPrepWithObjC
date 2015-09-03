#import "RPHorizontalScroller.h"

#define VIEW_PADDING 10
#define VIEW_DIMENSIONS 100
#define VIEWS_OFFSET 100

@interface RPHorizontalScroller () <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scroller;

@end

@implementation RPHorizontalScroller

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scroller.delegate = self;
        [self addSubview:self.scroller];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [self.scroller addGestureRecognizer:tapRecognizer];
    }
    return self;
}


- (void)scrollerTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    // we can't use an enumerator here, because we don't want to enumerate over ALL of the UIScrollView subviews.
    // we want to enumerate only the subviews that we added
    NSInteger numberOfSubviews = [self.delegate numberOfViewsForHorizontalScroller:self];
    for (int index = 0; index < numberOfSubviews; index++)
    {
        UIView *view = self.scroller.subviews[index];
        if (CGRectContainsPoint(view.frame, location))
        {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];
            // Center the tapped view
            [self.scroller setContentOffset:CGPointMake(view.frame.origin.x - self.frame.size.width / 2.0 + view.frame.size.width / 2.0, 0) animated:YES];
            break;
        }
    }
}

- (void)reload {
    [self.scroller.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat xCoordinateForView = VIEWS_OFFSET;
    NSInteger numberOfSubviews = [self.delegate numberOfViewsForHorizontalScroller:self];
    for (int i = 0; i < numberOfSubviews; i++) {
        xCoordinateForView += VIEW_PADDING;
        UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xCoordinateForView, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [self.scroller addSubview:view];
        xCoordinateForView += VIEW_DIMENSIONS + VIEW_PADDING;
    }
    
    [self.scroller setContentSize:CGSizeMake(xCoordinateForView + VIEWS_OFFSET, self.frame.size.height)];
    
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
        int initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        [self.scroller setContentOffset:CGPointMake(initialView*(VIEW_DIMENSIONS+(2*VIEW_PADDING)), 0) animated:YES];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self reload];
}

- (void)centerCurrentView
{
    int xFinal = self.scroller.contentOffset.x + (VIEWS_OFFSET/2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS+(2*VIEW_PADDING));
    xFinal = viewIndex * (VIEW_DIMENSIONS+(2*VIEW_PADDING));
    [self.scroller setContentOffset:CGPointMake(xFinal,0) animated:YES];
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
}

#pragma UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerCurrentView];
}

@end
