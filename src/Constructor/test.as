package Constructor   
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    /**
     * ...
     * @author Atoris
     */
    public class test extends Sprite
    {
        private var _cage:Sprite; 
        private var _grid:Sprite;
        private var _arrCage:Vector.<Sprite>; // массив клеточек(тип Sprite)
        private var _mouseCage:Sprite;
        private var _mMove:Boolean = false;
        private var _testGrid:Boolean = false; // если true то проверка идет по координатам сетки, false проверка по клеткам 
        
        private const CW:int = 32; // размер клетки
        private const SW:int = 640; //ширина экрана
        private const SH:int = 480; // высота экрана
        
        public function test() 
        {
            _arrCage = new Vector.<Sprite>();
            addCage();
            addMouseCage();
            _mouseCage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
            
        }
        // если зажали клавишу мышки
        private function mDown(e:MouseEvent):void {
            _mMove = true;
            addEventListener(Event.ENTER_FRAME, update);
            _mouseCage.addEventListener(MouseEvent.MOUSE_UP, mUp);
        }
        // если отпустили клавишу мышки
        private function mUp(e:MouseEvent):void {
            _mMove = false;
            // проверка  
            if (!_testGrid) {
                // проверка элементо массива
                for (var i:int = 0; i < _arrCage.length; i++) {
                    //сама проверка
                    if (_arrCage[i].hitTestPoint(_mouseCage.x+_mouseCage.width/2,_mouseCage.y+_mouseCage.height/2,true)) {
                        _mouseCage.x = _arrCage[i].x;
                        _mouseCage.y = _arrCage[i].y;
                    }
                }
            }else {
                // проверка по координатам
                
                // тут мы проверяем координаты квадрата, незнаю как написать
                // если остача квадрата по х меньше ширины сетки(16) 
                if (e.target.x % CW < CW/2) {
                    e.target.x = int(e.target.x / CW) * CW;
                }
                else {
                    e.target.x = int(e.target.x / CW) * CW+CW;
                }
                
                if (e.target.y % CW < CW/2) {
                    e.target.y = int(e.target.y / CW) * CW;
                }else {
                    e.target.y = int(e.target.y / CW) * CW+CW;
                }
            }
            
        }
        // функция движения красного квадрата за мышкой
        private function update(e:Event):void {
            if (_mMove) {
                _mouseCage.x = mouseX-_mouseCage.width/2;
                _mouseCage.y = mouseY-_mouseCage.height/2;
            }else {
                removeEventListener(Event.ENTER_FRAME, update);
            }
        }
        // рисуем красный квадрат
        private function addMouseCage():void {
            _mouseCage = new Sprite();
            _mouseCage.graphics.beginFill(0xff0000);
            _mouseCage.graphics.drawRect(0, 0, CW, CW);
            _mouseCage.graphics.endFill();
            addChild(_mouseCage);
        }
        
        // рисуем и добавляем клетки на сцену или сетку
        
        private function addCage():void {
            
            if (!_testGrid) {
                //клетки
                for (var i:int = 0; i < SW/CW; i++) 
                {
                    for (var j:int = 0; j < SH/CW; j++) 
                    {
                        
                        _cage = new Sprite();
                        _cage.graphics.lineStyle(1, 0x000000);
                        _cage.graphics.beginFill(0xffffff);
                        _cage.graphics.drawRect(0, 0, CW, CW);
                        _cage.graphics.endFill();
                        _cage.x = CW * i;
                        _cage.y = CW * j;
                        addChild(_cage);
                        _arrCage.push(_cage);// добавляем каждую клетку в массив
                    }
                }
            }else {
                //сетка
                _grid = new Sprite();
                _grid.graphics.clear();
                _grid.graphics.lineStyle(1, 0x000000);
                
                for (i = 0; i < SW/CW+1; i++) 
                {
                    for (j = 0; j < SH/CW+1; j++) 
                    {
                        
                        _grid.graphics.moveTo(i * CW, 0);
                        _grid.graphics.lineTo(i * CW, CW * SH/CW);
                        _grid.graphics.moveTo(0, j * CW);
                        _grid.graphics.lineTo(CW * SW/CW, j * CW);
                        
                    }
                }
                addChild(_grid);
            }
            
        }
        
        
    }
 
}