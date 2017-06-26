//
//  PPNameSort.m
//  PPNameSort
//
//  Created by peng on 2017/6/26.
//  Copyright © 2017年 cxp. All rights reserved.
//

#import "PPNameSort.h"

@implementation PPNameSort

+ (void)sortWithModels:(NSArray<NSObject *> *)models sortPropertyNameString:(NSString *)propertyName sortedModelDict:(SortedModelDictBlock)sortedModelDict
{
    if (!propertyName.length) {
        NSLog(@"需要排序的属性名不能为空");
        return;
    }
    
    NSString *classStr = NSStringFromClass([self class]);
    const char *resCStr = NULL;
    resCStr = [classStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    // 将耗时操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create(resCStr, DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        NSMutableDictionary *sortedModelDictM = [NSMutableDictionary dictionary];
        
        [models enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *sortValue = [obj valueForKey:propertyName];
            
            //            NSLog(@"%@", sortValue);
            if (!sortValue.length) {
                return;
                
            }
            
            //获取到姓名的大写首字母
            NSString *firstLetterString = [self getFirstLetterFromString:sortValue];
            //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
            if (sortedModelDictM[firstLetterString])
            {
                [sortedModelDictM[firstLetterString] addObject:obj];
            }
            //没有出现过该首字母，则在字典中新增一组key-value
            else
            {
                //创建新发可变数组存储该首字母对应的联系人模型
                NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:obj];
                //将首字母-姓名数组作为key-value加入到字典中
                [sortedModelDictM setObject:arrGroupNames forKey:firstLetterString];
            }
            
            
        }];
        
        // 将addressBookDict字典中的所有Key值进行排序: A~Z
        NSMutableArray *nameKeys = [NSMutableArray arrayWithArray:[[sortedModelDictM allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        
        // 将 "#" 排列在 A~Z 的后面
        if ([nameKeys.firstObject isEqualToString:@"#"])
        {
            NSMutableArray *mutableNamekeys = [NSMutableArray arrayWithArray:nameKeys];
            [mutableNamekeys insertObject:nameKeys.firstObject atIndex:nameKeys.count];
            [mutableNamekeys removeObjectAtIndex:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sortedModelDict ? sortedModelDict(sortedModelDictM,mutableNamekeys) : nil;
            });
            return;
        }
        
        // 将排序好的通讯录数据回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            sortedModelDict ? sortedModelDict(sortedModelDictM,nameKeys) : nil;
        });
        
    });
    
}

#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)getFirstLetterFromString:(NSString *)aString
{
    /**
     * **************************************** START ***************************************
     * 之前PPGetAddressBook对联系人排序时在中文转拼音这一部分非常耗时
     * 参考博主-庞海礁先生的一文:iOS开发中如何更快的实现汉字转拼音 http://www.olinone.com/?p=131
     * 使PPGetAddressBook对联系人排序的性能提升 3~6倍, 非常感谢!
     */
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    /**
     *  *************************************** END ******************************************
     */
    
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self polyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
    
}

/**
 多音字处理
 */
+ (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}


@end
