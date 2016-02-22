package com.vestas.servlet
{
	
	import mx.charts.ColumnChart;
	import mx.controls.DataGrid;
	import mx.core.UIComponent;
	
	import org.alivepdf.display.Display;
	import org.alivepdf.layout.Layout;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Download;
	import org.alivepdf.saving.Method;
	

	public class CreatePDF
	{
		public static var myPDF:PDF=null;
		
		public static function generatePDF (myDataGrid:DataGrid ,chart:ColumnChart):void
		{
						
			myPDF = new PDF( Orientation.PORTRAIT, Unit.MM, Size.A4 );
			myPDF.setDisplayMode ( Display.FULL_WIDTH ); 
			myPDF.addPage();
			myPDF.addImage (chart,null,0,0,150);
			myPDF.addImage (myDataGrid,null,0,0,150);
			myPDF.save(Method.REMOTE, "http://localhost:8080/Vestas-Server/CreatePDFServlet", Download.ATTACHMENT, "myPDF.pdf");
		}
		
		public static function generatePDFTest (uiComp:UIComponent):void
		{
			
			myPDF = new PDF( Orientation.PORTRAIT, Unit.MM, Size.A4 );
			myPDF.setDisplayMode ( Display.FULL_WIDTH ); 
			myPDF.addPage();
			myPDF.addImage (uiComp,null,0,0,150);
			myPDF.save(Method.REMOTE, "http://localhost:8080/Vestas-Server/CreatePDFServlet", Download.ATTACHMENT, "myPDF.pdf");
		}
		
		public static function generateExcel():void{
			
		}
		
	
	}
}