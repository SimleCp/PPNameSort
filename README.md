# PPNameSort

## 对App中的联系人数组模型进行排序. 

##### 使用方式
1 #import "PPNameSort.h"

2 创建模型(从服务器)

```objc 
NSMutableArray *arr = [NSMutableArray array];
PPObject *model = [PPObject new];
model.nickName = @"啦啦";
[arr addObject:model];
```

3 将模型数组导入并获取回调
```objc

arr 模型数组
@"nickName" 需要排序的模型属性名
sortedModelDict 回调

[PPNameSort sortWithModels:arr sortPropertyNameString:@"nickName" sortedModelDict:^(NSMutableDictionary<NSString *,NSMutableArray *> *sortedModelDict, NSMutableArray *nameKeys) {
        NSLog(@"sortedModelDict = %@", sortedModelDict);
        NSLog(@"nameKeys = %@", nameKeys);
}];
```

4 最终获取到的数据
```objc
2017-06-26 17:31:45.532 PPNameSort[7814:261673] sortedModelDict = {
    "#" =     (
        "<PPObject: 0x60000001ce00>",
        "<PPObject: 0x60000001cec0>"
    );
    A =     (
        "<PPObject: 0x60000001ceb0>"
    );
    L =     (
        "<PPObject: 0x60000001cd80>"
    );
    S =     (
        "<PPObject: 0x60000001cdb0>"
    );
}
2017-06-26 17:31:45.532 PPNameSort[7814:261673] nameKeys = (
    A,
    L,
    S,
    "#"
)
```

### 本项目根据 [PPGetAddressBook](https://github.com/jkpang/PPGetAddressBook) 框架进行`简单修改后`提取出来的. 已保留原项目的注释.
