//
//  StatusModel.h
//  Runtime(字典转模型)
//
//  Created by 郭彬 on 16/7/22.
//  Copyright © 2016年 walker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

@interface StatusModel : NSObject

@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) int reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) int comments_count;

//@property (nonatomic, strong) NSDictionary *user;

@property (nonatomic, strong) UserModel *user;


//__kindof StatusModel *也可以instancetype
+ (__kindof StatusModel *)statusWithDict:(NSDictionary *)dict;
@end
