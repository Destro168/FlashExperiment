/*

Aww ysss.

Copyright DestroTheGod aka Donny The Don Man McGee.

*/

package
{
	import TextLayer;
	
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
    import flash.text.engine.*; 
	//import flash.display.Stage;
	
	public class Main extends MovieClip
	{
		// Constants
		public static const PIXEL_SIZE:int = 32;
		public static const HERO_LAYER:int = 1;
		public static const ENEMY_LAYER:int = 2;
		
		private var textArray:Array;
		
		// Objects.
		private var grass:Grass;
		private var heroLayer:Sprite;
		private var enemyLayer:Sprite;
		
		// Key states
		private var leftKeyDown:Boolean;
		private var upKeyDown:Boolean;
		private var rightKeyDown:Boolean;
		private var downKeyDown:Boolean;
		
		// Hero positions
		private var lastX:int = 0;
		private var lastY:int = 0;
		private var lastEnemyX:int = 0;
		private var lastEnemyY:int = 0;
		
		public function Main() { }
		
		/* ------------------------------
		>> Text Functions
		------------------------------ */
		
		public function getTextLine(textMessage:String):TextLine
		{
			// Generate text string. 
			var format:ElementFormat = new ElementFormat(); 
            var textElement:TextElement = new TextElement(textMessage, format); 
            var textBlock:TextBlock = new TextBlock(); 
            textBlock.content = textElement; 
            var textLine1:TextLine = textBlock.createTextLine(null, 300); 
			
			return textLine1;
		}
		
		// Text example.
		public function standardTextMessage(textMessage:String):void
        {
			// Variable Declarations/Initializations
            var textLine1:TextLine = getTextLine(textMessage);
			var success:Boolean = false;
			
			// Attempt to add text to any free open text layer. If there is success, set success to true.
			for (var i:int = 0; i < 5; i++)
			{
				if (textArray[i].isOpen == true)
				{
					addChildAt(textLine1, textArray[i].position);
					textLine1.x = textArray[i].xLoc;
					textLine1.y = textArray[i].yLoc;
					
					// Store text and set position to closed.
					textArray[i].msg = textMessage;
					textArray[i].isOpen = false;
					
					success = true;
					break;
				}
			}
			
			// If there wasn't a free spot open, then we want to shift all text up and add new one to the start.
			if (!success)
			{
				// Shift all text up.
				for (var j:int = 4; j > -1; j--)
				{
					trace(j);
					
					removeChildAt(textArray[j].position);
					
					var textLine2:TextLine;
					
					if (j != 0)
					{
						textLine2 = getTextLine(textArray[j-1].msg);
						textArray[j].msg = textArray[j-1].msg;
					}
					else
					{
						textLine2 = textLine1;
						textArray[j].msg = textMessage;
					}
					
					addChildAt(textLine2, textArray[j].position);
					textLine2.x = textArray[j].xLoc;
					textLine2.y = textArray[j].yLoc;
				}
				
				/*
				// Remove first index.
				removeChildAt(textArray[0].position);
				
				// Add new text.
				addChildAt(textLine1, textArray[0].position);
				textLine1.x = textArray[0].xLoc;
				textLine1.y = textArray[0].yLoc;
				
				// Store text and set position to closed.
				textArray[0].msg = textMessage;
				*/
			}
        } 
		
		/* ------------------------------
		>> Unit Functions
		------------------------------ */
		
		// Adds hero.
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
		
		function addEnemy(x:int, y:int):void
		{
			enemyLayer = new Sprite();
			var enemy:MovieClip = new Diamond();
			
			enemyLayer.addChild(enemy);
			
			enemy.x = x;
			enemy.y = y;
			
			lastEnemyX = x;
			lastEnemyY = y;
			
			addChildAt(enemyLayer, ENEMY_LAYER);
		}
		
		/* ------------------------------
		>> Enviroment Functions
		------------------------------ */
		
		// Add tiled grass.
		public function addGrass():void
		{
			var tileLayer:Sprite = new Sprite();
			var bgClip:MovieClip = new Grass();
			
			var i:int = 0;
			var j:int = 0;
			
			while(bgClip.x < stage.stageWidth - PIXEL_SIZE) 
			{
				bgClip = new Grass();
				while (bgClip.y < stage.stageHeight - PIXEL_SIZE*5) 
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
			
			/*
			for (var i:int = 0; bgClip.x < stage.stageWidth; i++)
			{
				bgClip = new Grass();
				for (var j:int = 0; bgClip.x < stage.stageWidth; j++)
				{
					bgClip = new Grass();
					tileLayer.addChild(bgClip);
					bgClip.x = bgClip.width * i;
					bgClip.y = bgClip.height * j;
				}
			}
			*/
			
			addChildAt(tileLayer, 0);
		}
		
		/* ------------------------------
		>> Event Functions
		------------------------------ */
		
		// Listens for key releases and tracks that information.
		function checkKeysDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 37 || event.keyCode == 65)
			{
				leftKeyDown = true;
				standardTextMessage("You have moved left.");
			}
			if(event.keyCode == 38 || event.keyCode == 87){
				upKeyDown = true;
				standardTextMessage("You have moved up.");
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = true;
				standardTextMessage("You have moved right.");
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				downKeyDown = true;
				standardTextMessage("You have moved down.");
			}
		}
		
		// Listens for key releases and tracks that information.
		function checkKeysUp(event:KeyboardEvent):void
		{
			if(event.keyCode == 37 || event.keyCode == 65){
				leftKeyDown = false;
			}
			if(event.keyCode == 38 || event.keyCode == 87){
				upKeyDown = false;
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				rightKeyDown = false;
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				downKeyDown = false;
			}
		}
		
		/* ------------------------------
		>> General Functions
		------------------------------ */
		
		// Handles hero movement.
		public function movechar(event:Event):void
		{
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
			
			// If a key has been pressed, remove hero replace sprite at new location.
			if (success)
			{
				removeChildAt(1);
				addHero(x,y);
			}
		}
		
		/* ------------------------------
		>> Main Start Function
		------------------------------ */
		
		public function startGame():void
		{
			var a:TextLayer = new TextLayer(3, true, 6, stage.stageHeight - 6);
			var b:TextLayer = new TextLayer(4, true, 6, stage.stageHeight - PIXEL_SIZE - 6);
			var c:TextLayer = new TextLayer(5, true, 6, stage.stageHeight - PIXEL_SIZE * 2 - 6);
			var d:TextLayer = new TextLayer(6, true, 6, stage.stageHeight - PIXEL_SIZE * 3 - 6);
			var e:TextLayer = new TextLayer(7, true, 6, stage.stageHeight - PIXEL_SIZE * 4 - 6);
			
			textArray = new Array(a,b,c,d,e);
			
			// Load grass/hero sprites.
			addGrass();
			addHero(PIXEL_SIZE, PIXEL_SIZE);
			addEnemy(PIXEL_SIZE*8, PIXEL_SIZE*8);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
			addEventListener(Event.ENTER_FRAME, movechar);
		}
	}
}