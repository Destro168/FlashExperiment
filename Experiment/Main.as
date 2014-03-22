/*

Aww ysss.

Copyright DestroTheGod aka Donny The Don Man McGee.

*/

package
{
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	
	//import flash.display.Stage;
	
	public class Main extends MovieClip
	{
		public static const PIXEL_SIZE:int = 16;
		public static const HERO_LAYER:int = 1;
		
		// Objects.
		private var hero:Hero;
		private var grass:Grass;
		
		// Hero positions
		var lastX:int = 0;
		var lastY:int = 0;
		
		public function Main()
		{
			
		}
		
		// Add tiled grass.
		public function addGrass():void
		{
			var tileLayer:Sprite = new Sprite();
			var bgClip:MovieClip = new Grass();
			
			var i:int = 0;
			var j:int = 0;
			
			while(bgClip.x < stage.stageWidth) 
			{
				bgClip = new Grass();
				while (bgClip.y < stage.stageHeight) 
				{
					bgClip = new Grass();
					tileLayer.addChild(bgClip);
					bgClip.x = bgClip.width * i;
					bgClip.y = bgClip.height * j;
		
					j++;
				}
				
				j = 0;
				i++;
			}
			
			addChildAt(tileLayer, 0);
		}
		
		var heroLayer:Sprite;
		
		// Added hero.
		public function addHero(x:int, y:int):void
		{
			heroLayer = new Sprite();
			var hero:MovieClip = new Hero();
			
			heroLayer.addChild(hero);
			
			hero.x = x;
			hero.y = y;
			
			lastX = x;
			lastY = y;
			
			addChildAt(heroLayer, HERO_LAYER);
		}
		
		var leftKeyDown:Boolean;
		var upKeyDown:Boolean;
		var rightKeyDown:Boolean;
		var downKeyDown:Boolean;
		
		var mutexLockDown:Boolean;
		
		function flipMutex():void
		{
			mutexLockDown = !mutexLockDown;
		}
		
		function checkKeysDown(event:KeyboardEvent):void
		{
			if (mutexLockDown)
				return;
			
			//making the booleans true based on the keycode
			//WASD Keys or arrow keys
			if(event.keyCode == 37 || event.keyCode == 65){
				leftKeyDown = true; flipMutex();
			}
			if(event.keyCode == 38 || event.keyCode == 87){
				upKeyDown = true; flipMutex();
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = true; flipMutex();
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				downKeyDown = true; flipMutex();
			}
		}
		
		//this listener will listen for keys being released
		function checkKeysUp(event:KeyboardEvent):void
		{
			//making the booleans false based on the keycode
			if(event.keyCode == 37 || event.keyCode == 65){
				leftKeyDown = false; flipMutex();
			}
			if(event.keyCode == 38 || event.keyCode == 87){
				upKeyDown = false; flipMutex();
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = false; flipMutex();
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				downKeyDown = false; flipMutex();
			}
		}
		
		public function movechar(event:Event):void
		{
			//trace(leftKeyDown);
			// Variable Declarations
			var success:Boolean = false;
			var x:int = lastX;
			var y:int = lastY;
			
			// Check different key inputs to move hero.
			if (leftKeyDown)
			{
				x -= PIXEL_SIZE;
				success = true;
				leftKeyDown = false;
			}
			else if (upKeyDown)
			{
				y -= PIXEL_SIZE;
				success = true;
				upKeyDown = false;
			}
			else if (rightKeyDown)
			{
				x += PIXEL_SIZE;
				success = true;
				rightKeyDown = false;
			}
			else if (downKeyDown)
			{
				y += PIXEL_SIZE;
				success = true;
				downKeyDown = false;
			}
			
			// If successful, then we want to remove the hero.
			if (success)
			{
				removeChildAt(1);
				addHero(x,y);
			}
		}
		
		public function startGame():void
		{
			// Load grass/hero sprites.
			addGrass();
			addHero(PIXEL_SIZE, PIXEL_SIZE);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
			addEventListener(Event.ENTER_FRAME, movechar);
		}
	}
}