//
//  FMDBManager.h
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject



/**
 *  单例
 *
 *  @return 返回当前对象
 */
+ (id)shareInstance;



/**
 *  创建数据表
 *
 *  @param tableName 数据表名称
 */
//- (void)createDataToFMDBWithTableName:(NSString *)tableName;



/**
 *  向数据表里面插入数据
 *
 *  @param tableName 数据表名称
 */
- (void)insertDataToFMDBWithTableName:(NSString *)tableName;



/**
 *  删除数据表里面的所有数据
 *
 *  @param tableName 数据表名称
 */

- (void)deleteAllDataFMDBWithTableName:(NSString *)tableName;



/**
 *  修改数据表中的数据
 *
 *  @param tableName 数据表名称
 */

- (void)changeDataToFMDBWithTableName:(NSString *)tableName;



/**
 *  删除数据表中某一条数据
 *
 *  @param tableName 数据表名称
 */

- (void)deleteOneDataFMDBWithTableName:(NSString *)tableName;



/**
 *  查找数据表符合的数据
 *
 *  @param tableName 数据表名称
 *
 *  @param ID        查询数据字段
 */
- (BOOL)searchDataFMDBWithTableName:(NSString *)tableName ID:(NSString *)strID;



/**
 *  查找数据表所有的数据
 *
 *  @param tableName 数据表名称
 */

- (void)searchDataFMDBWithTableName:(NSString *)tableName;



@end
