package com.truesecrets.strange.tour.melbourne;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.Typeface;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.Window;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.common.data.Freezable;
import com.google.android.gms.maps.GoogleMap;
import com.inapppurchase.util.IabHelper;
import com.inapppurchase.util.IabResult;
import com.inapppurchase.util.Purchase;
import com.truesecrets.purchase.StartUpActivity;
import com.truesecrets.strange.tour.melbourne.R;
import com.truesecrets.strange.tour.melbourne.ObbExpansionsManager.ObbListener;
import com.truesecrets.util.CommonUtilities;
import com.truesecrets.util.ConnectionDetector;
import com.truesecrets.util.CouponChecker;
import com.truesecrets.util.NavigationDataSet;
import com.truesecrets.util.NavigationSaxHandler;
import com.truesecrets.util.PagerAdapter;


public class MainActivity  extends FragmentActivity implements OnCompletionListener/*implements MediaPlayer.OnCompletionListener, View.OnClickListener*/ {
	
	static TextView secret1, secret2,
	 secret3,
	 secret4,
	 secret5,
	 secret6,
	 secret7;
	TextView home, about;
	public static TextView secret;
	LinearLayout _ll;
	GoogleMap map;
	TableRow  menuLayout;
	SharedPreferences prefernces;
	public TableRow subMenuLayout;
	public static int flag = 0;
	public static NavigationDataSet dataset;
	public static ArrayList<View> views;
	private ImageView imgLogo;
	static String imei;
	public static ViewPager viewPager;
	PagerAdapter pagerAdapter;
	AboutUsFragment aboutFragment;
	HomeFragment homeFragment;
	SecretFragment secretOneFragment,secretTwoFragment, secretThreeFragment, secretFourFragment, secretFiveFragment, secretSixFragment, secretSevenFragment;	
	public static MediaPlayer masterPlayer, backgroundPlayer, bonusPlayer, welcomePlayer, thanksPlayer;	
	public static int couponVar=0;
	static SharedPreferences pref;
	public static Typeface headingTypeface, boldTypeface, regularTypeface, droidsansTypeface;
	//public static String respons, androidcoupon,ioscoupon, date;
	public static boolean showHidecoupons = true;
	static ConnectionDetector detector;
	static String url;
	static IabHelper mHelper;
	static String thanksDate="";
	private TimerTask TimerTask;    
	private Timer timer;
	static int int_day=0;
	private static  ProgressDialog pDialog;
	 ObbExpansionsManager expansionManager;
	 static Context ctx;
	 
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.main);		
		
		ctx = MainActivity.this;
		intitlize();
		
		startTimer();
		
		prefernces = this.getSharedPreferences("truesecretPreferences", MODE_PRIVATE);
		pref = this.getSharedPreferences("mypref", Context.MODE_APPEND);
		Log.e("main activity", "main started");
	    new GetData().execute();
		
	    Log.e("main activity", "thread started");
	    
		masterPlayer = new MediaPlayer();
		backgroundPlayer = new MediaPlayer();
		bonusPlayer = new MediaPlayer();
		welcomePlayer = new MediaPlayer();
		thanksPlayer = new MediaPlayer();
		
		welcomePlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {			
			@Override
			public void onCompletion(MediaPlayer mp) {
				Log.e("completion listener", "music completed");
				Toast.makeText(MainActivity.this, "Sound Complete", Toast.LENGTH_LONG).show();
			}
		});
		
		views = new ArrayList<View>();
		views.clear();
				
		
		aboutFragment = new AboutUsFragment(MainActivity.this);
	    homeFragment= new HomeFragment(MainActivity.this);	    
	    secretOneFragment = new SecretFragment(MainActivity.this, 1);
	    secretTwoFragment = new SecretFragment(MainActivity.this, 2);
	    secretThreeFragment = new SecretFragment(MainActivity.this, 3);
	    secretFourFragment = new SecretFragment(MainActivity.this, 4);
	    secretFiveFragment = new SecretFragment(MainActivity.this, 5);
	    secretSixFragment = new SecretFragment(MainActivity.this, 6);
	    secretSevenFragment = new SecretFragment(MainActivity.this, 7);
	    
	   
	    
	    viewPager = (ViewPager)findViewById(R.id.awesomepager);
	    imgLogo = (ImageView)findViewById(R.id.imgLogo);
	    
		headingTypeface = Typeface.createFromAsset(getAssets(), "fonts/IMFePIsc28P.ttf");
		boldTypeface = Typeface.createFromAsset(getAssets(), "fonts/NoticiaText-Bold.ttf");
		regularTypeface = Typeface.createFromAsset(getAssets(), "fonts/NoticiaText-Regular.ttf");	
		droidsansTypeface=Typeface.createFromAsset(getAssets(), "fonts/DroidSans.ttf");
		
		home = (TextView)findViewById(R.id.home);  
	    about = (TextView)findViewById(R.id.about);
	    secret = (TextView)findViewById(R.id.secret); 
	    subMenuLayout = (TableRow)findViewById(R.id.subMenuLayout);
	    
	    secret1 = (TextView)findViewById(R.id.secret1);
	    secret2 = (TextView)findViewById(R.id.secret2);
	    secret3 = (TextView)findViewById(R.id.secret3);
	    secret4 = (TextView)findViewById(R.id.secret4);
	    secret5 = (TextView)findViewById(R.id.secret5);
	    secret6 = (TextView)findViewById(R.id.secret6);
	    secret7 = (TextView)findViewById(R.id.secret7);
	    
	  //  changeTextColor();
	    
	    secret1.setOnClickListener(secretListner);
	    secret2.setOnClickListener(secretListner);
	    secret3.setOnClickListener(secretListner);
	    secret4.setOnClickListener(secretListner);
	    secret5.setOnClickListener(secretListner);
	    secret6.setOnClickListener(secretListner);
	    secret7.setOnClickListener(secretListner);   
	    
	    secret1.setOnTouchListener(secrettouchListner);
	    secret2.setOnTouchListener(secrettouchListner);
	    secret3.setOnTouchListener(secrettouchListner);
	    secret4.setOnTouchListener(secrettouchListner);
	    secret5.setOnTouchListener(secrettouchListner);
	    secret6.setOnTouchListener(secrettouchListner);
	    secret7.setOnTouchListener(secrettouchListner);
	   
	    
	    secret.setOnClickListener(new View.OnClickListener() {			
			@Override
			public void onClick(View v) {
				if(flag==0){
					/*if(pref.getBoolean("isPurchased", false))
					{
							secret1.setVisibility(View.GONE);	
						    secret2.setVisibility(View.GONE);	
						    secret3.setVisibility(View.VISIBLE);	
						    secret4.setVisibility(View.GONE);	
						    secret5.setVisibility(View.GONE);	
						    secret6.setVisibility(View.GONE);	
						    secret7.setVisibility(View.GONE);	
					}
					else
					{
						secret1.setVisibility(View.VISIBLE);	
					    secret2.setVisibility(View.VISIBLE);	
					    secret3.setVisibility(View.VISIBLE);	
					    secret4.setVisibility(View.VISIBLE);	
					    secret5.setVisibility(View.VISIBLE);	
					    secret6.setVisibility(View.VISIBLE);	
					    secret7.setVisibility(View.VISIBLE);
					}*/
					subMenuLayout.setVisibility(View.VISIBLE);					
					
					flag = 1;
				}else{
					subMenuLayout.setVisibility(View.GONE);					
					flag = 0;
				}
			}
		});
	    
	    home.setOnClickListener(new View.OnClickListener() {
			@SuppressLint("NewApi")
			@Override
			public void onClick(View v) {	
				freeMemory();
				subMenuLayout.setVisibility(View.GONE);				
					flag = 0;	
					viewPager.setCurrentItem(0);
				
					/*MainActivity.flag = 0;
					MainActivity.secret.callOnClick();
					
					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();*/
					if(Build.VERSION.SDK_INT>=15){
				    	MainActivity.flag = 0;
						MainActivity.secret.callOnClick();
							
						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
			    	}else{
			    		MainActivity.flag = 0;
						MainActivity.secret.performClick();
							
						MainActivity.flag = 1;
						MainActivity.secret.performClick();
			    	}
			}
		});
	    /*viewPager.setOnTouchListener(new OnTouchListener() {

            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                case MotionEvent.ACTION_DOWN:

                    break;
                case MotionEvent.ACTION_UP:

                    break;

                default:
                    break;
                }
                return false;
            }
        });*/
	    about.setOnClickListener(new View.OnClickListener() {			
			@Override
			public void onClick(View v) {
				freeMemory();
				subMenuLayout.setVisibility(View.GONE);				
					flag = 0;	
					viewPager.setCurrentItem(8);
			
					/*MainActivity.flag = 0;
					MainActivity.secret.callOnClick();
					
					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();*/
					if(Build.VERSION.SDK_INT>=15){
				    	MainActivity.flag = 0;
						MainActivity.secret.callOnClick();
							
						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
			    	}else{
			    		MainActivity.flag = 0;
						MainActivity.secret.performClick();
							
						MainActivity.flag = 1;
						MainActivity.secret.performClick();
			    	}
			}
		});  
	
	
	   /* home.setTypeface(headingTypeface);
		about.setTypeface(headingTypeface);
		secret.setTypeface(headingTypeface);
		
		secret1.setTypeface(headingTypeface);
		secret2.setTypeface(headingTypeface);
		secret3.setTypeface(headingTypeface);
		secret4.setTypeface(headingTypeface);
		secret5.setTypeface(headingTypeface);
		secret6.setTypeface(headingTypeface);
		secret7.setTypeface(headingTypeface);*/
		
		
	    /*viewPager.addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
			
			@Override
			public void onLayoutChange(View v, int left, int top, int right,
					int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
				Log.e("view","changed");
			}
		});*/   
	    
	    
	}	
	public void	intitlize()
	{
		Resources res = MainActivity.this.getResources();    
   	  	url= res.getString(R.string.app_url);
    	
   	 TelephonyManager mngr = (TelephonyManager)this.getSystemService(MainActivity.this.TELEPHONY_SERVICE); 
	 imei=mngr.getDeviceId();	 
//	 mobile=mngr.getLine1Number();
	 mHelper = new IabHelper(MainActivity.this,CommonUtilities.base64EncodedPublicKey);
        
     mHelper.startSetup(new 
	 IabHelper.OnIabSetupFinishedListener() {
    	   	 public void onIabSetupFinished(IabResult result) 
		 {
    	           if (!result.isSuccess()) {
    	             Log.d("TAG", "In-app Billing setup failed: " + 
				result);
    	           } else {             
    	      	     Log.d("TAG", "In-app Billing is set up OK");
	           }
    	         }
    	});
		
    	mHelper.enableDebugLogging(true, "TAG");
    	
    	
    	pref = MainActivity.this.getSharedPreferences("mypref", Context.MODE_APPEND);
    	detector = new ConnectionDetector(MainActivity.this);
    	expansionManager = new ObbExpansionsManager(MainActivity.this, new ObbListener() {
			
			@Override
			public void onMountSuccess() {
				Log.e("on Mount success","mount success");
			}
			
			@Override
			public void onFilesNotFound() {
				Log.e("on file not found","file not found");
			}
		});
    	
    	
    	
	}
	
