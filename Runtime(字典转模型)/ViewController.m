//
//  ViewController.m
//  Runtime(字典转模型)
//
//  Created by 郭彬 on 16/7/22.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+autoLogProperty.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "NSObject+Model.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;   //记录模型的数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //log方法属性
    NSArray *dictArr = dict[@"statuses"];
    [[self class] createPropertyCodeWithDict:dictArr[0]];            //打印StatusModel的属性
    [[self class] createPropertyCodeWithDict:dictArr[0][@"user"]];   //打印UserModel的属性
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
//        KVC字典转模型，调用setValueForKeyWithDictionary:方法
//        StatusModel *statusModel = [StatusModel statusWithDict:dict];
        
//       runtime字典转模型，调用分类方法
        StatusModel *statusModel = [StatusModel modelWithDict:dict];
        [statuses addObject:statusModel];
    }
    NSLog(@"%@",statuses);
    self.dataArray = statuses;
}

//懒加载dataArray
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}

@end
