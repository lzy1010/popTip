//
//  CPAlertControllerPlugin.h
//  123
//
//  Created by zzc-20170215 on 2017/9/19.
//
//

#import "ZZCBasePlugin.h"

@interface CPAlertControllerPlugin : ZZCBasePlugin

- (void)showAlertController:(CDVInvokedUrlCommand *)command;

- (void)showToast:(CDVInvokedUrlCommand *)command;

@end
