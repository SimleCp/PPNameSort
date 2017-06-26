//
//  ViewController.m
//  PPNameSort
//
//  Created by peng on 2017/6/26.
//  Copyright © 2017年 cxp. All rights reserved.
//

#import "ViewController.h"
#import "PPNameSort.h"
#import "PPObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    PPObject *model = [PPObject new];
    model.nickName = @"啦啦";
    [arr addObject:model];
    
    PPObject *model1 = [PPObject new];
    model1.nickName = @"#你说";
    [arr addObject:model1];
    
    PPObject *model2 = [PPObject new];
    model2.nickName = @"...很皮";
    [arr addObject:model2];
    
    PPObject *model3 = [PPObject new];
    model3.nickName = @"石乐智";
    [arr addObject:model3];
    
    PPObject *model4 = [PPObject new];
    model4.nickName = @"狐狸呀";
    [arr addObject:model4];
    
    PPObject *model5 = [PPObject new];
    model5.nickName = @"搜索";
    [arr addObject:model5];
    
    PPObject *model6 = [PPObject new];
    model6.nickName = @"丢";
    [arr addObject:model6];
    
    PPObject *model7 = [PPObject new];
    model7.nickName = @"a";
    [arr addObject:model7];
    
    PPObject *model8 = [PPObject new];
    model8.nickName = @"1233";
    [arr addObject:model8];
    

    [PPNameSort sortWithModels:arr sortPropertyNameString:@"nickName" sortedModelDict:^(NSMutableDictionary<NSString *,NSMutableArray *> *sortedModelDict, NSMutableArray *nameKeys) {
        NSLog(@"sortedModelDict = %@", sortedModelDict);
        NSLog(@"nameKeys = %@", nameKeys);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
