// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//LevelUpDisplay

package 
{
    import flash.display.MovieClip;

    public dynamic class LevelUpDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function LevelUpDisplay()
        {
            addFrameScript(37, this.frame38);
        }

        internal function frame38():*
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

