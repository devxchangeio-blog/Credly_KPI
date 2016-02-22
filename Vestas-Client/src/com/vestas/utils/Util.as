package com.vestas.utils
{

	public class Util
	{
		public static var months:Array=new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

		public static function getMonthIndex(monthString:String):int
		{
			for (var i:int=0; i < months.length; i++)
			{
				if (months[i] == monthString)
				{
					return i;
				}
			}

			// not a valid month string
			return -1;
		}

		public static function getMonthString(monthIndex:int):String
		{
			for (var i:int=0; i < months.length; i++)
			{
				if (i == monthIndex)
				{
					return months[i];
				}
			}

			return "";

		}

		public static function getMonths(currentMonth:int, currentYear:int):Array
		{
			var months:Array=new Array();
			var monthIndex:int=currentMonth;
			var temp:String="";
			var flag:Boolean=true;

			for (var i:int=1; i < 12; i++)
			{
				if (monthIndex < 12 && flag)
				{
					monthIndex++;
					months.push(new Date(currentYear-1,monthIndex,1));
					if (monthIndex == 12)
					{
						monthIndex=0;
						flag=false;
					}
				}
				else if (monthIndex <= (currentMonth - 1))
				{
					monthIndex++;
					months.push(new Date(currentYear,monthIndex,1) );
				}

			}
			return months;
		}

	}
}
