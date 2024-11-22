package com.truesecrets.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import android.content.Context;
import android.util.Log;

public class CouponChecker  {

	Context ctx;
	HashMap<String, String> map = new HashMap<String, String>();
	public static String coupon_productid="",coupon_status="",coupon_expired="",coupon_used="";
	public CouponChecker(Context ctx)
	{
		this.ctx = ctx;
		
	}
	public HashMap<String, String> checkCoupn(String username,String password,String name,String email,String imei, String mobileNumber,String action, String coupon_c, String myurl)
	{
		
		
		try
		
		{
		 HttpClient httpclient = new DefaultHttpClient();	    
		 HttpPost httppost = new HttpPost(myurl);
	     Log.e("url ", myurl);
		 List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		 nameValuePairs.add(new BasicNameValuePair("username",username));
         nameValuePairs.add(new BasicNameValuePair("password",password));
         nameValuePairs.add(new BasicNameValuePair("name", name));
         nameValuePairs.add(new BasicNameValuePair("email", email));
         nameValuePairs.add(new BasicNameValuePair("IMEI", imei));
         nameValuePairs.add(new BasicNameValuePair("mobile", mobileNumber));
         nameValuePairs.add(new BasicNameValuePair("action", action));
         nameValuePairs.add(new BasicNameValuePair("coupon_code", coupon_c));
         
         Log.e("username ", username);
         Log.e("password ", password);
         Log.e("name ", name);
         Log.e("email ", email);
         Log.e("IMEI ", imei);
         Log.e("mobile ", mobileNumber);
         Log.e("action ", action);
         Log.e("coupon ", coupon_c);
       
         httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
         httppost.setHeader("Accept", "application/xml");
         
      
         
         HttpResponse response = httpclient.execute(httppost);
        // System.err.println(response);
         String responseCoupon = EntityUtils.toString(response.getEntity());
         
         Log.e("Response ", responseCoupon);
      
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	        DocumentBuilder db = dbf.newDocumentBuilder();
	        InputStream is = new ByteArrayInputStream(responseCoupon.getBytes("UTF-8"));
	        Document doc = db.parse(is);
	        Element root = doc.getDocumentElement(); 
	        
	        NodeList nodelist = root.getElementsByTagName("data");
	      
	        Element e1 = (root);
	       
	        coupon_productid=  getValue(e1, "product_code").toString().trim();
	        System.err.println("productcode-->"+ coupon_productid+"=kk");
	        
	        coupon_status=getValue(e1, "status").toString().trim();
	        System.err.println("status----->"+coupon_status);
	        
	        coupon_expired=getValue(e1, "expired").toString().trim();
	        System.err.println("ex----->"+coupon_expired+"=hhh");
	        
	        coupon_used=getValue(e1, "used").toString().trim();
	        System.err.println("used----->"+coupon_used);
	        
	        
	        for (int i = 0; i < nodelist.getLength(); i++) {
	        	Element e = (Element)nodelist.item(i);
	            String mobile = getValue(e, "mobile"); 
	         //   System.err.println("mmmmmmmmmmmm"+mobile);
	        //    String coupon_code = getValue(e, "coupon_code"); 
	          //  System.err.println(coupon_code);
	         //   String expired = getValue(e, "expired"); 
	          //  System.err.println(expired);
	         //   String used= getValue(e,"used");
	         //   System.err.println(used);
	         //   String product_code = getValue(e, "product_code");
	       //    String status= getValue(e, "status");
	          //  System.err.println("useeeeeeeeeeeeed"+status);
	       //     String usernam= getValue(e, "username");
	            
	            
	            
	            map.put("mobile", mobile);	 
	            
	        }
	        
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return map;
	}
	public String getValue(Element item, String str) {      
	    NodeList n = item.getElementsByTagName(str);        
	    return this.getElementValue(n.item(0));
	}
	 
	public final String getElementValue( Node elem ) {
	         Node child;
	         if( elem != null){
	             if (elem.hasChildNodes()){
	                 for( child = elem.getFirstChild(); child != null; child = child.getNextSibling() ){
	                     if( child.getNodeType() == Node.TEXT_NODE  ){
	                         return child.getNodeValue();
	                     }
	                 }
	             }
	         }
	         return "";
	  } 
}
