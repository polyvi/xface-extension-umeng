# xface-extension-umeng
集成了[友盟](http://www.umeng.com)统计分析插件

iOS Preferences
-----------

#### config.xml

-  __UmengAppKey__ (string, 默认值为“526f500356240bdc2d06fb7a”,对应xFace v3.2). 友盟appKey.

        <preference name="UmengAppKey" value="526f500356240bdc2d06fb7a" />
        
   [获取友盟Appkey](http://dev.umeng.com/social/ios/share/quick-integration)
            
- __UmengReportPolicy__ (string, 默认值为“realtime”). 发送策略,用于定义用户由统计分析SDK产生的数据发送回友盟服务器的频率.

	```
	realtime : 实时发送
	batch    : 启动发送
	daily    : 每日发送
	wifionly : 仅在WIFI下启动时发送
	interval : 按最小间隔（10秒）发送
	onexit   : 退出或进入后台时发送,这种发送策略在App运行过程中不发送，对开发者和用户的影响最小
	
	其中realtime,wifionly只在模拟器和DEBUG模式下生效，真机release模式会自动改成batch
	```

        <preference name="UmengReportPolicy" value="realtime" />
        

- __UmengChannel__ (string, 默认值为“App Store”). 渠道名称.

        <preference name="UmengChannel" value="" />
        
   [渠道分析](http://dev.umeng.com/analytics/reports/channel)
   
   [渠道管理](http://dev.umeng.com/analytics/reports/setting/channels)

   

