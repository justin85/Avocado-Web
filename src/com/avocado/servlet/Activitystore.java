package com.avocado.servlet;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;


@PersistenceCapable
public class Activitystore {
	//	private static long FN=0;
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;


	@Persistent
	private String UID;
	@Persistent
	private Date startDate;
	@Persistent
	private Date endDate;
	@Persistent
	private String acti;
	@Persistent
	private String niceName;

	@Persistent
	private String size;
	@Persistent
	private String timezone;
	@Persistent
	private static long unique;


	public Activitystore(){
	}

	public Activitystore(String UID,Date startDate,Date endDate,String acti,String niceName,String size,String timezone) {
		this.UID=UID;
		this.startDate=startDate;
		this.endDate=endDate;
		this.acti=acti;
		this.niceName=niceName;
		this.size=size;
		this.timezone=timezone;

	}

	public Key getKey() {
		return key;
	}


	public String getUID(){
		return UID;
	}
	public Date getStartDate(){
		return startDate;
	}

	public Date getEndDate(){
		return endDate;
	}

	public String getSize(){
		return size;
	}
	public String getTimezone(){
		return timezone;
	}
	//    public long getFN(){
		//    	return FN;
		//    }

	public String getActi() {
		return acti;
	}

	public String getNiceName() {
		return niceName;
	}


	public void setUID(String UID){
		this.UID=UID;
	}
	public void setStartDate(Date startDate){
		this.startDate=startDate;
	}
	public void setEndDate(Date endDate){
		this.endDate=endDate;
	}

	public void setSize(String size){
		this.size=size;
	}


	public void setActi(String acti) {
		this.acti = acti;
	}

	public void setNiceName(String niceName) {
		this.niceName = niceName;
	}
	public void setTimezone(String timezone) {
		this.timezone = timezone;
	}


}