package com.avocado.servlet;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;


@PersistenceCapable
public class testactivitystore {
//	private static long FN=0;
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;

 
    @Persistent
    private String UID;
    @Persistent
    private Date date;
    @Persistent
    private String acti;

    @Persistent
    private String size;
    @Persistent
    private String timezone;
    @Persistent
    private static long unique;
    
    
    public testactivitystore(){
        }
  
    public testactivitystore(String UID,Date date,String acti,String size,String timezone) {
    	this.UID=UID;
    	this.date=date;
    	this.acti=acti;
    	
    	this.size=size;
    	this.timezone=timezone;
    	
    }

    public Key getKey() {
        return key;
    }


	 public String getUID(){
		 return UID;
	 }
	 public Date getDate(){
		 return date;
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
    
    
    public void setUID(String UID){
    	this.UID=UID;
    }
    public void setDate(Date date){
    	this.date=date;
    }

    public void setSize(String size){
    	this.size=size;
    }

   
    public void setActi(String acti) {
        this.acti = acti;
    }
    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }
   

}