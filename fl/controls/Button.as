﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.controls.Button

package fl.controls
{
    import fl.managers.IFocusManagerComponent;
    import flash.display.DisplayObject;
    import fl.core.UIComponent;
    import fl.core.InvalidationType;

    public class Button extends LabelButton implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "emphasizedSkin":"Button_emphasizedSkin",
            "emphasizedPadding":2
        };
        public static var createAccessibilityImplementation:Function;

        protected var _emphasized:Boolean = false;
        protected var emphasizedBorder:DisplayObject;


        public static function getStyleDefinition():Object
        {
            return (UIComponent.mergeStyles(LabelButton.getStyleDefinition(), defaultStyles));
        }


        public function get emphasized():Boolean
        {
            return (_emphasized);
        }

        public function set emphasized(_arg_1:Boolean):void
        {
            _emphasized = _arg_1;
            invalidate(InvalidationType.STYLES);
        }

        override protected function draw():void
        {
            if (((isInvalid(InvalidationType.STYLES)) || (isInvalid(InvalidationType.SIZE))))
            {
                drawEmphasized();
            };
            super.draw();
            if (emphasizedBorder != null)
            {
                setChildIndex(emphasizedBorder, (numChildren - 1));
            };
        }

        protected function drawEmphasized():void
        {
            var _local_2:Number;
            if (emphasizedBorder != null)
            {
                removeChild(emphasizedBorder);
            };
            emphasizedBorder = null;
            if (!_emphasized)
            {
                return;
            };
            var _local_1:Object = getStyleValue("emphasizedSkin");
            if (_local_1 != null)
            {
                emphasizedBorder = getDisplayObjectInstance(_local_1);
            };
            if (emphasizedBorder != null)
            {
                addChildAt(emphasizedBorder, 0);
                _local_2 = Number(getStyleValue("emphasizedPadding"));
                emphasizedBorder.x = (emphasizedBorder.y = -(_local_2));
                emphasizedBorder.width = (width + (_local_2 * 2));
                emphasizedBorder.height = (height + (_local_2 * 2));
            };
        }

        override public function drawFocus(_arg_1:Boolean):void
        {
            var _local_2:Number;
            var _local_3:*;
            super.drawFocus(_arg_1);
            if (_arg_1)
            {
                _local_2 = Number(getStyleValue("emphasizedPadding"));
                if (((_local_2 < 0) || (!(_emphasized))))
                {
                    _local_2 = 0;
                };
                _local_3 = getStyleValue("focusRectPadding");
                _local_3 = ((_local_3 == null) ? 2 : _local_3);
                _local_3 = (_local_3 + _local_2);
                uiFocusRect.x = -(_local_3);
                uiFocusRect.y = -(_local_3);
                uiFocusRect.width = (width + (_local_3 * 2));
                uiFocusRect.height = (height + (_local_3 * 2));
            };
        }

        override protected function initializeAccessibility():void
        {
            if (Button.createAccessibilityImplementation != null)
            {
                Button.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls

