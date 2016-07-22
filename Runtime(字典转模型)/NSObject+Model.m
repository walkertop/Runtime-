//
//  NSObject+Model.m
//  Runtime(字典转模型)
//
//  Created by 郭彬 on 16/7/22.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    /**
     *  核心思想是：
     1.遍历自定义类中的成员变量
     2.将遍历获取的成员变量定为value,复制给类中的ivar.
     
     与KVC赋值的区别:
     KVC是调用setValue: forKey: 的方法，将系统的成员变量作为value，自定义的属性为key
     如果自定义的属性找不到就必须要调用     - (void)setValue:(id)value forUndefinedKey:(NSString *)key
     来处理报错。
     但是runtime的字典转模型是将自定义属性生成的下划线成员变量变为key.
     setValuesForKeysWithDictionary:就不会出现找不到key而报错的问题了。
     */
    id objc = [[self alloc] init];

    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        //获取属性名
        Ivar ivar = ivarList[i];
        
        //获取成员名
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //获取key
        NSString *key = [propertyName substringFromIndex:1];   //取出下划线_
        //获取字典中的value
        id value = dict[key];
        
        //获取成员属性类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];

        //此处为二级转换，如果里面的为字典类型，且属性类型为二级模型的名字，不为NSDictionary
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) { // 需要字典转换成模型
            // 转换成哪个类型
            
            // 打印出来的值为  @"@\"User\"", 截取成User
            
            // 字符串截取
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            //此时变为 User\"";,借着截取掉后面的\""
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
            // 获取需要转换类的类对象
            Class modelClass =  NSClassFromString(propertyType);
            
            if (modelClass) {
                value =  [modelClass modelWithDict:value];
            }
        }
        if (value) {
            // KVC赋值:不能传空
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}


@end
