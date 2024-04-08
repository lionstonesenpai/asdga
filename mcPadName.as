// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcPadName

package 
{
    import flash.display.MovieClip;

    public dynamic class mcPadName extends MovieClip 
    {

        public var cnt:MovieClip;
        public var isOn:*;

        public function mcPadName()
        {
            addFrameScript(0, frame1, 4, frame5, 9, frame10, 19, frame20);
        }

        internal function frame1():*
        {
            visible = false;
            isOn = false;
            stop();
        }

        internal function frame5():*
        {
            visible = true;
        }

        internal function frame10():*
        {
            stop();
        }

        internal function frame20():*
        {
            visible = false;
            stop();
        }


    }
}//package 

