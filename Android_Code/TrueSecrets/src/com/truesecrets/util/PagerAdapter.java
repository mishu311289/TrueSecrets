package com.truesecrets.util;

import java.util.ArrayList;

import android.os.Build;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.util.Log;
import android.view.View;

import com.truesecrets.strange.tour.melbourne.HomeFragment;
import com.truesecrets.strange.tour.melbourne.MainActivity;
import com.truesecrets.strange.tour.melbourne.SecretFragment;

public class PagerAdapter extends FragmentPagerAdapter implements OnPageChangeListener{

	
    private final ArrayList<Fragment> mFragments = new ArrayList<Fragment>();

    public PagerAdapter(FragmentManager manager) {
        super(manager);
    }

    public void addFragment(Fragment fragment) {
        mFragments.add(fragment);
        notifyDataSetChanged();
    }

   /*@Override 
    public Object instantiateItem(ViewGroup container, final int position)
    {
    	LayoutInflater inflater = (LayoutInflater) container.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    	Log.e("page initialization","selected "+position);
    	
        int resId = 0;
        switch (position) {
            case 0:
                resId = R.layout.mainscreen;
                break;
            case 1:
                resId = R.layout.secret_layout;
                break;
            case 2:
                resId = R.layout.secret_layout;
                break;
            case 3:
                resId = R.layout.secret_layout;
                break;
            case 4:
                resId = R.layout.secret_layout;
                break;
            case 5:
                resId = R.layout.secret_layout;
                break;
            case 6:
                resId = R.layout.secret_layout;
                break;
            case 7:
                resId = R.layout.secret_layout;
                break;
            case 8:
                resId = R.layout.about;
                break;
        }

        View view = inflater.inflate(resId, null);
        view.setTag(resId);
        
        ((ViewPager) container).addView(view, 0);
        return view;
    }*/
    
//    View v = mAdapter.findViewWithTag("pos"+index); and update anything you want in v: 
//    ImageView ivBackground = (ImageView) v .findViewById(R.id.pager_image); 
    
    @Override
    public int getCount() {
        return mFragments.size();
    }

    @Override
    public Fragment getItem(int position) {
        return mFragments.get(position);
    }

	@Override
	public void onPageScrollStateChanged(int arg0) {
		Log.e("page scroll state","state changed");
	}

	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {
		Log.e("page scroll","scrolled");
		
		
	}

	@Override
	public void onPageSelected(int arg0) {
		Log.e("page selected","selected "+arg0);
		
		
		for(int i = 0; i< MainActivity.views.size(); i++)
		{
			View view = MainActivity.views.get(i);
			if((view.getTag().toString().equals("BgAudio"+(arg0 - 1)) && (MainActivity.backgroundPlayer.isPlaying() || SecretFragment.bgSoundInitialized))|| (view.getTag().toString().equals("BonusAudio"+(arg0 - 1)) && (MainActivity.bonusPlayer.isPlaying() || SecretFragment.bonusSoundInitialized)) || (view.getTag().toString().equals("Play"+(arg0 - 1)) && (MainActivity.masterPlayer.isPlaying() || SecretFragment.masterSoundInitialized))  || (view.getTag().toString().equals("Welcome") && (MainActivity.welcomePlayer.isPlaying() || HomeFragment.welcomeSoundInitialized)) || (view.getTag().toString().equals("thanksAudio"+(arg0 - 1)) && (MainActivity.thanksPlayer.isPlaying() || SecretFragment.thanksSoundInitialized))){
				if(Build.VERSION.SDK_INT>=15){
					view.callOnClick();
		    	}else{
		    		view.performClick();
		    	}
			}
				
			else if((view.getTag().toString().equals("BgAudio"+(arg0 + 1)) && (MainActivity.backgroundPlayer.isPlaying() || SecretFragment.bgSoundInitialized))|| (view.getTag().toString().equals("BonusAudio"+(arg0 + 1)) && (MainActivity.bonusPlayer.isPlaying() || SecretFragment.bonusSoundInitialized)) || (view.getTag().toString().equals("Play"+(arg0 + 1)) && (MainActivity.masterPlayer.isPlaying() || SecretFragment.masterSoundInitialized)) || (view.getTag().toString().equals("Welcome") && (MainActivity.welcomePlayer.isPlaying() || HomeFragment.welcomeSoundInitialized)) || (view.getTag().toString().equals("thanksAudio"+(arg0 + 1)) && (MainActivity.thanksPlayer.isPlaying() || SecretFragment.thanksSoundInitialized))){
				if(Build.VERSION.SDK_INT>=15){
					view.callOnClick();
		    	}else{
		    		view.performClick();
		    	}
			}
			
			/*else if((view.getTag().toString().equals("BgAudio"+(arg0 + 1)) && (MainActivity.welcomePlayer.isPlaying() || HomeFragment.welcomeSoundInitialized))|| (view.getTag().toString().equals("BonusAudio"+(arg0 + 1)) && (MainActivity.welcomePlayer.isPlaying() || HomeFragment.welcomeSoundInitialized)))
				view.callOnClick();*/
		}
		
		try{
			if(MainActivity.masterPlayer.isPlaying() || SecretFragment.masterSoundInitialized){
				MainActivity.masterPlayer.stop();		
				SecretFragment.masterSoundInitialized = false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			if(MainActivity.backgroundPlayer.isPlaying() || SecretFragment.bgSoundInitialized){
				MainActivity.backgroundPlayer.stop();		
				SecretFragment.bgSoundInitialized = false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			if(MainActivity.bonusPlayer.isPlaying() || SecretFragment.bonusSoundInitialized){
				MainActivity.bonusPlayer.stop();
				SecretFragment.bonusSoundInitialized = false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			if(MainActivity.welcomePlayer.isPlaying() || HomeFragment.welcomeSoundInitialized){
				MainActivity.welcomePlayer.stop();
				HomeFragment.welcomeSoundInitialized = false;				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			if(MainActivity.thanksPlayer.isPlaying() || SecretFragment.thanksSoundInitialized){
				MainActivity.thanksPlayer.stop();
				SecretFragment.thanksSoundInitialized = false;				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		/*MainActivity.flag = 0;
		MainActivity.secret.callOnClick();
		
		MainActivity.flag = 1;
		MainActivity.secret.callOnClick();		*/
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
		
	
    
   /* @Override
	public void destroyItem(ViewGroup collection, int position, Object view) {
		collection.removeView((Fragment) view);
	}*/
}
