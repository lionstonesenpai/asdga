// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//spider_fla.charicon_323

package spider_fla
{
    import flash.display.MovieClip;

    public dynamic class charicon_323 extends MovieClip 
    {

        public var buttons:Array;

        public function charicon_323()
        {
            addFrameScript(0, frame1);
        }

        internal function frame1():*
        {
            buttons = new Array({
                "txt":"Stats Overview",
                "fct":"rootClass.toggleStatspanel"
            }, {
                "txt":"Class Overview",
                "fct":"rootClass.toggleCharpanel"
            }, {
                "txt":"Reputations",
                "fct":"rootClass.showFactionInterface"
            }, {
                "txt":"Friendships",
                "fct":"rootClass.showFriendshipUI"
            }, {
                "txt":"Friends",
                "fct":"rootClass.world.showFriendsList"
            }, {
                "txt":"Guild",
                "fct":"rootClass.world.showGuildList"
            }, {
                "txt":"Outfits",
                "fct":"rootClass.toggleOutfits"
            }, {
                "txt":"Character Page",
                "fct":"charPage"
            }, {"txt":"Your Hero"});
        }


    }
}//package spider_fla