class GetData extends AsyncTask<String, String, String> {
		
		@Override
		protected String doInBackground(String... str) {
			Log.e("main activity", "m in doBackground of thread");
			try{
		    	AssetManager assetManager = getAssets();
		        InputStream is = assetManager.open("TrueSecretsMelbourneTourRoute.kml");
		         
		        byte[] buffer = new byte[10000];
		        int bytesRead;
		        ByteArrayOutputStream output = new ByteArrayOutputStream();
		        while ((bytesRead = is.read(buffer)) != -1)
		        {
		            output.write(buffer, 0, bytesRead);
		        }
		        
		        
		        dataset = GetNavigationDataSet(new ByteArrayInputStream(output.toByteArray()));

		        /*for(int i =0; i<dataset.getPlacemarks().size(); i++)
		        {
		        	for(int j =0; j<dataset.getPlacemarks().get(i).getCoordinates().size(); j++)
		        	{
		        		Log.e("placemark cordinate "+i, "lat : "+dataset.getPlacemarks().get(i).getCoordinates().get(j).latitude+
		        				",, lon : " + dataset.getPlacemarks().get(i).getCoordinates().get(j).longitude);
		        	}
		        }*/
		        
		        Log.e("dataset","parsed "+dataset.getPlacemarks().size());
		        }
		        catch(Exception e)
		        {
		        	e.printStackTrace();
		        }
			return "success";
		}

