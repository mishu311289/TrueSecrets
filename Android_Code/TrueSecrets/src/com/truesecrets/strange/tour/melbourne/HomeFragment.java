package com.truesecrets.strange.tour.melbourne;

import java.io.File;
import java.io.InputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.res.Resources;
import android.graphics.Color;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.telephony.TelephonyManager;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AlphaAnimation;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.TextView.BufferType;
import android.widget.Toast;

import com.android.vending.expansion.zipfile.APKExpansionSupport;
import com.android.vending.expansion.zipfile.ZipResourceFile;
import com.inapppurchase.util.IabHelper;
import com.inapppurchase.util.IabResult;
import com.inapppurchase.util.Inventory;
import com.inapppurchase.util.Purchase;
import com.truesecrets.strange.tour.melbourne.ObbExpansionsManager.ObbListener;
import com.truesecrets.util.CommonUtilities;
import com.truesecrets.util.ConnectionDetector;

@SuppressLint("ValidFragment")
public class HomeFragment extends Fragment {	
	Context ctx;
	int flag = 0;
	TextView welcomeString, welcomeString_a, txtEnjoy,imgSecret1txt,imgSecret2txt,imgSecret3txt,imgSecret4txt,imgSecret5txt,imgSecret6txt,imgSecret7txt;
	static ImageView imgSecret1;
	static ImageView imgSecret2, imgSecret3,imgSecret4,imgSecret5, imgSecret6, imgSecret7;	
	public static LinearLayout laySecret1, laySecret2, laySecret4, laySecret5, laySecret6, laySecret7;
	static public ImageView imgplay;
//    Bitmap bmp;
    RelativeLayout welcomeLayout;
    ObbExpansionsManager expansionManager;
    File convertedFile;
    public static SharedPreferences pref;
    public static boolean welcomeSoundInitialized = false;
    CommonUtilities commonUtilities;
    String url;
	String imei;
	String mobile;
    private static final String TAG = "com.truesecrets.purchase.inappbilling";
    IabHelper mHelper;
    int count=0;
//	static final String ITEM_SKU = "com.truesecrets.tour.melbourne.click";
	
    
	
