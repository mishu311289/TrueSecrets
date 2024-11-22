package com.truesecrets.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Environment;
import android.util.Log;

public class CommonUtilities {

	private Context context;
	/*static public final String ITEM_ts950 = "android.test.purchased";//product_test
	static public final String ITEM_ts1450 = "android.test.purchased";
	static public final String ITEM_ts1800 = "android.test.purchased";
	static public final String ITEM_ts1900 = "android.test.purchased";//"android.test.refunded";
*/
	static public final String ITEM_ts950 = "truesecrets.inapp.ts950";
	static public final String ITEM_ts1450 = "truesecrets.inapp.ts1450";
	static public final String ITEM_ts1800 = "truesecrets.inapp.ts1800";
	static public final String ITEM_ts1900 = "truesecrets.inapp.ts1900";
	static public final String base64EncodedPublicKey = 
			"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyWaOjWjjsXoBiQfREc0BwLx844Wgg0Pm5ExCgEqsVuedBNPJlwomcag4v+/sjEfN9NuF0HMCvrA6GtbD55YgU8tQs2QdEIkkM6UkAFhH1V4g7kp61sDZI8MQcqutY8H/vYqjm13GxiDZOKIHEKwEffglOYlJh9enHc2Hs3HusipkuPHN215Beftt4WZuR2iPCb7kN8uuCYUaWL4a40Fa2OdUSPi+0efUyYfQDjuoQobtxxcBf9MgvgxiGiI91GPW2d8v79bnN6ID3BLE5Ia01f9SUiLyxsxrgLdcDqdvzdgEiXM9YZt0MffQPRnCpPh3VMlQ05xyJzGh87KXG9DIGwIDAQAB";
//            "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyWaOjWjjsXoBiQfREc0BwLx844Wgg0Pm5ExCgEqsVuedBNPJlwomcag4v+/sjEfN9NuF0HMCvrA6GtbD55YgU8tQs2QdEIkkM6UkAFhH1V4g7kp61sDZI8MQcqutY8H/vYqjm13GxiDZOKIHEKwEffglOYlJh9enHc2Hs3HusipkuPHN215Beftt4WZuR2iPCb7kN8uuCYUaWL4a40Fa2OdUSPi+0efUyYfQDjuoQobtxxcBf9MgvgxiGiI91GPW2d8v79bnN6ID3BLE5Ia01f9SUiLyxsxrgLdcDqdvzdgEiXM9YZt0MffQPRnCpPh3VMlQ05xyJzGh87KXG9DIGwIDAQAB";
			//MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyWaOjWjjsXoBiQfREc0BwLx844Wgg0Pm5ExCgEqsVuedBNPJlwomcag4v+/sjEfN9NuF0HMCvrA6GtbD55YgU8tQs2QdEIkkM6UkAFhH1V4g7kp61sDZI8MQcqutY8H/vYqjm13GxiDZOKIHEKwEffglOYlJh9enHc2Hs3HusipkuPHN215Beftt4WZuR2iPCb7kN8uuCYUaWL4a40Fa2OdUSPi+0efUyYfQDjuoQobtxxcBf9MgvgxiGiI91GPW2d8v79bnN6ID3BLE5Ia01f9SUiLyxsxrgLdcDqdvzdgEiXM9YZt0MffQPRnCpPh3VMlQ05xyJzGh87KXG9DIGwIDAQAB
	public CommonUtilities(Context ctx)
	{
		context = ctx;
		
	}
	public File takeInputStream(InputStream stream, String fileName) throws IOException
	{
		File tempFile = null;
	    try
	    {
	    	
	    		tempFile = File.createTempFile(fileName, ".mp3");
		        Log.e("convertedFilePath",":: "+tempFile.getAbsolutePath());
		        
		        FileOutputStream out = new FileOutputStream(tempFile);
	
		        byte buffer[] = new byte[16384];
		        int length = 0;
		        while ( (length = stream.read(buffer)) != -1 ) 
		        {
		          out.write(buffer,0, length);
		        }
	
		        out.close();
	
		        FileInputStream fis = new FileInputStream(tempFile);
		        fis.close();
		        
//	        }
	       
	    }catch(Exception e)
	    {
	    	e.printStackTrace();
	    }
	    
	    return tempFile;
	}
	public static int getCodeVersion(Context context )
	{
		int versionCode=9;
		 try {
	            PackageInfo pInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
	            versionCode = pInfo.versionCode;
	        } catch (PackageManager.NameNotFoundException e) {
	            e.printStackTrace();
	        }
		return versionCode;
	}
}
