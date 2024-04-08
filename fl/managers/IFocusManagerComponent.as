// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.managers.IFocusManagerComponent

package fl.managers
{
    public interface IFocusManagerComponent 
    {

        function get focusEnabled():Boolean;
        function set focusEnabled(_arg_1:Boolean):void;
        function get mouseFocusEnabled():Boolean;
        function get tabEnabled():Boolean;
        function get tabIndex():int;
        function setFocus():void;
        function drawFocus(_arg_1:Boolean):void;

    }
}//package fl.managers