		@Override
		protected void onPreExecute() {
			Log.e("main activity", "m in preExecute of thread");
		}

		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);			
			Log.e("main activity", "m in postExecute of thread");
			imgLogo.setVisibility(View.GONE);
			pagerAdapter = new PagerAdapter(getSupportFragmentManager());
			   
		
			  if(pref.getBoolean("isPurchased", false)==false)
				{ 
					pagerAdapter.addFragment(homeFragment);
					pagerAdapter.addFragment(secretThreeFragment);
					pagerAdapter.addFragment(aboutFragment);
					viewPager.setAdapter(pagerAdapter);
				    viewPager.setOffscreenPageLimit(2);
				  
					}
				else
				{
								
				pagerAdapter.addFragment(homeFragment);
			    pagerAdapter.addFragment(secretOneFragment);
			    pagerAdapter.addFragment(secretTwoFragment);
			    pagerAdapter.addFragment(secretThreeFragment);
			    pagerAdapter.addFragment(secretFourFragment);
			    pagerAdapter.addFragment(secretFiveFragment);
			    pagerAdapter.addFragment(secretSixFragment);
			    pagerAdapter.addFragment(secretSevenFragment);
			    pagerAdapter.addFragment(aboutFragment);
						   
				viewPager.setAdapter(pagerAdapter);
			    viewPager.setOffscreenPageLimit(9);
//			  
				}
			  	viewPager.setCurrentItem(0);
			    viewPager.setOnPageChangeListener(pagerAdapter);	
			  
			  /*  MainActivity.flag = 0;
				MainActivity.secret.callOnClick();
				
				MainActivity.flag = 1;
				MainActivity.secret.callOnClick();*/
			    if(Build.VERSION.SDK_INT>=15){
			    	MainActivity.flag = 0;
					MainActivity.secret.callOnClick();
						
					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();
		    	}else{
		    		MainActivity.flag = 0;
					MainActivity.secret.performClick();
						
					MainActivity.flag = 1;
					MainActivity.secret.performClick();
		    	}
		}
	}
	/*@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.splash, menu);
		return true;
	}
	*/

