// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//auraDisplay

package 
{
    import flash.display.MovieClip;

    public dynamic class auraDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function auraDisplay()
        {
            addFrameScript(34, this.frame35);
        }

        internal function frame35():*
        {
            try
            {
                MovieClip(parent).removeChild(this);
            }
            catch(e)
            {
            };
            stop();
        }


    }
}//package 

