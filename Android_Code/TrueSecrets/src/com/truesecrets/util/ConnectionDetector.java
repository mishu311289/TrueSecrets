package com.truesecrets.util;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

public class ConnectionDetector {

	private static Context _context;
    
    public ConnectionDetector(Context context){
        this._context = context;
    }
 
    public boolean isConnectingToInternet(){
        ConnectivityManager connectivity = (ConnectivityManager) _context.getSystemService(Context.CONNECTIVITY_SERVICE);
       
        if (connectivity != null) 
          {
              NetworkInfo[] info = connectivity.getAllNetworkInfo();
              if (info != null) 
                  for (int i = 0; i < info.length; i++) 
                  {
                	
                      if (info[i].getState() == NetworkInfo.State.CONNECTED)
                      {
                    	  
                          return true;
                      }
                  }
          }
          return false;
    }
    static public  void hideKeyboard(Context context) {
    	_context =context ;
	    InputMethodManager inputManager = (InputMethodManager)_context.getSystemService(Context.INPUT_METHOD_SERVICE);
	    
	    // check if no view has focus:
	    View view = ((Activity)_context).getCurrentFocus();
	    if (view != null) {
	        inputManager.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
	    }
	}
}
