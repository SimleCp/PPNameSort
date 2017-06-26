//
//  PPNameSort.h
//  PPNameSort
//
//  Created by peng on 2017/6/26.
//  Copyright © 2017年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取按A~Z顺序排列的所有模型的Block
 *
 *  @param sortedModelDict 装有所有模型的字典
 *  @param nameKeys   模型大写首字母的数组
 */
typedef void(^SortedModelDictBlock)(NSMutableDictionary<NSString *, NSMutableArray *> *sortedModelDict, NSMutableArray *nameKeys);

@interface PPNameSort : NSObject


/**
 对模型数组, 根据名字或昵称进行排序 排序顺序 A-Z-#

 @param models 需要排序的模型数组
 @param propertyName 需要排序的模型属性名
 @param sortedModelDict 排序后的回调
 */
+ (void)sortWithModels:(NSArray<NSObject *> *)models sortPropertyNameString:(NSString *)propertyName sortedModelDict:(SortedModelDictBlock)sortedModelDict;

@end
