package com.vestas.utils
{
	import mx.collections.ArrayCollection;
	/**
	 * 
	 * @author Karthy
	 * 
	 */	
	public class ArrayCollectionExtended extends ArrayCollection
	{
		private var _filterFunctions:Array;
		
		public function ArrayCollectionExtended( source:Array = null )
		{
			super(source);
		}
		public function set filterFunctions( filtersArray:Array ):void
		{
			_filterFunctions = filtersArray;
			this.filterFunction = complexFilter;
		}
		public function get filterFunctions():Array
		{
			return _filterFunctions;
		}
		
		protected function complexFilter( item:Object ):Boolean
		{
			var filterFlag:Boolean = true;
			var filter:Function;
			for each(filter in filterFunctions)
			{
				filterFlag = filter( item );
				if( !filterFlag )
					break;
			}
			
			return filterFlag;
		}
	}
}