package com.truesecrets.util;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.google.android.gms.maps.model.LatLng;

import android.util.Log;

@SuppressWarnings("unused")
public class NavigationSaxHandler extends DefaultHandler{ 
//	private static final String TAG = NavigationSaxHandler.class.getSimpleName();
 
	// =========================================================== 
	// Fields 
	// =========================================================== 
 
	private boolean in_kmltag = false; 
	private boolean in_placemarktag = false; 
	private boolean in_nametag = false;
	private boolean in_descriptiontag = false;
	private boolean in_geometrycollectiontag = false;
	private boolean in_linestringtag = false;
	private boolean in_pointtag = false;
	private boolean in_coordinatestag = false;
	private double latitude, longitude; 
	private ArrayList<LatLng> buffer;
	private String[] temp;
	private NavigationDataSet navigationDataSet = new NavigationDataSet();
 
	// =========================================================== 
	// Getter & Setter 
	// =========================================================== 
 
	public NavigationDataSet getParsedData() {
//		Log.e("buffer size ",":::"+buffer.size());
		navigationDataSet.getCurrentPlacemark().setCoordinates(buffer);
		return this.navigationDataSet; 
	} 
 
	// =========================================================== 
	// Methods 
	// =========================================================== 
	@Override 
	public void startDocument() throws SAXException { 
		this.navigationDataSet = new NavigationDataSet(); 
	} 
 
	@Override 
	public void endDocument() throws SAXException { 
		// Nothing to do
//		Log.e("end doc","end doc");
	} 
 
	/** Gets be called on opening tags like: 
	 * <tag> 
	 * Can provide attribute(s), when xml was like: 
	 * <tag attribute="attributeValue">*/ 
	@Override 
	public void startElement(String namespaceURI, String localName, 
			String qName, Attributes atts) throws SAXException { 
		if (localName.equals("kml")) { 
			this.in_kmltag = true;
		} else if (localName.equals("Placemark")) { 
			this.in_placemarktag = true; 
//			Log.d(TAG, "startElement localName[" + localName + "] qName[" + qName + "]");
			navigationDataSet.setCurrentPlacemark(new Placemark());
		} else if (localName.equals("name")) { 
			this.in_nametag = true;
		} else if (localName.equals("description")) { 
			this.in_descriptiontag = true;
		} else if (localName.equals("GeometryCollection")) { 
			this.in_geometrycollectiontag = true;
		} else if (localName.equals("LineString")) { 
			this.in_linestringtag = true;              
		} else if (localName.equals("point")) { 
			this.in_pointtag = true;          
		} else if (localName.equals("coordinates")) {
			buffer = new ArrayList<LatLng>();
			this.in_coordinatestag = true;                        
		}
	} 
 
	/** Gets be called on closing tags like: 
	 * </tag> */
	@Override 
	public void endElement(String namespaceURI, String localName, String qName) 
			throws SAXException { 
		if (localName.equals("kml")) {
			this.in_kmltag = false; 
		} else if (localName.equals("Placemark")) { 
			this.in_placemarktag = false;
 
//			Log.d(TAG, "endElement localName[" + localName + "] qName[" + qName + "] Route[" + navigationDataSet.getCurrentPlacemark().getTitle() + "]");
			if ("Route".equals(navigationDataSet.getCurrentPlacemark().getTitle())) 
				navigationDataSet.setRoutePlacemark(navigationDataSet.getCurrentPlacemark());
			else navigationDataSet.addCurrentPlacemark();
 
		} else if (localName.equals("name")) { 
			this.in_nametag = false;           
		} else if (localName.equals("description")) { 
			this.in_descriptiontag = false;
		} else if (localName.equals("GeometryCollection")) { 
			this.in_geometrycollectiontag = false;
		} else if (localName.equals("LineString")) { 
			this.in_linestringtag = false;              
		} else if (localName.equals("point")) { 
			this.in_pointtag = false;          
		} else if (localName.equals("coordinates")) { 
			this.in_coordinatestag = false;
			navigationDataSet.getCurrentPlacemark().setCoordinates(buffer);
		}
	} 
 
	/** Gets be called on the following structure: 
	 * <tag>characters</tag> */ 
	@Override 
	public void characters(char ch[], int start, int length) { 
		if(this.in_nametag){ 
			if (navigationDataSet.getCurrentPlacemark()==null) navigationDataSet.setCurrentPlacemark(new Placemark());
			navigationDataSet.getCurrentPlacemark().setTitle(new String(ch, start, length));            
		} else if(this.in_descriptiontag){ 
			if (navigationDataSet.getCurrentPlacemark()==null) navigationDataSet.setCurrentPlacemark(new Placemark());
			navigationDataSet.getCurrentPlacemark().setDescription(new String(ch, start, length));          
		} else if(this.in_coordinatestag){        
			if (navigationDataSet.getCurrentPlacemark()==null) navigationDataSet.setCurrentPlacemark(new Placemark());
//			navigationDataSet.getCurrentPlacemark().setCoordinates(new String(ch, start, length));
			if(length>1){
				String str = new String(ch, start, length);
//				Log.e("strrrrrrrrrrrrrrrrrrr",str+"............."+length);
				
				temp = new String(ch, start, length).trim().split(",");
//				Log.e("split","success");
				if(temp.length>2){
//					Log.e("title",navigationDataSet.getCurrentPlacemark().getTitle());
					LatLng coordinates = new LatLng(Double.valueOf(temp[1].trim()), Double.valueOf(temp[0].trim()));
					buffer.add(coordinates);
				}
			}
			
//			Log.e("appending", "aaaa::: "+new String(ch).trim() +",,,,,,,,,,"+start+",,,,,,,,,,,"+length);
//			buffer.append(ch, start, length);
		}
	}
}