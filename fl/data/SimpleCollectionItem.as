// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.data.SimpleCollectionItem

package fl.data
{
    public dynamic class SimpleCollectionItem 
    {

        public var label:String;
        public var data:String;


        public function toString():String
        {
            return (((("[SimpleCollectionItem: " + label) + ",") + data) + "]");
        }


    }
}//package fl.data

