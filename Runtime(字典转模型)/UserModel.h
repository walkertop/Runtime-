//
//  UserModel.h
//  Runtime(字典转模型)
//
//  Created by 郭彬 on 16/7/22.
//  Copyright © 2016年 walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *profile_image_url;

@property (nonatomic, assign) BOOL vip;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign) int mbtype;

@end
