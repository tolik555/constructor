package Constructor 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ktolik
	 */
	public class Backings 
	{
		public static function showBorders(sprite:Sprite,color:Number = 0x808080):void
		{
			var dot:Shape = new Shape();
			dot.graphics.beginFill(0xff0000);
			dot.graphics.drawCircle(0, 0, 3);
			dot.graphics.endFill();
			
			var bounds:Rectangle = sprite.getBounds(sprite);
			
			var boudsShape:Shape = new Shape();
			boudsShape.graphics.beginFill(color, 0.2);
			boudsShape.graphics.drawRect(0, 0, bounds.width, bounds.height);
			boudsShape.graphics.endFill();
			boudsShape.x = bounds.x;
			boudsShape.y = bounds.y;
			sprite.addChild(boudsShape);
			
			dot.x = bounds.x;
			dot.y = bounds.y;
			sprite.addChild(dot);
		}
		
		public static function getShape(width:int,height:int,color:Number = 0x000000,x:int = 0,y:int = 0):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color, 1);
			shape.graphics.drawRoundRect(x, y, width, height, 10);
			shape.graphics.endFill();
			return shape;
		}
	}

}