package com.truesecrets.purchase;

import com.inapppurchase.util.IabHelper;

import com.inapppurchase.util.IabResult;
import com.inapppurchase.util.Inventory;
import com.inapppurchase.util.Purchase;
import com.truesecrets.strange.tour.melbourne.R;
import com.truesecrets.util.ConnectionDetector;

import android.os.Bundle;
import android.os.IBinder;
import android.os.StrictMode;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class Payment extends Activity {

	private Button clickButton;
	private Button buyButton;
	IabHelper mHelper;
	static final String ITEM_SKU = "com.truesecrets.tour.melbourne.click";
	private static final String TAG = "<your domain>.inappbilling";
	ConnectionDetector detector;
	Context mcontext;
	SharedPreferences pref;
	@SuppressLint("NewApi")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.payment);
		
	
		
		buyButton = (Button)findViewById(R.id.buyButton);
		clickButton = (Button)findViewById(R.id.clickButton);	
		clickButton.setEnabled(false);
		
		mcontext = this;
		detector = new ConnectionDetector(this);
		
		pref = getSharedPreferences("mypref", MODE_APPEND);
		
		
		String base64EncodedPublicKey = 
                "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlP1weAFUbJiNii/YDpNRhq4gYMHbNgtI64EvKtkOLhZdaAIaj7yzB2+foc61mhxYVLFTLvGLXbFx/19wONXPTdfSfPjm8RtnyPYZImGx8Gmt1DNz9e1CxO8xjaiIEnYKMmXQlXyVb9AMun6K8s9x+2+3fgJObjFRtm3hgoE/8xvnhSaeqHMkLP2jIhhbWF9vFWHG9divie8SZPll7dfUuHb6+oFF7xj+S6qryb+Tt8BlSPK5syZmdC2+0A7tyns6GTvMjVv/2rhMHfkrKmIJJqx755D0OoT8wQJds5X0S3IRV108NUSi8nKKFmqTT9hFUyb/t6iPZAunLaigf4N3NQIDAQAB";
		
		mHelper = new IabHelper(this, base64EncodedPublicKey);
        
    	mHelper.startSetup(new 
		IabHelper.OnIabSetupFinishedListener() {
    	   	 public void onIabSetupFinished(IabResult result) 
		 {
    	           if (!result.isSuccess()) {
    	             Log.d(TAG, "In-app Billing setup failed: " + 
				result);
    	           } else {             
    	      	     Log.d(TAG, "In-app Billing is set up OK");
	           }
    	         }
    	});
		
    	mHelper.enableDebugLogging(true, TAG);
	}
	public void buyClick(View view) {
		
		String purchaseToken = "inapp:"+getPackageName()+":android.test.purchased";
		
		
			Log.e("Value ", ""+detector.isConnectingToInternet());
			if(detector.isConnectingToInternet())
			{
				mHelper.launchPurchaseFlow(this, ITEM_SKU, 10001,   
			   mPurchaseFinishedListener, "mypurchasetoken");
			}
			else
			{
				AlertDialog.Builder builder=new AlertDialog.Builder(this);
				builder.setTitle("Notification");
				builder.setMessage("Internet connection is not available");
				builder.setNegativeButton("Ok", null);
				builder.create().show();
			}
			
		
	
}
	public void buttonClicked (View view)
	{
		clickButton.setEnabled(false);
		buyButton.setEnabled(true);
	}
	IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener 
	= new IabHelper.OnIabPurchaseFinishedListener() {
	public void onIabPurchaseFinished(IabResult result,  Purchase purchase) 
	{
		
		Toast.makeText(mcontext, result.getResponse()+" "+result.getMessage(), 1000).show();
		
		
	   if (result.isFailure()) {
	      // Handle error
	      return;
	 }      
	 else if (purchase.getSku().equals(ITEM_SKU)) {
//		 consumeItem();
		
	   pref.edit().putBoolean("purchasedone", true).commit();
	    buyButton.setEnabled(false);
	}
	      
   }
};
public void consumeItem() {
	mHelper.queryInventoryAsync(mReceivedInventoryListener);
}
	
IabHelper.QueryInventoryFinishedListener mReceivedInventoryListener 
   = new IabHelper.QueryInventoryFinishedListener() {
	   public void onQueryInventoryFinished(IabResult result,
	      Inventory inventory) {

		   	System.out.println(result.getResponse()+result.getMessage());	   
	      if (result.isFailure()) {
		  // Handle failure
	      } else {
                 mHelper.consumeAsync(inventory.getPurchase(ITEM_SKU), 
			mConsumeFinishedListener);
	      }
    }
};
IabHelper.OnConsumeFinishedListener mConsumeFinishedListener =
new IabHelper.OnConsumeFinishedListener() {
 public void onConsumeFinished(Purchase purchase, 
       IabResult result) {

if (result.isSuccess()) {	
	
	
 	  clickButton.setEnabled(true);
} else {
       // handle error
	
	
}
}
};
@Override
public void onDestroy() {
	super.onDestroy();
	if (mHelper != null) mHelper.dispose();
	mHelper = null;
}
}
