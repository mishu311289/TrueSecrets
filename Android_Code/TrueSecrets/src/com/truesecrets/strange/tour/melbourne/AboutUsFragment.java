package com.truesecrets.strange.tour.melbourne;

import java.io.ByteArrayInputStream;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.truesecrets.strange.tour.melbourne.R;




import android.app.AlertDialog;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.support.v4.app.Fragment;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

public class AboutUsFragment extends Fragment implements AnimationListener{
	
    TextView  castcreadit, castcreaditstr, disclaimer, disclaimerstr, info, infostr, anyproblems, anyproblemsstr1, anyproblemsstr2, anyproblemsstr3 , anyproblemsnum, anyproblemsemail, coupontxt, coupondiscounttxt, emailtxt, namelabel,emaillabel, googletxt;
	String num , email;
	Context ctx;
	int flag = 0;
	
	LinearLayout emailSubContainer,couponSubContainer;
	Button submitbtn,couponbtn,okbtn, okcouponbtn;
	EditText nameedittxt,emailedittxt;
	static String imei,  mobile, url,  android_coupon, ios_coupon, android_expiry, ios_expiry, discountTxt;
	//static SharedPreferences pref;
	Handler myOffMainThreadHandler;
	
	// Animation
    Animation animSlide_down, animSlideUp;
    static boolean isCouponVisible;
	
