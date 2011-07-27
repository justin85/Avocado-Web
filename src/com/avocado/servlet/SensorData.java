package com.avocado.servlet;

public class SensorData {

	private String timestamp;
	private String Xaccel;
	private String Yaccel;
	private String Zaccel;
	private String Xmag;
	private String Ymag;
	private String Zmag;
	private String Xorien;
	private String Yorien;
	private String Zorien;
	private String Xgyro;
	private String Ygyro;
	private String Zgyro;
	private String phone_location;
	private String comment;
	

	public SensorData() {
	}
	public SensorData(String timestamp, String Xaccel,
			String Yaccel, String Zaccel,
			String Xmag, String Ymag,
			String Zmag, String Xorien,
			String Yorien, String Zorien) {
		this.timestamp = timestamp;
		this.Xaccel = Xaccel;
		this.Yaccel = Yaccel;
		this.Zaccel = Zaccel;
		this.Xmag = Xmag;
		this.Ymag = Ymag;
		this.Zmag = Zmag;
		this.Xorien = Xorien;
		this.Yorien = Yorien;
		this.Zorien = Zorien;

		
	}
	public SensorData(String timestamp, String Xaccel,
			String Yaccel, String Zaccel,
			String Xmag, String Ymag,
			String Zmag, String Xorien,
			String Yorien, String Zorien,
			String Xgyro, String Ygyro,
			String Zgyro) {
		this.timestamp = timestamp;
		this.Xaccel = Xaccel;
		this.Yaccel = Yaccel;
		this.Zaccel = Zaccel;
		this.Xmag = Xmag;
		this.Ymag = Ymag;
		this.Zmag = Zmag;
		this.Xorien = Xorien;
		this.Yorien = Yorien;
		this.Zorien = Zorien;
		this.Xgyro = Xgyro;
		this.Ygyro = Ygyro;
		this.Zgyro = Zgyro;
		
	}
	public SensorData(String timestamp, String Xaccel,
			String Yaccel, String Zaccel,
			String Xmag, String Ymag,
			String Zmag, String Xorien,
			String Yorien, String Zorien,
			String Xgyro, String Ygyro,
			String Zgyro, String phone_location,
			String comment) {
		this.timestamp = timestamp;
		this.Xaccel = Xaccel;
		this.Yaccel = Yaccel;
		this.Zaccel = Zaccel;
		this.Xmag = Xmag;
		this.Ymag = Ymag;
		this.Zmag = Zmag;
		this.Xorien = Xorien;
		this.Yorien = Yorien;
		this.Zorien = Zorien;
		this.Xgyro = Xgyro;
		this.Ygyro = Ygyro;
		this.Zgyro = Zgyro;
		this.phone_location = phone_location;
		this.comment = comment;
		
	}

	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	public String getXaccel() {
		return Xaccel;
	}
	public void setXaccel(String Xaccel) {
		this.Xaccel = Xaccel;
	}
	
	public String getYaccel() {
		return Yaccel;
	}
	public void setYaccel(String Yaccel) {
		this.Yaccel = Yaccel;
	}
	
	public String getZaccel() {
		return Zaccel;
	}
	public void setZaccel(String Zaccel) {
		this.Zaccel = Zaccel;
	}
	
	public String getXmag() {
		return Xmag;
	}
	public void setXmag(String Xmag) {
		this.Xmag = Xmag;
	}
	
	public String getYmag() {
		return Ymag;
	}
	public void setYmag(String Ymag) {
		this.Ymag = Ymag;
	}
	
	public String getZmag() {
		return Zmag;
	}
	public void setZmag(String Zmag) {
		this.Zmag = Zmag;
	}
	
	public String getXorien() {
		return Xorien;
	}
	public void setXorien(String Xorien) {
		this.Xorien = Xorien;
	}
	
	public String getYorien() {
		return Yorien;
	}
	public void setYorien(String Yorien) {
		this.Yorien = Yorien;
	}
	
	public String getZorien() {
		return Zorien;
	}
	public void setZorien(String Zorien) {
		this.Zorien = Zorien;
	}
	
	public String getXgyro() {
		return Xgyro;
	}
	public void setXgyro(String Xgyro) {
		this.Xgyro = Xgyro;
	}
	
	public String getYgyro() {
		return Ygyro;
	}
	public void setYgyro(String Ygyro) {
		this.Ygyro = Ygyro;
	}
	
	public String getZgyro() {
		return Zgyro;
	}
	public void setZgyro(String Zgyro) {
		this.Zgyro = Zgyro;
	}
	
	public String getPhoneLocation() {
		return phone_location;
	}
	public void setPhoneLocaion(String phone_location) {
		this.phone_location = phone_location;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	

}