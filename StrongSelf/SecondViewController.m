//
//  SecondViewController.m
//  StrongSelf
//
//  Created by Tsing on 2019/1/21.
//  Copyright © 2019 iflytek. All rights reserved.
//

#import "SecondViewController.h"

typedef void(^TestBlock)(void);

@interface SecondViewController ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) TestBlock completionBlock;
@property (nonatomic, copy) TestBlock otherBlock;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TestBlock other = ^void(void) {
        NSLog(@"Some thing");
    };
    
    self.otherBlock = other;
    
    __weak typeof(self)weakSelf = self;
    TestBlock block = ^void (void) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            strongSelf.name = @"Hello";
//            NSLog(@"%@", strongSelf.name);
//            // 模拟耗时任务
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//                strongSelf.name = @"Hello World";
//                NSLog(@"%@", strongSelf.name);
//                strongSelf.otherBlock();
//            });
            
            weakSelf.name = @"Hello";
            NSLog(@"%@", weakSelf.name);
            // 模拟耗时任务
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                weakSelf.name = @"Hello World";
                NSLog(@"%@", weakSelf.name);
                weakSelf.otherBlock();
            });
        });
    };
    self.completionBlock = block;
    
    self.completionBlock();
}

- (void)dealloc {
    NSLog(@"dealloc %@", self.name);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
