#import <Foundation/Foundation.h>

@interface RPItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, readonly, copy) NSString *serialNumber;
@property (nonatomic, readonly, unsafe_unretained) NSInteger valueInDollars;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic) RPItem *containedItem;
@property (nonatomic) RPItem *container;


+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name;

- (NSString *)getSerialNumber;

- (void)setSerialNumber:(NSString *)serialNumber;

- (NSMutableArray *)printFizzBuzzForFirstNumber:(NSInteger)number withLastNumber:(NSInteger)end withArray:(NSMutableArray *)resultingArray;

@end
