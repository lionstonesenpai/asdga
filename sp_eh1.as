﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//sp_eh1

package 
{
    import flash.display.MovieClip;

    public dynamic class sp_eh1 extends MovieClip 
    {

        public function sp_eh1()
        {
            addFrameScript(35, this.frame36);
        }

        internal function frame36():*
        {
            stop();
            MovieClip(parent).removeChild(this);
        }


    }
}//package 

