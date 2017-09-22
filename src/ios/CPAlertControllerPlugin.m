//
//  CPAlertControllerPlugin.m
//  123
//
//  Created by zzc-20170215 on 2017/9/19.
//
//

#import "CPAlertControllerPlugin.h"

@implementation CPAlertControllerPlugin

- (void)showAlertController:(CDVInvokedUrlCommand *)command
{
    NSArray *options = [command argumentAtIndex:0 withDefault:@[] andClass:[NSArray class]];
    NSInteger cancelButtonIndex = -1;
    NSInteger destructiveButtonIndex = -1;
    NSString *title = nil;
    if (command.arguments.count>=4) {
        cancelButtonIndex = [[command argumentAtIndex:1] integerValue];
        destructiveButtonIndex = [[command argumentAtIndex:2] integerValue];
        title = command.arguments[3];
    }
    if ([title isEqualToString:@""]) {
        title = nil;
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableArray<UIAlertAction *> *actions = [NSMutableArray array];
    for (int i = 0; i < options.count; i++)
    {
        NSString *op = [options objectAtIndex:i];
        
        [actions addObject:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:op style:destructiveButtonIndex == i ? UIAlertActionStyleDestructive : cancelButtonIndex == i ? UIAlertActionStyleCancel : UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self responseWithCallbackId:command.callbackId state:@"0" message:nil data:@([actions indexOfObject:action])];
            }];
            
            action;
        })];
    }
    
    
    [actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addAction:obj];
    }];
    
    [self.viewController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)showToast:(CDVInvokedUrlCommand *)command
{
    NSString *text = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    if (text.length > 0)
    {
        CGFloat duration = [[command argumentAtIndex:1 withDefault:@2] floatValue];
        duration = MAX(2, duration);
        duration = MIN(10, duration);
        
        if ([[self pluginDelegate] respondsToSelector:@selector(showToast:duration:completeBlock:)]) {
            
            __weak CPAlertControllerPlugin *wSelf = self;
            [[self pluginDelegate] showToast:text duration:duration completeBlock:^{
                
                [wSelf responseWithCallbackId:command.callbackId state:@"0" message:@"" data:@""];
            }];
            
        }else
        {
            [self responseForDisableFindProtocol:command.callbackId];
        }
        
    }else
    {
        [self responseWithCallbackId:command.callbackId state:@"1001" message:@"无提示内容" data:@""];
    }
}

@end
