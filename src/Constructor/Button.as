package Constructor 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author ktolik
	 */
	public class Button extends Sprite
	{
		private var _seettings:Object = {
			width:30,
			height:30,
			caption:"+",
			onClick:function():void {trace("Click");}
		};
		private var _bg:Shape;
		private var _capture:TextField;
		
		public function Button(settings:Object)
		{
			for (var param:String in settings) {
				_seettings[param] = settings[param];
			}
			
			init();
			build();
		}
		
		public function dispose():void
		{
			removeListeners();
		}
		
		private function init():void 
		{
			drawBg();
			drawCapture();
			setListeners();
		}
		
		private function setListeners():void 
		{
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function removeListeners():void 
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function drawBg():void 
		{
			_bg = Backings.getShape(_seettings.width, _seettings.height, 0xA3D5E7);
		}
		
		private function drawCapture():void 
		{
			_capture = new TextField();
			_capture.text = _seettings.caption;
			_capture.width = _capture.textWidth + 4;
			_capture.height = _capture.textHeight + 4;
			_capture.mouseEnabled = false;
		}
		
		private function build():void 
		{
			addChild(_bg);
			addChild(_capture);
			
			_bg.x = -_bg.width / 2;
			_bg.y = -_bg.height / 2;
			
			_capture.x = -_capture.width / 2;
			_capture.y = -_capture.height / 2;
		}
		
		private function onMouseDown(e:MouseEvent = null):void
		{
			if(_seettings.onClick is Function) _seettings.onClick();
		}
		
	}

}