package core
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class CustomButton
	{		
		public function CustomButton(content: Sprite, title: String, callback: Function)
		{
			content.buttonMode = true;
			var tfBtn: TextField = content.getChildByName('btnText') as TextField;
			tfBtn.mouseEnabled = false;
			tfBtn.text = title;						
			content.addEventListener(MouseEvent.CLICK, function(e: MouseEvent): void {
				callback();
			});
		}
	}
}