package com.truesecrets.purchase;

import android.os.Bundle;

import com.inapppurchase.util.IabHelper.OnIabSetupFinishedListener;
import com.inapppurchase.util.IabResult;


/**
 * Checks that In App Purchasing is available on this device
 * 
 * @author Blundell
 * 
 */
public class StartUpActivity extends PurchaseActivity implements OnIabSetupFinishedListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("App started");
    }

    @Override
    public void onIabSetupFinished(IabResult result) {
        if (result.isSuccess()) {
            Log.d("In-app Billing set up" + result);
            dealWithIabSetupSuccess();
        } else {
            Log.d("Problem setting up In-app Billing: " + result);
            dealWithIabSetupFailure();
        }
    }

    @Override
    protected void dealWithIabSetupSuccess() {
        navigate().toMainActivity();
        finish();
    }

    @Override
    protected void dealWithIabSetupFailure() {
        popBurntToast("Sorry In App Billing isn't available on your device");
    }
}
