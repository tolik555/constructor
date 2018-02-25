package Constructor
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ktolik
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.color = 0xFBCA0B;
			
			var _constructorWindow:ConstructorWindow = new ConstructorWindow();
			addChild(_constructorWindow);
		}
		
	}
	
}