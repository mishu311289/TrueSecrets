package com.truesecrets.strange.tour.melbourne;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ExecutionException;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.graphics.Color;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.android.vending.expansion.zipfile.APKExpansionSupport;
import com.android.vending.expansion.zipfile.ZipResourceFile;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PolylineOptions;
import com.inapppurchase.util.IabHelper;
import com.inapppurchase.util.IabResult;
import com.inapppurchase.util.Purchase;

import com.truesecrets.strange.tour.melbourne.R;
import com.truesecrets.util.CommonUtilities;
import com.truesecrets.util.ConnectionDetector;
import com.truesecrets.util.CouponChecker;
import com.truesecrets.util.NavigationDataSet;
import com.truesecrets.util.Placemark;

@SuppressLint({ "ValidFragment", "NewApi" })
public class SecretFragment extends Fragment implements AnimationListener {

	static Context ctx;
	int flag = 0;
	TextView secretCounter, secretInsights, secretTitle, maptxtstring, desc_a,
			desc_b, secretCaption, readyToGo, secretReady, txtPlay, txtCheckIn,
			txtShare, maptxt, looktxt;
	LinearLayout mapContainer;
	RelativeLayout getBackground, getBonus, thanklayout;
	TextView txtBackground, txtBonus;
	ImageView backgroundAudio, bonusAudio, mapImage, thankAudio;
	ImageButton play;
	int position;
	LinearLayout maplayout;
	// Animation
	Animation animSlide_down, animSlideUp;
	static IabHelper mHelper;
	boolean isMapVisible;
	static SharedPreferences pref;
	File backgroundFile, bonusFile, masterFile, thanksFile;
	public static boolean bgSoundInitialized = false,
			bonusSoundInitialized = false, masterSoundInitialized = false,
			thanksSoundInitialized = false;
	private String imei, mobile, url;

	ConnectionDetector detector;
	ImageButton share, facebook, foursquare, googlePlus;

	AssetManager assetManager;
	private GoogleMap map;
	
	//private BitmapDescriptor secret1Des, secret2Des,secret3Des,secret4Des,secret5Des,secret6Des,secret7Des;
	
	CommonUtilities commonUtilities;

