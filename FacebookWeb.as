// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FacebookWeb

package 
{
    import flash.display.MovieClip;
    import com.facebook.graph.*;

    public class FacebookWeb 
    {

        public var fb:FBListener;
        public var rootClass:MovieClip;
        public var extInterface:ExternalCalls;


        public function InitListener(_arg_1:MovieClip):*
        {
            rootClass = _arg_1;
            fb = new FBListener(_arg_1);
            extInterface = _arg_1.extCall;
        }

        public function FBMessage(_arg_1:*, _arg_2:*):*
        {
            fb.handleFBEvent(_arg_1, _arg_2);
        }

        public function Login():void
        {
            extInterface.fbLogin();
        }

        public function Logout():void
        {
            fb.fbLogout();
            fb.logoutFromFB();
        }


    }
}//package 

