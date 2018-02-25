package Constructor 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * {sid:155,width:3,height:3,mode:0,location:0}
	 * @author ktolik
	 */
	public class ActionItem extends Sprite 
	{
		private var _settings:Object = {
			padding:4,
			color:0xE0A160,
			width:3,
			height:3,
			step:100
		};
		private var _width:int;
		private var _height:int;
		private var _location:uint;
		private var _mode:uint;
		private var _bg:Shape;
		private var _body:Shape;
		private var _mMove:Boolean = false;
		private var _horizontalPlusBttn:Button;
		private var _horizontalMinusBttn:Button;
		private var _verticalPlusBttn:Button;
		private var _verticalMinusBttn:Button;
		private var _sid:int;
		
		public function ActionItem(settings:Object) 
		{
			_sid = settings.sid;
			_width = settings['width'] * _settings.step;
			_height = settings['height'] * _settings.step;
			if (settings.height <= 1) _height = 1.25 * _settings.step;
			
			init();
			build();
		}
		
		public function dispose():void
		{
			
		}
		
		private function redrawMyself():void
		{
			if (_settings.height <= 1) _height = 1.25 * _settings.step;
			init();
			build();
		}
		
		private function init():void 
		{
			drawBody();
			drawBttns();
		}
		
		private function drawBttns():void 
		{
			if (_horizontalPlusBttn && _horizontalPlusBttn.parent) _horizontalPlusBttn.parent.removeChild(_horizontalPlusBttn);
			if (_horizontalMinusBttn && _horizontalMinusBttn.parent) _horizontalMinusBttn.parent.removeChild(_horizontalMinusBttn);
			if (_verticalPlusBttn && _verticalPlusBttn.parent) _verticalPlusBttn.parent.removeChild(_verticalPlusBttn);
			if (_verticalMinusBttn && _verticalMinusBttn.parent) _verticalMinusBttn.parent.removeChild(_verticalMinusBttn);
			
			_horizontalPlusBttn = new Button({
				caption:"+",
				onClick:function():void { 
					var width:int = _settings.width;
					if(_settings.width < 9) _settings.width = width + 1;
					_width = _settings.width * _settings.step;
					redrawMyself();
				}
			});
			
			_horizontalMinusBttn = new Button({
				caption:"-",
				onClick:function():void { 
					var width:int = _settings.width;
					if(_settings.width > 1) _settings.width = width - 1;
					_width = _settings.width * _settings.step;
					redrawMyself();
				}
			});
			
			_verticalPlusBttn = new Button({
				caption:"+",
				onClick:function():void { 
					var height:int = _settings.height;
					if(_settings.height < 9) _settings.height = height + 1;
					_height = _settings.height * _settings.step;
					redrawMyself();
				}
			});
			
			_verticalMinusBttn = new Button({
				caption:"-",
				onClick:function():void { 
					var height:int = _settings.height;
					if(_settings.height > 1) _settings.height = height - 1;
					_height = _settings.height * _settings.step;
					redrawMyself();
				}
			});
			
		}
	
		private function drawBody():void 
		{
			if (_bg && _bg.parent) _bg.parent.removeChild(_bg);
			if (_body && _body.parent) _body.parent.removeChild(_body);
			
			_bg = new Shape();
			_bg.graphics.beginFill(_settings.color, 0.2);
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_body = new Shape();
			_body.graphics.beginFill(_settings.color, 1);
			_body.graphics.drawRect(0, 0, _width - (_settings.padding*2), _height - (_settings.padding * 2));
			_body.graphics.endFill();
		}
		
		private function build():void 
		{
			addChild(_bg);
			addChild(_body);
			addChild(_horizontalPlusBttn);
			addChild(_horizontalMinusBttn);
			addChild(_verticalPlusBttn);
			addChild(_verticalMinusBttn);
			
			_body.x = (_bg.width - _body.width)/2;
			_body.y = (_bg.height - _body.height) / 2;
			
			_horizontalPlusBttn.x = width/3 * 2;
			_horizontalPlusBttn.y = height - _horizontalPlusBttn.height - 10;
			
			_horizontalMinusBttn.x = width/3;
			_horizontalMinusBttn.y = height - _horizontalMinusBttn.height - 10;
			
			_verticalPlusBttn.x = _verticalPlusBttn.width + 10;
			_verticalPlusBttn.y = height / 3;
			
			_verticalMinusBttn.x = _verticalMinusBttn.width + 10;
			_verticalMinusBttn.y = height/3 * 2;
		}
		
		public function get sid():int { return _sid; }
		public function set sid(value:int):void { _sid = value; }
	}

}