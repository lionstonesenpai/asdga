﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//spider_fla.Symbol23copy3_79

package spider_fla
{
    import flash.display.MovieClip;

    public dynamic class Symbol23copy3_79 extends MovieClip 
    {

        public var buttons:Array;

        public function Symbol23copy3_79()
        {
            addFrameScript(0, frame1);
        }

        internal function frame1():*
        {
            buttons = new Array({
                "txt":"Stats & Class",
                "fct":"rootClass.toggleCharpanel"
            }, {
                "txt":"Reputations",
                "fct":"rootClass.showFactionInterface"
            }, {
                "txt":"Friends",
                "fct":"rootClass.world.showFriendsList"
            }, {
                "txt":"Guild",
                "fct":"rootClass.world.showGuildList"
            }, {
                "txt":"Character Page",
                "fct":"charPage"
            }, {"txt":"Your Hero"});
        }


    }
}//package spider_fla

