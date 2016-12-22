#import "ViewController.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>
#import "InfoTableViewCell.h"
#import "Person.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *infoTable;
@property (nonatomic,strong)Person *person;
@end

@implementation ViewController

-(UIRectEdge)edgesForExtendedLayout
{
    
    return UIRectEdgeNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"info";
    self.infoTable = [[UITableView alloc] init];
    [self.view addSubview:self.infoTable];
    
    [self.infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.infoTable registerClass:[InfoTableViewCell class] forCellReuseIdentifier:kInfoTableViewCell];
    
    self.infoTable.backgroundColor = [UIColor whiteColor];
    self.infoTable.delegate = self;
    self.infoTable.dataSource = self;
    self.person=[Person new];
    self.person.pid=10;
    self.person.desc=@"HYBMasonryAutoCellHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.hybblog.com/masonryjie-shao/，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *stateKey = nil;
    if (self.person.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
   
    return [InfoTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        InfoTableViewCell *cell=(InfoTableViewCell*)sourceCell;
        [cell configCellWithModel:self.person];
    } cache:^NSDictionary *{
       
        return @{kHYBCacheUniqueKey:[NSString stringWithFormat:@"%ld",self.person.pid],kHYBCacheStateKey:stateKey,kHYBRecalculateForStateKey:@(NO)};
    }];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kInfoTableViewCell];
    if(cell==nil)
    {
        cell=[[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kInfoTableViewCell];
    }
    [cell configCellWithModel:self.person];
    cell.expandBlock = ^(BOOL isExpand) {
        
        self.person.isExpand =isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