    ScrollView mainScrollView;
    
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
    	super.onActivityCreated(savedInstanceState);
    }

    public AboutUsFragment()
    {
    	
    }
    
    public AboutUsFragment(Context context)
    {
    	ctx = context;
    	
    	
    	/*headingTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/IMFePIsc28P.ttf");
		boldTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Bold.ttf");
		boldItalicTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-BoldItalic.ttf");
		italicTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Italic.ttf");
		regularTypeface = Typeface.createFromAsset(ctx.getAssets(), "fonts/NoticiaText-Regular.ttf");	*/	
    }
    
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
        Bundle savedInstanceState) {
    View view = inflater.inflate(R.layout.about, container, false);
    
    mainScrollView = (ScrollView)view.findViewById(R.id.aboutUsScroll);
    
	castcreadit = (TextView)view.findViewById(R.id.castcreadit);
	castcreaditstr = (TextView)view.findViewById(R.id.castcreaditstr);	
	disclaimer= (TextView)view.findViewById(R.id.disclaimer);
	disclaimerstr = (TextView)view.findViewById(R.id.disclaimerstr);
	info= (TextView)view.findViewById(R.id.info);
	infostr = (TextView)view.findViewById(R.id.infostr);
	
	coupontxt = (TextView)view.findViewById(R.id.coupontxt);
	googletxt= (TextView)view.findViewById(R.id.googletxt);
	coupondiscounttxt = (TextView)view.findViewById(R.id.coupondiscounttxt);
	emailtxt = (TextView)view.findViewById(R.id.emailtxt);
	namelabel = (TextView)view.findViewById(R.id.namelabel);
	emaillabel = (TextView)view.findViewById(R.id.emaillabel);
	emailSubContainer= (LinearLayout)view.findViewById(R.id.emailSubContainer);
	couponSubContainer= (LinearLayout)view.findViewById(R.id.couponSubContainer);
	nameedittxt=(EditText)view.findViewById(R.id.nameedittxt);
	emailedittxt=(EditText)view.findViewById(R.id.emailedittxt);
	
	couponbtn =(Button)view.findViewById(R.id.couponbtn);
	submitbtn =(Button)view.findViewById(R.id.submitbtn);
	okbtn =(Button)view.findViewById(R.id.okbtn);
	okcouponbtn=(Button)view.findViewById(R.id.okcouponbtn);
	//pref =ctx.getSharedPreferences("mypref", 1);
	isCouponVisible=true;
//    inVisible=false;
	
	SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
	SharedPreferences.Editor editor = sharedPref.edit();
	editor.putString("Coupon", "visible");
	editor.commit();
	
	// load the animation
    animSlide_down = AnimationUtils.loadAnimation(ctx, R.anim.slide_down);  
    animSlideUp=AnimationUtils.loadAnimation(ctx, R.anim.slide_up); 
    
 // set animation listener
    animSlide_down.setAnimationListener(this);
    animSlideUp.setAnimationListener(this);
	
	anyproblems = (TextView)view.findViewById(R.id.anyproblems);
	anyproblemsnum=(TextView)view.findViewById(R.id.anyproblemsnum);
	anyproblemsemail=(TextView)view.findViewById(R.id.anyproblemsemail);
	anyproblemsstr1 = (TextView)view.findViewById(R.id.anyproblemsstr1);
	anyproblemsstr2 = (TextView)view.findViewById(R.id.anyproblemsstr2);
	anyproblemsstr3 = (TextView)view.findViewById(R.id.anyproblemsstr3);  
	
	  num ="(03) 8256 9621";
	  email="info@truesecrets.com.au";	 
	  
	  myOffMainThreadHandler = new Handler();  // the handler for the main thread
	  
    if(!MainActivity.showHidecoupons && MainActivity.couponVar<3){
	//  if(sharedPref.getString("Coupon","").equals("invisible") && MainActivity.couponVar<3){
    	googletxt.setVisibility(View.VISIBLE);
    	coupondiscounttxt.setVisibility(View.VISIBLE);    	
    	googletxt.setText("Coupon code : "+android_coupon);//\niOS Coupon : "+ios_coupon);
    	//coupondiscounttxt.setText(discountTxt);
    	coupondiscounttxt.setVisibility(View.GONE);
    }/*else if(){
    	
    }*/
	  
	  Resources res = ctx.getResources();    
	  url= res.getString(R.string.app_url);
	  
	
	  anyproblemsnum.setText(num);
	  anyproblemsemail.setText(email);
	
	  castcreadit.setTypeface(MainActivity.boldTypeface );
	  disclaimer.setTypeface(MainActivity.boldTypeface );
	  info.setTypeface(MainActivity.boldTypeface );
   
	 castcreaditstr.setTypeface(MainActivity.regularTypeface);
	 disclaimerstr.setTypeface(MainActivity.regularTypeface);
	 infostr.setTypeface(MainActivity.regularTypeface);
	 anyproblemsstr1.setTypeface(MainActivity.regularTypeface);
	 anyproblemsstr2.setTypeface(MainActivity.regularTypeface);
	 anyproblemsstr3.setTypeface(MainActivity.regularTypeface);
	 anyproblemsnum.setTypeface(MainActivity.regularTypeface);
	 anyproblemsemail.setTypeface(MainActivity.regularTypeface);
	 
     anyproblemsnum.setOnClickListener(listner);
	 anyproblemsemail.setOnClickListener(listner);
	 
	 
	 StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
	 StrictMode.setThreadPolicy(policy); 
	 
	 //TelephonyManager mngr = (TelephonyManager)getSystemService(Context.Telephony_service); 
	 TelephonyManager mngr = (TelephonyManager)ctx.getSystemService(ctx.TELEPHONY_SERVICE); 
	 imei=mngr.getDeviceId();	 
	 mobile=mngr.getLine1Number();
	 //Log.e("About", "IMEINumber =: "+imei+", Mobilenumber=: "+mobile);
	 
	/* Log.e("About","GetCoupon : "+callWebService("","","","","",url));	 
	 Log.e("About","AddEmail : "+callWebService("","",imei, mobile,"addemail",url));*/
	 
	   coupontxt.setOnClickListener(new View.OnClickListener() {			
			@SuppressWarnings({ "static-access", "static-access" })
			@Override
			public void onClick(View v) {

				if(!isCouponVisible){
					submitbtn.setVisibility(v.GONE);
					emailedittxt.setVisibility(v.GONE);
					nameedittxt.setVisibility(v.GONE);
					emailSubContainer.setVisibility(v.GONE);
				    emailSubContainer.startAnimation(animSlideUp);				
				    couponSubContainer.setVisibility(v.VISIBLE);
				    couponSubContainer.startAnimation(animSlide_down);				   
				    isCouponVisible=true;
//				    inVisible=false;
				}else{
					emailedittxt.setVisibility(v.VISIBLE);
					nameedittxt.setVisibility(v.VISIBLE);
					emailedittxt.setText("");
					nameedittxt.setText("");
					submitbtn.setVisibility(v.VISIBLE);
					emailSubContainer.startAnimation(animSlide_down);
					emailSubContainer.setVisibility(v.VISIBLE);
					couponSubContainer.setVisibility(v.GONE);
					couponSubContainer.startAnimation(animSlideUp);	
					
					namelabel.setVisibility(v.VISIBLE);	
					emaillabel.setVisibility(v.VISIBLE);
					namelabel.setText("Name:");	
					emaillabel.setText("Email Adddress:");	
					namelabel.setTextColor(Color.WHITE);
					emaillabel.setTextColor(Color.WHITE);
//					visible=false;
					isCouponVisible=false;
				}
				
				
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
	    
	    emailtxt.setOnClickListener(new View.OnClickListener() {		
			@Override
			public void onClick(View v) {	
				submitbtn.setVisibility(v.VISIBLE);
				emailSubContainer.startAnimation(animSlide_down);
				emailSubContainer.setVisibility(v.VISIBLE);	
				couponSubContainer.startAnimation(animSlideUp);
				couponSubContainer.setVisibility(v.GONE);	
				emailedittxt.setVisibility(v.VISIBLE);
				nameedittxt.setVisibility(v.VISIBLE);
				
				
				
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
	    
	    submitbtn.setOnClickListener(new View.OnClickListener() {		
			@Override
			public void onClick(View v) {
				
				String name=nameedittxt.getEditableText().toString().trim();
				String email=emailedittxt.getEditableText().toString().trim();
				String  respons=callWebServiceaddemail("ts_coupongetter","6X&z7ub^bzqiPJuLcu",imei, mobile, name, email,"addemail",url);
				//Log.e("Aboutus", "Name: "+name+",  Email: "+email+ "Response: "+respons);
				String txt="Thanks your email has been submitted successfully to our email list. You will get a confirmation email soon.";
				System.err.println("respons"+respons);
				if(!name.equals("") && isEmailValid(email)){
					
					System.err.println("respons"+respons);
					if(respons.contains("success") && !respons.equals("Exception") ){
						System.err.println("respons"+respons);
						nameedittxt.setVisibility(v.GONE);
						emailedittxt.setVisibility(v.GONE);
						emaillabel.setVisibility(v.GONE);
						submitbtn.setVisibility(v.GONE);
						namelabel.setText(txt);						
						submitbtn.setVisibility(v.GONE);
						okbtn.setVisibility(v.VISIBLE);
						namelabel.setTextColor(Color.WHITE);
						emaillabel.setTextColor(Color.WHITE);
						
					}else{
						txt="Sorry there has been an error.\nCould be\n-not internet connection\n-connection error\n\nPlease try again later";
						nameedittxt.setVisibility(v.GONE);
						emailedittxt.setVisibility(v.GONE);
						emaillabel.setVisibility(v.GONE);
						submitbtn.setVisibility(v.GONE);
						okbtn.setVisibility(v.VISIBLE);
						namelabel.setText(txt);	
						namelabel.setTextColor(Color.WHITE);
						emaillabel.setTextColor(Color.WHITE);
						}
				}else{
					
					if(name.equals("") && !isEmailValid(email)){
						namelabel.setTextColor(Color.RED);
						emaillabel.setTextColor(Color.RED);
					}else if(name.equals("")){
						namelabel.setTextColor(Color.RED);
						emaillabel.setTextColor(Color.WHITE);
					}else{
						emaillabel.setTextColor(Color.RED);
						namelabel.setTextColor(Color.WHITE);
					}
					
					if(!isEmailValid(email) && !name.equals("")){
						emaillabel.setTextColor(Color.RED);
						Toast.makeText(ctx, "Please fill the valid email", Toast.LENGTH_LONG).show();
						}
					else{
					Toast.makeText(ctx, "Please fill the highlighted fields", Toast.LENGTH_LONG).show();
					}
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
			}
		});
	    
	  
	    couponbtn.setOnClickListener(new View.OnClickListener() {		
			@Override
			public void onClick(View v) {	
				if(HomeFragment.pref.getBoolean("isPurchased", false)==false)
				{
					MainActivity.showPaymentDialog();
									
					}
				else
				{
				
				
				String respons=callWebService("ts_coupongetter","6X&z7ub^bzqiPJuLcu",imei, mobile,"getcoupon",url);
				discountTxt="50% off for your friends\n";				 
				 
				if(respons.contains("coupon codes retrieved successfully") && !respons.equals("Exception") ){
					
					if(MainActivity.couponVar<3){
						//Log.e("couponVar", "couponVar++=: "+MainActivity.couponVar);
						MainActivity.showHidecoupons=false;
						MainActivity.couponVar++;
						googletxt.setVisibility(v.VISIBLE);
						coupondiscounttxt.setVisibility(v.VISIBLE);	
						okbtn.setVisibility(v.GONE);		
												
						if(android_expiry.equals(ios_expiry)){							
							discountTxt=discountTxt+"Valid Until: "+ ios_expiry;
						}else{
							Log.e("", "In date != section");
							discountTxt=discountTxt+"Valid for Android Until: "+android_expiry+"\n"+"Valid for iOS Until: "+ios_expiry;
						}				
						
						googletxt.setText("Coupon code: "+android_coupon);
								//\niOS Coupon : "+ios_coupon);
						coupondiscounttxt.setText(discountTxt);
						changeUi();				   
						}else{
							String txt="Sorry you have used all your coupons, if you think this is an error please contact support";					
							googletxt.setVisibility(v.VISIBLE);
							coupondiscounttxt.setVisibility(v.GONE);
							googletxt.setText(txt);
							changeUi();					
							}
					}else{
						    String txt="Sorry there has been an error.\nCould be\n-not internet connection\n-connection error\n\nPlease try again later";				
							googletxt.setVisibility(v.VISIBLE);
							coupondiscounttxt.setVisibility(v.GONE);
							okcouponbtn.setVisibility(v.VISIBLE);
							googletxt.setText(txt);
							okbtn.setVisibility(v.GONE);
							emailedittxt.setVisibility(v.GONE);
							nameedittxt.setVisibility(v.GONE);
						}
				
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
			}
		});
	    
	    okbtn.setOnClickListener(new View.OnClickListener() {		
			@SuppressWarnings("static-access")
			@Override
			public void onClick(View v) {
				emailSubContainer.setVisibility(v.VISIBLE);
				nameedittxt.setVisibility(v.VISIBLE);
				namelabel.setText("Name:");
				emailedittxt.setVisibility(v.VISIBLE);
				emaillabel.setVisibility(v.VISIBLE);
				submitbtn.setVisibility(v.VISIBLE);
				nameedittxt.setText("");
				emailedittxt.setText("");
				
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
	    
	    okcouponbtn.setOnClickListener(new View.OnClickListener() {		
			@SuppressWarnings("static-access")
			@Override
			public void onClick(View v) {
				googletxt.setVisibility(v.GONE);
				coupondiscounttxt.setVisibility(v.GONE);
				okcouponbtn.setVisibility(v.GONE);
							
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

//	    mainScrollView.scrollTo(0, mainScrollView.getBottom());
	    
       return view;
    }
    
    private View.OnClickListener listner = new View.OnClickListener() {		
		@Override
		public void onClick(View v) {
			 // Perform action on click
	          switch(v.getId()) {  
	          
	          case R.id.home:	         
		         // Log.e("MyPagerAdapter", "home");
		         // ctx.setScrollX(0);
		          break;
		          
	          case R.id.about:	         
	        	  //Log.e("MyPagerAdapter", "about");
	        	  
	        	  LayoutInflater inflater = (LayoutInflater) ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	      	        View view = inflater.inflate(R.layout.about, null);
	      	        
		          break;
		          
	          case R.id.secret:		         
	        	 // Log.e("MyPagerAdapter", "secret");
		          break;
	          
	          case R.id.anyproblemsemail:
	        	  
	        	      Intent emailIntent =new Intent(Intent.ACTION_SEND);  
	                  emailIntent.setType("text/html");
	                  emailIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
	                  emailIntent.putExtra(Intent.EXTRA_EMAIL, email);
	                  emailIntent.putExtra(Intent.EXTRA_SUBJECT, "For testing............");            
                      ctx.startActivity(Intent.createChooser(emailIntent, email));
	                 
	          break;
	          
	          case R.id.anyproblemsnum:
	        	  try {
				        Intent my_callIntent = new Intent(Intent.ACTION_CALL);
				        my_callIntent.setData(Uri.parse("tel:"+num));//here the word 'tel' is important for making a call...
				       // ctx.startActivityForResult(my_callIntent , 1);
				        ctx.startActivity(my_callIntent);
				       // finish();
				    } catch (ActivityNotFoundException e) {
				      Toast.makeText(ctx, "Error in your phone call"+e.getMessage(), Toast.LENGTH_LONG).show();

				    } 
	          break;		
		}
	  }
	};
	
    private View.OnClickListener secretListner = new View.OnClickListener() {		
		@Override
		public void onClick(View v) {
			
		}
	};
	
	
	@SuppressWarnings("unchecked")
	public String callWebService(String username,String password,String imei, String mobileNumber, String action, String myurl){	
		 String str="";
		 HttpClient httpclient = new DefaultHttpClient();	    
		 HttpPost httppost = new HttpPost(myurl);
	     try {
	    	// Add your data
	         @SuppressWarnings("rawtypes")
			 List nameValuePairs = new ArrayList(5);
	         nameValuePairs.add(new BasicNameValuePair("username",username));
	         nameValuePairs.add(new BasicNameValuePair("password",password));
	         nameValuePairs.add(new BasicNameValuePair("IMEI", imei));
	         nameValuePairs.add(new BasicNameValuePair("mobile", mobileNumber));
	         nameValuePairs.add(new BasicNameValuePair("action", action));
	       
	         Log.e("mail", nameValuePairs.toString());
	        
	         httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
	    	
	        HttpResponse response = httpclient.execute(httppost);
	        final String responseCoupon =  EntityUtils.toString(response.getEntity());	  
	      
	        Log.e("responseCoupon",responseCoupon);
	        try{
				InputStream is = new ByteArrayInputStream(responseCoupon.getBytes("UTF-8"));
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		        DocumentBuilder db = dbf.newDocumentBuilder();
		        Document doc = db.parse(is);
		        Element root = doc.getDocumentElement();    
		        NodeList nodelist;
		      
		        nodelist = root.getElementsByTagName("return_code");
		       // Log.e("","return_code : "+nodelist.item(0).getFirstChild().getNodeValue());
		      
		        nodelist = root.getElementsByTagName("message");	  
		        str = nodelist.item(0).getFirstChild().getNodeValue();		        
		        System.err.println("yy="+str+"=yy");
		        if(str.contains("coupon codes retrieved successfully")){
		        nodelist = root.getElementsByTagName("ios_coupon");	
		        ios_coupon=nodelist.item(0).getFirstChild().getNodeValue();		        
		        
		        nodelist = root.getElementsByTagName("ios_expiry");	 
		        ios_expiry=nodelist.item(0).getFirstChild().getNodeValue();		        
		        
		        nodelist = root.getElementsByTagName("android_coupon");	 
		        android_coupon=nodelist.item(0).getFirstChild().getNodeValue();		        
		        
		        nodelist = root.getElementsByTagName("android_expiry");	
		        android_expiry=nodelist.item(0).getFirstChild().getNodeValue();		      
		        }else{
		        	str="Exception";
		        }		    
		     }catch(Exception e){
				e.printStackTrace();
			}		
	        
	        
	        return str;
	     }catch (Exception e){
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	        return "Exception";
	     }		 
	}
	
	@SuppressWarnings("unchecked")
	private String callWebServiceaddemail(String username,String password,String imei, String mobileNumber,String name,String email, String action, String myurl){	
		  String str="";
		 HttpClient httpclient = new DefaultHttpClient();	   
		 HttpPost httppost = new HttpPost(myurl);
	     try {
	    	// Add your data
	         @SuppressWarnings("rawtypes")
			List nameValuePairs = new ArrayList(7);
	         nameValuePairs.add(new BasicNameValuePair("username",username));
	         nameValuePairs.add(new BasicNameValuePair("password",password));
	         nameValuePairs.add(new BasicNameValuePair("name", name));
	         nameValuePairs.add(new BasicNameValuePair("email", email));
	         nameValuePairs.add(new BasicNameValuePair("IMEI", imei));
	         nameValuePairs.add(new BasicNameValuePair("mobile", mobileNumber));
	         nameValuePairs.add(new BasicNameValuePair("action", action));	       
	         
	         Log.e("add email","add email="+nameValuePairs.toString());
	         httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
	    	 
	        HttpResponse response = httpclient.execute(httppost);
	      
	        final String responseEmail =  EntityUtils.toString(response.getEntity());     
	        Log.e("response email","response email="+responseEmail);
	        try{
				InputStream is = new ByteArrayInputStream(responseEmail.getBytes("UTF-8"));
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		        DocumentBuilder db = dbf.newDocumentBuilder();
		        Document doc = db.parse(is);
		        Element root = doc.getDocumentElement();    
		        NodeList nodelist;
		      
		        nodelist = root.getElementsByTagName("return_code");
		    //    Log.e("","return_code : "+nodelist.item(0).getFirstChild().getNodeValue());		        
		        nodelist = root.getElementsByTagName("message");	
		        str=nodelist.item(0).getFirstChild().getNodeValue();
		        Log.e("","message : "+str);	
		        
		        if(str.contains("success")){
		        }
		        else
		        {
		        	str="Exception";
		        	}	    
		     }catch(Exception e){
				e.printStackTrace();
			}		
	        
	        return str;
	     } catch (Exception e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	        return "Exception";
	     }		 
	}
	
	private void changeUi(){
		//Log.e("AboutUs", "Before sleepforsomeTime");
		
		Runnable runnableOffMain = new Runnable(){
            @Override
            public void run() {  // this thread is not on the main	                         	
                         	sleepforsomeTime();
                         	myOffMainThreadHandler.post(new Runnable(){  // this is on the main thread
                                public void run(){
                                	// Log.e("AboutUs", "After sleepforsomeTime");
                                       googletxt.setVisibility(View.GONE);
               						   coupondiscounttxt.setVisibility(View.GONE);	
               						   
               						   MainActivity.showHidecoupons=true;  
               						   
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
                     }
                };
                
                new Thread(runnableOffMain).start();                
	        }
	
	   private void sleepforsomeTime() {
		 Log.e("AboutUs", "sleep(50000)");
        try {
        	  Thread.sleep(12*3600000);
             // Thread.sleep(50000);
              Log.e("AboutUs", "sleep(50000)");
        	} catch (InterruptedException e) { 
               e.printStackTrace();
        	}
        }
	   
	   public boolean isEmailValid(String email){
	         String regExpn =
	             "^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]{1}|[\\w-]{2,}))@"
	                 +"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
	                   +"[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
	                   +"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
	                   +"[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
	                   +"([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})$";

	     CharSequence inputStr = email;

	     Pattern pattern = Pattern.compile(regExpn,Pattern.CASE_INSENSITIVE);
	     Matcher matcher = pattern.matcher(inputStr);

	     if(matcher.matches())
	        return true;
	     else
	        return false;
		}

	@Override
	public void onAnimationEnd(Animation arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onAnimationRepeat(Animation animation) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onAnimationStart(Animation animation) {
		// TODO Auto-generated method stub
		
	}
}
