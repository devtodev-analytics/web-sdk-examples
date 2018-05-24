package
{	
	import core.CustomButton;
	import core.CustomCheckBox;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	public class Main extends Sprite
	{
		[Embed(source = '/assets/interface.swf', symbol = 'main')] 
		private var _main:Class;
		
		public static const DEDAULT_WIDTH:int = 520; 
		public static const DEDAULT_HEIGHT:int = 500;
		
		private var devtodev: Devtodev;		
		private var _btnFullScreen: MovieClip;
		
		public var canvas:Sprite 	= new Sprite();
		private var _checkboxes: Array = new Array();
			
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, ready);
		}
		
		public function ready(e:Event = null):void
		{
			stage.frameRate = 12;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			devtodev = new Devtodev(stage);			
			canvas = new _main();
			addChild(canvas); 
			Security.allowDomain("*");
			stage.dispatchEvent(new Event(Event.DEACTIVATE));
			stage.dispatchEvent(new Event(Event.ACTIVATE));	
			this._initFullscreen(canvas.getChildByName('btnFullScreen') as MovieClip);
			
			var sprite: Sprite = canvas.getChildByName('initBlock') as Sprite;
			this._initSdk(sprite);
			sprite = canvas.getChildByName('btnStartSession') as Sprite
			this._initStartSession(sprite);
			this._initUserInfo(canvas.getChildByName('blockUserInfo') as Sprite);
			this._initDeviceInfo(canvas.getChildByName('blockDeviceInfo') as Sprite);
			this._initTutorialCompleted(canvas.getChildByName('blockTutorial') as Sprite);
			this._initLevelUp(canvas.getChildByName('blockLevel') as Sprite);	
			this._initSocialNetworkConnect(canvas.getChildByName('btnSocialConn') as Sprite);
			this._initSocialNetworkPost(canvas.getChildByName('btnSocalPost') as Sprite);		
			this._initSendBufferedEvents(canvas.getChildByName('btnSendBuffer') as Sprite);
			this._initInAppPurchase(canvas.getChildByName('blockInAppPurchase') as Sprite);
			this._initCustomEvents(canvas.getChildByName('blockCustomEvents') as Sprite);
			this._initRealPayment(canvas.getChildByName('btnRealPayment') as Sprite);
			this._initCrossUid(canvas.getChildByName('blockCuid') as Sprite);	
			this._initUserCard(canvas.getChildByName('userCard') as Sprite);
			this._initLocation(canvas.getChildByName('blockLocation') as Sprite);		
			this._initServiceSetting(canvas.getChildByName('serviceSetting') as Sprite);
		}
		
		private function _initServiceSetting(content: Sprite): void {
			var trakingStatusCheckBox: CustomCheckBox = new CustomCheckBox(content.getChildByName('btnCheckTrakingStatus') as MovieClip);
			new CustomButton(content.getChildByName('btnSendTrakingStatus') as Sprite, 'Send', function(): void {
				devtodev.setTrackingAvailability(trakingStatusCheckBox.flag);
			});
		}
		
		private function _initLocation(content: Sprite): void {
			var textInputLocationId: TextField = content.getChildByName('textLocationId') as TextField;
			new CustomButton(content.getChildByName('btnStartLocation') as Sprite, 'Start Progression Event', function(): void {
				var params: DevtodevLocationResources = new DevtodevLocationResources();
				params.spent.push(new DevtodevCurrencyAmount('piasters', 1000));
				params.spent.push(new DevtodevCurrencyAmount('gold', 14));		
				params.earned.push(new DevtodevCurrencyAmount('gold', 14));
				params.difficulty = 2;		
				params.duration = 5;
				params.source = 'last location';
				devtodev.startProgressionEvent(textInputLocationId.text, params);				
			});	
			new CustomButton(content.getChildByName('btnEndLocation') as Sprite, 'End Progression Event', function(): void {
				var params: DevtodevLocationResources = new DevtodevLocationResources();
				params.spent.push(new DevtodevCurrencyAmount('piasters', 1000));
				params.spent.push(new DevtodevCurrencyAmount('gold', 14));		
				params.earned.push(new DevtodevCurrencyAmount('piasters', 1000));
				params.earned.push(new DevtodevCurrencyAmount('gold', 20));
				devtodev.endProgressionEvent(textInputLocationId.text, params);				
			});
		}
		
		private function _initUserCard(content: Sprite): void {
			var textInputAge: TextField = content.getChildByName('textInputAge') as TextField;			
			textInputAge.restrict = '[1-9]';
			new CustomButton(content.getChildByName('btnAge') as Sprite, 'Send', function(): void {
				devtodev.user.age(parseInt(textInputAge.text));
			});
			
			var textInputGender: TextField = content.getChildByName('textInputGender') as TextField;
			new CustomButton(content.getChildByName('btnGender') as Sprite, 'Send', function(): void {
				devtodev.user.gender(parseInt(textInputGender.text));
			});	
			var textInputName: TextField = content.getChildByName('textInputName') as TextField;
			new CustomButton(content.getChildByName('btnName') as Sprite, 'Send', function(): void {
				devtodev.user.name(textInputName.text);
			});	
			var textInputEmail: TextField = content.getChildByName('textInputEmail') as TextField;
			new CustomButton(content.getChildByName('btnEmail') as Sprite, 'Send', function(): void {
				devtodev.user.email(textInputEmail.text);
			});	
			var textInputPhoto: TextField = content.getChildByName('textInputPhoto') as TextField;
			new CustomButton(content.getChildByName('btnPhoto') as Sprite, 'Send', function(): void {
				devtodev.user.photo(textInputPhoto.text);
			});	
			var textInputPhone: TextField = content.getChildByName('textInputPhone') as TextField;
			new CustomButton(content.getChildByName('btnPhone') as Sprite, 'Send', function(): void {
				devtodev.user.phone(textInputPhone.text);
			});	
			new CustomButton(content.getChildByName('btnDeleteUser') as Sprite, 'Delete user', function(): void {
				devtodev.user.deleteUser();
			});	
			var cheaterCheckBox: CustomCheckBox = new CustomCheckBox(content.getChildByName('checkCheater') as MovieClip);	
			new CustomButton(content.getChildByName('btnCheater') as Sprite, 'Send', function(): void {
				devtodev.user.cheater(cheaterCheckBox.flag);
			});	
			var checkeds: Array = [
					{alias: 'set', mc: 'checkSet', flag: true},
					{alias: 'inc', mc: 'checkInc', flag: false},
					{alias: 'remove', mc: 'checkRemove', flag: false}
				],				
				checkBoxTemp: CustomCheckBox,
				row: Object;
			for (var i:String in checkeds) 
			{ 
				row = checkeds[i];
				checkBoxTemp = new CustomCheckBox(content.getChildByName(row.mc) as MovieClip, _clickCheckboxUserCard); 
				checkBoxTemp.alias = row.alias;
				checkBoxTemp.flag = row.flag;
				checkBoxTemp.radiobutton = true;
				this._checkboxes.push(checkBoxTemp);
			} 	
			
			var textInputProperies: TextField = content.getChildByName('textInputProperies') as TextField;
			var textInputValue: TextField = content.getChildByName('textInputValue') as TextField;
			var checkboxes: Array = this._checkboxes;
			new CustomButton(content.getChildByName('btnInfoSend') as Sprite, 'Send', function(): void {
				var value: String = textInputValue.text,
					prop: String = textInputProperies.text,
					i: int = 0,
					action: String;
				for (i = 0; i < checkboxes.length; i++) {
					if(checkboxes[i].flag) {
						action = checkboxes[i].alias;
						break;
					}
				}
				switch (action) { 
					case 'set' : 
						devtodev.user.set(jsonDecode(prop) == undefined ? prop : jsonDecode(prop), isNumber(value) ? parseFloat(value) : value); 
						break; 
					case 'inc' : 
						devtodev.user.increment(jsonDecode(prop) == undefined ? prop : jsonDecode(prop), isNumber(value) ? parseFloat(value) : value); 
						break; 
					case 'remove' : 
						devtodev.user.remove(jsonDecode(prop) == undefined ? prop : jsonDecode(prop)); 
						break; 
				}
			});	
		}
		public static function jsonDecode( data:String ):* {
			try {
				return ExternalInterface.call("function(){return " + data + "}");
			} catch (e:Error) {
				return data;
			}
		}
		
		public static function isNumber(value: String): Boolean
		{
			return !isNaN(parseFloat(value));
		}
		
		private function _clickCheckboxUserCard(target: CustomCheckBox) :void
		{
			var checkBoxTemp: CustomCheckBox,
				i: int = 0;
			for (i = 0; i < this._checkboxes.length; i++) {
				checkBoxTemp = this._checkboxes[i];
				if(target.alias != checkBoxTemp.alias) {
					checkBoxTemp.flag = false;
				}
			}
		}
		
		private function _initCrossUid(content: Sprite): void
		{
			var textCUid: TextField = content.getChildByName('textCUid') as TextField;
			new CustomButton(content.getChildByName('btnSetCuid') as Sprite, 'Set Crossplatform Id', function(): void {
				devtodev.setCrossplatformUserId(textCUid.text);
			});	
			new CustomButton(content.getChildByName('btnChangeCuid') as Sprite, 'Change Crossplatform Id', function(): void {
				devtodev.replaceCrossplatformUserId(textCUid.text);
			});	
		}
		
		private function _initFullscreen(btn: MovieClip): void
		{
			this._btnFullScreen = canvas.getChildByName('btnFullScreen') as MovieClip;
			this._btnFullScreen.buttonMode = true;
			this._btnFullScreen.gotoAndStop(1);
			this._btnFullScreen.addEventListener(MouseEvent.CLICK, _onFullscreen);
		}
		
		private function _initDeviceInfo(content: Sprite): void
		{
			var textAppVersion: TextField = content.getChildByName('textAppVersion') as TextField;
			var textCodeVersion: TextField = content.getChildByName('textCodeVersion') as TextField;			
			var btn: CustomButton = new CustomButton(content.getChildByName('btnDeviceInfo') as Sprite, 'Update App Info', function(): void {
				var params: Object = {}
				if(textAppVersion.text) {
					params['appVersion'] = textAppVersion.text
				}
				if(textCodeVersion.text) {
					params['codeVersion'] = textCodeVersion.text
				}
				devtodev.setAppData(params);
			});	
			
		}
		
		private function _initUserInfo(content: Sprite): void
		{
			var textInputCurrentLevel: TextField = content.getChildByName('textInputCurrentLevel') as TextField;		
			new CustomButton(content.getChildByName('btnInfoUser') as Sprite, 'Update User Info', function(): void {
				var params: Object = {}
				if(textInputCurrentLevel.text !=='') {
					params['currentLevel'] = parseInt(textInputCurrentLevel.text)
				}
				devtodev.setUserData(params);
			});
		}
		
		private function _initLevelUp(content: Sprite): void
		{
			var tfLevelUp: TextField = content.getChildByName('textInputLevel') as TextField;
			tfLevelUp.restrict = '[0-9]';
			new CustomButton(content.getChildByName('btnLevelSimple') as Sprite, 'Send Level Up Event (Simple)', function(): void {
				devtodev.levelUp(int(tfLevelUp.text));
			});
			new CustomButton(content.getChildByName('btnLevelExtended') as Sprite, 'Send Level Up Event (Extended)', function(): void {
				var params: DevtodevLevelUpResources = new DevtodevLevelUpResources();
				params.balance.push(new DevtodevCurrencyAmount('piasters', 1000));
				params.balance.push(new DevtodevCurrencyAmount('gold', 14));
				devtodev.levelUp(int(tfLevelUp.text), params);
			});
		}
		
		private function _initTutorialCompleted(content: Sprite): void
		{		
			var tfTutor: TextField = content.getChildByName('textStepTutor') as TextField;
			tfTutor.restrict = '[0-9]';
			new CustomButton(content.getChildByName('btnTutor') as Sprite, 'Send Tutorial Event', function(): void {
				devtodev.tutorialCompleted(int(tfTutor.text));
			});	
		}
		
		private function _initSocialNetworkPost(btn: Sprite): void
		{
			new CustomButton(btn, 'Send Social Post Event', function(): void {
				var socialNetwork: String = DevtodevSocialNetworks.FACEBOOK;
				var reason: String ='achievement';
				devtodev.socialNetworkPost(socialNetwork, reason);
			});	
		}
		
		private function _initSocialNetworkConnect(btn: Sprite): void
		{
			new CustomButton(btn, 'Send Social Connect Event', function(): void {
				devtodev.socialNetworkConnect(DevtodevSocialNetworks.FACEBOOK);
			});	
		}
		
		private function _initRealPayment(btn: Sprite): void
		{
			new CustomButton(btn, 'Send Real Payment Event', function(): void {
				var now:Date = new Date();
				var transactionId: String = (now.getMilliseconds()).toString();
				var productPrice: Number = 10.3;
				var productName: String ='gold pack 1';
				var transactionCurrencyISOCode: String = 'USD';
				devtodev.realPayment(transactionId, productPrice, productName, transactionCurrencyISOCode);
			});		
		}
		
		private function _initInAppPurchase(content: Sprite): void
		{
			new CustomButton(content.getChildByName('btnInAppPurchaseSimple') as Sprite, 'Send In App Purchase Event (Simple)', function(): void {
				var purchaseId:String = 'thing';
				var purchaseType: String = 'singlecurrency';
				var purchaseAmount: Number = 1;
				var purchase: Vector.<DevtodevCurrencyAmount> = new Vector.<DevtodevCurrencyAmount>();
				purchase.push(new DevtodevCurrencyAmount('piasters', 1));
				devtodev.inAppPurchase(purchaseId, purchaseType, purchaseAmount, purchase);
			});		
			
			new CustomButton(content.getChildByName('btnInAppPurchaseExtended') as Sprite, 'Send In App Purchase Event (Extended)', function(): void {
				var purchaseId:String = 'expensive thing';
				var purchaseType: String = 'multicurrency';
				var purchaseAmount: Number = 2;
				
				var purchase: Vector.<DevtodevCurrencyAmount> = new Vector.<DevtodevCurrencyAmount>();
				purchase.push(new DevtodevCurrencyAmount('piasters', 20));
				purchase.push(new DevtodevCurrencyAmount('gold', 5));
				devtodev.inAppPurchase(purchaseId, purchaseType, purchaseAmount, purchase);
			});
		}
			
		private function _initCustomEvents(content: Sprite): void 
		{
			new CustomButton(content.getChildByName('btnCustomEventSimple') as Sprite, 'Send Custom Event (Extended)', function(): void {
				devtodev.customEvent('SimpleEvent');
			});			
			new CustomButton(content.getChildByName('btnCustomEventExtended') as Sprite, 'Send Custom Event (Extended)', function(): void {
				var customEvents: Vector.<DevtodevCustomEventParam> = new Vector.<DevtodevCustomEventParam>();
				customEvents.push(new DevtodevCustomEventParam(DevtodevCustomEventParamTypes.STRING, 'flowless', 'victory'));
				customEvents.push(new DevtodevCustomEventParam(DevtodevCustomEventParamTypes.DOUBLE, 100500, 'score'));				
				devtodev.customEvent('ExtendedEvent', customEvents);
			});
		}
		
		private function _initSdk(content: Sprite): void 
		{		
			var debugCheckBox: CustomCheckBox = new CustomCheckBox(content.getChildByName('btnCheckbox') as MovieClip, function(target: CustomCheckBox): void {
				devtodev.setDebugLog(target.flag);
			});
			new CustomButton(content.getChildByName('btnInit') as Sprite, 'Init/Reinit', function(): void {
				var textUserId: String = (content.getChildByName('inputUserId') as TextField).text;
				var textApiKey: String = (content.getChildByName('inputApiKey') as TextField).text;
				var textPrevUserId: String = (content.getChildByName('inputPrevUserId') as TextField).text;
				devtodev.init(textApiKey, textUserId, textPrevUserId);
			});
		}
		
		private function _initSendBufferedEvents(content: Sprite): void 
		{		
			new CustomButton(content, 'Send Buffered Events Immediately', function(): void {
				devtodev.sendBufferedEvents();
			});
		}
		
		private function _initStartSession(content: Sprite): void 
		{			
			new CustomButton(content, 'Manual Session Start', function(): void {
				devtodev.startSession();
			});
		}
		
		private function _onFullscreen(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				this._btnFullScreen.gotoAndStop(2);
			} else {
				stage.displayState = StageDisplayState.NORMAL;
				this._btnFullScreen.gotoAndStop(1);
			}
		}
	}
}