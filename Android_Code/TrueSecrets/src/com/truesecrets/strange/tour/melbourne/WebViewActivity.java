package com.truesecrets.strange.tour.melbourne;




import com.truesecrets.strange.tour.melbourne.R;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebSettings.RenderPriority;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class WebViewActivity extends Activity {
		 
		private WebView webView;
	 
		@SuppressLint("SetJavaScriptEnabled")
		@Override
		public void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.webview);
			
	        String link=getIntent().getStringExtra("Link");
	        
	        webView = (WebView) findViewById(R.id.webView);
	        webView.setWebViewClient(new MyWebViewClient());   
	        //webView.setCacheMode (8);
	       // webView.getSettings().setSupportZoom(false);
//	        webView.getSettings().setRenderPriority(WebSettings.RenderPriority.HIGH);
	        webView.getSettings().setRenderPriority(RenderPriority.HIGH);
	        webView.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
	  
	       // webView.getSettings().setDomStorageEnabled(true);	        
			webView.getSettings().setJavaScriptEnabled(true);		
			//webView.addStatesFromChildren();
			//webView.getSettings().setSupportMultipleWindows (false);
			Log.e("WebView", link);
			webView.loadUrl(link);			
		}	
		
	 
		private class MyWebViewClient extends WebViewClient {
		    @Override
		    public boolean shouldOverrideUrlLoading(WebView view, String url) {
		        // This line right here is what you're missing.
		        // Use the url provided in the method.  It will match the member URL!
		        view.loadUrl(url);
		        return true;
		    }
		}
	}


