package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ItemWrapper;
	import mx.core.IVisualElement;
	
	import spark.components.DropDownList;
	import spark.events.DropDownEvent;
	
	
	public class MultiSelectionDropDown extends DropDownList
	{
		
		/** selected check boxes */
		protected var currentlySelectedCheckBoxes:Array = new Array();
		
		/**
		 * constructor
		 */
		public function MultiSelectionDropDown()
		{
			super();
			this.addEventListener(DropDownEvent.OPEN, onOpen, false, 0, true);
		}
	
		/**
		 *  handler for opening the dropdown
		 *  
		 *  @param dropdown event
		 */ 
		public function onOpen(event:DropDownEvent):void {
			activateAllCheckBoxes();
		}		
		
		/**
		 * selected views getter (inclusive of check boxes on item renderer)
		 * 
		 * @return array
		 */
		[Bindable(event="selectionChange")]
		public function get selectedViews():Array {
			var multiSelect:Array = selectedCheckboxes;
			if (multiSelect.length > 0) {
				return multiSelect;
			} else {
				return [selectedItem];
			}
		}
		
		/**
		 * selected views setter (does nothing)
		 * 
		 * @param array
		 */
		public function set selectedViews(value:Array):void {}
		
		/**
		 * item mouse down handler
		 * 
		 * @param mouse event
		 */
		override protected function item_mouseDownHandler(event:MouseEvent):void {
			// launch solo view mode when clicking "playback only"
			if ( event.currentTarget.data == "Select This Item Only" ) {
				deselectAllCheckBoxes();
			}
			
			if (selectedCheckboxes.length == 0) {
				super.item_mouseDownHandler(event);	
				dispatchEvent(new Event("selectionChange"));
			} else {
				closeDropDown(false);
			}
		}
		
		/**
		 *  @private
		 *  Event handler for the <code>dropDownController</code> 
		 *  <code>DropDownEvent.CLOSE</code> event. Updates the skin's state.
		 * 
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		protected override function dropDownController_closeHandler(event:DropDownEvent):void
		{
			if (currentlySelectedCheckBoxes.length > 0) {
				// if checkboxes are selected prevent the default behavior,
				// which is to set a selection index
				event.preventDefault();
			}
			super.dropDownController_closeHandler(event);
		}
		
		/**
		 * turn on all check boxes
		 */
		protected function activateAllCheckBoxes():void {
			for (var c:int = 0; c < dataGroup.numElements; c++) {
				var obj:MultiSelectItemRenderer = dataGroup.getElementAt(c) as MultiSelectItemRenderer;
				if (obj) {
					// no check box here, this playback mode only is a solo view
					if (dataProvider.getItemAt(c) == "Select This Item Only" ) {
						obj.checkbox.visible = false;
					}
					
					// find and check of previously checked boxes
					if ( currentlySelectedCheckBoxes.indexOf(dataProvider.getItemAt(c)) != -1 ) {
						obj.checkbox.selected = true;
					}
					
					obj.checkbox.addEventListener(MouseEvent.MOUSE_DOWN, mouseCheckBox, false, 0, true);
					obj.checkbox.addEventListener(MouseEvent.MOUSE_UP, mouseCheckBox, false, 0, true);
					obj.checkbox.addEventListener(Event.CHANGE, changeCheckBoxSelection, false, 0, true);
				}
			}
		}
		
		/**
		 * deselect all check boxes
		 */
		protected function deselectAllCheckBoxes():void {
			currentlySelectedCheckBoxes = [];
			for (var c:int = 0; c < dataGroup.numElements; c++) {
				var obj:MultiSelectItemRenderer = dataGroup.getElementAt(c) as MultiSelectItemRenderer;
				if (obj) {
					obj.checkbox.selected = false;
				}
			}
		}
		
		/**
		 * get array of selected checkboxes
		 * 
		 * @return array of selected checkboxes
		 */
		protected function get selectedCheckboxes():Array {
			var returnList:Array = new Array();
			for (var c:int = 0; c < dataGroup.numElements; c++) {
				var obj:MultiSelectItemRenderer = dataGroup.getElementAt(c) as MultiSelectItemRenderer;
				if (obj && obj.checkbox.selected) {
					returnList.push(obj.data);
				}
			}
			return returnList;
		}
		
		/**
		 * on click checkbox (stop event from going to underlying item renderer)
		 * 
		 * @param change event
		 */
		protected function mouseCheckBox(event:Event):void {
			event.stopImmediatePropagation();
		}
		
		/**
		 * on change checkbox
		 * 
		 * @param change event
		 */
		protected function changeCheckBoxSelection(event:Event):void {
			currentlySelectedCheckBoxes = selectedCheckboxes;
			
			// turn on multi-view mode
			if (event.currentTarget.selected == true ) {
				selectedIndex = -1;
				labelDisplay.text = "multiple selections";
			}
			
			dispatchEvent(new Event("selectionChange"));
		}
	}
	
	
}