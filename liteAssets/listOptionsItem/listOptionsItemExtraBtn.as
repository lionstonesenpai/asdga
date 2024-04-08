// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//liteAssets.listOptionsItem.listOptionsItemExtraBtn

package liteAssets.listOptionsItem
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import liteAssets.handlers.optionHandler;

    public class listOptionsItemExtraBtn extends MovieClip 
    {

        public var txtName:TextField;
        public var btnActive:SimpleButton;
        public var sDesc:String;
        public var rootClass:MovieClip;

        public function listOptionsItemExtraBtn(_arg_1:MovieClip, _arg_2:String)
        {
            rootClass = _arg_1;
            this.sDesc = _arg_2;
            btnActive.addEventListener(MouseEvent.CLICK, onActive, false, 0, true);
        }

        public function onActive(_arg_1:MouseEvent):void
        {
            optionHandler.cmd(rootClass, txtName.text);
        }


    }
}//package liteAssets.listOptionsItem