	private SharedPreferences prefernces;
	private final String TAG = "com.truesecrets.purchase.inappbilling";

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}
	public SecretFragment()
	{}
	
	public SecretFragment(Context context, int pos) {
		ctx = context;
		position = pos;
		commonUtilities = new CommonUtilities(context);
		detector = new ConnectionDetector(ctx);
		pref = ctx.getSharedPreferences("mypref", Context.MODE_APPEND);
		prefernces = context.getSharedPreferences("truesecretPreferences",context.MODE_PRIVATE);

		
		/*secret1Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__01);

		secret2Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__02);
		
		secret3Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__03);
		secret4Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__04);
		secret5Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__05);
		secret6Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__06);
		secret7Des=BitmapDescriptorFactory.fromResource(R.drawable.secret__07);*/

mHelper = new IabHelper(ctx, CommonUtilities.base64EncodedPublicKey);

		mHelper.startSetup(new IabHelper.OnIabSetupFinishedListener() {
			public void onIabSetupFinished(IabResult result) {
				if (!result.isSuccess()) {
					Log.d(TAG, "In-app Billing setup failed: " + result);
				} else {
					Log.d(TAG, "In-app Billing is set up OK");
				}
			}
		});

		mHelper.enableDebugLogging(true, TAG);

	}
	

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view = inflater.inflate(R.layout.secret_layout, container, false);

		isMapVisible = true;
		// inVisible=true;

		maplayout = (LinearLayout) view.findViewById(R.id.mapContainer);

		secretCounter = (TextView) view.findViewById(R.id.secretCounter);
		secretTitle = (TextView) view.findViewById(R.id.secretTitle);
		desc_a = (TextView) view.findViewById(R.id.secretDesc_a);
		maptxtstring = (TextView) view.findViewById(R.id.maptxtstring);
		secretInsights = (TextView) view.findViewById(R.id.secretInsights);

		share = (ImageButton) view.findViewById(R.id.btnShare);

		facebook = (ImageButton) view.findViewById(R.id.btnFb);
		foursquare = (ImageButton) view.findViewById(R.id.btnFousquare);
		googlePlus = (ImageButton) view.findViewById(R.id.btnGooglePlus);

		desc_b = (TextView) view.findViewById(R.id.secretDesc_b);
		secretCaption = (TextView) view.findViewById(R.id.secretCaption);

		getBackground = (RelativeLayout) view.findViewById(R.id.getBackground);
		getBackground.setTag("BgAudio" + position);
		MainActivity.views.add(getBackground);

		getBonus = (RelativeLayout) view.findViewById(R.id.postBackground);
		getBonus.setTag("BonusAudio" + position);
		MainActivity.views.add(getBonus);

		play = (ImageButton) view.findViewById(R.id.play);
		play.setTag("Play" + position);
		MainActivity.views.add(play);

		thanklayout = (RelativeLayout) view.findViewById(R.id.thanklayout);
		thanklayout.setTag("thanksAudio" + position);
		MainActivity.views.add(thanklayout);

		readyToGo = (TextView) view.findViewById(R.id.readyToGo);
		/*
		 * secretReady = (TextView)view.findViewById(R.id.secretReady); txtPlay
		 * = (TextView)view.findViewById(R.id.txtPlay);
		 */
		maptxt = (TextView) view.findViewById(R.id.maptxt_a);
		looktxt = (TextView) view.findViewById(R.id.maptxt_b);

		txtCheckIn = (TextView) view.findViewById(R.id.txtCheckIn);
		txtShare = (TextView) view.findViewById(R.id.txtShare);
		txtBackground = (TextView) view.findViewById(R.id.txtBackground);
		txtBonus = (TextView) view.findViewById(R.id.txtBonus);

		backgroundAudio = (ImageView) view.findViewById(R.id.playBackground);
		mapImage = (ImageView) view.findViewById(R.id.mapimage);
		bonusAudio = (ImageView) view.findViewById(R.id.playBonus);
		thankAudio = (ImageView) view.findViewById(R.id.playthanks);

		// load the animation
		animSlide_down = AnimationUtils.loadAnimation(ctx, R.anim.slide_down);
		animSlideUp = AnimationUtils.loadAnimation(ctx, R.anim.slide_up);

		// set animation listener
		animSlide_down.setAnimationListener(this);
		animSlideUp.setAnimationListener(this);

		secretCounter.setText("Secret #" + (position));

		secretCounter.setTypeface(MainActivity.headingTypeface);
		secretTitle.setTypeface(MainActivity.headingTypeface);
		secretCaption.setTypeface(MainActivity.droidsansTypeface);
		secretInsights.setTypeface(MainActivity.droidsansTypeface);

		desc_a.setTypeface(MainActivity.droidsansTypeface);
		desc_b.setTypeface(MainActivity.droidsansTypeface);
		maptxtstring.setTypeface(MainActivity.droidsansTypeface);

		txtBackground.setTypeface(MainActivity.boldTypeface);
		txtBonus.setTypeface(MainActivity.boldTypeface);

		readyToGo.setTypeface(MainActivity.droidsansTypeface);
		/*
		 * secretReady.setTypeface(MainActivity.headingTypeface);
		 * txtPlay.setTypeface(MainActivity.headingTypeface);
		 */
		maptxt.setTypeface(MainActivity.droidsansTypeface);
		looktxt.setTypeface(MainActivity.droidsansTypeface);
		txtCheckIn.setTypeface(MainActivity.boldTypeface);
		txtShare.setTypeface(MainActivity.boldTypeface);

		facebook.setOnClickListener(invokeUrl);
		foursquare.setOnClickListener(invokeUrl);
		googlePlus.setOnClickListener(invokeUrl);

		mapContainer = (LinearLayout) view.findViewById(R.id.mapContainer);

		try{
		if (position == 1) {
			secretTitle.setText(R.string.secret1_title);
			desc_a.setText(R.string.secret_1a);
			desc_b.setText(R.string.secret_1b);
			maptxtstring.setText(R.string.maptxtstring_1a);
			mapImage.setBackgroundResource(R.drawable.secret1_opt4);

			View mapFragment = inflater.inflate(R.layout.secret1_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret1);
			map = fm.getMap();
		} else if (position == 2) {
			secretTitle.setText(R.string.secret2_title);
			desc_a.setText(R.string.secret_2a);
			desc_b.setText(R.string.secret_2b);
			maptxtstring.setText(R.string.maptxtstring_2a);
			mapImage.setBackgroundResource(R.drawable.secret2_opt3);

			View mapFragment = inflater.inflate(R.layout.secret2_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret2);
			map = fm.getMap();
		} else if (position == 3) {
			secretTitle.setText(R.string.secret3_title);
			desc_a.setText(R.string.secret_3a);
			desc_b.setText(R.string.secret_3b);
			maptxtstring.setText(R.string.maptxtstring_3a);
			mapImage.setBackgroundResource(R.drawable.secret3_opt2);

			View mapFragment = inflater.inflate(R.layout.secret3_mapfragment,null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret3);
			map = fm.getMap();
		} else if (position == 4) {
			secretTitle.setText(R.string.secret4_title);
			desc_a.setText(R.string.secret_4a);
			desc_b.setText(R.string.secret_4b);
			maptxtstring.setText(R.string.maptxtstring_4a);
			mapImage.setBackgroundResource(R.drawable.secret4_opt1);

			View mapFragment = inflater.inflate(R.layout.secret4_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret4);
			map = fm.getMap();
		} else if (position == 5) {
			secretTitle.setText(R.string.secret5_title);
			desc_a.setText(R.string.secret_5a);
			desc_b.setText(R.string.secret_5b);
			maptxtstring.setText(R.string.maptxtstring_5a);
			mapImage.setBackgroundResource(R.drawable.secret5_opt1);

			View mapFragment = inflater.inflate(R.layout.secret5_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret5);
			map = fm.getMap();
		} else if (position == 6) {
			secretTitle.setText(R.string.secret6_title);
			desc_a.setText(R.string.secret_6a);
			desc_b.setText(R.string.secret_6b);
			maptxtstring.setText(R.string.maptxtstring_6a);
			mapImage.setBackgroundResource(R.drawable.secret6);

			View mapFragment = inflater.inflate(R.layout.secret6_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret6);
			map = fm.getMap();
		} else if (position == 7) {
			thanklayout.setVisibility(View.VISIBLE);
			secretTitle.setText(R.string.secret7_title);
			desc_a.setText(R.string.secret_7a);
			desc_b.setText(R.string.secret_7b);
			maptxtstring.setText(R.string.maptxtstring_7a);
			mapImage.setBackgroundResource(R.drawable.secret7_opt2);

			View mapFragment = inflater.inflate(R.layout.secret7_mapfragment,
					null);
			mapContainer.addView(mapFragment);

			SupportMapFragment fm = (SupportMapFragment) ((FragmentActivity) ctx)
					.getSupportFragmentManager().findFragmentById(
							R.id.map_secret7);
			map = fm.getMap();
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}

		try {
			map.setMyLocationEnabled(true);
		} catch (Exception e) {
			e.printStackTrace();
		}

		share.setOnClickListener(new View.OnClickListener() {
			@SuppressLint("NewApi")
			@Override
			public void onClick(View v) {
				/*
				 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
				 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
				 */
				if (Build.VERSION.SDK_INT >= 15) {
					MainActivity.flag = 0;
					MainActivity.secret.callOnClick();

					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();
				} else {
					MainActivity.flag = 0;
					MainActivity.secret.performClick();

					MainActivity.flag = 1;
					MainActivity.secret.performClick();
				}

				Intent shareInt = new Intent(android.content.Intent.ACTION_SEND);
				shareInt.setType("text/plain");
				shareInt.putExtra(android.content.Intent.EXTRA_SUBJECT,
						"Shareable data");
				shareInt.putExtra(android.content.Intent.EXTRA_TEXT,
						"http://truesecrets.com.au");
				ctx.startActivity(Intent.createChooser(shareInt, "Share via"));
			}
		});

		looktxt.setOnClickListener(new View.OnClickListener() {
			@SuppressLint("NewApi")
			@SuppressWarnings({ "static-access", "static-access" })
			@Override
			public void onClick(View v) {
				// if(isMapVisible){
				maplayout.startAnimation(animSlideUp);
				maptxtstring.startAnimation(animSlideUp);
				maplayout.setVisibility(v.GONE);
				maptxtstring.setVisibility(v.GONE);
				mapImage.setVisibility(v.VISIBLE);
				mapImage.startAnimation(animSlide_down);
				isMapVisible = false;
				// }

				/*
				 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
				 * 
				 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
				 */
				if (Build.VERSION.SDK_INT >= 15) {
					MainActivity.flag = 0;
					MainActivity.secret.callOnClick();

					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();
				} else {
					MainActivity.flag = 0;
					MainActivity.secret.performClick();

					MainActivity.flag = 1;
					MainActivity.secret.performClick();
				}
			}
		});

		maptxt.setOnClickListener(new View.OnClickListener() {
			@SuppressLint("NewApi")
			@Override
			public void onClick(View v) {
				if (!isMapVisible) {
					maplayout.setVisibility(v.VISIBLE);
					maptxtstring.setVisibility(v.VISIBLE);
					maplayout.startAnimation(animSlide_down);
					maptxtstring.startAnimation(animSlide_down);
					mapImage.startAnimation(animSlideUp);
					mapImage.setVisibility(v.GONE);
					isMapVisible = true;
				} else {
					maplayout.startAnimation(animSlideUp);
					maptxtstring.startAnimation(animSlideUp);
					maplayout.setVisibility(v.GONE);
					maptxtstring.setVisibility(v.GONE);
					mapImage.setVisibility(v.VISIBLE);
					mapImage.startAnimation(animSlide_down);
					isMapVisible = false;
					// inVisible=true;
				}

				/*
				 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
				 * 
				 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
				 */
				if (Build.VERSION.SDK_INT >= 15) {
					MainActivity.flag = 0;
					MainActivity.secret.callOnClick();

					MainActivity.flag = 1;
					MainActivity.secret.callOnClick();
				} else {
					MainActivity.flag = 0;
					MainActivity.secret.performClick();

					MainActivity.flag = 1;
					MainActivity.secret.performClick();
				}
			}
		});

		play.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				int pos=0;
				if(pref.getBoolean("isPurchased", false)==false)
				{
					pos=3;
				}
				else
				{
					pos=MainActivity.viewPager.getCurrentItem();
					}
				if (pos == position) {
					if (MainActivity.masterPlayer.isPlaying()) {
						play.setImageResource(R.drawable.play_main);
						System.err.println("playyyyyyyyyyy");
					} else {
						play.setImageResource(R.drawable.pause_main);
						System.err.println("pauseeeeeeeeee");

						/*Intent i = new Intent(getActivity(),
								com.truesecrets.purchase.StartUpActivity.class);

						// i.setClassName("com.truesecrets.tour.melbourne.SecretFragment.this","com.truesecrets.purchase.StartUpActivity.class");
						startActivity(i);*/
					}

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * 
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}

					if (position == 1) {
						//showPaymentDialog();
						getFile(1, "mace_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.mace_master"),
						// 1);
					} else if (position == 2) {
						getFile(1, "dim_sim_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.dim_sim_master"),
						// 1);
					} else if (position == 3) {
						getFile(1, "police_strike_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.police_strike_master"), 1);
					} else if (position == 4) {
						getFile(1, "assassin_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.assassin_master"), 1);
					} else if (position == 5) {
						getFile(1, "gargoyles_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.gargoyles_master"), 1);
					} else if (position == 6) {
						getFile(1, "one_tel_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.one_tel_master"),
						// 1);
					} else if (position == 7) {
						getFile(1, "police_raid_master");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.police_raid_master"), 1);
					}
				} else {
					play.setImageResource(R.drawable.play_main);

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * 
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}
				}

			}
		});

		getBackground.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				int pos=0;
				if(pref.getBoolean("isPurchased", false)==false)
				{
					pos=3;
				}
				else
				{
					pos=MainActivity.viewPager.getCurrentItem();
					}
				
				
				if (pos== position) {
					if (MainActivity.backgroundPlayer.isPlaying()) {
						backgroundAudio.setImageResource(R.drawable.play);
					} else
						backgroundAudio.setImageResource(R.drawable.pause);

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * 
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}

					if (position == 1) {
						getFile(0, "secret1_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret1_background"), 0);
					} else if (position == 2) {
						getFile(0, "secret2_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret2_background"), 0);
					} else if (position == 3) {
						getFile(0, "secret3_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret3_background"), 0);
					} else if (position == 4) {
						getFile(0, "secret4_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret4_background"), 0);
					} else if (position == 5) {
						getFile(0, "secret5_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret5_background"), 0);
					} else if (position == 6) {
						getFile(0, "secret6_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret6_background"), 0);
					} else if (position == 7) {
						getFile(0, "secret7_background");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret7_background"), 0);
					}
				} else {
					backgroundAudio.setImageResource(R.drawable.play);

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * 
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}
				}
			}
		});

		getBonus.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				int pos=0;
				if(pref.getBoolean("isPurchased", false)==false)
				{
					pos=3;
				}
				else
				{
					pos=MainActivity.viewPager.getCurrentItem();
					}
				if (pos == position) {
					if (MainActivity.bonusPlayer.isPlaying()) {
						bonusAudio.setImageResource(R.drawable.play);
					} else
						bonusAudio.setImageResource(R.drawable.pause);

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * 
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}

					if (position == 1) {
						getFile(2, "secret1_bonus_material");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" +
						// "R.raw.secret1_bonus_material"), 2);
					} else if (position == 2) {
						getFile(2, "secret2_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret2_bonus"),
						// 2);
					} else if (position == 3) {
						getFile(2, "secret3_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret3_bonus"),
						// 2);
					} else if (position == 4) {
						getFile(2, "secret4_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret4_bonus"),
						// 2);
					} else if (position == 5) {
						getFile(2, "secret5_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret5_bonus"),
						// 2);
					} else if (position == 6) {
						getFile(2, "secret6_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret6_bonus"),
						// 2);
					} else if (position == 7) {
						getFile(2, "secret7_bonus");
						// playMusic(Uri.parse("android.resource://" +
						// ctx.getPackageName() + "/" + "R.raw.secret7_bonus"),
						// 2);
					}
				} else {
					bonusAudio.setImageResource(R.drawable.play);
				}
			}
		});

		thanklayout.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (MainActivity.viewPager.getCurrentItem() == position) {
					if (MainActivity.thanksPlayer.isPlaying()) {
						thankAudio.setImageResource(R.drawable.play);
					} else
						thankAudio.setImageResource(R.drawable.pause);

					/*
					 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
					 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
					 */
					if (Build.VERSION.SDK_INT >= 15) {
						MainActivity.flag = 0;
						MainActivity.secret.callOnClick();

						MainActivity.flag = 1;
						MainActivity.secret.callOnClick();
					} else {
						MainActivity.flag = 0;
						MainActivity.secret.performClick();

						MainActivity.flag = 1;
						MainActivity.secret.performClick();
					}

					/*
					 * if(position == 1){
					 * playMusic(R.raw.secret1_bonus_material, 2); }else
					 * if(position == 2){ playMusic(R.raw.secret2_bonus, 2);
					 * }else if(position == 3){ playMusic(R.raw.secret3_bonus,
					 * 2); }else if(position == 4){
					 * playMusic(R.raw.secret4_bonus, 2); }else if(position ==
					 * 5){ playMusic(R.raw.secret5_bonus, 2); }else if(position
					 * == 6){ playMusic(R.raw.secret6_bonus, 2); }else
					 * if(position == 7){
					 */
					getFile(3, "thanks_track");
					// playMusic(Uri.parse("android.resource://" +
					// ctx.getPackageName() + "/" + "R.raw.thanks_track"), 3);
					// }
				} else {
					thankAudio.setImageResource(R.drawable.play);
				}
			}
		});

		/*
		 * MainActivity.thanksPlayer.setOnCompletionListener(new
		 * OnCompletionListener() {
		 * 
		 * public void onCompletion(MediaPlayer mp) { mp.stop();
		 * Log.i("Completion Listener","Song Complete"); //Toast.makeText(ctx,
		 * " welcome Media Completed", Toast.LENGTH_SHORT).show();
		 * Log.e("MainActivity", "welcome Media Completed");
		 * MainActivity.thanksPlayer.stop();
		 * thankAudio.setImageResource(R.id.play);
		 * 
		 * } });
		 */

		drawPath(MainActivity.dataset, map);

		TelephonyManager mngr = (TelephonyManager) ctx
				.getSystemService(ctx.TELEPHONY_SERVICE);
		imei = mngr.getDeviceId();
		mobile = mngr.getLine1Number();
		Resources res = ctx.getResources();
		url = res.getString(R.string.app_url);

		return view;
	}

	public void getFile(int trigger, String fileName) {
		int versionCode=10;
		try{
				versionCode=CommonUtilities.getCodeVersion(ctx);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		try {
			Log.e("verionCode", ""+versionCode);
			ZipResourceFile expansionFile = APKExpansionSupport
					.getAPKExpansionZipFile(ctx, versionCode, 0);

			InputStream fileStream = expansionFile
					.getInputStream(ctx.getResources().getString(R.string.expansionFilesPrefix)+"/"
							+ fileName + ".mp3");

			if (prefernces.getString(fileName, "").equals("")) {
				if (trigger == 0)
					initializeFile(fileStream, fileName, trigger);
				else if (trigger == 2)
					initializeFile(fileStream, fileName, trigger);
				else if (trigger == 1)
					initializeFile(fileStream, fileName, trigger);
				else if (trigger == 3)
					initializeFile(fileStream, fileName, trigger);
			} else {

				if (trigger == 0) {

					if(fileName.equalsIgnoreCase("secret3_background"))
					{
						playMusic(Uri.fromFile(backgroundFile), trigger);
							}
					else
					{
					if (pref.getBoolean("isPurchased", false)) {
						playMusic(Uri.fromFile(backgroundFile), trigger);
					} else {
						MainActivity.showPaymentDialog();
						}
					}
				} else if (trigger == 1) {
					if(fileName.equalsIgnoreCase("police_strike_master"))
					{
						playMusic(Uri.fromFile(masterFile), trigger);
						}
					else
					{
						if (pref.getBoolean("isPurchased", false)) {
						
							playMusic(Uri.fromFile(masterFile), trigger);
						} else {
							MainActivity.showPaymentDialog();
					}
					}
				} else if (trigger == 2) {
					if(fileName.equalsIgnoreCase("secret3_bonus"))
					{
						playMusic(Uri.fromFile(bonusFile), trigger);
						}
					else
					{
					
						if (pref.getBoolean("isPurchased", false)) {
							playMusic(Uri.fromFile(bonusFile), trigger);
						} else {
							MainActivity.showPaymentDialog();
						}
					}
				} else if (trigger == 3)
					
					if (pref.getBoolean("isPurchased", false)) {
						playMusic(Uri.fromFile(thanksFile), trigger);
					} else {
						MainActivity.showPaymentDialog();
					}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void initializeFile(InputStream fileStream, String fileName,
			int trigger) {
		try {
			if (trigger == 0) {
				backgroundFile = commonUtilities.takeInputStream(fileStream,
						fileName);

				Editor editor = prefernces.edit();
				editor.putString(fileName, backgroundFile.getAbsolutePath());
				editor.commit();
				if(fileName.equalsIgnoreCase("secret3_background"))
				{
					playMusic(Uri.fromFile(backgroundFile), trigger);
					}
				else
				{
				
					if (pref.getBoolean("isPurchased", false)) {
	
						playMusic(Uri.fromFile(backgroundFile), trigger);
					} else {
						MainActivity.showPaymentDialog();
					}
				}
			} else if (trigger == 1) {
				masterFile = commonUtilities.takeInputStream(fileStream,fileName);

				Editor editor = prefernces.edit();
				editor.putString(fileName, masterFile.getAbsolutePath());
				editor.commit();
				if(fileName.equalsIgnoreCase("police_strike_master"))
				{
					playMusic(Uri.fromFile(masterFile), trigger);
						}
				else
				{
				if (pref.getBoolean("isPurchased", false)) {

					playMusic(Uri.fromFile(masterFile), trigger);
				} else {
					MainActivity.showPaymentDialog();
				}
				}
			} else if (trigger == 2) {
				bonusFile = commonUtilities.takeInputStream(fileStream,fileName);

				Editor editor = prefernces.edit();
				editor.putString(fileName, bonusFile.getAbsolutePath());
				editor.commit();
				//secret3_bonus
				if(fileName.equalsIgnoreCase("secret3_bonus"))
				{
					playMusic(Uri.fromFile(bonusFile), trigger);	
				}
				else
				{
					if (pref.getBoolean("isPurchased", false)) {
	
					playMusic(Uri.fromFile(bonusFile), trigger);
					} else {
						MainActivity.showPaymentDialog();
					}
				}
			} else if (trigger == 3) {
				thanksFile = commonUtilities.takeInputStream(fileStream,fileName);

				Editor editor = prefernces.edit();
				editor.putString(fileName, thanksFile.getAbsolutePath());
				editor.commit();
				
				
				if (pref.getBoolean("isPurchased", false)) {

					playMusic(Uri.fromFile(thanksFile), trigger);
				} else {
					MainActivity.showPaymentDialog();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//@SuppressWarnings("deprecation")
	/* public  void showPaymentDialog()
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
/*	public  void couponAlertbox()   //coupon alert box with three button and one edit text
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
		
	dialog1.show();
	
//	builder.show();	final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);
	}*/
/*		AlertDialog dialog = new AlertDialog.Builder(ctx).create();
		dialog.setTitle("To experience the full True Secrets tour you need to purchase access to the audio files.");
		//dialog.setMessage("you have purchase the song");
		dialog.setButton("I have a coupon/ voucher", new DialogInterface.OnClickListener() {
			
			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub
				dialog.dismiss();
				if(detector.isConnectingToInternet())
				{
					HomeFragment.couponAlertbox();

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
		}) ;
		dialog.setButton2("I do not have a coupon/ voucher", new DialogInterface.OnClickListener() {
			
			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub
				mHelper.launchPurchaseFlow((Activity)ctx, CommonUtilities.ITEM_SKU, 10001, mPurchaseFinishedListener, "mypurchasetoken");
				dialog.dismiss();
			}
		}) ;	
		dialog.show();*/
     //  }
	@SuppressWarnings("deprecation")
	/*	//public void showPaymentDialog() {
		AlertDialog dialog = new AlertDialog.Builder(ctx).create();
		dialog.setTitle("True Secrets");
		dialog.setMessage("You would need to purchase audio files. Purchase now?");
		dialog.setButton("Continue", new DialogInterface.OnClickListener() {

			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub

				dialog.dismiss();

				final AlertDialog.Builder builder = new AlertDialog.Builder(ctx);

				LayoutInflater inflator = ((Activity) ctx).getLayoutInflater();

				View couponView = inflator.inflate(R.layout.coupon, null);
				builder.setView(couponView);

				final AlertDialog dialog1 = builder.create();

				WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
				lp.width = LayoutParams.MATCH_PARENT;
				lp.height = LayoutParams.MATCH_PARENT;
				dialog1.getWindow().setAttributes(lp);

				final EditText editCoupon = (EditText) couponView
						.findViewById(R.id.coupon);
				Button btnCheck = (Button) couponView.findViewById(R.id.check);
				Button btnCancel = (Button) couponView
						.findViewById(R.id.cancel);
				Button btnContinueWithoutCoupon = (Button) couponView
						.findViewById(R.id.continueWithoutCoupon);

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
						// if(!str.equals(""))
						// {
						Log.e("map", "");
						CouponChecker couponCheck = new CouponChecker(ctx);

						HashMap<String, String> map = couponCheck.checkCoupn(
								"ts_coupongetter", "6X&z7ub^bzqiPJuLcu", imei,
								mobile, "action", "checkcoupon", url);

						Log.e("map", map.toString());

						mHelper.launchPurchaseFlow((Activity) ctx,
								CommonUtilities.ITEM_SKU, 10001,
								mPurchaseFinishedListener, "mypurchasetoken");
						Log.e("map", map.toString());
						
						 * } else {
						 
						// }
					}
				});

				dialog1.show();
				// builder.show();
			}
		});
		dialog.setButton2("Cancel", new DialogInterface.OnClickListener() {

			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub
				dialog.dismiss();
			}
		});
		dialog.show();
		
		 * AlertDialog dialog = new AlertDialog.Builder(ctx).create();
		 * dialog.setTitle("Purchase");
		 * dialog.setMessage("you have purchase the song");
		 * dialog.setButton("Yes", new DialogInterface.OnClickListener() {
		 * 
		 * @Override public void onClick(DialogInterface dialog, int which) { //
		 * TODO Auto-generated method stub
		 * 
		 * dialog.dismiss();
		 * 
		 * if(detector.isConnectingToInternet()) {
		 * 
		 * mHelper.launchPurchaseFlow((Activity)ctx, CommonUtilities.ITEM_SKU,
		 * 10001, mPurchaseFinishedListener, "mypurchasetoken"); } else {
		 * AlertDialog.Builder builder=new AlertDialog.Builder(ctx);
		 * builder.setTitle("Notification");
		 * builder.setMessage("Internet connection is not available");
		 * builder.setNegativeButton("Ok", null); builder.create().show(); }
		 * 
		 * 
		 * } }) ; dialog.setButton2("No", new DialogInterface.OnClickListener()
		 * {
		 * 
		 * @Override public void onClick(DialogInterface dialog, int which) { //
		 * TODO Auto-generated method stub dialog.dismiss(); } }) ;
		 * dialog.show();
		 

	}*/

	public void drawPath(NavigationDataSet dataSet, GoogleMap map) {
		int counter = 0;
		freeMemory();
		try {
			for (int i = 0; i < dataSet.getPlacemarks().size(); i++) {
				Placemark placemark = dataSet.getPlacemarks().get(i);

				if (placemark.getCoordinates().size() > 1) {
					ArrayList<LatLng> locList = dataSet.getCurrentPlacemark()
							.getCoordinates();
					LatLng loc = dataSet.getCurrentPlacemark().getCoordinates()
							.get(0);

					PolylineOptions rectOptions = new PolylineOptions();
					rectOptions.width(5f);

					for (int j = 0; j < locList.size(); j++) {
						rectOptions.add(locList.get(j));
					}

					rectOptions.color(Color.parseColor("#8989ff"));
					map.addPolyline(rectOptions);
					map.moveCamera(CameraUpdateFactory.newLatLngZoom(loc, 17));
					map.animateCamera(CameraUpdateFactory.zoomTo(14), 2000,
							null);
				} else {
					counter++;
					Log.e("counter ", "value :: " + counter);
					LatLng coordinates = new LatLng(placemark.getCoordinates()
							.get(0).latitude,
							placemark.getCoordinates().get(0).longitude);
					MarkerOptions marker = new MarkerOptions().position(
							coordinates).title(placemark.getTitle());
				/*	if (counter == 1) {
						marker.icon(secret1Des);
					} 
					else if (counter == 2) {
						marker.icon(secret2Des);
					} 
					else if (counter == 3) {
						marker.icon(secret3Des);
					} 
					else if (counter == 4) {
						marker.icon(secret4Des);
					} 
					else if (counter == 5) {
						marker.icon(secret5Des);
					} 
					else if (counter == 6) {
						marker.icon(secret6Des);
					} 
					else if (counter == 7) {
						marker.icon(secret7Des);
					}*/
					
					if (counter == 1) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__01));
					} else if (counter == 2) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__02));
					} else if (counter == 3) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__03));
					} else if (counter == 4) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__04));
					} else if (counter == 5) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__05));
					} else if (counter == 6) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__06));
					} else if (counter == 7) {
						marker.icon(BitmapDescriptorFactory
								.fromResource(R.drawable.secret__07));
					}
					map.addMarker(marker);
				}
				map.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(
						MainActivity.dataset.getPlacemarks().get(position - 1)
								.getCoordinates().get(0).latitude,
						MainActivity.dataset.getPlacemarks().get(position - 1)
								.getCoordinates().get(0).longitude), 19));
				map.animateCamera(CameraUpdateFactory.zoomTo(16), 2000, null);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void playMusic(Uri audioFileId, int trigger) {
		try {
			if (trigger == 0) {
				if (!bgSoundInitialized) {
					bgSoundInitialized = true;
					if (MainActivity.backgroundPlayer == null) {
						MainActivity.backgroundPlayer = new MediaPlayer();

					}

					MainActivity.backgroundPlayer = MediaPlayer.create(ctx,
							audioFileId);
					MainActivity.backgroundPlayer
							.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
								@Override
								public void onCompletion(MediaPlayer mp) {
									backgroundAudio
											.setImageResource(R.drawable.play);

									/*
									 * MainActivity.flag = 0;
									 * MainActivity.secret.callOnClick();
									 * 
									 * MainActivity.flag = 1;
									 * MainActivity.secret.callOnClick();
									 */
									if (Build.VERSION.SDK_INT >= 15) {
										MainActivity.flag = 0;
										MainActivity.secret.callOnClick();

										MainActivity.flag = 1;
										MainActivity.secret.callOnClick();
									} else {
										MainActivity.flag = 0;
										MainActivity.secret.performClick();

										MainActivity.flag = 1;
										MainActivity.secret.performClick();
									}

								}
							});
				}
				if (MainActivity.masterPlayer.isPlaying()) {
					MainActivity.masterPlayer.pause();
					play.setImageResource(R.drawable.play_main);
				}

				if (MainActivity.bonusPlayer.isPlaying()) {
					MainActivity.bonusPlayer.pause();
					bonusAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.welcomePlayer.isPlaying()) {
					MainActivity.welcomePlayer.pause();
					// backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.thanksPlayer.isPlaying()) {
					MainActivity.thanksPlayer.pause();
					thankAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.backgroundPlayer.isPlaying()) {
					MainActivity.backgroundPlayer.pause();
				} else {
					MainActivity.backgroundPlayer.start();
				}

			} else if (trigger == 1) {
				if (!masterSoundInitialized) {
					masterSoundInitialized = true;

					if (MainActivity.masterPlayer == null) {
						MainActivity.masterPlayer = new MediaPlayer();

					}
					MainActivity.masterPlayer = MediaPlayer.create(ctx,
							audioFileId);
					MainActivity.masterPlayer
							.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
								@Override
								public void onCompletion(MediaPlayer mp) {
									play.setImageResource(R.drawable.play_main);

									/*
									 * MainActivity.flag = 0;
									 * MainActivity.secret.callOnClick();
									 * 
									 * MainActivity.flag = 1;
									 * MainActivity.secret.callOnClick();
									 */
									if (Build.VERSION.SDK_INT >= 15) {
										MainActivity.flag = 0;
										MainActivity.secret.callOnClick();

										MainActivity.flag = 1;
										MainActivity.secret.callOnClick();
									} else {
										MainActivity.flag = 0;
										MainActivity.secret.performClick();

										MainActivity.flag = 1;
										MainActivity.secret.performClick();
									}

								}
							});
				}

				if (MainActivity.backgroundPlayer.isPlaying()) {
					MainActivity.backgroundPlayer.pause();
					backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.bonusPlayer.isPlaying()) {
					MainActivity.bonusPlayer.pause();
					bonusAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.welcomePlayer.isPlaying()) {
					MainActivity.welcomePlayer.pause();
					// backgroundAudio.setImageResource(R.drawable.play);
				}
				if (MainActivity.thanksPlayer.isPlaying()) {
					MainActivity.thanksPlayer.pause();
					thankAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.masterPlayer.isPlaying()) {
					MainActivity.masterPlayer.pause();
				} else {
					MainActivity.masterPlayer.start();
				}
			} else if (trigger == 2) {
				if (!bonusSoundInitialized) {
					bonusSoundInitialized = true;
					if (MainActivity.bonusPlayer == null) {
						MainActivity.bonusPlayer = new MediaPlayer();

					}
					MainActivity.bonusPlayer = MediaPlayer.create(ctx,
							audioFileId);
					MainActivity.bonusPlayer
							.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
								@Override
								public void onCompletion(MediaPlayer mp) {
									bonusAudio
											.setImageResource(R.drawable.play);

									/*
									 * MainActivity.flag = 0;
									 * MainActivity.secret.callOnClick();
									 * 
									 * MainActivity.flag = 1;
									 * MainActivity.secret.callOnClick();
									 */
									if (Build.VERSION.SDK_INT >= 15) {
										MainActivity.flag = 0;
										MainActivity.secret.callOnClick();

										MainActivity.flag = 1;
										MainActivity.secret.callOnClick();
									} else {
										MainActivity.flag = 0;
										MainActivity.secret.performClick();

										MainActivity.flag = 1;
										MainActivity.secret.performClick();
									}

								}
							});
				}

				if (MainActivity.masterPlayer.isPlaying()) {
					MainActivity.masterPlayer.pause();
					play.setImageResource(R.drawable.play_main);
				}

				if (MainActivity.backgroundPlayer.isPlaying()) {
					MainActivity.backgroundPlayer.pause();
					backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.thanksPlayer.isPlaying()) {
					MainActivity.thanksPlayer.pause();
					thankAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.welcomePlayer.isPlaying()) {
					MainActivity.welcomePlayer.pause();
					// backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.bonusPlayer.isPlaying()) {
					MainActivity.bonusPlayer.pause();
				} else {
					MainActivity.bonusPlayer.start();
				}
			} else if (trigger == 3) {
				if (!thanksSoundInitialized) {
					thanksSoundInitialized = true;
					if (MainActivity.thanksPlayer == null) {
						MainActivity.thanksPlayer = new MediaPlayer();

					}

					MainActivity.thanksPlayer = MediaPlayer.create(ctx,
							audioFileId);
					MainActivity.thanksPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
								@Override
								public void onCompletion(MediaPlayer mp) {
									thankAudio.setImageResource(R.drawable.play);
									if(pref.getBoolean("rating", false)==false)
									{
										MainActivity.findDate();
									
										if(MainActivity.int_day>3)
										{
											MainActivity.RatingDailog();
											}
										}
									/*
									 * MainActivity.flag = 0;
									 * MainActivity.secret.callOnClick();
									 * 
									 * MainActivity.flag = 1;
									 * MainActivity.secret.callOnClick();
									 */
									if (Build.VERSION.SDK_INT >= 15) {
										MainActivity.flag = 0;
										MainActivity.secret.callOnClick();

										MainActivity.flag = 1;
										MainActivity.secret.callOnClick();
									} else {
										MainActivity.flag = 0;
										MainActivity.secret.performClick();

										MainActivity.flag = 1;
										MainActivity.secret.performClick();
									

								}}
							});
				}

				if (MainActivity.masterPlayer.isPlaying()) {
					MainActivity.masterPlayer.pause();
					play.setImageResource(R.drawable.play_main);
				}

				if (MainActivity.bonusPlayer.isPlaying()) {
					MainActivity.bonusPlayer.pause();
					bonusAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.backgroundPlayer.isPlaying()) {
					MainActivity.backgroundPlayer.pause();
					backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.welcomePlayer.isPlaying()) {
					MainActivity.welcomePlayer.pause();
					// backgroundAudio.setImageResource(R.drawable.play);
				}

				if (MainActivity.thanksPlayer.isPlaying()) {
					MainActivity.thanksPlayer.pause();
				} else {
					MainActivity.thanksPlayer.start();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private View.OnClickListener invokeUrl = new View.OnClickListener() {

		@Override
		public void onClick(View v) {
			/*
			 * MainActivity.flag = 0; MainActivity.secret.callOnClick();
			 * MainActivity.flag = 1; MainActivity.secret.callOnClick();
			 */
			if (Build.VERSION.SDK_INT >= 15) {
				MainActivity.flag = 0;
				MainActivity.secret.callOnClick();

				MainActivity.flag = 1;
				MainActivity.secret.callOnClick();
			} else {
				MainActivity.flag = 0;
				MainActivity.secret.performClick();

				MainActivity.flag = 1;
				MainActivity.secret.performClick();
			}

			// Intent urlIntent = new Intent(ctx, WebViewActivity.class);
			Intent urlIntent = new Intent(Intent.ACTION_VIEW);

			// startActivity(i);
			Resources r = ctx.getResources();

			if (v == facebook) {
				if (position == 1) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink1)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink1));
				} else if (position == 2) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink2)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink2));
				} else if (position == 3) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink3)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink3));
				} else if (position == 4) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink4)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink4));
				} else if (position == 5) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink5)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink5));
				} else if (position == 6) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink6)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink6));
				} else if (position == 7) {
					urlIntent.setData(Uri.parse(r.getString(R.string.fbsecretlink7)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.fbsecretlink7));
				}
			} else if (v == foursquare) {
				if (position == 1) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink1)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink1));
				} else if (position == 2) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink2)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink2));
				} else if (position == 3) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink3)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink3));
				} else if (position == 4) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink4)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink4));
				} else if (position == 5) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink5)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink5));
				} else if (position == 6) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink6)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink6));
				} else if (position == 7) {
					urlIntent.setData(Uri.parse(r
							.getString(R.string.Foursquarelink7)));
					// urlIntent.putExtra("Link",
					// r.getString(R.string.Foursquarelink7));
				}
			} else if (v == googlePlus) {
				urlIntent.setData(Uri.parse(r
						.getString(R.string.GooglePluslink)));
				// urlIntent.putExtra("Link",
				// r.getString(R.string.GooglePluslink));
			}

			ctx.startActivity(urlIntent);
		}
	};
	  /*IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener = new IabHelper.OnIabPurchaseFinishedListener() {
		public void onIabPurchaseFinished(IabResult result, Purchase purchase) {
			
			Log.e("mPurchaseFinishedListener secret fragment",""+ result);
			
			if (result.getResponse() == IabHelper.BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED) {
				showToast("Item is already purchased");
				pref.edit().putBoolean("isPurchased", true).commit();
				HomeFragment.backgroundColorChange();
			}
			else if (result.isFailure()) {
				// Handle error
				return;
			}  
			else if(
					purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts950)
					||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1450)
					||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1800)
					||purchase.getSku().equalsIgnoreCase(CommonUtilities.ITEM_ts1900)
					)
				 //change the sku item for real purchase
			 	{
				  Toast.makeText(ctx, "Item is successfully purchased",Toast.LENGTH_SHORT).show();
				  Log.d("tag", "purchase successfully");
				
				  pref.edit().putBoolean("isPurchased", true).commit();
				  HomeFragment.backgroundColorChange();
				 // MainActivity.changeTextColor();
			  		}
				}
	};*/

	public static void showToast(String str) {
		Toast.makeText(ctx, str, 1000).show();
	}

	/*
	 * private View.OnClickListener invokeUrl = new View.OnClickListener() {
	 * 
	 * @Override public void onClick(View v) { Intent urlIntent = new
	 * Intent(ctx, WebViewActivity.class); Resources r = ctx.getResources();
	 * 
	 * if(v==facebook) { if(position == 1){ urlIntent.putExtra("Link",
	 * r.getString(R.string.fbsecretlink1)); }else if(position == 2){
	 * urlIntent.putExtra("Link", r.getString(R.string.fbsecretlink2)); }else
	 * if(position == 3){ urlIntent.putExtra("Link",
	 * r.getString(R.string.fbsecretlink3)); }else if(position == 4){
	 * urlIntent.putExtra("Link", r.getString(R.string.fbsecretlink4)); }else
	 * if(position == 5){ urlIntent.putExtra("Link",
	 * r.getString(R.string.fbsecretlink5)); }else if(position == 6){
	 * urlIntent.putExtra("Link", r.getString(R.string.fbsecretlink6)); }else
	 * if(position == 7){ urlIntent.putExtra("Link",
	 * r.getString(R.string.fbsecretlink7)); } }else if(v==foursquare) {
	 * if(position == 1){ urlIntent.putExtra("Link",
	 * r.getString(R.string.Foursquarelink1)); }else if(position == 2){
	 * urlIntent.putExtra("Link", r.getString(R.string.Foursquarelink2)); }else
	 * if(position == 3){ urlIntent.putExtra("Link",
	 * r.getString(R.string.Foursquarelink3)); }else if(position == 4){
	 * urlIntent.putExtra("Link", r.getString(R.string.Foursquarelink4)); }else
	 * if(position == 5){ urlIntent.putExtra("Link",
	 * r.getString(R.string.Foursquarelink5)); }else if(position == 6){
	 * urlIntent.putExtra("Link", r.getString(R.string.Foursquarelink6)); }else
	 * if(position == 7){ urlIntent.putExtra("Link",
	 * r.getString(R.string.Foursquarelink7)); } }else if(v==googlePlus) {
	 * urlIntent.putExtra("Link", r.getString(R.string.GooglePluslink)); }
	 * 
	 * ctx.startActivity(urlIntent); } };
	 */

	/*
	 * Intent fbIntent =new Intent(ctx, WebViewActivity.class);
	 * 
	 * if(fbsecretlink1 != null) fbIntent.putExtra("Link", fbsecretlink1); else
	 * if(fbsecretlink2 != null) fbIntent.putExtra("Link", fbsecretlink2); else
	 * if(fbsecretlink3 != null) fbIntent.putExtra("Link", fbsecretlink3); else
	 * if(fbsecretlink4 != null) fbIntent.putExtra("Link", fbsecretlink4); else
	 * if(fbsecretlink5 != null) fbIntent.putExtra("Link", fbsecretlink5); else
	 * if(fbsecretlink6 != null) fbIntent.putExtra("Link", fbsecretlink6); else
	 * if(fbsecretlink7 != null) fbIntent.putExtra("Link", fbsecretlink7); else
	 * if(fbsecretlinkall != null) fbIntent.putExtra("Link", fbsecretlinkall);
	 * 
	 * ctx.startActivity(fbIntent);
	 */

	// animation listeners
	@Override
	public void onAnimationEnd(Animation animation) {
		// Take any action after completing the animation
		// check for fade in animation
		if (animation == animSlide_down) {
			/*
			 * Toast.makeText(getApplicationContext(), "Animation Stopped",
			 * Toast.LENGTH_SHORT).show();
			 */
		}

	}

	@Override
	public void onAnimationRepeat(Animation animation) {
		// Animation is repeating
	}

	@Override
	public void onAnimationStart(Animation animation) {
		// Animation started
	}
	@Override
	public void onResume() {
		freeMemory();
		super.onResume();
	}
	public void freeMemory(){ 
		System.err.println("free memory");
	    System.runFinalization();
	    Runtime.getRuntime().gc();
	    System.gc();
	}
}
