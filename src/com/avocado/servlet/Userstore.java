package com.avocado.servlet;


import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;


@PersistenceCapable
public class Userstore {
//	private static long FN=0;
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;

    @Persistent
    private String UID;
    @Persistent
    private String IMEI;
    @Persistent
    private String Model;
    @Persistent
    private String Permission;


    
    public Userstore(){
        }
    public Userstore(String UID,String IMEI,String Model) {
    	this.UID=UID;
    	this.IMEI=IMEI;
    	this.Model=Model;
    	
    }
    public Userstore(String UID,String IMEI,String Model,String Permission) {
    	this.UID=UID;
    	this.IMEI=IMEI;
    	this.Model=Model;
    	this.Permission = Permission;
    }

    public Key getKey() {
        return key;
    }
    public String getUID(){
		 return UID;
	}
	public String getIMEI(){
		 return IMEI;
	}
	public String getModel(){
		 return Model;
	}
	public String getPermission(){
		 return Permission;
	}


    
    public void setSize(String UID){
    	this.UID=UID;
    }
    public void setIMEI(String IMEI){
    	this.IMEI=IMEI;
    }
    public void setModel(String Model){
    	this.Model=Model;
    }
    public void setPermission(String Permission){
    	this.Permission=Permission;
    }



}