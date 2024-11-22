package com.truesecrets.util;

import java.util.ArrayList;
import com.google.android.gms.maps.model.LatLng;

/**
 * @author Kis_8
 * Bean class for fetching Placemarks
 */
public class Placemark {
	 
	String title;
	String description;
	ArrayList<LatLng> coordinates;
	String address;
 
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public ArrayList<LatLng> getCoordinates() {
		return coordinates;
	}
	public void setCoordinates(ArrayList<LatLng> coordinates) {
		this.coordinates = coordinates;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}