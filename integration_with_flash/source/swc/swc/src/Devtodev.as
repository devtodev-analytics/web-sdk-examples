package
{
	import flash.display.Stage;
	import flash.events.FullScreenEvent;
	import flash.external.ExternalInterface;

	public class Devtodev
	{
		private var _stage: Stage;
		private static var _instance: Devtodev;
		
		private var _user: DevtodevUser;
		
		static public function get instance():Devtodev
		{
			return _instance;
		}
		
		public function Devtodev(stage : Stage)
		{		
			if(!_instance){
				_instance = this;
				this._stage = stage;	
				this._user = new DevtodevUser();
				if(ExternalInterface.available) {
					this._stage.addEventListener(FullScreenEvent.FULL_SCREEN, _onFullScreen);	
				} else {
					trace('External interface is not available for this container.');
				}	
			} 
		}
		
		public function get user():DevtodevUser {
			return this._user;
		}
		
		private function _onFullScreen(eFs: FullScreenEvent): void
		{
			this._setFullScreenMode(eFs.fullScreen);
		}
		
		/**
		 * @param {string} apiKey - devtodev API key, unique API key can be found in the application settings (“My apps” → App Name → “Settings” → “Integration”)
		 * @param {string} userId - Unique user identifier. For example, user’s ID in a social network, or a unique account name used for user identification on your server.
		 */
		public function init(apiKey: String, userId: String, prevUserId: String): void 
		{
			try {
				ExternalInterface.call('devtodev.init', apiKey, userId, prevUserId);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Full-screen view status
		 * @param {boolean} status - set true when the app switches to the full-screen mode, set false in other case
		 */
		private function _setFullScreenMode(status: Boolean): void 
		{
			try {
				ExternalInterface.call('devtodev.setFullScreenMode', status);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * @param {Object} userData - User data object.
		 * @param {int} userData.currentLevel - Сurrent game level of the player. Required if level feature used in the app.
		 * @param {boolean} userData.cheater - Set true if you know the user is cheater and you wouldn’t like his payments to be included to statistics. Optional.
		 * @param {int} userData.age - User’s age. Optional.
		 * @param {int} userData.gender - User’s gender. (0 - Unknown, 1 - Male, 2 - Female). Optional.
		 * @param {Object} userData.custom - User’s custom data. Optional.
		 */
		public function setUserData(userData: Object): void 
		{
			try {
				ExternalInterface.call('devtodev.setUserData', userData);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * @param {Object} appData - App data object.
		 * @param {string} appData.appVersion - Current app version. Required.
		 * @param {int} appData.codeVersion - Current code version. Optional.
		 */
		public function setAppData(appData: Object): void 
		{
			try {
				ExternalInterface.call('devtodev.setAppData', appData);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * The event allowing to track the stage of tutorial a player is on.
		 * @param {int} tutorialStep - the latest successfully completed tutorial step.
		 * Use special values to record base evetns of the tutorial:
		 * -1 - Start the tutorial (at the beginning, before the first step is completed)
		 * -2 - Tutorial finished (instead of the last step number)
		 *  0 - Tutorial skipped (if user skipped the tutorial).
		 * In other cases use step numbers. Make sure you use numbers above 0 numerating the steps.
		 */
		public function tutorialCompleted(tutorialStep: int): void 
		{
			try {
				ExternalInterface.call('devtodev.tutorialCompleted', tutorialStep);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * @param {number} level - player/character's "level"
		 * @param {Object} resources - Object with data about currencies. Optional.
		 * @param {Object[]} resources.balance -  Account balance of in-game currency by the end of level. Optional. 
		 * @param {Object[]} resources.balance[].currency - Game currency name
		 * @param {Object[]} resources.balance[].amount - Game currency amount
		 * @param {Object[]} resources.earned - Game currency earned during the level. Optional. 
		 * @param {Object[]} resources.earned[].currency - Game currency name
		 * @param {Object[]} resources.earned[].amount - Game currency amount 
		 * @param {Object[]} resources.spent - Game currency amount spent during the level. Optional.
		 * @param {Object[]} resources.spent[].currency - Game currency name
		 * @param {Object[]} resources.spent[].amount - Game currency amount 
		 * @param {Object[]} resources.bought - Game currency amount bought during the level. Optional.
		 * @param {Object[]} resources.bought[].currency - Game currency name
		 * @param {Object[]} resources.bought[].amount - Game currency amount 
		 */
		public function levelUp(level: int, resources: DevtodevLevelUpResources = null): void 
		{
			try {
				ExternalInterface.call('devtodev.levelUp', level, resources);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Sends event packet immediately
		 */
		public function sendBufferedEvents(): void 
		{
			try {
				ExternalInterface.call('devtodev.sendBufferedEvents');
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Activates console log
		 * @param {boolean} status
		 */
		public function setDebugLog(status: Boolean): void 
		{
			try {
				ExternalInterface.call('devtodev.setDebugLog', status);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Register transactions made through the platform's payment system.
		 *
		 * @param {string} transactionId - transaction ID
		 * @param {Number} productPrice - product price (in user's currency)
		 * @param {string} productName - product name
		 * @param {string} transactionCurrencyISOCode - transaction currency (ISO 4217 format)
		 */
		public function realPayment(transactionId: String, productPrice: Number, productName: String, transactionCurrencyISOCode: String): void 
		{
			try {
				ExternalInterface.call('devtodev.realPayment', transactionId, productPrice, productName, transactionCurrencyISOCode);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Tracks the existence of a connection with a social network.
		 * Use pre-defined or custom values as an identifier.
		 * @param {string} socialNetwork - social network id (max. 24 symbols)
		 **/
		public function socialNetworkConnect(socialNetwork: String): void 
		{
			try {
				ExternalInterface.call('devtodev.socialNetworkConnect', socialNetwork);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Tracks the existence of posts to a social network.
		 * @param {string} socialNetwork - social network Id (max. 24 symbols)
		 * @param {string} reason - the reason of posting (max. 32 symbols)
		 */
		public function socialNetworkPost(socialNetwork: String, reason: String): void 
		{
			try {
				ExternalInterface.call('devtodev.socialNetworkPost', socialNetwork, reason);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Tracks in-app purchases.
		 *
		 * @param {string} purchaseId - unique purchase Id (max. 32 symbols)
		 * @param {string} purchaseType - purchase type or group (max. 96 symbols)
		 * @param {int} purchaseAmount - count of purchased goods
		 * @param {Object[]} purchasePrice - array including the names and amounts of the paid currencies (total cost - if several goods were purchased)
		 * @param {string} purchasePrice[].currency - game currency name
		 * @param {number} purchasePrice[].amount - currency amount
		 */
		public function inAppPurchase(purchaseId:String, purchaseType: String, purchaseAmount: int, purchasePrice: Vector.<DevtodevCurrencyAmount>): void 
		{
			try {
				ExternalInterface.call('devtodev.inAppPurchase', purchaseId, purchaseType, purchaseAmount, purchasePrice);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Tracks custom events.
		 * @param {string} eventName - event name (max. 72 symbols)
		 * @param {Object[]} params - array of event parameters. Up to 10 params.
		 * @param {string} params[].name - parameter name (max. 32 symbols)
		 * @param {string} params[].type - parameter value type. Can be "date", "double" or "string".
		 * @param {string|number} params[].value - parameter value. (max. 255 symbols)
		 */
		public function customEvent(eventName: String, params: Vector.<DevtodevCustomEventParam> = null): void 
		{
			try {
				ExternalInterface.call('devtodev.customEvent', eventName, params);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Activates console log
		 * @param {boolean} status
		 */
		public function startSession(): void 
		{
			try {
				ExternalInterface.call('devtodev.startSession');
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * @param {string} userId - Unique user identifier. For example, user’s ID in a social network, or a unique account name used for user identification on your server.
		 */
		public function replaceUserId(newUserId: String): void 
		{
			try {
				ExternalInterface.call('devtodev.replaceUserId', newUserId);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Initializes the user with the specified cross-platform identificator
		 * @param {string} сrossplatformUserId - unique cross-platform user ID used
		 * for user identification on your server.
		 */
		public function setCrossplatformUserId(crossplatformUserId: String): void 
		{
			try {
				ExternalInterface.call('devtodev.setCrossplatformUserId', crossplatformUserId);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * Replaces current cross-platform user id
		 * Attention! Don't use this method if you're going to perform the user's relogin.
		 * @param {string} newCrossPlatformID - new cross-platform user ID
		 */
		public function replaceCrossplatformUserId(newCrossPlatformID: String): void 
		{
			try {
				ExternalInterface.call('devtodev.replaceCrossplatformUserId', newCrossPlatformID);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * The method have to be used when entering the location.
		 * @param {string} locationName - the name of location user entered.
		 * @param {Object} startParams - location parameters object
		 */
		public function startProgressionEvent(locationId: String, params: DevtodevLocationResources): void 
		{
			try {
				ExternalInterface.call('devtodev.startProgressionEvent', locationId, params.params);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
		
		/**
		 * The method have to be used when the location passing is over.
		 * @param {string} locationName - the name of location user left.
		 * @param {Object} endParams - location parameters object
		 */
		public function endProgressionEvent(locationId: String, params: DevtodevLocationResources): void 
		{
			try {				
				ExternalInterface.call('devtodev.endProgressionEvent', locationId, params.params);
			} catch (error:Error) {
				trace("An Error occurred: " + error.message + "\n");
			}
		}
	}
}