require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmEquipamentoItem()
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
    obj:setName("frmEquipamentoItem");
    obj:setHeight(40);
    obj.cacheMode = "time";

 
		



		require("common.lua");
		local function askForDelete()
			Dialogs.confirmYesNo("Deseja realmente apagar este item?",
								 function (confirmado)
									if confirmado then
										NDB.deleteNode(self.sheet);
									end;
								 end);
		end;
		



	


    obj.layItem = GUI.fromHandle(_obj_newObject("layout"));
    obj.layItem:setParent(obj);
    obj.layItem:setName("layItem");
    obj.layItem:setAlign("client");
    obj.layItem:setMargins({top=5, bottom=5});

    obj.btnApagar = GUI.fromHandle(_obj_newObject("button"));
    obj.btnApagar:setParent(obj.layItem);
    obj.btnApagar:setName("btnApagar");
    obj.btnApagar:setAlign("left");
    obj.btnApagar:setWidth(25);
    obj.btnApagar:setMargins({right=2});
    obj.btnApagar:setText("✖");

    obj.btnRolarAtaque = GUI.fromHandle(_obj_newObject("button"));
    obj.btnRolarAtaque:setParent(obj.layItem);
    obj.btnRolarAtaque:setName("btnRolarAtaque");
    obj.btnRolarAtaque:setAlign("left");
    obj.btnRolarAtaque:setWidth(25);
    obj.btnRolarAtaque:setMargins({right=2});
    obj.btnRolarAtaque:setText("🎲");

    obj.editName = GUI.fromHandle(_obj_newObject("edit"));
    obj.editName:setParent(obj.layItem);
    obj.editName:setName("editName");
    obj.editName:setAlign("client");
    obj.editName:setField("nome");
    obj.editName:setVertTextAlign("leading");
    obj.editName:setEnabled(false);
    obj.editName:setFontSize(15);
    obj.editName:setFontColor("white");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj);
    obj.dataLink1:setField("nome");
    obj.dataLink1:setDefaultValue("NOME");
    obj.dataLink1:setName("dataLink1");

    obj.dataLink2 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj);
    obj.dataLink2:setField("peso");
    obj.dataLink2:setDefaultValue("");
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

    obj.dataLink6 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink6:setParent(obj);
    obj.dataLink6:setField("propriedades");
    obj.dataLink6:setDefaultValue("");
    obj.dataLink6:setName("dataLink6");

    obj.dataLink7 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink7:setParent(obj);
    obj.dataLink7:setField("alcance");
    obj.dataLink7:setDefaultValue("");
    obj.dataLink7:setName("dataLink7");

    obj.dataLink8 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink8:setParent(obj);
    obj.dataLink8:setField("municao");
    obj.dataLink8:setDefaultValue("");
    obj.dataLink8:setName("dataLink8");

    obj.dataLink9 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink9:setParent(obj);
    obj.dataLink9:setField("qtMunicao");
    obj.dataLink9:setDefaultValue("");
    obj.dataLink9:setName("dataLink9");

    obj.dataLink10 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink10:setParent(obj);
    obj.dataLink10:setField("imagem");
    obj.dataLink10:setDefaultValue("https://clipartart.com/images/cross-sword-clipart.png");
    obj.dataLink10:setName("dataLink10");

    obj._e_event0 = obj.btnApagar:addEventListener("onClick",
        function (event)
            askForDelete();
        end);

    obj._e_event1 = obj.btnRolarAtaque:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.editName);
        end);

    obj._e_event2 = obj.btnRolarAtaque:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.editName);
        end);

    obj._e_event3 = obj.btnRolarAtaque:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaAtaque, { item = sheet }, nil, true);
        end);

    obj._e_event4 = obj.btnRolarAtaque:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaAtaque, { item = sheet }, nil, false);
        end);

    obj._e_event5 = obj.btnRolarAtaque:addEventListener("onMouseEnter",
        function ()
            self.btnRolarAtaque:setFocus();
        end);

    obj._e_event6 = obj.btnRolarAtaque:addEventListener("onExit",
        function ()
            self.editName.fontColor = "white";
        end);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event6);
        __o_rrpgObjs.removeEventListenerById(self._e_event5);
        __o_rrpgObjs.removeEventListenerById(self._e_event4);
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
        if self.dataLink5 ~= nil then self.dataLink5:destroy(); self.dataLink5 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.btnApagar ~= nil then self.btnApagar:destroy(); self.btnApagar = nil; end;
        if self.btnRolarAtaque ~= nil then self.btnRolarAtaque:destroy(); self.btnRolarAtaque = nil; end;
        if self.dataLink4 ~= nil then self.dataLink4:destroy(); self.dataLink4 = nil; end;
        if self.dataLink9 ~= nil then self.dataLink9:destroy(); self.dataLink9 = nil; end;
        if self.editName ~= nil then self.editName:destroy(); self.editName = nil; end;
        if self.dataLink7 ~= nil then self.dataLink7:destroy(); self.dataLink7 = nil; end;
        if self.dataLink10 ~= nil then self.dataLink10:destroy(); self.dataLink10 = nil; end;
        if self.dataLink8 ~= nil then self.dataLink8:destroy(); self.dataLink8 = nil; end;
        if self.dataLink3 ~= nil then self.dataLink3:destroy(); self.dataLink3 = nil; end;
        if self.dataLink6 ~= nil then self.dataLink6:destroy(); self.dataLink6 = nil; end;
        if self.layItem ~= nil then self.layItem:destroy(); self.layItem = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmEquipamentoItem()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmEquipamentoItem();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmEquipamentoItem = {
    newEditor = newfrmEquipamentoItem, 
    new = newfrmEquipamentoItem, 
    name = "frmEquipamentoItem", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    cacheMode = "time", 
    title = "", 
    description=""};

frmEquipamentoItem = _frmEquipamentoItem;
Firecast.registrarForm(_frmEquipamentoItem);

return _frmEquipamentoItem;
