
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

package com.polyvi.xface.extension.umeng;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;

import com.umeng.analytics.MobclickAgent;

/**
 * XUMengExt用于UMeng统计代理<br/>
 * dependent-libs: umeng_sdk.jar
 */
public class XUmengExt extends CordovaPlugin {
    private CordovaInterface mCordova;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        // 注意：这里需要将SessionContinue的设置为0，不然连续启动程序的间隔时间果断的话，不会发送数据
        mCordova = cordova;
        MobclickAgent.setSessionContinueMillis(0);
        MobclickAgent.onError(cordova.getActivity());
    }

    @Override
    public void onPause(boolean multitasking) {
        MobclickAgent.onPause(mCordova.getActivity());
    }

    @Override
    public void onResume(boolean multitasking) {
        MobclickAgent.onResume(mCordova.getActivity());
    }

}