    static ConnectionDetector detector;
	private SharedPreferences prefernces;
	
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
    	super.onActivityCreated(savedInstanceState);    	
    }

    public HomeFragment()
    {
    
    	
    	
    	
    }
    public HomeFragment(Context context)
    {
    	ctx = context;
    	
    	
    	Resources res = ctx.getResources();    
   	  	url= res.getString(R.string.app_url);
    	
   	 TelephonyManager mngr = (TelephonyManager)ctx.getSystemService(ctx.TELEPHONY_SERVICE); 
	 imei=mngr.getDeviceId();	 
	 mobile=mngr.getLine1Number();
	 mHelper = new IabHelper(ctx,CommonUtilities.base64EncodedPublicKey);
        
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
    	
    	
    	pref = ctx.getSharedPreferences("mypref", Context.MODE_APPEND);
    	detector = new ConnectionDetector(ctx);
    	expansionManager = new ObbExpansionsManager(ctx, new ObbListener() {
			
			@Override
			public void onMountSuccess() {
				Log.e("on Mount success","mount success");
			}
			
			@Override
			public void onFilesNotFound() {
				Log.e("on file not found","file not found");
			}
		});
    	
    	commonUtilities = new CommonUtilities(context);
    	prefernces = context.getSharedPreferences("truesecretPreferences", context.MODE_PRIVATE);
    	/*headingTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/IMFePIsc28P.ttf");
		boldTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Bold.ttf");
		boldItalicTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-BoldItalic.ttf");
		italicTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Italic.ttf");
		regularTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Regular.ttf");		*/
    }
    
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
        Bundle savedInstanceState) {
    View view = inflater.inflate(R.layout.mainscreen, container, false);
    
  
     welcomeLayout = (RelativeLayout)view.findViewById(R.id.welcomeLayout);
     imgSecret1 = (ImageView)view.findViewById(R.id.imgSecret1);   
     imgSecret2 = (ImageView)view.findViewById(R.id.imgSecret2);     
     imgSecret3 = (ImageView)view.findViewById(R.id.imgSecret3);    
     imgSecret4 = (ImageView)view.findViewById(R.id.imgSecret4); 	
     imgSecret5 = (ImageView)view.findViewById(R.id.imgSecret5);     
     imgSecret6 = (ImageView)view.findViewById(R.id.imgSecret6);      
	 imgSecret7 = (ImageView)view.findViewById(R.id.imgSecret7);
	 
	 laySecret1=(LinearLayout)view.findViewById(R.id.laySecret1);
	 laySecret2=(LinearLayout)view.findViewById(R.id.laySecret2);
	 //laySecret3=(LinearLayout)view.findViewById(R.id.laySecret3);
	 laySecret4=(LinearLayout)view.findViewById(R.id.laySecret4);
	 laySecret5=(LinearLayout)view.findViewById(R.id.laySecret5);
	 laySecret6=(LinearLayout)view.findViewById(R.id.laySecret6);
	 laySecret7=(LinearLayout)view.findViewById(R.id.laySecret7);
	
	 
	
	 backgroundColorChange();//set disable all secrets images
	 
	imgplay = (ImageView)view.findViewById(R.id.imgplay);
	
	welcomeLayout.setTag("Welcome");
    MainActivity.views.add(welcomeLayout);
    
    String mainscreenstring="Just swipe to the left to start, or click below\n\nBefore you start:\nBest enjoyed with headphones and some friends. You can get a discount coupon for a friend here";
	
  /*  sorry_Span=new SpannableString("Sorry, you dont have any registered device, what you want to do ?");

    // sorry_Span.setSpan(new ForegroundColorSpan(Color.rgb(34,141,65), 36, 42, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
 sorry_Span.setSpan(new ForegroundColorSpan(getResource().getColor(R.color.mycolor), 36, 42, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
     sorry_Msg.setText(sorry_Span);*/
    
    welcomeString = (TextView)view.findViewById(R.id.welcomeText);
    addClickablePart(mainscreenstring).setSpan(new ForegroundColorSpan(getResources().getColor(R.color.app_base)), flag, flag, flag);
    welcomeString.setMovementMethod(LinkMovementMethod.getInstance());
   // welcomeString.setText(addClickablePart(mainscreenstring), BufferType.SPANNABLE);
    welcomeString.setText(addClickablePart(mainscreenstring), BufferType.SPANNABLE);
    welcomeString_a = (TextView)view.findViewById(R.id.welcomeText_a);
    txtEnjoy = (TextView)view.findViewById(R.id.txtEnjoy);
    
    imgSecret1txt = (TextView)view.findViewById(R.id.imgSecret1txt);
    imgSecret2txt = (TextView)view.findViewById(R.id.imgSecret2txt);
    imgSecret3txt = (TextView)view.findViewById(R.id.imgSecret3txt);
    imgSecret4txt = (TextView)view.findViewById(R.id.imgSecret4txt);
    imgSecret5txt = (TextView)view.findViewById(R.id.imgSecret5txt);
    imgSecret6txt = (TextView)view.findViewById(R.id.imgSecret6txt);
    imgSecret7txt = (TextView)view.findViewById(R.id.imgSecret7txt);
    
   
      
    imgSecret1txt.setTypeface(MainActivity.headingTypeface);
    imgSecret2txt.setTypeface(MainActivity.headingTypeface);
    imgSecret3txt.setTypeface(MainActivity.headingTypeface);
    imgSecret4txt.setTypeface(MainActivity.headingTypeface);
    imgSecret5txt.setTypeface(MainActivity.headingTypeface);
    imgSecret6txt.setTypeface(MainActivity.headingTypeface);
    imgSecret7txt.setTypeface(MainActivity.headingTypeface);
    
    
    welcomeString_a.setTypeface(MainActivity.headingTypeface);
    welcomeString.setTypeface(MainActivity.regularTypeface);
    txtEnjoy.setTypeface(MainActivity.droidsansTypeface);
   
    
    imgSecret1.setOnClickListener(imageLinkListner);
    imgSecret2.setOnClickListener(imageLinkListner);
    imgSecret3.setOnClickListener(imageLinkListner);
    imgSecret4.setOnClickListener(imageLinkListner);
    imgSecret5.setOnClickListener(imageLinkListner);
    imgSecret6.setOnClickListener(imageLinkListner);
    imgSecret7.setOnClickListener(imageLinkListner); 
    
    imgSecret1txt.setOnClickListener(txtLinkListner);
    imgSecret2txt.setOnClickListener(txtLinkListner);
    imgSecret3txt.setOnClickListener(txtLinkListner);
    imgSecret4txt.setOnClickListener(txtLinkListner);
    imgSecret5txt.setOnClickListener(txtLinkListner);
    imgSecret6txt.setOnClickListener(txtLinkListner);
    imgSecret7txt.setOnClickListener(txtLinkListner);
    welcomeLayout.setOnClickListener(imageLinkListner);    
    
    return view;
    }
    
   /* @Override
    public void onResume() {
    	super.onResume();
    	imgplay.setImageResource(R.drawable.play);
    	Log.e("","onResume()");
    }
    
    @Override
    public void onPause() {
    	super.onPause();
    	imgplay.setImageResource(R.drawable.play);
    	Log.e("","onPause();");
    }
    
    @Override
    public void onStop() {
    	super.onStop();
    	imgplay.setImageResource(R.drawable.play);
    	Log.e("","onStop();");
    }*/

    private View.OnClickListener imageLinkListner = new View.OnClickListener() {		
		@SuppressWarnings("deprecation")
		@SuppressLint("NewApi")
		@Override
		public void onClick(View v) {
			if(v == imgSecret1)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(1);
					}
				
			else if(v == imgSecret2)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(2);
					}
				
			else if(v == imgSecret3)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.viewPager.setCurrentItem(1);
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(3);
					}
				
			else if(v == imgSecret4)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(4);
					}
				
			else if(v == imgSecret5)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(5);
					}
				
			else if(v == imgSecret6)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(6);
					}
			
			else if(v == imgSecret7)
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(7);
					}
				
			else if(v == welcomeLayout){	
				if(MainActivity.viewPager.getCurrentItem() == 0){
					
					
					try{
					if(MainActivity.welcomePlayer.isPlaying()){
						imgplay.setImageResource(R.drawable.play);
					}else
					{
						imgplay.setImageResource(R.drawable.pause);
						}
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					
					/*MainActivity.flag = 0;
					MainActivity.secret.callOnClick();
					
					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();	*/		
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
					
					//couponAlertbox();
				
					try{
						
					int versionCode=CommonUtilities.getCodeVersion(ctx);
					ZipResourceFile expansionFile = APKExpansionSupport.getAPKExpansionZipFile(ctx, versionCode, 0);
					
					InputStream fileStream = expansionFile.getInputStream(ctx.getResources().getString(R.string.expansionFilesPrefix)+"/opening_monologue.mp3");
					Log.e("file","="+fileStream);
					//convertedFile = commonUtilities.takeInputStream(fileStream,"opening_monologue");
				//	Log.e("converted file","::: ="+convertedFile+":::="+convertedFile.getAbsolutePath());
					if(prefernces.getString("welcomePlayer", "").equals("")){
						convertedFile = commonUtilities.takeInputStream(fileStream,"opening_monologue");//opening_monologue
						Log.e("converted file","::: "+convertedFile+":::"+convertedFile.getAbsolutePath());
						
						
				        Editor editor = prefernces.edit();
				        editor.putString("welcomePlayer", convertedFile.getAbsolutePath());
				        editor.commit();
					}
					
				/*	if(pref.getBoolean("isPurchased", false))
					{
					*/
						playMusic(Uri.fromFile(convertedFile));
					
				/*	}
					else
					{*/
						//couponAlertbox();
						
						/*AlertDialog dialog = new AlertDialog.Builder(ctx).create();
							dialog.setTitle("True Secrets");
							dialog.setMessage("You would need to purchase audio files. Purchase now?");
							dialog.setButton("Continue", new DialogInterface.OnClickListener() {
								
								@Override
								public void onClick(DialogInterface dialog, int which) {
									// TODO Auto-generated method stub
									
									dialog.dismiss();
									
										
										final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
									
										LayoutInflater inflator = ((Activity)ctx).getLayoutInflater();
										
										View couponView = inflator.inflate(R.layout.coupon, null);
										builder.setView(couponView);
										
										final AlertDialog dialog1 =builder.create();
										
										 WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
							                lp.width = LayoutParams.MATCH_PARENT;
							                lp.height = LayoutParams.MATCH_PARENT;
							                dialog1.getWindow().setAttributes(lp); 
										
										
										final EditText editCoupon = (EditText) couponView.findViewById(R.id.coupon);
										Button btnCheck = (Button) couponView.findViewById(R.id.check);
										Button btnCancel = (Button) couponView.findViewById(R.id.cancel);
										Button btnContinueWithoutCoupon = (Button) couponView.findViewById(R.id.continueWithoutCoupon);
										
										
										btnCancel.setOnClickListener(new OnClickListener() {
											
											@Override
											public void onClick(View v) {
												// TODO Auto-generated method stub
												dialog1.dismiss();
												
											}
										});
										btnCheck.setOnClickListener(new OnClickListener() {
											
											@Override
											public void onClick(View v) {
												// TODO Auto-generated method stub
												dialog1.dismiss();
												
												String str = editCoupon.getText().toString().trim();
												Log.e("map", str);
//												if(!str.equals(""))
//												{
													Log.e("map", "");
													CouponChecker couponCheck = new CouponChecker(ctx);
													
													HashMap<String, String> map =couponCheck.checkCoupn("ts_coupongetter","6X&z7ub^bzqiPJuLcu", imei, mobile, "action","checkcoupon", url);
													
													Log.e("map", map.toString());
													mHelper.launchPurchaseFlow((Activity)ctx, CommonUtilities.ITEM_SKU, 10001,   
															mPurchaseFinishedListener, "mypurchasetoken");
													Log.e("map", map.toString());
												}
												else
												{
													
													
													
													
													
													
													
//												}
											}
										});
										
										dialog1.show();
//										builder.show();
										
									
									
								}
							}) ;
							dialog.setButton2("Cancel", new DialogInterface.OnClickListener() {
								
								@Override
								public void onClick(DialogInterface dialog, int which) {
									// TODO Auto-generated method stub
									dialog.dismiss();
								}
							}) ;	
							dialog.show();
						}*/
					
					//}
					}catch (Exception e) {
						e.printStackTrace();
					}
				    
				}else{
					imgplay.setImageResource(R.drawable.play);				
				}
			}
		}
	};
	
	
	
	private View.OnClickListener txtLinkListner = new View.OnClickListener() {		
		@Override
		public void onClick(View v) {
			if(v ==  imgSecret1txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(1);
					}
			
				}
			else if(v == imgSecret2txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(2);
					}
				
				}
			else if(v == imgSecret3txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.viewPager.setCurrentItem(3);
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(3);
					}
			
				}
			else if(v == imgSecret4txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(4);
					}
				
				}
			else if(v == imgSecret5txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(5);
					}
				
				}
			else if(v == imgSecret6txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(6);
					}
			
				}
			else if(v == imgSecret7txt)
			{
				if(pref.getBoolean("isPurchased", false)==false)
				{ 
					MainActivity.showPaymentDialog();
				}
				else
				{
					MainActivity.viewPager.setCurrentItem(7);
					}
			
				}
			}
	};
	
	
	/*public Bitmap getRoundedCornerBitmap(Context context, Bitmap input, int pixels , int w , int h , boolean squareTL, boolean squareTR, boolean squareBL, boolean squareBR  ) {

		freeMemory();
		Bitmap output= null;
	try{
	     output = Bitmap.createBitmap(w, h, Config.ARGB_8888);
	    Canvas canvas = new Canvas(output);
	    final float densityMultiplier = context.getResources().getDisplayMetrics().density;

	    final int color = 0xff424242;
	    final Paint paint = new Paint();
	    final Rect rect = new Rect(0, 0, w, h);
	    final RectF rectF = new RectF(rect);

	    //make sure that our rounded corner is scaled appropriately
	    final float roundPx = pixels*densityMultiplier;

	    paint.setAntiAlias(true);
	    canvas.drawARGB(0, 0, 0, 0);
	    paint.setColor(color);
	    canvas.drawRoundRect(rectF, roundPx, roundPx, paint);


	    //draw rectangles over the corners we want to be square
	    if (squareTL ){
	        canvas.drawRect(0, 0, w/2, h/2, paint);
	    }
	    if (squareTR ){
	        canvas.drawRect(w/2, 0, w, h/2, paint);
	    }
	    if (squareBL ){
	        canvas.drawRect(0, h/2, w/2, h, paint);
	    }
	    if (squareBR ){
	        canvas.drawRect(w/2, h/2, w, h, paint);
	    }

	    paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
	    canvas.drawBitmap(input, 0,0, paint);
		
		}
	catch(Exception e)
	{
		System.err.println("Excepction out of memory.");
		e.printStackTrace();
		}
	
	return output;
		
	}*/
	
	IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener = new IabHelper.OnIabPurchaseFinishedListener() {
		
		public void onIabPurchaseFinished(IabResult result, Purchase purchase) 
		{		
			 Log.i("purchaseFinishedListener home screen", "Result:"+result);
		
			 if(result.getResponse() == IabHelper.BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED)
				{
				//  System.err.println("already owned");	
					Toast.makeText(ctx, "Item is already purchased",Toast.LENGTH_SHORT).show();
					pref.edit().putBoolean("isPurchased", true).commit();
					
					backgroundColorChange();
					//MainActivity.changeTextColor();
					}
			 else if (result.isFailure()) {
					// Handle error
				  	System.err.println("failure");
				    Log.d("tag", "purchased failure");
					return;
					}   
			 else if(
				  purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts950)
				||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1450)
				||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1800)
				||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1900))
			 	{
				  Toast.makeText(ctx, "Item is successfully purchased",Toast.LENGTH_SHORT).show();
				  Log.d("tag", "purchase successfully");
				 // consumeItem();
				  pref.edit().putBoolean("isPurchased", true).commit();
				  backgroundColorChange();
				 // MainActivity.changeTextColor();
			  		}
			
				}
		};
		public  void consumeItem() {
			mHelper.queryInventoryAsync(mReceivedInventoryListener);
			}
		 IabHelper.QueryInventoryFinishedListener mReceivedInventoryListener= new IabHelper.QueryInventoryFinishedListener() {
			   public void onQueryInventoryFinished(IabResult result,Inventory inventory) {
			      if (result.isFailure()) {
				  // Handle failure
			      } 
			      else {
		              mHelper.consumeAsync(inventory.getPurchase(CommonUtilities.ITEM_ts1900),  mConsumeFinishedListener);
			      	}
			   }
			};
		static IabHelper.OnConsumeFinishedListener mConsumeFinishedListener =new IabHelper.OnConsumeFinishedListener() {
				@SuppressWarnings("static-access")
				public void onConsumeFinished(Purchase purchase, IabResult result) {
					if (result.isSuccess()) {		    	 
					Log.i("tag", "Consume Successfully");
					} else {
						// handle error
						Log.i("tag", "Consume Failed");
					}
				}
			};
	/*IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener 
	= new IabHelper.OnIabPurchaseFinishedListener() {
	public void onIabPurchaseFinished(IabResult result, 
                    Purchase purchase) 
	{
		
		if(result.getResponse() == IabHelper.BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED)
			{
			
				 pref.edit().putBoolean("isPurchased", true).commit();
			}
			if (result.isFailure()) {
	      // Handle error
	      return;
	 }      
	 else if (purchase.getSku().equals(CommonUtilities.ITEM_SKU)) {
//		 consumeItem();
		
	   pref.edit().putBoolean("isPurchased", true).commit();
	    
	}
	      
   }bitma
};*/
	public void playMusic(Uri audioFileId) {
	    try {	    	
	    		if(!welcomeSoundInitialized){
	    			welcomeSoundInitialized= true;
	    			if(MainActivity.welcomePlayer==null){
	    				MainActivity.welcomePlayer = new MediaPlayer();
	    			}
	    			
	    			
	    			MainActivity.welcomePlayer = MediaPlayer.create(ctx, audioFileId);
	    			MainActivity.welcomePlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {						
						@SuppressLint("NewApi")
						@Override
						public void onCompletion(MediaPlayer mp) {
							imgplay.setImageResource(R.drawable.play);

							/*MainActivity.flag = 0;
							MainActivity.secret.callOnClick();
							
							MainActivity.flag = 1;
							MainActivity.secret.callOnClick();	*/
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
	    		}		    		
	    		
	    		if(MainActivity.welcomePlayer.isPlaying()){	   	    			
		    		MainActivity.welcomePlayer.pause();
		    	}else{
		    		
		    		MainActivity.welcomePlayer.start();	
		    		
		    	/*	MainActivity.welcomePlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
		    			  public void onPrepared(MediaPlayer mp) {
		    				  MainActivity.welcomePlayer.start();
		    			  }
		    			});*/
	    	      }

	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	}
	
	public SpannableStringBuilder addClickablePart(String str) {
	    SpannableStringBuilder ssb = new SpannableStringBuilder(str);
	    //ssb.setSpan(new ForegroundColorSpan(Color.GREEN), flag, flag, flag);	   
	    try{    	   	
	      // int i=0;
	        Matcher m = Pattern.compile("for a friend here").matcher(str);
	        
		    while(m.find()){		    	
		    	 final String clickString  = m.group(0); // (714) 321-2620	
		    	// myArray[i] = m.group(0);
		    	// Log.e("String",  matchstr[i] );
		         ssb.setSpan(new ClickableSpan() {	
		        	  @SuppressLint("NewApi")
					@Override
		            public void onClick(View widget) {
		               // Toast.makeText(MyListActivity.this, clickString,  Toast.LENGTH_SHORT).show();
		            	MainActivity.viewPager.setCurrentItem(8);
		            	
		            	/*MainActivity.flag = 0;
						MainActivity.secret.callOnClick();
						
						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();	*/
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
		        }, m.start(), m.end(), 0);
		    }
		   }catch(Exception e){Log.e("Exception",  e.getMessage());	    
	    	Log.e("Exception", e.getMessage());	    }
	    //ssb.setSpan(new ForegroundColorSpan(Color.WHITE), 135 ,152, 0);
	    ssb.setSpan(new ForegroundColorSpan(Color.parseColor("#be8e26")), 135 ,161, 0);
	    return ssb;	    
	 }
	/*public  void couponAlertbox()   //coupon alert box with three button and one edit text
	{
		final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
		LayoutInflater inflator = ((Activity)ctx).getLayoutInflater();
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
					HashMap<String, String> map =couponCheck.checkCoupn("ts_coupongetter","6X&z7ub^bzqiPJuLcu",
					"Parampreet","parampreetsingh@krishnais.com" ,imei, "0123456789","checkcoupon",str_coupon, url);
				
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
								
								
								Log.e("str_couponcode", str_couponcode);
								
								mHelper.launchPurchaseFlow((Activity)ctx, str_couponcode, 10001, mPurchaseFinishedListener,"mypurchasetoken");
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
		
	dialog1.show();*/
	
//	builder.show();	final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
//	}
	public static void backgroundColorChange() {
		
		if(pref.getBoolean("isPurchased", false)==false)
		 {
			//laySecret1.setBackgroundResource(R.drawable.body_bg);
			 AlphaAnimation alpha = new AlphaAnimation(0.5F, 0.5F);
             alpha.setDuration(0); // Make animation instant
             alpha.setFillAfter(true); // Tell it to persist after the animation ends
             laySecret1.startAnimation(alpha);
			laySecret2.startAnimation(alpha);
			laySecret4.startAnimation(alpha);
			laySecret5.startAnimation(alpha);
			laySecret6.startAnimation(alpha);
			laySecret7.startAnimation(alpha);
			 
			 
		 }
		 else{
			
			 AlphaAnimation alpha = new AlphaAnimation(1F, 1F);
             alpha.setDuration(0); // Make animation instant
             alpha.setFillAfter(true); // Tell it to persist after the animation ends
             laySecret1.startAnimation(alpha);
			laySecret2.startAnimation(alpha);
			laySecret4.startAnimation(alpha);
			laySecret5.startAnimation(alpha);
			laySecret6.startAnimation(alpha);
			laySecret7.startAnimation(alpha);
		 }
    }
	
	@Override
	public void onResume() {
		// TODO Auto-generated method stub
		
		backgroundColorChange();
		
		System.err.println("onResume home fragment");
		super.onResume();
	}
	/* public void showPaymentDialog()
	    {
	    	
			final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
			LayoutInflater inflator = ((Activity)ctx).getLayoutInflater();
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
				mHelper.launchPurchaseFlow((Activity)ctx, CommonUtilities.ITEM_ts1900, 10001, mPurchaseFinishedListener, "mypurchasetoken");
				dialog1.dismiss();
				}
			});
			dialog1.show();
	    }*/
	
	public void freeMemory(){       
	    System.runFinalization();
	    Runtime.getRuntime().gc();
	    System.gc();
	}
}

