package
{
	import flash.external.ExternalInterface;
	
	public class DevtodevUser
	{
		public function DevtodevUser() {}
		
		/**
		 * Track's user's age
		 * @param {int} age - User’s age.
		 */
		public function age(value: int): void 
		{
			this._send('devtodev.user.age', value);
		}
		
		/**
		 * Track's user's cheater flag
		 * @param {boolean} cheater - Set true if you know the user is cheater and you wouldn’t like his payments to be included to statistics.
		 */
		public function cheater(value: Boolean): void 
		{
			this._send('devtodev.user.cheater', value);
		}
		
		/**
		 * Track's user's gender
		 * @param {int} gender - User’s gender. (0 - Unknown, 1 - Male, 2 - Female).
		 */
		public function gender(value: int): void 
		{
			this._send('devtodev.user.gender', value);
		}
		
		/**
		 * Track's user's name
		 * @param {String} name - User’s name.
		 */
		public function name(value: String): void 
		{
			this._send('devtodev.user.name', value);
		}
		
		/**
		 * Track's user's e-mail
		 * @param {String} email - User’s e-mail.
		 */
		public function email(value: String): void 
		{
			this._send('devtodev.user.email', value);
		}
		
		/**
		 * Track's user's phone number
		 * @param {string} phone_number - User’s phone number.
		 */
		public function phone(value: String): void 
		{
			this._send('devtodev.user.phone', value);
		}
		
		/**
		 * Track's user's gender
		 * @param {int} gender - User’s gender. (0 - Unknown, 1 - Male, 2 - Female).
		 */
		public function photo(value: String): void 
		{
			this._send('devtodev.user.photo', value);
		}
		
		/*
		* Set properties on a user data.
		*
		* ### Usage:
		*     devtodev.user.set('Hair color', 'copper red');
		*
		*     // to set multiple properties at once
		*     devtodev.user.set({
		*         'Hair color': 'blonde',
		*			'Last payment': 100;
		*			'Last order': ['Coloring','Hair Straightening'],
		*         'Order date': new Date()
		*     });
		*     // properties can be strings, integers, dates, or lists
		*
		* @param {Object|String} prop If a string, this is the name of the property. If an object, this is an associative array of names and values.
		* @param {*} [val] A value to set on the given property
		*/
		public function set(... args): void 
		{
			args.unshift('devtodev.user.set');
			this._send.apply(null, args);
		}
		
		/*
		* Set properties on a user data.
		*
		* ### Usage:
		*     devtodev.user.set('Hair color', 'copper red');
		*
		*     // to set multiple properties at once
		*     devtodev.user.set({
		*         'Hair color': 'blonde',
		*			'Last payment': 100;
		*			'Last order': ['Coloring','Hair Straightening'],
		*         'Order date': new Date()
		*     });
		*     // properties can be strings, integers, dates, or lists
		*
		* @param {Object|String} prop If a string, this is the name of the property. If an object, this is an associative array of names and values.
		* @param {*} [val] A value to set on the given property
		*/
		public function increment(...args): void 
		{
			args.unshift('devtodev.user.increment');
			this._send.apply(null, args);
		}
		
		/*
		* Removes properties from a user data.
		*
		* ### Usage:
		*     devtodev.user.remove('Hair color');
		*
		*     // to set multiple properties at once
		*     devtodev.user.removeProp(['Hair color', 'blonde', 'Last payment']});
		*
		* @param {Array|String} prop If a string, this is the name of the property. If an array, this is an array of names.
		*/
		public function remove(value:*): void 
		{
			this._send('devtodev.user.remove', value);
		}
		
		/*
		* Removes all user's personal data from devtodev data base.
		*/
		public function deleteUser(): void 
		{
			this._send('devtodev.user.clearUser');
		}
		
		private function _send(method: String, ... args): void 
		{
			try {
				args.unshift(method);
				ExternalInterface.call.apply(null, args);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
	}
}