public View.OnTouchListener secrettouchListner = new View.OnTouchListener() {
	
	@Override
	public boolean onTouch(View v, MotionEvent event) {
		// TODO Auto-generated method stub	
		if(v== secret1){	
			secret1.setTextColor(Color.parseColor("#ffcccccc"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));			
		}else if(v== secret2){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#ffcccccc"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));			
		}else if(v== secret3){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#ffcccccc"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));			
		}else if(v== secret4){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#ffcccccc"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));
		}else if(v== secret5){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#ffcccccc"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));		
		}else if(v== secret6){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#ffcccccc"));
			secret7.setTextColor(Color.parseColor("#be8e26"));			
		}else if(v== secret7){
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#ffcccccc"));	
		}		
		return false;
		}
	};	


	public View.OnClickListener secretListner = new View.OnClickListener() {		
		@Override
		public void onClick(View v) {
			
			secret1.setTextColor(Color.parseColor("#be8e26"));
			secret2.setTextColor(Color.parseColor("#be8e26"));
			secret3.setTextColor(Color.parseColor("#be8e26"));
			secret4.setTextColor(Color.parseColor("#be8e26"));
			secret5.setTextColor(Color.parseColor("#be8e26"));
			secret6.setTextColor(Color.parseColor("#be8e26"));
			secret7.setTextColor(Color.parseColor("#be8e26"));	
			
			
			if(v== secret1){
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					showPaymentDialog();
					}
				else
				{
				    viewPager.setCurrentItem(1);
					}
			}else if(v== secret2){	
				if(pref.getBoolean("isPurchased", false)==false)
				{
					showPaymentDialog();
				}
				else
				{
					viewPager.setCurrentItem(2);
					}
			}else if(v== secret3){	
				if(pref.getBoolean("isPurchased", false)==false)
				{
					viewPager.setCurrentItem(1);
				}
				else
				{
					viewPager.setCurrentItem(3);
					}
			}else if(v== secret4){	
				if(pref.getBoolean("isPurchased", false)==false)
				{
					showPaymentDialog();
				}
				else
				{
					viewPager.setCurrentItem(4);
					}
			}else if(v== secret5){
				if(pref.getBoolean("isPurchased", false)==false)
				{
					showPaymentDialog();
				}
				else
				{
					 viewPager.setCurrentItem(5);
					}
			}else if(v== secret6){	
				if(pref.getBoolean("isPurchased", false)==false)
				{
					showPaymentDialog();
				}
				else
				{
					viewPager.setCurrentItem(6);
					}
			}else if(v== secret7){	
				if(pref.getBoolean("isPurchased", false)==false)
				{
					showPaymentDialog();
				}
				else
				{
					viewPager.setCurrentItem(7);
					}
			}		
		}
	};
	
	 public NavigationDataSet GetNavigationDataSet(ByteArrayInputStream inputStream) {
			NavigationDataSet navigationDataSet = null;
	        try
	            { 
	        	/*Log.e("Data", "url[" + url + "]");
	            final URL aUrl = new URL(url); 
	            Log.e("Data", "Connecting...");
	            final URLConnection conn = aUrl.openConnection();
//	            conn.setReadTimeout(15 * 1000);  // timeout for reading the google maps data: 15 secs
	            conn.connect();
	            */
//	             Get a SAXParser from the SAXPArserFactory. 
	            SAXParserFactory spf = SAXParserFactory.newInstance(); 
	            SAXParser sp = spf.newSAXParser(); 
	 
//	             Get the XMLReader of the SAXParser we created. 
	            XMLReader xr = sp.getXMLReader();
	 
//	             Create a new ContentHandler and apply it to the XML-Reader 
	            NavigationSaxHandler navSax2Handler = new NavigationSaxHandler(); 
	            xr.setContentHandler(navSax2Handler); 
	            
//	             Parse the xml-data from our URL.  
	            xr.parse(new InputSource(inputStream));
	            
//	             Our NavigationSaxHandler now provides the parsed data to us.  
	            navigationDataSet = navSax2Handler.getParsedData();
	        } catch (Exception e) {
//	        	if(LOG_LEVEL <= Log.ERROR)Log.e(TAG, "error getting route info", e);
	        	e.printStackTrace();
	            navigationDataSet = null;
	        }	 
	        return navigationDataSet;
	    }

	/*@Override
		public void onPause()
		{
		    super.onPause();
			if(masterPlayer.isPlaying())
				masterPlayer.pause();
			if(backgroundPlayer.isPlaying())
				backgroundPlayer.pause();
			if(bonusPlayer.isPlaying())
				bonusPlayer.pause();
			if(welcomePlayer.isPlaying())
				welcomePlayer.pause();
			if(thanksPlayer.isPlaying())
				thanksPlayer.pause();
			
			if(wakeLock.isHeld())
			{
				wakeLock.release();
			}

		}*/
	 
	    @Override
		public void onResume()
		{
	    	super.onResume();
	    	//pref.edit().putBoolean("isPurchased", true).commit();
	    	/*MainActivity.flag = 0;
			MainActivity.secret.callOnClick();
				
			MainActivity.flag = 1;
			MainActivity.secret.callOnClick();*/
	    	if(Build.VERSION.SDK_INT>=15){
		    	MainActivity.flag = 0;
				MainActivity.secret.callOnClick();
					
				MainActivity.flag = 1;
				MainActivity.secret.callOnClick();
	    	}else{
	    		MainActivity.flag = 0;
				MainActivity.secret.performClick();
					
				MainActivity.flag = 1;
				MainActivity.secret.performClick();
	    	}
		}
	 
		@Override
		public void onDestroy()
		{
			 super.onDestroy();
			 try{
			if(masterPlayer.isPlaying()){
				masterPlayer.stop();
				masterPlayer.release();
				masterPlayer = null;
			}}catch(Exception e){
				e.printStackTrace();
				masterPlayer = null;
			}
			 
			 try{
			if(backgroundPlayer.isPlaying()){
				backgroundPlayer.stop();
				backgroundPlayer.release();
				backgroundPlayer = null;
			}}catch(Exception e){
				e.printStackTrace();
				backgroundPlayer = null;
			}
			 
			 try{
			if(bonusPlayer.isPlaying()){
				bonusPlayer.stop();
				bonusPlayer.release();
				bonusPlayer = null;
			}}catch(Exception e){
				e.printStackTrace();
				bonusPlayer = null;
			}
			 
			 try{
			if(welcomePlayer.isPlaying()){
				welcomePlayer.stop();
				welcomePlayer.release();
				welcomePlayer = null;
			}}catch(Exception e){
				e.printStackTrace();
				welcomePlayer = null;
			}
			 
			 try{
			if(thanksPlayer.isPlaying()){
				thanksPlayer.stop();	 
				thanksPlayer.release();
				thanksPlayer = null;
			}
			 }catch(Exception e){
					e.printStackTrace();
					thanksPlayer = null;
				}
			 
			checkPreferences("welcomePlayer");
			
			checkPreferences("thanks_track");
			for(int i =1; i<=7; i++){
				checkPreferences("secret"+i+"_background");
				
				if(i==1){
					checkPreferences("secret1_bonus_material");
				}else{
					checkPreferences("secret"+i+"_bonus");
				}
			}
			
			checkPreferences("mace_master");
			checkPreferences("dim_sim_master");
			checkPreferences("police_strike_master");
			checkPreferences("assassin_master");
			checkPreferences("gargoyles_master");
			checkPreferences("one_tel_master");
			checkPreferences("police_raid_master");
		
			Editor editor = prefernces.edit();
			editor.clear();
			editor.commit();
		}

		public void checkPreferences(String fileName){
			if(!prefernces.getString(fileName, "").equals("")){
				try{
					File file = new File(prefernces.getString(fileName, ""));
					file.delete();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		@Override
		public void onCompletion(MediaPlayer mp) {
			Log.e("complete","complete");	
		}
		public static void changeTextColor()
		{
			  if(pref.getBoolean("isPurchased", false)==false)
				{ 	
				secret1.setTextColor(Color.parseColor("#a8a8a8"));
				secret2.setTextColor(Color.parseColor("#a8a8a8"));
				secret3.setTextColor(Color.parseColor("#be8e26"));
				secret4.setTextColor(Color.parseColor("#a8a8a8"));
				secret5.setTextColor(Color.parseColor("#a8a8a8"));
				secret6.setTextColor(Color.parseColor("#a8a8a8"));
				secret7.setTextColor(Color.parseColor("#a8a8a8"));	
				}
				else{
				
				secret1.setTextColor(Color.parseColor("#be8e26"));
				secret2.setTextColor(Color.parseColor("#be8e26"));
				secret3.setTextColor(Color.parseColor("#be8e26"));
				secret4.setTextColor(Color.parseColor("#be8e26"));
				secret5.setTextColor(Color.parseColor("#be8e26"));
				secret6.setTextColor(Color.parseColor("#be8e26"));
				secret7.setTextColor(Color.parseColor("#be8e26"));
				}
		}
		
		public static void findDate()
		{
			if((pref.getString("thanksdate", "").equals("")))
			{	int_day=4;	
				System.err.println(int_day+"intday");
				}
			else
			{
				String savedate=pref.getString("thanksdate", "");
				String currentdate=getCurrentDateTime();
		 	 	Date l_startdate = null,l_enddate=null;
				try {
					DateFormat dtimeformatter = new SimpleDateFormat("yyyy-MM-dd");  
					l_startdate = (Date)dtimeformatter.parse(savedate);
					l_enddate = (Date)dtimeformatter.parse(currentdate);
		
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				  Calendar cal1 = Calendar.getInstance();cal1.setTime(l_startdate);
				  Calendar cal2 = Calendar.getInstance();cal2.setTime(l_enddate);

				  Log.e("save=1","====="+cal1);
				  Log.e("current","======"+cal2);
				 
				  int day= getDaysDifference(cal1,cal2);
				  System.err.println("day======"+day);
				  
					int_day = day;
				
				}
		}
		 public static int getDaysDifference(Calendar calendar1,Calendar calendar2)
		 {
		 if(calendar1==null||calendar2==null)
		 return 0;
		  
		 return (int)( (calendar2.getTimeInMillis() - calendar1.getTimeInMillis()) / (1000 * 60 * 60 * 24));
		 }
		private static String getCurrentDateTime() {		
			try{
			Calendar mCalendar=Calendar.getInstance();
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			thanksDate=df.format(mCalendar.getTime());	
			return thanksDate;
			}catch(Exception e){
				
				return thanksDate;
			}
		}

		public static void openRating(Context c)
		{
			Intent browser = new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.truesecrets.strange.tour.melbourne"));
			c.startActivity(browser);
		}
		 public static void RatingDailog()
		    {
			 
				final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
				LayoutInflater inflator = ((Activity) ctx).getLayoutInflater();
				final View couponView = inflator.inflate(R.layout.rating_layout, null);
				builder.setView(couponView);
				final AlertDialog dialog1 =builder.create();
				//dialog1.setTitle("To experience the full True Secrets tour you need to purchase access to the audio files.");
				//dialog1.setMessage("coupon code");
				WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
			        lp.width = LayoutParams.MATCH_PARENT;
			        lp.height = LayoutParams.MATCH_PARENT;
			        dialog1.getWindow().setAttributes(lp); 
				Button rating = (Button) couponView.findViewById(R.id.rating);
				rating.setOnClickListener(new OnClickListener() {
				public void onClick(View v) {
					
					openRating(ctx);
				
					Editor ed=pref.edit();
					ed.putBoolean("rating", true);
					ed.commit();
					dialog1.dismiss();
					}
				});
				Button later = (Button) couponView.findViewById(R.id.later);
				later.setOnClickListener(new OnClickListener() {
				public void onClick(View v) {
						// TODO Auto-generated method stub
				
					dialog1.dismiss();
					}
				});
				Button nothanks = (Button) couponView.findViewById(R.id.nothanks);
				nothanks.setOnClickListener(new OnClickListener() {
				public void onClick(View v) {
					Log.e("date", getCurrentDateTime());
					Editor ed=pref.edit();
					ed.putString("thanksdate", getCurrentDateTime());
					ed.commit();
					dialog1.dismiss();
					
					}
				});
				dialog1.show();
		    }
		public static  void couponAlertbox()   //coupon alert box with three button and one edit text
		{
			final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
			LayoutInflater inflator = ((Activity) ctx).getLayoutInflater();
			final View couponView = inflator.inflate(R.layout.coupon_layout, null);
			builder.setView(couponView);
			final AlertDialog dialog1 =builder.create();
			//dialog1.setMessage("coupon code");
			WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
		        lp.width = LayoutParams.MATCH_PARENT;
		        lp.height = LayoutParams.MATCH_PARENT;
		        dialog1.getWindow().setAttributes(lp); 
			Button btnCheck = (Button) couponView.findViewById(R.id.check);
			btnCheck.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
				
				//4E:67:26:ED:00:75:31:15:22:00:0C:9F:C4:DA:25:E3:00:78:0E:BA;com.truesecrets.strange.tour.melbourne

					// TODO Auto-generated method stub
					
					ConnectionDetector.hideKeyboard(ctx);
					
					final EditText editCoupon = (EditText) couponView.findViewById(R.id.coupon);
					String str_coupon = editCoupon.getText().toString().replaceAll(" ", "");//"   5454YUH"
					Log.e("edit text coupon code str", str_coupon);
					CouponChecker couponCheck = new CouponChecker(ctx);
					if(str_coupon.equals(""))
					{
						Toast.makeText(ctx, "Please enter coupon/ vaucher", Toast.LENGTH_SHORT).show();
						}
					else
					{
						
					if(detector.isConnectingToInternet())
					{
						
						CouponChecker.coupon_status="";
						CouponChecker.coupon_expired="";
						CouponChecker.coupon_used="";
						/*pDialog = new ProgressDialog(ctx);
						pDialog.setTitle("True Secrets");
						pDialog.setMessage("Please wait...");
						pDialog.setCancelable(false);
						pDialog.show();*/
						
						HashMap<String, String> map =couponCheck.checkCoupn("ts_coupongetter","6X&z7ub^bzqiPJuLcu",
						"Parampreet","parampreetsingh@krishnais.com" ,imei, "0123456789","checkcoupon",str_coupon, url);
						
						//pDialog.dismiss();
						 if((CouponChecker.coupon_status).equalsIgnoreCase("invalid coupon"))
							{
								Toast.makeText(ctx, "Please enter valid coupon", Toast.LENGTH_SHORT).show();
								}
						else
						{
							 if((CouponChecker.coupon_expired).equalsIgnoreCase("true"))
								{
									Toast.makeText(ctx, "Your coupon has expired", Toast.LENGTH_SHORT).show();	
									}
							else if((CouponChecker.coupon_used).equalsIgnoreCase("true"))
								{
									Toast.makeText(ctx, "Your coupon is already used", Toast.LENGTH_SHORT).show();	
									}
							else
								{
									Log.e("map", map.toString());
									String str_couponcode="";
									if(CouponChecker.coupon_productid.equalsIgnoreCase("TS950"))
									{
										str_couponcode=CommonUtilities.ITEM_ts950;
										}
									else if(CouponChecker.coupon_productid.equalsIgnoreCase("TS1450"))
									{
										str_couponcode=CommonUtilities.ITEM_ts1450;
										}
									else if(CouponChecker.coupon_productid.equalsIgnoreCase("TS1800"))
									{
										str_couponcode=CommonUtilities.ITEM_ts1800;
										}
									else if(CouponChecker.coupon_productid.equalsIgnoreCase("TS1900"))
									{
										str_couponcode=CommonUtilities.ITEM_ts1900;
										}
									else if(CouponChecker.coupon_productid.equalsIgnoreCase("TS000"))
									{
										//str_couponcode=CommonUtilities.ITEM_ts950;
										 pref.edit().putBoolean("isPurchased", true).commit();
										 HomeFragment.backgroundColorChange();
										 gotHomeActivty(ctx);
										Toast.makeText(ctx, "Application purchase sucessfully..!", Toast.LENGTH_SHORT).show();	
									}
									
									
									Log.e("str_couponcode", str_couponcode);
									
									mHelper.launchPurchaseFlow((Activity) ctx, str_couponcode, 10001, mPurchaseFinishedListener,"mypurchasetoken");
									//Log.e("map", map.toString());
									dialog1.dismiss();
				//					Intent myIntent = new Intent(ctx, StartUpActivity.class);
				//	                ctx.startActivity(myIntent); 
									}
							}
					}
					else
					{
						AlertDialog.Builder builder=new AlertDialog.Builder(ctx);
						builder.setTitle("True Secrets");
						builder.setMessage("Internet connection is not available");
						builder.setNegativeButton("Ok", null);
						builder.create().show();
						}
				}
				
				}
			});
			
		dialog1.show();
		}
	 public static void showPaymentDialog()
	    {
	    	
			final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
			LayoutInflater inflator = ((Activity) ctx).getLayoutInflater();
			final View couponView = inflator.inflate(R.layout.purchase_layout, null);
			builder.setView(couponView);
			final AlertDialog dialog1 =builder.create();
			//dialog1.setTitle("To experience the full True Secrets tour you need to purchase access to the audio files.");
			//dialog1.setMessage("coupon code");
			WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
		        lp.width = LayoutParams.MATCH_PARENT;
		        lp.height = LayoutParams.MATCH_PARENT;
		        dialog1.getWindow().setAttributes(lp); 
			Button btnCheck = (Button) couponView.findViewById(R.id.coupon);
			btnCheck.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
					// TODO Auto-generated method stub
				couponAlertbox();
				dialog1.dismiss();
				}
			});
			Button withoutCheck = (Button) couponView.findViewById(R.id.continueWithoutCoupon);
			withoutCheck.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
					// TODO Auto-generated method stub
				mHelper.launchPurchaseFlow((Activity) ctx, CommonUtilities.ITEM_ts1900, 10001, mPurchaseFinishedListener, "mypurchasetoken");
				
			/*	Intent myIntent = new Intent(ctx, StartUpActivity.class);
				                ctx.startActivity(myIntent); */
				dialog1.dismiss();
				}
			});
			dialog1.show();
	    }
	 public static void gotHomeActivty(Context ctx )
	 {
		  Intent i=new Intent(ctx,MainActivity.class);
		  ctx.startActivity(i);
		  
	 	}
		static IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener = new IabHelper.OnIabPurchaseFinishedListener() {
				
			public void onIabPurchaseFinished(IabResult result, Purchase purchase) 
				{		
					 Log.i("purchaseFinishedListener main screen", "Result:"+result);
				
					 if(result.getResponse() == IabHelper.BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED)
						{
						   System.err.println("already owned");	
							//Toast.makeText(MainActivity.this, "Item is already purchased",Toast.LENGTH_SHORT).show();
							pref.edit().putBoolean("isPurchased", true).commit();
							HomeFragment.backgroundColorChange();
							gotHomeActivty(ctx);
							//MainActivity.changeTextColor();
							}
					 else if (result.isFailure()) {
							// Handle error
						  	System.err.println("failure");
						    Log.d("tag", "purchased failure");
						 
						    
							return;
							}   
					 else if(purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts950))
						{
						 Log.d("tag", "purchase successfully");
						  pref.edit().putBoolean("isPurchased", true).commit();
						  HomeFragment.backgroundColorChange();
						  gotHomeActivty(ctx);
						     
						   
							}  
						  
					 else if(purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1450))
						 {
						 Log.d("tag", "purchase successfully");
						 // consumeItem();
						  pref.edit().putBoolean("isPurchased", true).commit();
						  HomeFragment.backgroundColorChange();
						  gotHomeActivty(ctx);
						  }
					 else if(purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1800))
						{
						 Log.d("tag", "purchase successfully");
						 // consumeItem();
						  pref.edit().putBoolean("isPurchased", true).commit();
						  HomeFragment.backgroundColorChange();
						  gotHomeActivty(ctx);
							 }
					 else if(purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1900))
						 {
						 Log.d("tag", "purchase successfully");
						 // consumeItem();
						  pref.edit().putBoolean("isPurchased", true).commit();
						  HomeFragment.backgroundColorChange();
						  gotHomeActivty(ctx);
						 // MainActivity.changeTextColor();
						}
					 		
					}
				};
				
				@Override
				protected void onActivityResult (int requestCode, int resultCode, Intent data) 
				{
//					super.onActivityResult(requestCode, resultCode, data);
//					Log.e("onActivityResult....................", "OnActivityResult called");
//					if(RESULT_OK==resultCode){
//					
//						IabResult result = new IabResult(resultCode, "Item Purchased");
//		                if (mPurchaseFinishedListener != null) mPurchaseFinishedListener.onIabPurchaseFinished(result, null);
					//}
					
					 if (!mHelper.handleActivityResult(requestCode, 
				              resultCode, data)) {     
				    	super.onActivityResult(requestCode, resultCode, data);
				    	
				      }
				}
	protected void startTimer() {
			stopTimer();
			timer = new Timer();
			initializeTimerTask();
			timer.schedule(TimerTask,600*1000, 600*1000);//10min
			
			Log.e("","Start timer");	
				}

		public void stopTimer() {
			if (timer != null) {
			timer.cancel();
			timer = null;

			Log.e("","Stop timer");	
			}
				}
		
		private void initializeTimerTask() {
			TimerTask = new TimerTask() {
			public void run() {
			runOnUiThread(new Runnable() {
			@Override
			public void run() {
					try{
						if(pref.getBoolean("rating", false)==false)
							{
								findDate();
								if(int_day>3)
								{
									RatingDailog();
									}
								}
							}
						catch(Exception e)
						{
							e.printStackTrace();
							}

						}
					});
				}
			};
				}
		
		@Override
		protected void onStop() {
			// TODO Auto-generated method stub
			super.onStop();
			stopTimer();
		}
		public void freeMemory(){ 
			System.err.println("free memory");
		    System.runFinalization();
		    Runtime.getRuntime().gc();
		    System.gc();
		}
	}


		