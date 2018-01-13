//
//  ViewController.m
//  UITableView+CornerRadius
//
//  Created by YamatoKira on 16/3/10.
//  Copyright © 2016年 kirayamato. All rights reserved.
//  我来看看

#import "ViewController.h"
#import "UITableView+CornerRadius.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    CGFloat _cornerRadius;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *cornerRadiusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44 * 8);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.tableView];
    
    UIButton *decreaseCornerRadiusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [decreaseCornerRadiusButton setTitle:@"-" forState:UIControlStateNormal];
    decreaseCornerRadiusButton.backgroundColor = [UIColor lightGrayColor];
    decreaseCornerRadiusButton.frame = CGRectMake(40, CGRectGetMaxY(self.tableView.frame) + 20, 44, 44);
    [self.view addSubview:decreaseCornerRadiusButton];
    
    [decreaseCornerRadiusButton addTarget:self action:@selector(decreaseCornerRadius:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cornerRadiusLabel.frame = CGRectMake(CGRectGetMaxX(decreaseCornerRadiusButton.frame) + 10, CGRectGetMinY(decreaseCornerRadiusButton.frame), 150, 44);
    [self.view addSubview:self.cornerRadiusLabel];
    
    UIButton *increaseCornerRadiusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [increaseCornerRadiusButton setTitle:@"+" forState:UIControlStateNormal];
    increaseCornerRadiusButton.backgroundColor = [UIColor redColor];
    increaseCornerRadiusButton.frame = CGRectMake(CGRectGetMaxX(self.cornerRadiusLabel.frame) + 10, CGRectGetMinY(decreaseCornerRadiusButton.frame), 44, 44);
    [self.view addSubview:increaseCornerRadiusButton];
    
    [increaseCornerRadiusButton addTarget:self action:@selector(increaseCornerRadius:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // important
    
    // enable tableView cornerRadius
    self.tableView.enableCornerRadiusCell = YES;
    
    // set cornerRadius for cell
    self.tableView.cornerRadius = _cornerRadius;
    
    // set cornerRadiusStyle
    self.tableView.cornerRadiusStyle = KYTableViewCornerRadiusStyleSectionTopAndBottom;
    
    // set cornerRadiusMaskInsets
    self.tableView.cornerRadiusMaskInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark UITableIiewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"section:%li",section];
}

#pragma mark private method
- (void)increaseCornerRadius:(UIButton *)button {
    _cornerRadius ++;
    _cornerRadius = MAX(0, _cornerRadius);
    [self cornerRadiusDidChange];
}

- (void)decreaseCornerRadius:(UIButton *)button {
    _cornerRadius --;
    _cornerRadius = MAX(0, _cornerRadius);
    [self cornerRadiusDidChange];
}

- (void)cornerRadiusDidChange {
    self.cornerRadiusLabel.text = [NSString stringWithFormat:@"cornerRadius:%.2f",_cornerRadius];
    self.tableView.cornerRadius = _cornerRadius;
    [self.tableView reloadData];
}

#pragma mark getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (UILabel *)cornerRadiusLabel {
    if (!_cornerRadiusLabel) {
        _cornerRadiusLabel = [[UILabel alloc] init];
        _cornerRadiusLabel.textColor = [UIColor blackColor];
        _cornerRadiusLabel.backgroundColor = [UIColor lightGrayColor];
        _cornerRadiusLabel.font = [UIFont systemFontOfSize:13.f];
        _cornerRadiusLabel.adjustsFontSizeToFitWidth = YES;
        _cornerRadiusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cornerRadiusLabel;
}

@end
