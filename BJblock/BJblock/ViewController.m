//
//  ViewController.m
//  test
//
//  Created by hbj on 2017/8/10.
//  Copyright © 2017年 宝剑. All rights reserved.
//

#import "ViewController.h"
//#import <objc/message.h>

#define kLog(aaa,__ARCH__)  NSLog(@"%@=%d", aaa,__ARCH__);
typedef int (^myBlock) (int a, int b);
@interface ViewController ()
{
    int (^blockName)(int a, int b);
    myBlock myBlock;
    CGFloat aflot;
}
@property (nonatomic, assign) myBlock myBlock;

- (void)copyMethod:(int (^)(int a, int b)) para1;


@end

@implementation ViewController

CGFloat aa = 100;
@synthesize myBlock = _myBlock;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    blockName = ^(int a, int b){
        return a+b;
    };
    NSLog(@"sum=%d", blockName(2, 3));
    
    self.myBlock = ^(int a, int b) {
        return a - b;
    };
    kLog(@"sub",_myBlock(3, 1));
    
    __block CGFloat bb;
    [UIView animateWithDuration:0.5f delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view setBackgroundColor:[UIColor yellowColor]];
        aflot = 200;
        aa = 200;//全局变量 读写
        bb = 200;//局部变量 只读(用__block修饰 可变成读写)
    } completion:^(BOOL finished) {
        NSLog(@"animation %@ finished", finished? @"is": @"isn't");
    }];
    
    //objc_msgSend(self, @selector(getMethod));
    
}
-(void)getMethod{
    
}

//block当参数使用 --- oc中block作为一个对象使用
- (void)copyMethod:(int (^)(int, int))para1 {
    aa = 100;
    para1(1, 1);
}
- (IBAction)clickAction:(UIButton *)sender {
    [[ViewController new] copyMethod:^int(int a, int b) {
        kLog(@"sum1=",a+b);
        return a+b;
    }];
}

- (int)copyReturnValue:(int (^)(int, int))para1 {
    aa = 100;
    para1(1, 1);
    return aa;
}
- (IBAction)valueAction:(UIButton *)sender {
    int intA = [[ViewController new] copyReturnValue:^int(int a, int b) {
        kLog(@"sum2=",a+b);
        aa=400;
        return a+b;
    }];
    kLog(@"intA", intA);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
