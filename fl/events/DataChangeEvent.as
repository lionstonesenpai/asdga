﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.events.DataChangeEvent

package fl.events
{
    import flash.events.Event;

    public class DataChangeEvent extends Event 
    {

        public static const DATA_CHANGE:String = "dataChange";
        public static const PRE_DATA_CHANGE:String = "preDataChange";

        protected var _startIndex:uint;
        protected var _endIndex:uint;
        protected var _changeType:String;
        protected var _items:Array;

        public function DataChangeEvent(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:int=-1, _arg_5:int=-1):void
        {
            super(_arg_1);
            _changeType = _arg_2;
            _startIndex = _arg_4;
            _items = _arg_3;
            _endIndex = ((_arg_5 == -1) ? _startIndex : _arg_5);
        }

        public function get changeType():String
        {
            return (_changeType);
        }

        public function get items():Array
        {
            return (_items);
        }

        public function get startIndex():uint
        {
            return (_startIndex);
        }

        public function get endIndex():uint
        {
            return (_endIndex);
        }

        override public function toString():String
        {
            return (formatToString("DataChangeEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable"));
        }

        override public function clone():Event
        {
            return (new DataChangeEvent(type, _changeType, _items, _startIndex, _endIndex));
        }


    }
}//package fl.events

