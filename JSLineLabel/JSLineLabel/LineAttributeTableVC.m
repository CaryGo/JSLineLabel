//
//  LineAttributeTableVC.m
//  JSLineLabel
//
//  Created by Cary on 16/9/28.
//  Copyright © 2016年 Cary. All rights reserved.
//

#import "LineAttributeTableVC.h"
#import "JSLineLabel.h"

@interface LineAttributeTableVC ()
@property(nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation LineAttributeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = [NSMutableArray arrayWithObjects:@"01.行行重行行\n行行重行行，与君生别离。\n相去万余里，各在天一涯。\n道路阻且长，会面安可知？\n胡马依北风，越鸟巢南枝。\n相去日已远，衣带日已缓。\n浮云蔽白日，游子不顾反。\n思君令人老，岁月忽已晚。\n弃捐勿复道，努力加餐饭。",@"02.青青河畔草\n青青河畔草，郁郁园中柳。\n盈盈楼上女，皎皎当窗牖。\n娥娥红粉妆，纤纤出素手。\n昔为倡家女，今为荡子妇。\n荡子行不归，空床难独守。",@"03.青青陵上柏\n青青陵上柏，磊磊涧中石。\n人生天地间，忽如远行客。\n斗酒相娱乐，聊厚不为薄。\n驱车策驽马，游戏宛与洛。\n洛中何郁郁，冠带自相索。\n长衢罗夹巷，王侯多第宅。\n两宫遥相望，双阙百余尺。\n极宴娱心意，戚戚何所迫？",@"04.西北有高楼\n西北有高楼，上与浮云齐。\n交疏结绮窗，阿阁三重阶。\n上有弦歌声，音响一何悲！\n谁能为此曲？无乃杞梁妻。\n清商随风发，中曲正徘徊。\n一弹再三叹，慷慨有余哀。\n不惜歌者苦，但伤知音稀。\n愿为双鸿鹄，奋翅起高飞。",@"05.冉冉孤生竹\n冉冉孤生竹，结根泰山阿。\n与君为新婚，兔丝附女萝。\n兔丝生有时，夫妇会有宜。\n千里远结婚，悠悠隔山陂。\n思君令人老，轩车来何迟！\n伤彼蕙兰花，含英扬光辉。\n过时而不采，将随秋草萎。\n君亮执高节，贱妾亦何为！",@"06.涉江采芙蓉\n涉江采芙蓉，兰泽多芳草。\n采之欲遗谁？所思在远道。\n还顾望旧乡，长路漫浩浩。\n同心而离居，忧伤以终老！",@"07.迢迢牵牛星\n迢迢牵牛星，皎皎河汉女。\n纤纤擢素手，札札弄机杼。\n终日不成章，泣涕零如雨。\n河汉清且浅，相去复几许？\n盈盈一水间，脉脉不得语。",@"08.生年不满百\n生年不满百，常怀千岁忧。\n昼短苦夜长，何不秉烛游！\n为乐当及时，何能待来兹？\n愚者爱惜费，但为后世嗤。\n仙人王子乔，难可与等期。", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = self.dataSource[indexPath.row];
    CGSize size = [JSLineLabel getLabelSizeWithText:str labelFont:UIFontSystem(14) lineHeight:40 maxWidth:js_screenW-20 verticalEdgeInsets:JSLineVerticalEdgeInsetsMake(10, 5)];
    return size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    for (UIView *child in cell.contentView.subviews) {
        [child removeFromSuperview];
    }
    JSLineLabel * attrLabel = [[JSLineLabel alloc] initWithFrame:CGRectZero labelFont:UIFontSystem(14) lineHeight:40 maxWidth:js_screenW-20];
    attrLabel.verticalInsets = JSLineVerticalEdgeInsetsMake(10, 5);
    attrLabel.labelText = self.dataSource[indexPath.row];
    attrLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row%2==0) {
        [attrLabel setBaseLineWithColor:[UIColor redColor] height:1];
    }
    CGSize size = [attrLabel getLabelSize];
    attrLabel.frame = CGRectMake(10, 0, js_screenW-20, size.height);
    [cell.contentView addSubview:attrLabel];
    return cell;
}

@end
