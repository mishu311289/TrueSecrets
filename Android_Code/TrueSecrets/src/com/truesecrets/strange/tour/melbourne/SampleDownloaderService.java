/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.truesecrets.strange.tour.melbourne;

import com.google.android.vending.expansion.downloader.impl.DownloaderService;

/**
 * This class demonstrates the minimal client implementation of the
 * DownloaderService from the Downloader library.
 */
public class SampleDownloaderService extends DownloaderService {
    // stuff for LVL -- MODIFY FOR YOUR APPLICATION!
   // private static final String BASE64_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8zB0Xz9y7BJ/JXg4xOJinbMhtc84Mh7SN3RrTi4sTE3E+3KqZr61+wtEGwC/0+WSQrp374Q+M8/eA/amPNFvdPj92C7c/+pF5TlJrNjmLBjHsXcHHVMFG/upJsDVkwicm/xPplIjXxmdwCg/NoRVwuwMb51Nt5bDQ/BxIosweRUKdmmiA1OXGjW8aw176y4U8vAeceuqKgmpdsbfwXJmAoa3akmQlqPye/88uwwr6EekLqv7Oq+o+cxYaWZxonseWIE6+LkRoDn2CC5sRJAhLqkBtLkq0/qXFscHEWcI895A14uDncO2q4KR4G2aT620mSl1tmDLfL52TuD/zilOowIDAQAB";
	
	private static final String BASE64_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyWaOjWjjsXoBiQfREc0BwLx844Wgg0Pm5ExCgEqsVuedBNPJlwomcag4v+/sjEfN9NuF0HMCvrA6GtbD55YgU8tQs2QdEIkkM6UkAFhH1V4g7kp61sDZI8MQcqutY8H/vYqjm13GxiDZOKIHEKwEffglOYlJh9enHc2Hs3HusipkuPHN215Beftt4WZuR2iPCb7kN8uuCYUaWL4a40Fa2OdUSPi+0efUyYfQDjuoQobtxxcBf9MgvgxiGiI91GPW2d8v79bnN6ID3BLE5Ia01f9SUiLyxsxrgLdcDqdvzdgEiXM9YZt0MffQPRnCpPh3VMlQ05xyJzGh87KXG9DIGwIDAQAB";
    // used by the preference obfuscater
    private static final byte[] SALT = new byte[] {
            1, 43, -12, -1, 54, 98,
            -100, -12, 43, 2, -8, -4, 9, 5, -106, -108, -33, 45, -1, 84
    };

    /**
     * This public key comes from your Android Market publisher account, and it
     * used by the LVL to validate responses from Market on your behalf.
     */
    @Override
    public String getPublicKey() {
        return BASE64_PUBLIC_KEY;
    }

    /**
     * This is used by the preference obfuscater to make sure that your
     * obfuscated preferences are different than the ones used by other
     * applications.
     */
    @Override
    public byte[] getSALT() {
        return SALT;
    }

    /**
     * Fill this in with the class name for your alarm receiver. We do this
     * because receivers must be unique across all of Android (it's a good idea
     * to make sure that your receiver is in your unique package)
     */
    @Override
    public String getAlarmReceiverClassName() {
        return SampleAlarmReceiver.class.getName();
    }

}
