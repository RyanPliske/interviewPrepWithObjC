#import <UIKit/UIKit.h>

@class RPHorizontalScroller;
@protocol RPHorizontalScrollerDelegate <NSObject>

@required
// ask the delegate how many views he wants to present inside the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(RPHorizontalScroller*)scroller;

// ask the delegate to return the view that should appear at <index>
- (UIView*)horizontalScroller:(RPHorizontalScroller*)scroller viewAtIndex:(int)index;

// inform the delegate what the view at <index> has been clicked
- (void)horizontalScroller:(RPHorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional
// ask the delegate for the index of the initial view to display. this method is optional
// and defaults to 0 if it's not implemented by the delegate
- (NSInteger)initialViewIndexForHorizontalScroller:(RPHorizontalScroller*)scroller;

@end

@interface RPHorizontalScroller : UIView

@property (weak) id<RPHorizontalScrollerDelegate> delegate;

- (void)reload;

@end