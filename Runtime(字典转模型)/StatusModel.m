//
//  StatusModel.m
//  Runtime(字典转模型)
//
//  Created by 郭彬 on 16/7/22.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

+ (StatusModel *)statusWithDict:(NSDictionary *)dict
{
    StatusModel *statusModel = [[self alloc] init];
    
    // KVC
    [statusModel setValuesForKeysWithDictionary:dict];
    
    return statusModel;
}

// 解决KVC报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if ([key isEqualToString:@"id"]) {
//        _ID = [value integerValue];
//    }
//    // key:没有找到key
//    // value:没有找到key对应的值
//    NSLog(@"%@ %@",key,value);
}
@end
