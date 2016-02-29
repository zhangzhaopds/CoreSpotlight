//
//  CustomCell.m
//  CoreSpotlight
//
//  Created by 张昭 on 16/2/29.
//  Copyright © 2016年 张昭. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.dictionary = [NSDictionary dictionary];
        
        self.pic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.pic];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.descLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.descLabel];
        self.descLabel.numberOfLines = 0;
        self.descLabel.textColor = [UIColor grayColor];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pic.frame = CGRectMake(5, 5, 80, 100);
    
    self.titleLabel.frame = CGRectMake(100, 5, 150, 20);
    
    self.descLabel.frame = CGRectMake(100, 30, [UIScreen mainScreen].bounds.size.width - 105, 75);
}

- (void)setDictionary:(NSDictionary *)dictionary {
    self.pic.image = [UIImage imageNamed:[dictionary objectForKey:@"picture"]];
    self.titleLabel.text = [dictionary objectForKey:@"title"];
    self.descLabel.text = [dictionary objectForKey:@"desc"];
}

@end
