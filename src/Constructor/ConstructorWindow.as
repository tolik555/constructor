package Constructor 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ktolik
	 */
	public class ConstructorWindow extends Sprite
	{
		private var _items:Vector.<ActionItem>;
		private var _mMove:Boolean = false;
		private var _currentTarget:Object;
		private var settings:Object = {
			allContent:[1, 2, 3, 4, 5, 6, 7],
			width:900,
			height:900,
			step:25
		};
		
		public function ConstructorWindow() 
		{
			drawBody();
			drawBttn();
			setListeners();
		}
		
		private function setListeners():void
		{
			for each (var item:ActionItem in _items) {
				item.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			}
		}
		
		private function mDown(e:MouseEvent):void {
			if (e.target is ActionItem) {
				_mMove = true;
				addEventListener(Event.ENTER_FRAME, update);
				_currentTarget = e.target;
				e.target.addEventListener(MouseEvent.MOUSE_UP, mUp);
			}
        }
		
		private function mUp(e:MouseEvent):void {
            _mMove = false;
			
			if (_currentTarget.x % settings.step < settings.step/2) {
				_currentTarget.x = int(_currentTarget.x / settings.step) * settings.step;
			}
			else {
				_currentTarget.x = int(_currentTarget.x / settings.step) * settings.step+settings.step;
			}
			
			if (_currentTarget.y % settings.step < settings.step/2) {
				_currentTarget.y = int(_currentTarget.y / settings.step) * settings.step;
			}else {
				_currentTarget.y = int(_currentTarget.y / settings.step) * settings.step+settings.step;
			}
		}
		
		private function removeListeners():void
		{
			for each (var item:ActionItem in _items) {
				item.removeEventListener(MouseEvent.MOUSE_DOWN, update);
			}
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function drawBody():void 
		{
			_items = new Vector.<ActionItem>();
			
			var _dX:int = 0;
			var _dY:int = 0;
			for (var i:int = 0; i < settings.allContent.length; i++) 
			{
				var actionItem:ActionItem = new ActionItem({
					sid:settings.allContent[i],
					width:3,
					height:3
				});
				
				if ((_dX + actionItem.width) > settings.width) {
					_dX = 0;
					_dY += 300;
				}
				
				actionItem.x = _dX;
				_dX += actionItem.width;
				actionItem.y = _dY;
				addChild(actionItem);
				_items.push(actionItem);
			}
		}
		
		
		private function drawBttn():void 
		{
			var _getParams:Button = new Button({
				caption:"g",
				onClick:getParams
			});
			_getParams.x = 850;
			_getParams.y = 850;
			addChild(_getParams);
		}
		
		private function getParams():void
		{
			var result:Object = {};
			for (var i:int = 0; i < _items.length; i++) {
				result[_items[i].sid] = {
					sid:_items[i].sid,
					x:_items[i].x,
					y:_items[i].y
				};
			}
			trace(JSON.stringify(result));
			var resultText:TextField = new TextField();
			resultText.text = JSON.stringify(result);
			resultText.width = resultText.textWidth + 10;
			resultText.height = resultText.textHeight + 10;
			resultText.x = 800;
			resultText.y = 800;
			addChild(resultText);
		}
		
		
		private function update(e:Event):void {
            if (_mMove) {
                _currentTarget.x = mouseX-_currentTarget.width/2;
                _currentTarget.y = mouseY-_currentTarget.height/2;
            }else {
                removeEventListener(Event.ENTER_FRAME, update);
            }
        }
		
		public function dispose():void
		{
			removeListeners();
		}
		
	}

}