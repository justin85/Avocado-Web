package com.avocado.servlet;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.Text;

@PersistenceCapable
public class Datastore {
//	private static long FN=0;
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;

 
    @Persistent
    private String IMEI;
    @Persistent
    private Date date;
    @Persistent
    private String acti;
    @Persistent
    private String correct;
    @Persistent
    private String FNS;
    @Persistent
    private Text myText;
    @Persistent
    private String phone_location;
    @Persistent
    private String comment;
    
    
    public Datastore(){
        }
    public Datastore(Text myText){
    	this.myText=myText;
    }
    public Datastore(String IMEI){
    	this.IMEI = IMEI;
    }
    public Datastore(Date date,String correct,String acti,String IMEI,String FNS,Text myText) {
    	this.myText=myText;
    	this.acti=acti;
        this.IMEI = IMEI;
        this.correct=correct;
        this.FNS=FNS;
        this.date=date;
//        setFN(FN);
        
    }
    public Datastore(Date date,String correct,String acti,String IMEI,String FNS,Text myText,String phone_location,String comment) {
    	this.myText=myText;
    	this.acti=acti;
        this.IMEI = IMEI;
        this.correct=correct;
        this.FNS=FNS;
        this.date=date;
        this.phone_location = phone_location;
        this.comment = comment;
//        setFN(FN);
        
    }

    public Key getKey() {
        return key;
    }

	 public String getFNS(){
		 return FNS;
	 }
	 public Date getDate(){
		 return date;
	 }
//    public long getFN(){
//    	return FN;
//    }
    public String getIMEI() {
        return IMEI;
    }
    public String getActi() {
        return acti;
    }
    public String getCorrect() {
        return correct;
    }

    public Text getMyText() {
        return myText;
    }
    public String getPhoneLocation() {
        return phone_location;
    }
    public String getComment() {
        return comment;
    }
  

    public void setFNS(String FNS){
    	this.FNS=FNS;
    }

    public void setDate(Date date){
    	this.date=date;
    }

    public void setIMEI(String IMEI) {
        this.IMEI = IMEI;
    }
    public void setActi(String acti) {
        this.acti = acti;
    }
    public void setCorrect(String correct) {
        this.correct = correct;
    }
    public void setMyText(Text myText) {
    	this.myText=myText;
    }
    public void setPhoneLocation(String phone_location) {
        this.phone_location = phone_location;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }

}