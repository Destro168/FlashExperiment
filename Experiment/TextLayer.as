package  
{
	public class TextLayer 
	{
		public var position:int;
		public var isOpen:Boolean;
		public var xLoc:int;
		public var yLoc:int;
		public var msg:String;
		
		public function TextLayer(position_:int, isOpen_:Boolean, xLoc_:int, yLoc_:int)
		{
			position = position_;
			isOpen = isOpen_;
			xLoc = xLoc_;
			yLoc = yLoc_;
			msg = "";
		}
	}
}
