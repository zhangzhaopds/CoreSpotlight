//
//  ViewController.m
//  CoreSpotlight
//
//  Created by 张昭 on 16/2/29.
//  Copyright © 2016年 张昭. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreSpotlight/CoreSpotlight.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *searchItemArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"图书推荐";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
    self.dataArr = [NSMutableArray arrayWithContentsOfFile:path];
    
    
    
    [self creatTableView];
    
    [self setSpotligtht];
}

// 设置spotlight
- (void)setSpotligtht {
    self.searchItemArr = [NSMutableArray array];
    int i = 0;
    for (NSDictionary *dic in self.dataArr) {
        CSSearchableItemAttributeSet *searchItemSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeText];
        searchItemSet.title = [dic objectForKey:@"title"];
        searchItemSet.contentDescription = [dic objectForKey:@"desc"];
        NSArray *arr = [[dic objectForKey:@"picture"] componentsSeparatedByString:@"."];
        searchItemSet.thumbnailURL = [[NSBundle mainBundle] URLForResource:arr[0] withExtension:arr[1]];
        
        // 搜索关键词 keywords(字符串形式) / contactKeywords(数组形式)
        searchItemSet.keywords = [dic objectForKey:@"title"];
        
        /*
         uniqueIdentifier：这个参数唯一地标识Spotlight当前搜索项。你可以用你喜欢的方式构造这个唯一标示符。
         domainIdentifier:使用这个参数对搜索项进行分组。
         attributeSet：它就是我们刚刚设置属性时的属性设置对象。
         */
        CSSearchableItem *searchItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:[NSString stringWithFormat:@"com.spolight.%d", i] domainIdentifier:@"books" attributeSet:searchItemSet];
        [self.searchItemArr addObject:searchItem];
        i++;
    }
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:self.searchItemArr completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"reuse"];
    self.tableView.rowHeight = 110;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.dictionary = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
