// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//LoaderMC

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.*;

    public class LoaderMC extends MovieClip 
    {

        public var mcPct:TextField;
        public var btnCancel:SimpleButton;
        public var strLoad:TextField;
        internal var mcDest:MovieClip;
        internal var isEvent:Boolean = false;
        private var rootClass:MovieClip;
        public var history:Object = {};
        private var _file:String;

        public function LoaderMC(_arg_1:MovieClip)
        {
            btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);
            rootClass = _arg_1;
        }

        public function loadFile(_arg_1:MovieClip, _arg_2:String, _arg_3:String, _arg_4:Boolean=false):void
        {
            _file = _arg_2;
            var _local_5:Number = new Date().getTime();
            if ((((_arg_2.indexOf("https://") == -1) && (_arg_2.indexOf("https://") == -1)) && (_arg_2.indexOf("file://") == -1)))
            {
                _arg_2 = (Game.serverFilePath + _arg_2);
            };
            isEvent = _arg_4;
            if (_arg_3 != "Inline Asset")
            {
                MovieClip(Game.root).addChild(this);
            };
            mcDest = _arg_1;
            var _local_6:* = new Loader();
            _local_6.load(new URLRequest(_arg_2), new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));
            _local_6.contentLoaderInfo.addEventListener(Event.COMPLETE, onFileLoadComplete, false, 0, true);
            _local_6.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onFileLoadProgress, false, 0, true);
            history[_arg_2] = {
                "ts":_local_5,
                "ldr":_local_6
            };
        }

        private function onFileLoadComplete(_arg_1:Event):void
        {
            var _local_5:String;
            var _local_6:Object;
            var _local_2:* = rootClass.world;
            var _local_3:Loader = Loader(_arg_1.target.loader);
            try
            {
                for each (_local_5 in history)
                {
                    if (history[_local_5].ldr == _local_3)
                    {
                        delete history[_local_5];
                    };
                };
            }
            catch(e:Error)
            {
            };
            _local_3.contentLoaderInfo.removeEventListener(Event.COMPLETE, onFileLoadComplete);
            _local_3.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onFileLoadProgress);
            var _local_4:* = MovieClip(_local_3.content);
            mcDest.addChild(_local_4);
            if (((isEvent) && ("eventTrigger" in _local_2.map)))
            {
                _local_6 = {
                    "cmd":"fileLoaded",
                    "args":{"loc":"default"}
                };
                _local_2.map.eventTrigger(_local_6);
            };
            if ((((_local_2.strMapName == "buyhouse") || (_local_2.strMapName == "house")) && (_file == rootClass.bagSpace)))
            {
                MovieClip(mcDest.getChildAt(0)).gotoAndPlay("House");
                _file = "";
            };
            mcDest = null;
            try
            {
                MovieClip(parent).removeChild(this);
            }
            catch(e:Error)
            {
            };
        }

        private function onFileLoadProgress(_arg_1:ProgressEvent):void
        {
            var _local_2:int = int(Math.floor(((_arg_1.bytesLoaded / _arg_1.bytesTotal) * 100)));
            if (_arg_1.bytesTotal <= 0)
            {
                _local_2 = 0;
            };
            strLoad.text = "Loading!";
            mcPct.text = (_local_2 + "%");
        }

        public function closeHistory():void
        {
            var _local_1:String;
            for each (_local_1 in history)
            {
                try
                {
                    history[_local_1].ldr.close();
                }
                catch(e:Error)
                {
                };
                delete history[_local_1];
            };
            history = {};
        }

        private function onCancelClick(_arg_1:MouseEvent):void
        {
            MovieClip(Game.root).logout();
            MovieClip(parent).removeChild(this);
        }


    }
}//package 

