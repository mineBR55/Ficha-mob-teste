require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmOptAtaque()
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
    obj:setName("frmOptAtaque");
    obj:setHeight(30);
    obj.cacheMode = "time";

    obj.flowLayout1 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout1:setParent(obj);
    obj.flowLayout1:setAlign("top");
    obj.flowLayout1:setHeight(30);
    obj.flowLayout1:setWidth(200);
    obj.flowLayout1:setName("flowLayout1");
    obj.flowLayout1:setHorzAlign("justify");
    obj.flowLayout1:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.flowLayout1:setMinScaledWidth(300);
    obj.flowLayout1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout1:setVertAlign("leading");

    obj.flowPart1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart1:setParent(obj.flowLayout1);
    obj.flowPart1:setHeight(30);
    obj.flowPart1:setWidth(20);
    obj.flowPart1:setName("flowPart1");
    obj.flowPart1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart1:setVertAlign("leading");

    obj.checkBox1 = GUI.fromHandle(_obj_newObject("checkBox"));
    obj.checkBox1:setParent(obj.flowPart1);
    obj.checkBox1:setAlign("client");
    obj.checkBox1:setHint("Usar opção de ataque");
    obj.checkBox1:setField("habilitado");
    obj.checkBox1:setName("checkBox1");

    obj.flowPart2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart2:setParent(obj.flowLayout1);
    obj.flowPart2:setHeight(30);
    obj.flowPart2:setMinWidth(80);
    obj.flowPart2:setMaxWidth(150);
    obj.flowPart2:setAvoidScale(true);
    obj.flowPart2:setName("flowPart2");
    obj.flowPart2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart2:setVertAlign("leading");

    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.flowPart2);
    obj.edit1:setAlign("client");
    obj.edit1:setField("nome");
    obj.edit1:setHorzTextAlign("center");
    obj.edit1:setVertTextAlign("center");
    obj.edit1:setFontSize(13);
    obj.edit1:setTransparent(false);
    obj.edit1:setHitTest(true);
    obj.edit1:setName("edit1");
    obj.edit1:setHeight(30);
    obj.edit1:setWidth(195);
    obj.edit1:setFontColor("white");

    obj.flowPart3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart3:setParent(obj.flowLayout1);
    obj.flowPart3:setHeight(30);
    obj.flowPart3:setMinWidth(110);
    obj.flowPart3:setMaxWidth(200);
    obj.flowPart3:setAvoidScale(true);
    obj.flowPart3:setName("flowPart3");
    obj.flowPart3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart3:setVertAlign("leading");

    obj.edit2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit2:setParent(obj.flowPart3);
    obj.edit2:setAlign("client");
    obj.edit2:setField("ataque");
    obj.edit2:setHorzTextAlign("center");
    obj.edit2:setVertTextAlign("center");
    obj.edit2:setFontSize(13);
    obj.edit2:setTransparent(false);
    obj.edit2:setHitTest(true);
    obj.edit2:setName("edit2");
    obj.edit2:setHeight(30);
    obj.edit2:setWidth(195);
    obj.edit2:setFontColor("white");

    obj.flowPart4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart4:setParent(obj.flowLayout1);
    obj.flowPart4:setHeight(30);
    obj.flowPart4:setMinWidth(80);
    obj.flowPart4:setMaxWidth(170);
    obj.flowPart4:setAvoidScale(true);
    obj.flowPart4:setName("flowPart4");
    obj.flowPart4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart4:setVertAlign("leading");

    obj.edit3 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit3:setParent(obj.flowPart4);
    obj.edit3:setAlign("client");
    obj.edit3:setField("dano");
    obj.edit3:setHorzTextAlign("center");
    obj.edit3:setVertTextAlign("center");
    obj.edit3:setFontSize(13);
    obj.edit3:setTransparent(false);
    obj.edit3:setHitTest(true);
    obj.edit3:setName("edit3");
    obj.edit3:setHeight(30);
    obj.edit3:setWidth(195);
    obj.edit3:setFontColor("white");

    obj.flowPart5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart5:setParent(obj.flowLayout1);
    obj.flowPart5:setHeight(30);
    obj.flowPart5:setMinWidth(80);
    obj.flowPart5:setMaxWidth(180);
    obj.flowPart5:setAvoidScale(true);
    obj.flowPart5:setName("flowPart5");
    obj.flowPart5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart5:setVertAlign("leading");

    obj.edit4 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit4:setParent(obj.flowPart5);
    obj.edit4:setAlign("client");
    obj.edit4:setField("tipo");
    obj.edit4:setHorzTextAlign("center");
    obj.edit4:setVertTextAlign("center");
    obj.edit4:setFontSize(13);
    obj.edit4:setTransparent(false);
    obj.edit4:setHitTest(true);
    obj.edit4:setName("edit4");
    obj.edit4:setHeight(30);
    obj.edit4:setWidth(195);
    obj.edit4:setFontColor("white");

    obj.flowPart6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart6:setParent(obj.flowLayout1);
    obj.flowPart6:setHeight(30);
    obj.flowPart6:setMinWidth(100);
    obj.flowPart6:setMaxWidth(200);
    obj.flowPart6:setAvoidScale(true);
    obj.flowPart6:setName("flowPart6");
    obj.flowPart6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart6:setVertAlign("leading");

    obj.cbOptAtaqueMunicao = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.cbOptAtaqueMunicao:setParent(obj.flowPart6);
    obj.cbOptAtaqueMunicao:setName("cbOptAtaqueMunicao");
    obj.cbOptAtaqueMunicao:setAlign("client");
    obj.cbOptAtaqueMunicao:setField("municao");
    obj.cbOptAtaqueMunicao:setHint("Qual 'contador' deve ser gasto");
    obj.cbOptAtaqueMunicao:setFontSize(18);
    obj.cbOptAtaqueMunicao:setHeight(30);
    obj.cbOptAtaqueMunicao:setTransparent(true);
    obj.cbOptAtaqueMunicao:setWidth(195);

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj.flowPart6);
    obj.dataLink1:setField("contadoresMudaram");
    obj.dataLink1:setName("dataLink1");

    obj.flowPart7 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart7:setParent(obj.flowLayout1);
    obj.flowPart7:setHeight(30);
    obj.flowPart7:setMinWidth(25);
    obj.flowPart7:setMaxWidth(50);
    obj.flowPart7:setAvoidScale(true);
    obj.flowPart7:setName("flowPart7");
    obj.flowPart7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart7:setVertAlign("leading");

    obj.edit5 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit5:setParent(obj.flowPart7);
    obj.edit5:setAlign("client");
    obj.edit5:setField("qtMunicao");
    obj.edit5:setHorzTextAlign("center");
    obj.edit5:setVertTextAlign("center");
    obj.edit5:setFontSize(13);
    obj.edit5:setTransparent(false);
    obj.edit5:setHitTest(true);
    obj.edit5:setName("edit5");
    obj.edit5:setHeight(30);
    obj.edit5:setWidth(195);
    obj.edit5:setFontColor("white");

    obj.flowPart8 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart8:setParent(obj.flowLayout1);
    obj.flowPart8:setHeight(30);
    obj.flowPart8:setWidth(25);
    obj.flowPart8:setName("flowPart8");
    obj.flowPart8:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart8:setVertAlign("leading");

    obj.btnApagar = GUI.fromHandle(_obj_newObject("button"));
    obj.btnApagar:setParent(obj.flowPart8);
    obj.btnApagar:setName("btnApagar");
    obj.btnApagar:setAlign("client");
    obj.btnApagar:setText("✖");
    obj.btnApagar:setEnabled(true);

    obj.dataLink2 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj);
    obj.dataLink2:setField("nome");
    obj.dataLink2:setDefaultValue("NOME");
    obj.dataLink2:setName("dataLink2");

    obj.dataLink3 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink3:setParent(obj);
    obj.dataLink3:setField("ataque");
    obj.dataLink3:setDefaultValue("");
    obj.dataLink3:setName("dataLink3");

    obj.dataLink4 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink4:setParent(obj);
    obj.dataLink4:setField("dano");
    obj.dataLink4:setDefaultValue("");
    obj.dataLink4:setName("dataLink4");

    obj.dataLink5 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink5:setParent(obj);
    obj.dataLink5:setField("tipo");
    obj.dataLink5:setDefaultValue("");
    obj.dataLink5:setName("dataLink5");

    obj._e_event0 = obj.dataLink1:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet and sheet.contadoresMudaram then
            							self.cbOptAtaqueMunicao:setItems(common.getNomeContadores(sheet, {""}));
            						end;
        end);

    obj._e_event1 = obj.btnApagar:addEventListener("onClick",
        function (event)
            common.askForDelete(self.sheet);
        end);

    function obj:_releaseEvents()
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
        if self.dataLink5 ~= nil then self.dataLink5:destroy(); self.dataLink5 = nil; end;
        if self.flowPart2 ~= nil then self.flowPart2:destroy(); self.flowPart2 = nil; end;
        if self.flowLayout1 ~= nil then self.flowLayout1:destroy(); self.flowLayout1 = nil; end;
        if self.edit4 ~= nil then self.edit4:destroy(); self.edit4 = nil; end;
        if self.flowPart6 ~= nil then self.flowPart6:destroy(); self.flowPart6 = nil; end;
        if self.checkBox1 ~= nil then self.checkBox1:destroy(); self.checkBox1 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.btnApagar ~= nil then self.btnApagar:destroy(); self.btnApagar = nil; end;
        if self.edit3 ~= nil then self.edit3:destroy(); self.edit3 = nil; end;
        if self.flowPart3 ~= nil then self.flowPart3:destroy(); self.flowPart3 = nil; end;
        if self.dataLink4 ~= nil then self.dataLink4:destroy(); self.dataLink4 = nil; end;
        if self.flowPart7 ~= nil then self.flowPart7:destroy(); self.flowPart7 = nil; end;
        if self.edit2 ~= nil then self.edit2:destroy(); self.edit2 = nil; end;
        if self.flowPart4 ~= nil then self.flowPart4:destroy(); self.flowPart4 = nil; end;
        if self.dataLink3 ~= nil then self.dataLink3:destroy(); self.dataLink3 = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.flowPart1 ~= nil then self.flowPart1:destroy(); self.flowPart1 = nil; end;
        if self.cbOptAtaqueMunicao ~= nil then self.cbOptAtaqueMunicao:destroy(); self.cbOptAtaqueMunicao = nil; end;
        if self.flowPart8 ~= nil then self.flowPart8:destroy(); self.flowPart8 = nil; end;
        if self.edit5 ~= nil then self.edit5:destroy(); self.edit5 = nil; end;
        if self.flowPart5 ~= nil then self.flowPart5:destroy(); self.flowPart5 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmOptAtaque()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmOptAtaque();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmOptAtaque = {
    newEditor = newfrmOptAtaque, 
    new = newfrmOptAtaque, 
    name = "frmOptAtaque", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    cacheMode = "time", 
    title = "", 
    description=""};

frmOptAtaque = _frmOptAtaque;
Firecast.registrarForm(_frmOptAtaque);

return _frmOptAtaque;
