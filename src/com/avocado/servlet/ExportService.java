package com.avocado.servlet;



import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Workbook;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import com.google.appengine.api.datastore.Text;

/**
 * 
 * @author <a href="mailto:jeremy.wallez@z80.fr>Jeremy Wallez</a>
 * @version 1.0
 */
public class ExportService {

	private static List<SensorData> data = new ArrayList<SensorData>();
	int count =0;
	int count1 =0;
	String haha="";
	public void setData(ArrayList<String> getdata){
		for(int j = 0 ; j < getdata.size(); j++){
			String line = getdata.get(j);
			String[] tempDataSet = line.split("&");
			String[] tempData;
			
			for (int i = 0; i < tempDataSet.length-1; i++) {
				tempData = tempDataSet[i].split("[:,]");
				if(tempData.length==13){
					data.add(new SensorData(tempData[0],tempData[1],tempData[2],tempData[3],
							tempData[4],tempData[5],tempData[6],tempData[7],tempData[8],tempData[9],tempData[10],tempData[11],tempData[12]));
				}else if(tempData.length == 10){
					data.add(new SensorData(tempData[0],tempData[1],tempData[2],tempData[3],
							tempData[4],tempData[5],tempData[6],tempData[7],tempData[8],tempData[9]));
				}
				if(i==0)
				count1=tempData.length;
			}
			if(j==0){
			count=tempDataSet.length;
			haha=line;
			}
		}
	}


	public ByteArrayOutputStream generateExcelReport(ArrayList<String> getdata) throws IOException, WriteException {
		/* Stream containing excel data */
		setData(getdata);
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		/* Create Excel WorkBook and Sheet */
		WritableWorkbook workBook = Workbook.createWorkbook(outputStream);
		WritableSheet sheet = workBook.createSheet("Sensor Data", 0);

		/* Generates Headers Cells */
		WritableFont headerFont = new WritableFont(WritableFont.TAHOMA, 12, WritableFont.BOLD);
		WritableCellFormat headerCellFormat = new WritableCellFormat(headerFont);
		headerCellFormat.setBackground(Colour.PALE_BLUE);
		sheet.addCell(new Label(0, 0, "Timestamp", headerCellFormat));
		sheet.addCell(new Label(1, 0, "X-accel", headerCellFormat));
		sheet.addCell(new Label(2, 0, "Y-accel", headerCellFormat));
		sheet.addCell(new Label(3, 0, "Z-accel", headerCellFormat));
		sheet.addCell(new Label(4, 0, "X-mag", headerCellFormat));
		sheet.addCell(new Label(5, 0, "Y-mag", headerCellFormat));
		sheet.addCell(new Label(6, 0, "Z-mag", headerCellFormat));
		sheet.addCell(new Label(7, 0, "X-orien", headerCellFormat));
		sheet.addCell(new Label(8, 0, "Y-orien", headerCellFormat));
		sheet.addCell(new Label(9, 0, "Z-orien", headerCellFormat));
		sheet.addCell(new Label(10, 0, "Z-gyro", headerCellFormat));
		sheet.addCell(new Label(11, 0, "Z-gyro", headerCellFormat));
		sheet.addCell(new Label(12, 0, "Z-gyro", headerCellFormat));


		/* Generates Data Cells */
		WritableFont dataFont = new WritableFont(WritableFont.TAHOMA, 12);
		WritableCellFormat dataCellFormat = new WritableCellFormat(dataFont);
		int currentRow = 1;
		for (SensorData data1 : getData()) {
			sheet.addCell(new Label(0, currentRow, data1.getTimestamp(),dataCellFormat));
			sheet.addCell(new Label(1, currentRow, data1.getXaccel(),dataCellFormat));
			sheet.addCell(new Label(2, currentRow, data1.getYaccel(),dataCellFormat));
			sheet.addCell(new Label(3, currentRow, data1.getZaccel(),dataCellFormat));
			sheet.addCell(new Label(4, currentRow, data1.getXmag(),dataCellFormat));
			sheet.addCell(new Label(5, currentRow, data1.getYmag(),dataCellFormat));
			sheet.addCell(new Label(6, currentRow, data1.getZmag(),dataCellFormat));
			sheet.addCell(new Label(7, currentRow, data1.getXorien(),dataCellFormat));
			sheet.addCell(new Label(8, currentRow, data1.getYorien(),dataCellFormat));
			sheet.addCell(new Label(9, currentRow, data1.getZorien(),dataCellFormat));
			sheet.addCell(new Label(10, currentRow, data1.getXgyro(),dataCellFormat));
			sheet.addCell(new Label(11, currentRow, data1.getYgyro(),dataCellFormat));
			sheet.addCell(new Label(12, currentRow, data1.getZgyro(),dataCellFormat));

			currentRow++;
		}

		/* Write & Close Excel WorkBook */
		workBook.write();
		workBook.close();
		data.clear();
		return outputStream;
	}
	
	public List<SensorData> getData() {
		return data;
	}
}