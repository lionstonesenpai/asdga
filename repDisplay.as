// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//repDisplay

package 
{
    import flash.display.MovieClip;

    public dynamic class repDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function repDisplay()
        {
            addFrameScript(39, frame40);
        }

        internal function frame40():*
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

