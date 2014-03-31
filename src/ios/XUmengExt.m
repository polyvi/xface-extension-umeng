
/*
 Copyright 2012-2013, Polyvi Inc. (http://polyvi.github.io/openxface)
 This program is distributed under the terms of the GNU General Public License.

 This file is part of xFace.

 xFace is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 xFace is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with xFace.  If not, see <http://www.gnu.org/licenses/>.
*/

//
//  XUmengExt.m
//
//

#import <xFace/XUtils.h>
#import <xFace/XConstants.h>

#import "XUmengExt.h"
#import "MobClick.h"

static NSString     *const kUMAppKey     = @"526f500356240bdc2d06fb7a";
static NSDictionary *com_polyvi_xface_UmengReportPolicy;

@implementation XUmengExt

+ (void)initialize
{
    com_polyvi_xface_UmengReportPolicy = @{
                                           @"realtime" : @0,  //实时发送
                                           @"batch"    : @1,  //启动发送
                                           @"daily"    : @4,  //每日发送
                                           @"wifionly" : @5,  //仅在WIFI下启动时发送
                                           @"interval" : @6,  //按最小间隔发送
                                           @"onexit"   : @7   //退出或进入后台时发送
                                           };
}

- (id)initWithWebView:(UIWebView*)theWebView
{
    self = (id)[super initWithWebView:theWebView];
    if (self) {
        //确保Umeng只被初始化一次
        if (![XUtils isDefaultAppWebView:theWebView]) {
            self = nil;
        }
    }
    return self;
}

- (void)pluginInitialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageDidLoad) name:CDVPageDidLoadNotification object:self.webView];
}

- (void)pageDidLoad
{
    // 初始化UMAnalytics
    [MobClick setCrashReportEnabled:YES];

    NSString *appKey = [XUtils getPreferenceForKey:UMENG_APP_KEY];
    if (!appKey.length) {
        appKey = kUMAppKey;
    }

    ReportPolicy reportPolicy = REALTIME;
    NSString *prefPolicy = [XUtils getPreferenceForKey:UMENG_REPORT_POLICY];
    if (prefPolicy.length) {
        reportPolicy = (ReportPolicy)[(NSNumber *)(com_polyvi_xface_UmengReportPolicy[[prefPolicy lowercaseString]]) intValue];
    }

    //channelId 渠道名称,为nil或@""时,默认会被被当作@"App Store"渠道
    NSString *channelId = [XUtils getPreferenceForKey:UMENG_CHANNEL];

    // REALTIME只在模拟器和DEBUG模式下生效，真机release模式会自动改成BATCH
    // BATCH策略说明：应用程序每次只在启动时会向服务器发送一次消息(BATCH策略)，在应用使用过程中产生的所有消息都会在下次启动时候发送。
    // 如果应用程序启动时处在不联网状态，那么消息将会缓存在本地，下次再尝试发送
    [MobClick startWithAppkey:appKey reportPolicy:reportPolicy channelId:channelId];

    // TODO:实现在线更新以及event监听，增加screen的统计功能
}

@end
