﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.controls.ComboBox

package fl.controls
{
    import fl.core.UIComponent;
    import fl.managers.IFocusManagerComponent;
    import fl.data.SimpleCollectionItem;
    import fl.core.InvalidationType;
    import fl.data.DataProvider;
    import fl.events.DataChangeEvent;
    import flash.events.Event;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import fl.events.ListEvent;
    import flash.events.FocusEvent;
    import flash.text.TextFormat;
    import flash.geom.Point;
    import fl.events.ComponentEvent;
    import flash.display.DisplayObject;
    import fl.controls.listClasses.ICellRenderer;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    public class ComboBox extends UIComponent implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "upSkin":"ComboBox_upSkin",
            "downSkin":"ComboBox_downSkin",
            "overSkin":"ComboBox_overSkin",
            "disabledSkin":"ComboBox_disabledSkin",
            "focusRectSkin":null,
            "focusRectPadding":null,
            "textFormat":null,
            "disabledTextFormat":null,
            "textPadding":3,
            "buttonWidth":24,
            "disabledAlpha":null,
            "listSkin":null
        };
        protected static const LIST_STYLES:Object = {
            "upSkin":"comboListUpSkin",
            "overSkin":"comboListOverSkin",
            "downSkin":"comobListDownSkin",
            "disabledSkin":"comboListDisabledSkin",
            "downArrowDisabledSkin":"downArrowDisabledSkin",
            "downArrowDownSkin":"downArrowDownSkin",
            "downArrowOverSkin":"downArrowOverSkin",
            "downArrowUpSkin":"downArrowUpSkin",
            "upArrowDisabledSkin":"upArrowDisabledSkin",
            "upArrowDownSkin":"upArrowDownSkin",
            "upArrowOverSkin":"upArrowOverSkin",
            "upArrowUpSkin":"upArrowUpSkin",
            "thumbDisabledSkin":"thumbDisabledSkin",
            "thumbDownSkin":"thumbDownSkin",
            "thumbOverSkin":"thumbOverSkin",
            "thumbUpSkin":"thumbUpSkin",
            "thumbIcon":"thumbIcon",
            "trackDisabledSkin":"trackDisabledSkin",
            "trackDownSkin":"trackDownSkin",
            "trackOverSkin":"trackOverSkin",
            "trackUpSkin":"trackUpSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval",
            "textFormat":"textFormat",
            "disabledAlpha":"disabledAlpha",
            "skin":"listSkin"
        };
        protected static const BACKGROUND_STYLES:Object = {
            "overSkin":"overSkin",
            "downSkin":"downSkin",
            "upSkin":"upSkin",
            "disabledSkin":"disabledSkin",
            "repeatInterval":"repeatInterval"
        };
        public static var createAccessibilityImplementation:Function;

        protected var inputField:TextInput;
        protected var background:BaseButton;
        protected var list:List;
        protected var _rowCount:uint = 5;
        protected var _editable:Boolean = false;
        protected var isOpen:Boolean = false;
        protected var highlightedCell:int = -1;
        protected var editableValue:String;
        protected var _prompt:String;
        protected var isKeyDown:Boolean = false;
        protected var currentIndex:int;
        protected var listOverIndex:uint;
        protected var _dropdownWidth:Number;
        protected var _labels:Array;
        private var collectionItemImport:SimpleCollectionItem;


        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, List.getStyleDefinition()));
        }


        public function get editable():Boolean
        {
            return (_editable);
        }

        public function set editable(_arg_1:Boolean):void
        {
            _editable = _arg_1;
            drawTextField();
        }

        public function get rowCount():uint
        {
            return (_rowCount);
        }

        public function set rowCount(_arg_1:uint):void
        {
            _rowCount = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get restrict():String
        {
            return (inputField.restrict);
        }

        public function set restrict(_arg_1:String):void
        {
            if (((componentInspectorSetting) && (_arg_1 == "")))
            {
                _arg_1 = null;
            };
            if (!_editable)
            {
                return;
            };
            inputField.restrict = _arg_1;
        }

        public function get selectedIndex():int
        {
            return (list.selectedIndex);
        }

        public function set selectedIndex(_arg_1:int):void
        {
            list.selectedIndex = _arg_1;
            highlightCell();
            invalidate(InvalidationType.SELECTED);
        }

        public function get text():String
        {
            return (inputField.text);
        }

        public function set text(_arg_1:String):void
        {
            if (!editable)
            {
                return;
            };
            inputField.text = _arg_1;
        }

        public function get labelField():String
        {
            return (list.labelField);
        }

        public function set labelField(_arg_1:String):void
        {
            list.labelField = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get labelFunction():Function
        {
            return (list.labelFunction);
        }

        public function set labelFunction(_arg_1:Function):void
        {
            list.labelFunction = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function itemToLabel(_arg_1:Object):String
        {
            if (_arg_1 == null)
            {
                return ("");
            };
            return (list.itemToLabel(_arg_1));
        }

        public function get selectedItem():Object
        {
            return (list.selectedItem);
        }

        public function set selectedItem(_arg_1:Object):void
        {
            list.selectedItem = _arg_1;
            invalidate(InvalidationType.SELECTED);
        }

        public function get dropdown():List
        {
            return (list);
        }

        public function get length():int
        {
            return (list.length);
        }

        public function get textField():TextInput
        {
            return (inputField);
        }

        public function get value():String
        {
            var _local_1:Object;
            if (editableValue != null)
            {
                return (editableValue);
            };
            _local_1 = selectedItem;
            if (((!(_editable)) && (!(_local_1.data == null))))
            {
                return (_local_1.data);
            };
            return (itemToLabel(_local_1));
        }

        public function get dataProvider():DataProvider
        {
            return (list.dataProvider);
        }

        public function set dataProvider(_arg_1:DataProvider):void
        {
            _arg_1.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
            list.dataProvider = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get dropdownWidth():Number
        {
            return (list.width);
        }

        public function set dropdownWidth(_arg_1:Number):void
        {
            _dropdownWidth = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function addItem(_arg_1:Object):void
        {
            list.addItem(_arg_1);
            invalidate(InvalidationType.DATA);
        }

        public function get prompt():String
        {
            return (_prompt);
        }

        public function set prompt(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                _prompt = null;
            }
            else
            {
                _prompt = _arg_1;
            };
            invalidate(InvalidationType.STATE);
        }

        public function get imeMode():String
        {
            return (inputField.imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            inputField.imeMode = _arg_1;
        }

        public function addItemAt(_arg_1:Object, _arg_2:uint):void
        {
            list.addItemAt(_arg_1, _arg_2);
            invalidate(InvalidationType.DATA);
        }

        public function removeAll():void
        {
            list.removeAll();
            inputField.text = "";
            invalidate(InvalidationType.DATA);
        }

        public function removeItem(_arg_1:Object):Object
        {
            return (list.removeItem(_arg_1));
        }

        public function removeItemAt(_arg_1:uint):void
        {
            list.removeItemAt(_arg_1);
            invalidate(InvalidationType.DATA);
        }

        public function getItemAt(_arg_1:uint):Object
        {
            return (list.getItemAt(_arg_1));
        }

        public function replaceItemAt(_arg_1:Object, _arg_2:uint):Object
        {
            return (list.replaceItemAt(_arg_1, _arg_2));
        }

        public function sortItems(... _args):*
        {
            return (list.sortItems.apply(list, _args));
        }

        public function sortItemsOn(_arg_1:String, _arg_2:Object=null):*
        {
            return (list.sortItemsOn(_arg_1, _arg_2));
        }

        public function open():void
        {
            currentIndex = selectedIndex;
            if (((isOpen) || (length == 0)))
            {
                return;
            };
            dispatchEvent(new Event(Event.OPEN));
            isOpen = true;
            addEventListener(Event.ENTER_FRAME, addCloseListener, false, 0, true);
            positionList();
            list.scrollToSelected();
            focusManager.form.addChild(list);
        }

        public function close():void
        {
            highlightCell();
            highlightedCell = -1;
            if (!isOpen)
            {
                return;
            };
            dispatchEvent(new Event(Event.CLOSE));
            var _local_1:DisplayObjectContainer = focusManager.form;
            _local_1.removeEventListener(MouseEvent.MOUSE_DOWN, onStageClick);
            isOpen = false;
            _local_1.removeChild(list);
        }

        public function get selectedLabel():String
        {
            if (editableValue != null)
            {
                return (editableValue);
            };
            if (selectedIndex == -1)
            {
                return (null);
            };
            return (itemToLabel(selectedItem));
        }

        override protected function configUI():void
        {
            super.configUI();
            background = new BaseButton();
            background.focusEnabled = false;
            copyStylesToChild(background, BACKGROUND_STYLES);
            background.addEventListener(MouseEvent.MOUSE_DOWN, onToggleListVisibility, false, 0, true);
            addChild(background);
            inputField = new TextInput();
            inputField.focusTarget = (this as IFocusManagerComponent);
            inputField.focusEnabled = false;
            inputField.addEventListener(Event.CHANGE, onTextInput, false, 0, true);
            addChild(inputField);
            list = new List();
            list.focusEnabled = false;
            copyStylesToChild(list, LIST_STYLES);
            list.addEventListener(Event.CHANGE, onListChange, false, 0, true);
            list.addEventListener(ListEvent.ITEM_CLICK, onListChange, false, 0, true);
            list.addEventListener(ListEvent.ITEM_ROLL_OUT, passEvent, false, 0, true);
            list.addEventListener(ListEvent.ITEM_ROLL_OVER, passEvent, false, 0, true);
            list.verticalScrollBar.addEventListener(Event.SCROLL, passEvent, false, 0, true);
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            super.focusInHandler(_arg_1);
            if (editable)
            {
                stage.focus = inputField.textField;
            };
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            isKeyDown = false;
            if (isOpen)
            {
                if (((!(_arg_1.relatedObject)) || (!(list.contains(_arg_1.relatedObject)))))
                {
                    if (((!(highlightedCell == -1)) && (!(highlightedCell == selectedIndex))))
                    {
                        selectedIndex = highlightedCell;
                        dispatchEvent(new Event(Event.CHANGE));
                    };
                    close();
                };
            };
            super.focusOutHandler(_arg_1);
        }

        protected function handleDataChange(_arg_1:DataChangeEvent):void
        {
            invalidate(InvalidationType.DATA);
        }

        override protected function draw():void
        {
            var _local_1:* = selectedIndex;
            if (((_local_1 == -1) && (((!(prompt == null)) || (editable)) || (length == 0))))
            {
                _local_1 = Math.max(-1, Math.min(_local_1, (length - 1)));
            }
            else
            {
                editableValue = null;
                _local_1 = Math.max(0, Math.min(_local_1, (length - 1)));
            };
            if (list.selectedIndex != _local_1)
            {
                list.selectedIndex = _local_1;
                invalidate(InvalidationType.SELECTED, false);
            };
            if (isInvalid(InvalidationType.STYLES))
            {
                setStyles();
                setEmbedFonts();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.STATE))
            {
                drawTextFormat();
                drawLayout();
                invalidate(InvalidationType.DATA);
            };
            if (isInvalid(InvalidationType.DATA))
            {
                drawList();
                invalidate(InvalidationType.SELECTED, true);
            };
            if (isInvalid(InvalidationType.SELECTED))
            {
                if (((_local_1 == -1) && (!(editableValue == null))))
                {
                    inputField.text = editableValue;
                }
                else
                {
                    if (_local_1 > -1)
                    {
                        if (length > 0)
                        {
                            inputField.horizontalScrollPosition = 0;
                            inputField.text = itemToLabel(list.selectedItem);
                        };
                    }
                    else
                    {
                        if (((_local_1 == -1) && (!(_prompt == null))))
                        {
                            showPrompt();
                        }
                        else
                        {
                            inputField.text = "";
                        };
                    };
                };
                if ((((editable) && (selectedIndex > -1)) && (stage.focus == inputField.textField)))
                {
                    inputField.setSelection(0, inputField.length);
                };
            };
            drawTextField();
            super.draw();
        }

        protected function setEmbedFonts():void
        {
            var _local_1:Object = getStyleValue("embedFonts");
            if (_local_1 != null)
            {
                inputField.textField.embedFonts = _local_1;
            };
        }

        protected function showPrompt():void
        {
            inputField.text = _prompt;
        }

        protected function setStyles():void
        {
            copyStylesToChild(background, BACKGROUND_STYLES);
            copyStylesToChild(list, LIST_STYLES);
        }

        protected function drawLayout():void
        {
            var _local_1:Number = (getStyleValue("buttonWidth") as Number);
            var _local_2:Number = (getStyleValue("textPadding") as Number);
            background.setSize(width, height);
            inputField.x = (inputField.y = _local_2);
            inputField.setSize(((width - _local_1) - _local_2), (height - _local_2));
            list.width = ((isNaN(_dropdownWidth)) ? width : _dropdownWidth);
            background.enabled = enabled;
            background.drawNow();
        }

        protected function drawTextFormat():void
        {
            var _local_1:TextFormat = (getStyleValue(((_enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
            if (_local_1 == null)
            {
                _local_1 = new TextFormat();
            };
            inputField.textField.defaultTextFormat = _local_1;
            inputField.textField.setTextFormat(_local_1);
            setEmbedFonts();
        }

        protected function drawList():void
        {
            list.rowCount = Math.max(0, Math.min(_rowCount, list.dataProvider.length));
        }

        protected function positionList():void
        {
            var myForm:DisplayObjectContainer;
            var theStageHeight:Number;
            var p:Point = localToGlobal(new Point(0, 0));
            myForm = focusManager.form;
            p = myForm.globalToLocal(p);
            list.x = p.x;
            try
            {
                theStageHeight = stage.stageHeight;
            }
            catch(se:SecurityError)
            {
                theStageHeight = myForm.height;
            };
            if (((p.y + height) + list.height) > theStageHeight)
            {
                list.y = (p.y - list.height);
            }
            else
            {
                list.y = (p.y + height);
            };
        }

        protected function drawTextField():void
        {
            inputField.setStyle("upSkin", "");
            inputField.setStyle("disabledSkin", "");
            inputField.enabled = enabled;
            inputField.editable = _editable;
            inputField.textField.selectable = ((enabled) && (_editable));
            inputField.mouseEnabled = (inputField.mouseChildren = ((enabled) && (_editable)));
            inputField.focusEnabled = false;
            if (_editable)
            {
                inputField.addEventListener(FocusEvent.FOCUS_IN, onInputFieldFocus, false, 0, true);
                inputField.addEventListener(FocusEvent.FOCUS_OUT, onInputFieldFocusOut, false, 0, true);
            }
            else
            {
                inputField.removeEventListener(FocusEvent.FOCUS_IN, onInputFieldFocus);
                inputField.removeEventListener(FocusEvent.FOCUS_OUT, onInputFieldFocusOut);
            };
        }

        protected function onInputFieldFocus(_arg_1:FocusEvent):void
        {
            inputField.addEventListener(ComponentEvent.ENTER, onEnter, false, 0, true);
            close();
        }

        protected function onInputFieldFocusOut(_arg_1:FocusEvent):void
        {
            inputField.removeEventListener(ComponentEvent.ENTER, onEnter);
            selectedIndex = selectedIndex;
        }

        protected function onEnter(_arg_1:ComponentEvent):void
        {
            _arg_1.stopPropagation();
        }

        protected function onToggleListVisibility(_arg_1:MouseEvent):void
        {
            _arg_1.stopPropagation();
            dispatchEvent(_arg_1);
            if (isOpen)
            {
                close();
            }
            else
            {
                open();
                focusManager.form.addEventListener(MouseEvent.MOUSE_UP, onListItemUp, false, 0, true);
            };
        }

        protected function onListItemUp(_arg_1:MouseEvent):void
        {
            focusManager.form.removeEventListener(MouseEvent.MOUSE_UP, onListItemUp);
            if (((!(_arg_1.target is ICellRenderer)) || (!(list.contains((_arg_1.target as DisplayObject))))))
            {
                return;
            };
            editableValue = null;
            var _local_2:* = selectedIndex;
            selectedIndex = _arg_1.target.listData.index;
            if (_local_2 != selectedIndex)
            {
                dispatchEvent(new Event(Event.CHANGE));
            };
            close();
        }

        protected function onListChange(_arg_1:Event):void
        {
            editableValue = null;
            dispatchEvent(_arg_1);
            invalidate(InvalidationType.SELECTED);
            if (isKeyDown)
            {
                return;
            };
            close();
        }

        protected function onStageClick(_arg_1:MouseEvent):void
        {
            if (!isOpen)
            {
                return;
            };
            if (((!(contains((_arg_1.target as DisplayObject)))) && (!(list.contains((_arg_1.target as DisplayObject))))))
            {
                if (highlightedCell != -1)
                {
                    selectedIndex = highlightedCell;
                    dispatchEvent(new Event(Event.CHANGE));
                };
                close();
            };
        }

        protected function passEvent(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        private function addCloseListener(_arg_1:Event):*
        {
            removeEventListener(Event.ENTER_FRAME, addCloseListener);
            if (!isOpen)
            {
                return;
            };
            focusManager.form.addEventListener(MouseEvent.MOUSE_DOWN, onStageClick, false, 0, true);
        }

        protected function onTextInput(_arg_1:Event):void
        {
            _arg_1.stopPropagation();
            if (!_editable)
            {
                return;
            };
            editableValue = inputField.text;
            selectedIndex = -1;
            dispatchEvent(new Event(Event.CHANGE));
        }

        protected function calculateAvailableHeight():Number
        {
            var _local_1:Number = Number(getStyleValue("contentPadding"));
            return (list.height - (_local_1 * 2));
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            isKeyDown = true;
            if (_arg_1.ctrlKey)
            {
                switch (_arg_1.keyCode)
                {
                    case Keyboard.UP:
                        if (highlightedCell > -1)
                        {
                            selectedIndex = highlightedCell;
                            dispatchEvent(new Event(Event.CHANGE));
                        };
                        close();
                        return;
                    case Keyboard.DOWN:
                        open();
                        return;
                };
                return;
            };
            _arg_1.stopPropagation();
            var _local_2:int = int(Math.max(((calculateAvailableHeight() / list.rowHeight) << 0), 1));
            var _local_3:uint = selectedIndex;
            var _local_4:Number = ((highlightedCell == -1) ? selectedIndex : highlightedCell);
            var _local_5:int = -1;
            switch (_arg_1.keyCode)
            {
                case Keyboard.SPACE:
                    if (isOpen)
                    {
                        close();
                    }
                    else
                    {
                        open();
                    };
                    return;
                case Keyboard.ESCAPE:
                    if (isOpen)
                    {
                        if (highlightedCell > -1)
                        {
                            selectedIndex = selectedIndex;
                        };
                        close();
                    };
                    return;
                case Keyboard.UP:
                    _local_5 = Math.max(0, (_local_4 - 1));
                    break;
                case Keyboard.DOWN:
                    _local_5 = Math.min((length - 1), (_local_4 + 1));
                    break;
                case Keyboard.PAGE_UP:
                    _local_5 = Math.max((_local_4 - _local_2), 0);
                    break;
                case Keyboard.PAGE_DOWN:
                    _local_5 = Math.min((_local_4 + _local_2), (length - 1));
                    break;
                case Keyboard.HOME:
                    _local_5 = 0;
                    break;
                case Keyboard.END:
                    _local_5 = (length - 1);
                    break;
                case Keyboard.ENTER:
                    if (((_editable) && (highlightedCell == -1)))
                    {
                        editableValue = inputField.text;
                        selectedIndex = -1;
                    }
                    else
                    {
                        if (((isOpen) && (highlightedCell > -1)))
                        {
                            editableValue = null;
                            selectedIndex = highlightedCell;
                            dispatchEvent(new Event(Event.CHANGE));
                        };
                    };
                    dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
                    close();
                    return;
                default:
                    if (editable) break;
                    _local_5 = list.getNextIndexAtLetter(String.fromCharCode(_arg_1.keyCode), _local_4);
            };
            if (_local_5 > -1)
            {
                if (isOpen)
                {
                    highlightCell(_local_5);
                    inputField.text = list.itemToLabel(getItemAt(_local_5));
                }
                else
                {
                    highlightCell();
                    selectedIndex = _local_5;
                    dispatchEvent(new Event(Event.CHANGE));
                };
            };
        }

        protected function highlightCell(_arg_1:int=-1):void
        {
            var _local_2:ICellRenderer;
            if (highlightedCell > -1)
            {
                _local_2 = list.itemToCellRenderer(getItemAt(highlightedCell));
                if (_local_2 != null)
                {
                    _local_2.setMouseState("up");
                };
            };
            if (_arg_1 == -1)
            {
                return;
            };
            list.scrollToIndex(_arg_1);
            list.drawNow();
            _local_2 = list.itemToCellRenderer(getItemAt(_arg_1));
            if (_local_2 != null)
            {
                _local_2.setMouseState("over");
                highlightedCell = _arg_1;
            };
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            isKeyDown = false;
        }

        override protected function initializeAccessibility():void
        {
            if (ComboBox.createAccessibilityImplementation != null)
            {
                ComboBox.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls

