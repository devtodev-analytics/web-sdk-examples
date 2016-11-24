package core
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CustomCheckBox
	{
		private static const  STATE_ACTIVE: int = 1;
		private static const  STATE_NOT_ACTIVE: int = 2;
		
		private var _content: MovieClip;
		private var _flag: Boolean = false;
		private var _callback: Function = null;
		private var _alias: String = '';
		private var _radiobutton: Boolean = false;
		
		public function CustomCheckBox(content: MovieClip, callback: Function = null)
		{
			this._content = content;
			this._render();
			content.addEventListener(MouseEvent.CLICK, _click);
			content.buttonMode = true; 
			this._callback = callback;
		}
		public function set alias(value: String): void 
		{
			this._alias = value;	
		}
		
		public function get alias(): String
		{
			return this._alias;
		}
		
		public function set flag(value: Boolean): void
		{
			this._flag = value;
			this._render();
		}
		
		public function set radiobutton(value: Boolean): void
		{
			this._radiobutton = value;
		}
		
		public function get flag(): Boolean
		{
			return this._flag
		}
			
		private function _click(e: MouseEvent): void 
		{
			var oldValue: Boolean = this.flag;
			this.flag = this._radiobutton ? true : !this.flag; 
			if(this._callback !== null && oldValue != this.flag) {
				this._callback(this);
			}
		}
	
		private function _render(): void
		{
			if(this._flag) {
				this._content.gotoAndStop(STATE_NOT_ACTIVE);
			} else {
				this._content.gotoAndStop(STATE_ACTIVE);
			}
		}
		
	}
}