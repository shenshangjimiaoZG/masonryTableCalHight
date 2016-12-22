#import "InfoTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "HomeMyFunationBtn.h"
#import "Person.h"

@interface InfoTableViewCell ()
@property (nonatomic,strong)UILabel *lblTitle;
@property (nonatomic,strong)UILabel *lblDesc;
@property (nonatomic,strong)HomeMyFunationBtn *btnAction;
@property (nonatomic,assign)BOOL isExpandedNow;
@end

@implementation InfoTableViewCell

-(void)setupHeaderView:(NSString*)title withSuperView:(HomeMyFunationBtn*)btn
{
    btn.lblName.text=title;
    btn.lblName.userInteractionEnabled=NO;
    btn.icon.userInteractionEnabled=NO;
    
    [btn.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(btn);
        make.left.equalTo(btn.lblName.mas_right).offset(3);
        make.size.mas_equalTo(btn.icon.image.size);
    }];
    [btn.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(btn);
        make.left.equalTo(btn.mas_left);
        
    }];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.lblTitle=[UILabel new];
        self.lblTitle.text=@"title:";
        self.lblTitle.font=[UIFont systemFontOfSize:14];
        self.lblTitle.textColor=[UIColor redColor];
        self.lblTitle.text=@"title:";
        self.lblTitle.backgroundColor=[UIColor greenColor];
        
        [self.contentView addSubview:self.lblTitle];
        
        self.lblDesc=[UILabel new];
        self.lblDesc.backgroundColor=[UIColor darkGrayColor];
        self.lblDesc.numberOfLines=0;
        self.lblDesc.font=[UIFont systemFontOfSize:14];
        self.lblDesc.textColor=[UIColor redColor];
        self.lblDesc.lineBreakMode = NSLineBreakByTruncatingHead;
        [self.contentView addSubview:self.lblDesc];
        
        self.btnAction=[HomeMyFunationBtn buttonWithType:UIButtonTypeCustom];
        self.btnAction.icon=[UIImageView new];
        self.btnAction.icon.image=[UIImage imageNamed:@"zhankai"];
        self.btnAction.icon.contentMode=UIViewContentModeScaleAspectFit;
        self.btnAction.userInteractionEnabled=YES;
        [self.btnAction addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnAction addSubview:self.btnAction.icon];
        
        self.btnAction.lblName=[UILabel new];
        self.btnAction.lblName.font=[UIFont systemFontOfSize:13];
        self.btnAction.lblName.textColor=[UIColor lightGrayColor];
        self.btnAction.lblName.text=nil;
        [self.btnAction addSubview:self.btnAction.lblName];
        
        
        [self.contentView addSubview:self.btnAction];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.lblDesc.mas_left).offset(-20);
            
            make.width.equalTo(@58);
            make.height.equalTo(@17);
            
        }];
        [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.lblTitle.mas_right).offset(20);
            make.width.equalTo(@300);
            make.height.equalTo(@17);
            
            make.bottom.equalTo(self.btnAction.mas_top).offset(-10);
        }];
        
        [self.btnAction mas_makeConstraints:^(MASConstraintMaker *make) {
            
           
            make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
            make.left.equalTo(self.lblDesc.mas_left);
            make.size.mas_equalTo(CGSizeMake(50, 40));
            
        }];
        
        
        [self setupHeaderView:@"展开" withSuperView:self.btnAction];
        self.btnAction.hidden=YES;
        
        
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1]];
        
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];

        self.isExpandedNow=NO;
                
    }
    
    
    return self;
}
-(void)configCellWithModel:(Person *)person
{
    CGFloat h=[person.desc boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    self.lblDesc.text=person.desc;
    
    self.isExpandedNow=person.isExpand;
    
    if(h>40)
    {
        
        
        self.btnAction.hidden=NO;
        
        if(self.isExpandedNow==NO)
        {
            [self.lblTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.left.equalTo(self.contentView.mas_left).offset(12);
                make.right.equalTo(self.lblDesc.mas_left).offset(-20);
                make.width.equalTo(@58);
                make.height.equalTo(@17);
            }];
            
            [self.lblDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.left.equalTo(self.lblTitle.mas_right).offset(20);
                make.width.equalTo(@300);
                make.height.equalTo(@40);
                
                make.bottom.equalTo(self.btnAction.mas_top).offset(-10);
                
            }];
            
            [self.btnAction mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
                make.left.equalTo(self.lblDesc.mas_left);
                make.size.mas_equalTo(CGSizeMake(50, 40));
                
            }];

        }
        else
        {
            [self.lblTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.left.equalTo(self.contentView.mas_left).offset(12);
                make.right.equalTo(self.lblDesc.mas_left).offset(-20);
                make.width.equalTo(@58);
                make.height.equalTo(@17);
            }];
            
            [self.lblDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.left.equalTo(self.lblTitle.mas_right).offset(20);
                make.width.equalTo(@300);
                make.height.equalTo(@(h+20));
                
                make.bottom.equalTo(self.btnAction.mas_top).offset(-10);
                
            }];
            
            [self.btnAction mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
                make.left.equalTo(self.lblDesc.mas_left);
                make.size.mas_equalTo(CGSizeMake(50, 40));
                
            }];

        }
    }
    
}
- (IBAction)showMore:(HomeMyFunationBtn*)sender {
    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
    }
    
}
@end
