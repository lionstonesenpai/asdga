﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//HouseItemHandleMC

package 
{
    import flash.display.MovieClip;

    public dynamic class HouseItemHandleMC extends MovieClip 
    {

        public var bCancel:MovieClip;
        public var frame:MovieClip;
        public var bFlip:MovieClip;
        public var bDelete:MovieClip;
        public var mDown:Boolean;

        public function HouseItemHandleMC()
        {
            addFrameScript(0, frame1);
        }

        internal function frame1():*
        {
            mDown = false;
        }


    }
}//package 

