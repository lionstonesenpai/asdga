﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.CancelButton

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class CancelButton extends MovieClip 
    {

        public function CancelButton()
        {
            addFrameScript(0, frame1);
            useHandCursor = false;
            this.addEventListener(MouseEvent.MOUSE_OVER, onRollOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, onRollOut, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_DOWN, onPress, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, onRelease, false, 0, true);
        }

        private function onRollOver(_arg_1:MouseEvent):void
        {
            this.gotoAndStop(1);
        }

        private function onRollOut(_arg_1:MouseEvent):void
        {
            gotoAndStop(1);
        }

        internal function onPress(_arg_1:MouseEvent):void
        {
            gotoAndStop(2);
        }

        internal function onRelease(_arg_1:MouseEvent):void
        {
            gotoAndStop(1);
            MovieClip(parent).click(this);
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

