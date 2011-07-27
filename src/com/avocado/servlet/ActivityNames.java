package com.avocado.servlet;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;


public class ActivityNames {

	public static final String OFF						= "OFF";
	public static final String END						= "END";
	public static final String UNKNOWN					= "UNKNOWN";
	public static final String UNCARRIED				= "CLASSIFIED/UNCARRIED";
	public static final String CHARGING					= "CLASSIFIED/CHARGING";
	public static final String CHARGING_TRAVELLING		= "CLASSIFIED/CHARGING/TRAVELLING";
	public static final String WALKING					= "CLASSIFIED/WALKING";
	public static final String STATIONARY				= "CLASSIFIED/STATIONARY";
	public static final String PADDLING					= "CLASSIFIED/PADDLING";
	public static final String TRAVELLING				= "CLASSIFIED/TRAVELLING";
	
	public static Set<String> allActivities = new TreeSet<String>(new StringComparator(false));
	/**
	 * Check if the given activity is a system-based activity,
	 * activities such as END, are not there for the user but for the system.
	 */
	public static boolean isSystemActivity(String activity) {
		return END.equals(activity) || OFF.equals(activity);
	}

	public ActivityNames(){
		this.allActivities.add(OFF);
		this.allActivities.add(END);
		this.allActivities.add(UNKNOWN);
		this.allActivities.add(UNCARRIED);
		this.allActivities.add(CHARGING);
		this.allActivities.add(CHARGING_TRAVELLING);
		this.allActivities.add(WALKING);
		this.allActivities.add(STATIONARY);
		this.allActivities.add(PADDLING);
		this.allActivities.add(TRAVELLING);
	}
	public static Set<String> getAllActivities() {

		return allActivities;
	}
	public static void setAllActivities(String activityName){
		if(!allActivities.contains(activityName)){
			allActivities.add(activityName);
		}
	}
}