#import <UIKit/UIKit.h>
@class Person;

static NSString *kInfoTableViewCell=@"InfoTableViewCell";
typedef void(^HYBExpandBlock)(BOOL isExpand);

@interface InfoTableViewCell : UITableViewCell
@property (nonatomic, copy) HYBExpandBlock expandBlock;
-(void)configCellWithModel:(Person*)person;
@end
