require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmEquipamentoItemDefesa()
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
    obj:setName("frmEquipamentoItemDefesa");
    obj.cacheMode = "time";
    obj.grid.role = "row";
    obj.grid["padding-top"] = 12;
    obj.grid["padding-bottom"] = 12;


		local Utils = require('utils.lua');
	
		function self:tryCastTipoStringToTypeEnumField(inputValue)
			inputValue = string.lower(Utils.removerAcentos(tostring(inputValue)));
			
			local function contains(stringsToFind)										
				for k, v in pairs(stringsToFind) do
					local r = string.find(inputValue, v, 1, true);
					
					if r then
						return r;
					end;						
				end;	

				return nil;
			end;
			
			if contains({'leve', 'light'}) then
				return "lightArmor";		
			elseif contains({'media', 'medio', 'medium'}) then
				return "mediumArmor";
			elseif contains({'pesada', 'pesado', 'heavy'}) then
				return "heavyArmor";
			elseif contains({'escudo', 'shield'}) then
				return "shield";	
			elseif contains({'outro', 'other'}) then
				return "other";		
			else
				return nil;
			end;
		end;
	
		function self:migrateTipoStringToTypeEnumFieldIfNeeded()
			assert(sheet ~= nil);
			
			local currentTipo = sheet.tipo;			
			
			if (sheet.typeEnum == nil) and (currentTipo ~= nil) then
				local convertedValue = self:tryCastTipoStringToTypeEnumField(currentTipo);
				
				if convertedValue ~= nil then
					sheet.typeEnum = convertedValue;
				end;
			end;
		end;
						
		local function askForDelete()
			Dialogs.confirmYesNo("@@DnD5e.generic.deleteConfirmation",
								 function (confirmado)
									if confirmado then
										NDB.deleteNode(self.sheet);
									end;
								 end);
		end;
			
		


		
	


    obj.layout1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout1:setParent(obj);
    obj.layout1.grid.role = "block";
    obj.layout1.grid["auto-height"] = true;
    obj.layout1.grid["dyn-width-each-line"] = true;
    obj.layout1.grid["vert-tile"] = true;
    obj.layout1.grid.gutter = 8;
    obj.layout1:setName("layout1");

    obj.btnApagar = GUI.fromHandle(_obj_newObject("button"));
    obj.btnApagar:setParent(obj.layout1);
    obj.btnApagar.grid.role = "block";
    obj.btnApagar.grid["dyn-width-txt"] = true;
    obj.btnApagar.grid["dyn-height-txt"] = true;
    obj.btnApagar.grid["min-height"] = 30;
    obj.btnApagar.grid["padding-left"] = 8;
    obj.btnApagar.grid["padding-right"] = 8;
    obj.btnApagar.grid["min-width"] = 64;
    obj.btnApagar:setText("@@DnD5e.tab.equipament.btn.delete");
    obj.btnApagar:setName("btnApagar");

    obj.layPrincipal = GUI.fromHandle(_obj_newObject("layout"));
    obj.layPrincipal:setParent(obj);
    obj.layPrincipal.grid.role = "col";
    obj.layPrincipal.grid.width = 12;
    obj.layPrincipal.grid["auto-height"] = true;
    obj.layPrincipal.grid["cnt-line-spacing"] = 8;
    obj.layPrincipal.grid["cnt-gutter"] = 12;
    obj.layPrincipal:setName("layPrincipal");

    obj.layUpperFieldGridCntEdit1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntEdit1:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntEdit1:setName("layUpperFieldGridCntEdit1");
    obj.layUpperFieldGridCntEdit1.grid["auto-height"] = true;
    obj.layUpperFieldGridCntEdit1.grid.role = "col";
    obj.layUpperFieldGridCntEdit1.grid["width-xs"] = 12;
    obj.layUpperFieldGridCntEdit1.grid["width-md"] = 6;
    obj.layUpperFieldGridCntEdit1.grid["width-xl"] = 3;
    obj.layUpperFieldGridCntEdit1.grid["min-width"] = 130;

    obj.edtUpperFieldGridCntEdit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperFieldGridCntEdit1:setParent(obj.layUpperFieldGridCntEdit1);
    obj.edtUpperFieldGridCntEdit1.grid.role = "col";
    obj.edtUpperFieldGridCntEdit1.grid.width = 12;
    obj.edtUpperFieldGridCntEdit1:setName("edtUpperFieldGridCntEdit1");
    obj.edtUpperFieldGridCntEdit1:setField("nome");
    obj.edtUpperFieldGridCntEdit1:setFontSize(13);
    obj.edtUpperFieldGridCntEdit1:setTransparent(false);
    obj.edtUpperFieldGridCntEdit1:setVertTextAlign("center");
    obj.edtUpperFieldGridCntEdit1:setHeight(30);
    obj.edtUpperFieldGridCntEdit1:setWidth(195);
    obj.edtUpperFieldGridCntEdit1:setFontColor("white");

    obj.labUpperFieldGridCntEdit1 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntEdit1:setParent(obj.layUpperFieldGridCntEdit1);
    obj.labUpperFieldGridCntEdit1.grid.role = "col";
    obj.labUpperFieldGridCntEdit1.grid.width = 12;
    obj.labUpperFieldGridCntEdit1.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntEdit1.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntEdit1:setName("labUpperFieldGridCntEdit1");
    obj.labUpperFieldGridCntEdit1:setText("@@DnD5e.tab.equipament.defend.lab.name");
    obj.labUpperFieldGridCntEdit1:setVertTextAlign("leading");
    obj.labUpperFieldGridCntEdit1:setWordWrap(true);
    obj.labUpperFieldGridCntEdit1:setTextTrimming("none");
    obj.labUpperFieldGridCntEdit1:setFontSize(12);
    obj.labUpperFieldGridCntEdit1:setFontColor("#D0D0D0");

    obj.layUpperFieldGridCntEdit2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntEdit2:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntEdit2:setName("layUpperFieldGridCntEdit2");
    obj.layUpperFieldGridCntEdit2.grid["auto-height"] = true;
    obj.layUpperFieldGridCntEdit2.grid.role = "col";
    obj.layUpperFieldGridCntEdit2.grid["width-xs"] = 12;
    obj.layUpperFieldGridCntEdit2.grid["width-sm"] = 6;
    obj.layUpperFieldGridCntEdit2.grid["width-md"] = 3;
    obj.layUpperFieldGridCntEdit2.grid["width-xl"] = 1;
    obj.layUpperFieldGridCntEdit2.grid["min-width"] = 80;

    obj.edtUpperFieldGridCntEdit2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperFieldGridCntEdit2:setParent(obj.layUpperFieldGridCntEdit2);
    obj.edtUpperFieldGridCntEdit2.grid.role = "col";
    obj.edtUpperFieldGridCntEdit2.grid.width = 12;
    obj.edtUpperFieldGridCntEdit2:setName("edtUpperFieldGridCntEdit2");
    obj.edtUpperFieldGridCntEdit2:setField("peso");
    obj.edtUpperFieldGridCntEdit2:setFontSize(13);
    obj.edtUpperFieldGridCntEdit2:setTransparent(false);
    obj.edtUpperFieldGridCntEdit2:setVertTextAlign("center");
    obj.edtUpperFieldGridCntEdit2:setHeight(30);
    obj.edtUpperFieldGridCntEdit2:setWidth(195);
    obj.edtUpperFieldGridCntEdit2:setFontColor("white");

    obj.labUpperFieldGridCntEdit2 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntEdit2:setParent(obj.layUpperFieldGridCntEdit2);
    obj.labUpperFieldGridCntEdit2.grid.role = "col";
    obj.labUpperFieldGridCntEdit2.grid.width = 12;
    obj.labUpperFieldGridCntEdit2.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntEdit2.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntEdit2:setName("labUpperFieldGridCntEdit2");
    obj.labUpperFieldGridCntEdit2:setText("@@DnD5e.tab.equipament.defend.lab.weight");
    obj.labUpperFieldGridCntEdit2:setVertTextAlign("leading");
    obj.labUpperFieldGridCntEdit2:setWordWrap(true);
    obj.labUpperFieldGridCntEdit2:setTextTrimming("none");
    obj.labUpperFieldGridCntEdit2:setFontSize(12);
    obj.labUpperFieldGridCntEdit2:setFontColor("#D0D0D0");

    obj.layTypeEnum = GUI.fromHandle(_obj_newObject("layout"));
    obj.layTypeEnum:setParent(obj.layPrincipal);
    obj.layTypeEnum:setName("layTypeEnum");
    obj.layTypeEnum.grid["auto-height"] = true;
    obj.layTypeEnum.grid.role = "col";
    obj.layTypeEnum.grid["width-xs"] = 12;
    obj.layTypeEnum.grid["width-sm"] = 6;
    obj.layTypeEnum.grid["width-md"] = 4;
    obj.layTypeEnum.grid["width-xl"] = 1;
    obj.layTypeEnum.grid["min-width"] = 110;

    obj.cmbTypeEnum = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.cmbTypeEnum:setParent(obj.layTypeEnum);
    obj.cmbTypeEnum.grid.role = "col";
    obj.cmbTypeEnum.grid.width = 12;
    obj.cmbTypeEnum:setName("cmbTypeEnum");
    obj.cmbTypeEnum:setField("typeEnum");
    obj.cmbTypeEnum:setFontSize(13);
    obj.cmbTypeEnum:setTransparent(false);
    obj.cmbTypeEnum:setHint("");
    obj.cmbTypeEnum:setItems({});
    obj.cmbTypeEnum:setValues({});
    obj.cmbTypeEnum:setHeight(30);
    obj.cmbTypeEnum:setWidth(195);

    obj.labTypeEnum = GUI.fromHandle(_obj_newObject("label"));
    obj.labTypeEnum:setParent(obj.layTypeEnum);
    obj.labTypeEnum.grid.role = "col";
    obj.labTypeEnum.grid.width = 12;
    obj.labTypeEnum.grid["dyn-height-txt"] = true;
    obj.labTypeEnum.grid["margin-top"] = 2;
    obj.labTypeEnum:setName("labTypeEnum");
    obj.labTypeEnum:setText("@@DnD5e.tab.equipament.defend.lab.type");
    obj.labTypeEnum:setVertTextAlign("leading");
    obj.labTypeEnum:setWordWrap(true);
    obj.labTypeEnum:setTextTrimming("none");
    obj.labTypeEnum:setFontSize(12);
    obj.labTypeEnum:setFontColor("#D0D0D0");


			self.cmbTypeEnum.items = { '@@DnD5e.tab.equipament.defend.cmbType.lightArmor', 
			                           '@@DnD5e.tab.equipament.defend.cmbType.mediumArmor', 
									   '@@DnD5e.tab.equipament.defend.cmbType.heavyArmor', 
									   '@@DnD5e.tab.equipament.defend.cmbType.shield',
									   '@@DnD5e.tab.equipament.defend.cmbType.other' }
									   
			self.cmbTypeEnum.values = {'lightArmor', 'mediumArmor', 'heavyArmor', 'shield', 'other'};
		


    obj.layUpperFieldGridCntCheckBox1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntCheckBox1:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntCheckBox1:setName("layUpperFieldGridCntCheckBox1");
    obj.layUpperFieldGridCntCheckBox1.grid["auto-height"] = true;
    obj.layUpperFieldGridCntCheckBox1.grid.role = "block";
    obj.layUpperFieldGridCntCheckBox1:setWidth(32);

    obj.cbxUpperFieldGridCntCheckBox1 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.cbxUpperFieldGridCntCheckBox1:setParent(obj.layUpperFieldGridCntCheckBox1);
    obj.cbxUpperFieldGridCntCheckBox1:setAlign("none");
    obj.cbxUpperFieldGridCntCheckBox1:setWidth(20);
    obj.cbxUpperFieldGridCntCheckBox1:setMargins({});
    obj.cbxUpperFieldGridCntCheckBox1:setField("active");
    obj.cbxUpperFieldGridCntCheckBox1:setOptimize(false);
    obj.cbxUpperFieldGridCntCheckBox1:setImageChecked("images/checkbox2_checked.png");
    obj.cbxUpperFieldGridCntCheckBox1:setImageUnchecked("images/checkbox2_unchecked.png");
    obj.cbxUpperFieldGridCntCheckBox1:setName("cbxUpperFieldGridCntCheckBox1");
    obj.cbxUpperFieldGridCntCheckBox1:setHeight(32);


				self.cbxUpperFieldGridCntCheckBox1['g-role'] = "col";
				self.cbxUpperFieldGridCntCheckBox1['g-width'] = "12";
			


    obj.labUpperFieldGridCntCheckBox1 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntCheckBox1:setParent(obj.layUpperFieldGridCntCheckBox1);
    obj.labUpperFieldGridCntCheckBox1.grid.role = "col";
    obj.labUpperFieldGridCntCheckBox1.grid.width = 12;
    obj.labUpperFieldGridCntCheckBox1.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntCheckBox1.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntCheckBox1:setName("labUpperFieldGridCntCheckBox1");
    obj.labUpperFieldGridCntCheckBox1:setText("@@DnD5e.tab.equipament.btn.active");
    obj.labUpperFieldGridCntCheckBox1:setHorzTextAlign("center");
    obj.labUpperFieldGridCntCheckBox1:setVertTextAlign("leading");
    obj.labUpperFieldGridCntCheckBox1:setWordWrap(true);
    obj.labUpperFieldGridCntCheckBox1:setTextTrimming("none");
    obj.labUpperFieldGridCntCheckBox1:setFontSize(12);
    obj.labUpperFieldGridCntCheckBox1:setFontColor("#D0D0D0");

    obj.layUpperFieldGridCntEdit3 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntEdit3:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntEdit3:setName("layUpperFieldGridCntEdit3");
    obj.layUpperFieldGridCntEdit3.grid["auto-height"] = true;
    obj.layUpperFieldGridCntEdit3.grid.role = "col";
    obj.layUpperFieldGridCntEdit3.grid["width-xs"] = 12;
    obj.layUpperFieldGridCntEdit3.grid["width-sm"] = 6;
    obj.layUpperFieldGridCntEdit3.grid["width-md"] = 3;
    obj.layUpperFieldGridCntEdit3.grid["width-xl"] = 1;
    obj.layUpperFieldGridCntEdit3.grid["min-width"] = 80;

    obj.edtUpperFieldGridCntEdit3 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperFieldGridCntEdit3:setParent(obj.layUpperFieldGridCntEdit3);
    obj.edtUpperFieldGridCntEdit3.grid.role = "col";
    obj.edtUpperFieldGridCntEdit3.grid.width = 12;
    obj.edtUpperFieldGridCntEdit3:setName("edtUpperFieldGridCntEdit3");
    obj.edtUpperFieldGridCntEdit3:setField("caBonus");
    obj.edtUpperFieldGridCntEdit3:setFontSize(13);
    obj.edtUpperFieldGridCntEdit3:setTransparent(false);
    obj.edtUpperFieldGridCntEdit3:setVertTextAlign("center");
    obj.edtUpperFieldGridCntEdit3:setHeight(30);
    obj.edtUpperFieldGridCntEdit3:setWidth(195);
    obj.edtUpperFieldGridCntEdit3:setFontColor("white");

    obj.labUpperFieldGridCntEdit3 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntEdit3:setParent(obj.layUpperFieldGridCntEdit3);
    obj.labUpperFieldGridCntEdit3.grid.role = "col";
    obj.labUpperFieldGridCntEdit3.grid.width = 12;
    obj.labUpperFieldGridCntEdit3.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntEdit3.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntEdit3:setName("labUpperFieldGridCntEdit3");
    obj.labUpperFieldGridCntEdit3:setText("@@DnD5e.tab.equipament.defend.lab.ca");
    obj.labUpperFieldGridCntEdit3:setVertTextAlign("leading");
    obj.labUpperFieldGridCntEdit3:setWordWrap(true);
    obj.labUpperFieldGridCntEdit3:setTextTrimming("none");
    obj.labUpperFieldGridCntEdit3:setFontSize(12);
    obj.labUpperFieldGridCntEdit3:setFontColor("#D0D0D0");

    obj.layUpperFieldGridCntCheckBox2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntCheckBox2:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntCheckBox2:setName("layUpperFieldGridCntCheckBox2");
    obj.layUpperFieldGridCntCheckBox2.grid["auto-height"] = true;
    obj.layUpperFieldGridCntCheckBox2.grid.role = "block";
    obj.layUpperFieldGridCntCheckBox2:setWidth(32);

    obj.cbxUpperFieldGridCntCheckBox2 = GUI.fromHandle(_obj_newObject("imageCheckBox"));
    obj.cbxUpperFieldGridCntCheckBox2:setParent(obj.layUpperFieldGridCntCheckBox2);
    obj.cbxUpperFieldGridCntCheckBox2:setAlign("none");
    obj.cbxUpperFieldGridCntCheckBox2:setWidth(20);
    obj.cbxUpperFieldGridCntCheckBox2:setMargins({});
    obj.cbxUpperFieldGridCntCheckBox2:setField("penalidade");
    obj.cbxUpperFieldGridCntCheckBox2:setOptimize(false);
    obj.cbxUpperFieldGridCntCheckBox2:setImageChecked("images/checkbox2_checked.png");
    obj.cbxUpperFieldGridCntCheckBox2:setImageUnchecked("images/checkbox2_unchecked.png");
    obj.cbxUpperFieldGridCntCheckBox2:setName("cbxUpperFieldGridCntCheckBox2");
    obj.cbxUpperFieldGridCntCheckBox2:setHeight(32);


				self.cbxUpperFieldGridCntCheckBox2['g-role'] = "col";
				self.cbxUpperFieldGridCntCheckBox2['g-width'] = "12";
			


    obj.labUpperFieldGridCntCheckBox2 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntCheckBox2:setParent(obj.layUpperFieldGridCntCheckBox2);
    obj.labUpperFieldGridCntCheckBox2.grid.role = "col";
    obj.labUpperFieldGridCntCheckBox2.grid.width = 12;
    obj.labUpperFieldGridCntCheckBox2.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntCheckBox2.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntCheckBox2:setName("labUpperFieldGridCntCheckBox2");
    obj.labUpperFieldGridCntCheckBox2:setText("@@DnD5e.tab.equipament.btn.pen");
    obj.labUpperFieldGridCntCheckBox2:setHorzTextAlign("center");
    obj.labUpperFieldGridCntCheckBox2:setVertTextAlign("leading");
    obj.labUpperFieldGridCntCheckBox2:setWordWrap(true);
    obj.labUpperFieldGridCntCheckBox2:setTextTrimming("none");
    obj.labUpperFieldGridCntCheckBox2:setFontSize(12);
    obj.labUpperFieldGridCntCheckBox2:setFontColor("#D0D0D0");

    obj.layUpperFieldGridCntEdit4 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layUpperFieldGridCntEdit4:setParent(obj.layPrincipal);
    obj.layUpperFieldGridCntEdit4:setName("layUpperFieldGridCntEdit4");
    obj.layUpperFieldGridCntEdit4.grid["auto-height"] = true;
    obj.layUpperFieldGridCntEdit4.grid.role = "col";
    obj.layUpperFieldGridCntEdit4.grid["width-xs"] = 12;
    obj.layUpperFieldGridCntEdit4.grid["width-md"] = 6;
    obj.layUpperFieldGridCntEdit4.grid["width-xl"] = 2;
    obj.layUpperFieldGridCntEdit4.grid["min-width"] = 110;

    obj.edtUpperFieldGridCntEdit4 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperFieldGridCntEdit4:setParent(obj.layUpperFieldGridCntEdit4);
    obj.edtUpperFieldGridCntEdit4.grid.role = "col";
    obj.edtUpperFieldGridCntEdit4.grid.width = 12;
    obj.edtUpperFieldGridCntEdit4:setName("edtUpperFieldGridCntEdit4");
    obj.edtUpperFieldGridCntEdit4:setField("propriedades");
    obj.edtUpperFieldGridCntEdit4:setFontSize(13);
    obj.edtUpperFieldGridCntEdit4:setTransparent(false);
    obj.edtUpperFieldGridCntEdit4:setVertTextAlign("center");
    obj.edtUpperFieldGridCntEdit4:setHeight(30);
    obj.edtUpperFieldGridCntEdit4:setWidth(195);
    obj.edtUpperFieldGridCntEdit4:setFontColor("white");

    obj.labUpperFieldGridCntEdit4 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperFieldGridCntEdit4:setParent(obj.layUpperFieldGridCntEdit4);
    obj.labUpperFieldGridCntEdit4.grid.role = "col";
    obj.labUpperFieldGridCntEdit4.grid.width = 12;
    obj.labUpperFieldGridCntEdit4.grid["dyn-height-txt"] = true;
    obj.labUpperFieldGridCntEdit4.grid["margin-top"] = 2;
    obj.labUpperFieldGridCntEdit4:setName("labUpperFieldGridCntEdit4");
    obj.labUpperFieldGridCntEdit4:setText("@@DnD5e.tab.equipament.defend.lab.property");
    obj.labUpperFieldGridCntEdit4:setVertTextAlign("leading");
    obj.labUpperFieldGridCntEdit4:setWordWrap(true);
    obj.labUpperFieldGridCntEdit4:setTextTrimming("none");
    obj.labUpperFieldGridCntEdit4:setFontSize(12);
    obj.labUpperFieldGridCntEdit4:setFontColor("#D0D0D0");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj);
    obj.dataLink1:setFields({'caBonus', 'active', 'typeEnum'});
    obj.dataLink1:setName("dataLink1");

    obj._e_event0 = obj:addEventListener("onNodeReady",
        function ()
            self:migrateTipoStringToTypeEnumFieldIfNeeded();
        end);

    obj._e_event1 = obj.btnApagar:addEventListener("onClick",
        function (event)
            askForDelete();
        end);

    obj._e_event2 = obj.dataLink1:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet==nil then return end
            
            			local rootNode = NDB.getRoot(sheet)
            			local nodes = NDB.getChildNodes(rootNode.equipamentos.defesas)
            			local ca = 0
            			local isUsingHeavyArmor = false;
            			local isUsingMediumArmor = false;
            			
            			for i=1, #nodes, 1 do
            				if nodes[i].active then
            					local bonus = common.interpreta(nodes[i], nodes[i].caBonus);
            									
            					local rolagem = Firecast.interpretarRolagem(bonus)
            					rolagem = Firecast.interpretarRolagem("1d1-1"):concatenar(rolagem)
            					rolagem:rolarLocalmente()
            					bonus = rolagem.resultado
            					
            					ca = ca + (tonumber(bonus) or 0)
            					
            					local equipType = nodes[i].typeEnum;
            					
            					if equipType == "heavyArmor" then					
            						isUsingHeavyArmor = true;
            					elseif equipType == "mediumArmor" then
            						isUsingMediumArmor = true;
            					end;
            				end
            			end
            
            			rootNode.caEquip = ca
            			
            			if isUsingHeavyArmor then
            				rootNode.caEquipDexMode = "heavyArmor";
            			elseif isUsingMediumArmor then
            				rootNode.caEquipDexMode = "mediumArmor";
            			else
            				rootNode.caEquipDexMode = nil;  -- default mode
            			end;
        end);

    function obj:_releaseEvents()
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

        if self.layTypeEnum ~= nil then self.layTypeEnum:destroy(); self.layTypeEnum = nil; end;
        if self.labUpperFieldGridCntCheckBox2 ~= nil then self.labUpperFieldGridCntCheckBox2:destroy(); self.labUpperFieldGridCntCheckBox2 = nil; end;
        if self.labUpperFieldGridCntEdit1 ~= nil then self.labUpperFieldGridCntEdit1:destroy(); self.labUpperFieldGridCntEdit1 = nil; end;
        if self.cbxUpperFieldGridCntCheckBox1 ~= nil then self.cbxUpperFieldGridCntCheckBox1:destroy(); self.cbxUpperFieldGridCntCheckBox1 = nil; end;
        if self.layUpperFieldGridCntEdit4 ~= nil then self.layUpperFieldGridCntEdit4:destroy(); self.layUpperFieldGridCntEdit4 = nil; end;
        if self.layPrincipal ~= nil then self.layPrincipal:destroy(); self.layPrincipal = nil; end;
        if self.cbxUpperFieldGridCntCheckBox2 ~= nil then self.cbxUpperFieldGridCntCheckBox2:destroy(); self.cbxUpperFieldGridCntCheckBox2 = nil; end;
        if self.labUpperFieldGridCntEdit4 ~= nil then self.labUpperFieldGridCntEdit4:destroy(); self.labUpperFieldGridCntEdit4 = nil; end;
        if self.edtUpperFieldGridCntEdit2 ~= nil then self.edtUpperFieldGridCntEdit2:destroy(); self.edtUpperFieldGridCntEdit2 = nil; end;
        if self.edtUpperFieldGridCntEdit1 ~= nil then self.edtUpperFieldGridCntEdit1:destroy(); self.edtUpperFieldGridCntEdit1 = nil; end;
        if self.layUpperFieldGridCntEdit1 ~= nil then self.layUpperFieldGridCntEdit1:destroy(); self.layUpperFieldGridCntEdit1 = nil; end;
        if self.labUpperFieldGridCntCheckBox1 ~= nil then self.labUpperFieldGridCntCheckBox1:destroy(); self.labUpperFieldGridCntCheckBox1 = nil; end;
        if self.layUpperFieldGridCntCheckBox1 ~= nil then self.layUpperFieldGridCntCheckBox1:destroy(); self.layUpperFieldGridCntCheckBox1 = nil; end;
        if self.edtUpperFieldGridCntEdit4 ~= nil then self.edtUpperFieldGridCntEdit4:destroy(); self.edtUpperFieldGridCntEdit4 = nil; end;
        if self.labUpperFieldGridCntEdit2 ~= nil then self.labUpperFieldGridCntEdit2:destroy(); self.labUpperFieldGridCntEdit2 = nil; end;
        if self.layout1 ~= nil then self.layout1:destroy(); self.layout1 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.edtUpperFieldGridCntEdit3 ~= nil then self.edtUpperFieldGridCntEdit3:destroy(); self.edtUpperFieldGridCntEdit3 = nil; end;
        if self.layUpperFieldGridCntEdit3 ~= nil then self.layUpperFieldGridCntEdit3:destroy(); self.layUpperFieldGridCntEdit3 = nil; end;
        if self.btnApagar ~= nil then self.btnApagar:destroy(); self.btnApagar = nil; end;
        if self.labTypeEnum ~= nil then self.labTypeEnum:destroy(); self.labTypeEnum = nil; end;
        if self.layUpperFieldGridCntCheckBox2 ~= nil then self.layUpperFieldGridCntCheckBox2:destroy(); self.layUpperFieldGridCntCheckBox2 = nil; end;
        if self.labUpperFieldGridCntEdit3 ~= nil then self.labUpperFieldGridCntEdit3:destroy(); self.labUpperFieldGridCntEdit3 = nil; end;
        if self.cmbTypeEnum ~= nil then self.cmbTypeEnum:destroy(); self.cmbTypeEnum = nil; end;
        if self.layUpperFieldGridCntEdit2 ~= nil then self.layUpperFieldGridCntEdit2:destroy(); self.layUpperFieldGridCntEdit2 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmEquipamentoItemDefesa()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmEquipamentoItemDefesa();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmEquipamentoItemDefesa = {
    newEditor = newfrmEquipamentoItemDefesa, 
    new = newfrmEquipamentoItemDefesa, 
    name = "frmEquipamentoItemDefesa", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    cacheMode = "time", 
    title = "", 
    description=""};

frmEquipamentoItemDefesa = _frmEquipamentoItemDefesa;
Firecast.registrarForm(_frmEquipamentoItemDefesa);

return _frmEquipamentoItemDefesa;
