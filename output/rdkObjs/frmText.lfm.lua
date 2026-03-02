require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmText()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", obj.setNodeObject);

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmText");
    obj:setHeight(30);
    obj.cacheMode = "time";

    obj.edit = GUI.fromHandle(_obj_newObject("button"));
    obj.edit:setParent(obj);
    obj.edit:setName("edit");
    obj.edit:setAlign("client");
    obj.edit:setWordWrap(true);
    obj.edit:setTextTrimming("none");

    obj.button = GUI.fromHandle(_obj_newObject("button"));
    obj.button:setParent(obj);
    obj.button:setName("button");
    obj.button:setAlign("right");
    obj.button:setText("✖");
    obj.button:setWidth(25);

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj);
    obj.dataLink1:setField("texto");
    obj.dataLink1:setName("dataLink1");

    obj.dataLink2 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj);
    obj.dataLink2:setField("hint");
    obj.dataLink2:setName("dataLink2");

    obj._e_event0 = obj.edit:addEventListener("onClick",
        function (event)
            if sheet.hint ~= nil then showMessage(sheet.hint); end;
        end);

    obj._e_event1 = obj.button:addEventListener("onClick",
        function (event)
            NDB.deleteNode(sheet);
        end);

    obj._e_event2 = obj.dataLink1:addEventListener("onChange",
        function (field, oldValue, newValue)
            self.edit:setText(sheet.texto);
        end);

    obj._e_event3 = obj.dataLink2:addEventListener("onChange",
        function (field, oldValue, newValue)
            self.edit:setHint(sheet.hint);
        end);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event3);
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.dataLink2 ~= nil then self.dataLink2:destroy(); self.dataLink2 = nil; end;
        if self.edit ~= nil then self.edit:destroy(); self.edit = nil; end;
        if self.button ~= nil then self.button:destroy(); self.button = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmText()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmText();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmText = {
    newEditor = newfrmText, 
    new = newfrmText, 
    name = "frmText", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    cacheMode = "time", 
    title = "", 
    description=""};

frmText = _frmText;
Firecast.registrarForm(_frmText);

return _frmText;
