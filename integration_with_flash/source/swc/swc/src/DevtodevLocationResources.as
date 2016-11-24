package
{
	public class DevtodevLocationResources
	{
		public var spent: Vector.<DevtodevCurrencyAmount> = new Vector.<DevtodevCurrencyAmount>();
		public var earned: Vector.<DevtodevCurrencyAmount> = new Vector.<DevtodevCurrencyAmount>();
		
		public var requestParams: Object = {
			success: false
		};
		
		public function DevtodevLocationResources()
		{
		}
		
		public function set difficulty(value: int): void {
			this.requestParams['difficulty'] = value
		}
		
		public function set source(value: String): void {
			this.requestParams['source'] = value
		}
		
		public function set success(value: Boolean): void {
			this.requestParams['success'] = value
		}
		
		public function set duration(value: int): void {
			this.requestParams['duration'] = value
		}
		
		public function get params(): Object {
			var params: Object = this.requestParams;
			params['spent'] = this.spent;
			params['earned'] = this.earned;
			return params
		}
	}
}