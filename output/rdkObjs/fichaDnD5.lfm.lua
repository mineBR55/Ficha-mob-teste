require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmDnD5()
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
    obj:setDataType("br.com.mineBR55.MobDnD5e_S3");
    obj:setFormType("sheetTemplate");
    obj:setTitle("Mob DnD 5e");
    obj:setDescription("Ficha de monstros para DnD 5e");
    obj:setName("frmDnD5");
    obj:setTheme("dark");
    obj.cacheMode = "time";

    obj.pgcPrincipal = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.pgcPrincipal:setParent(obj);
    obj.pgcPrincipal:setAlign("client");
    obj.pgcPrincipal:setName("pgcPrincipal");

    obj.tab1 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab1:setParent(obj.pgcPrincipal);
    obj.tab1:setTitle("Frente");
    obj.tab1:setName("tab1");

    obj.rectangle1 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle1:setParent(obj.tab1);
    obj.rectangle1:setName("rectangle1");
    obj.rectangle1:setAlign("client");
    obj.rectangle1:setColor("#40000000");
    obj.rectangle1:setXradius(10);
    obj.rectangle1:setYradius(10);


        
        require("locale.lua");

        function self:sortSkillBoxesOf(attrName)
            local sortData = self.__attrSortData;

            if sortData == nil then
                return;
            end;

            local attrSortData = sortData[attrName];

            if attrSortData == nil then
                return;
            end;

            table.sort(attrSortData,
                function (left, right)
                    local leftStr = Locale.eval(left.title);
                    local rightStr = Locale.eval(right.title);
                    return Utils.compareStringPtBr(leftStr, rightStr) < 0;
                end);

            for i = 1, #attrSortData, 1 do
                local ctrl = self:findControlByName(attrSortData[i].controlName);

                if ctrl ~= nil then
                    local previousParent = ctrl:getParent();
                    ctrl:setParent(nil);
                    ctrl:setParent(previousParent);
                end;
            end;
        end;

        function self:sortFrontSkillBoxes()
            self:sortSkillBoxesOf("forca");
            self:sortSkillBoxesOf("destreza");
            self:sortSkillBoxesOf("constituicao");
            self:sortSkillBoxesOf("inteligencia");
            self:sortSkillBoxesOf("sabedoria");
            self:sortSkillBoxesOf("carisma");
        end;

        local function _parseCR(v)
            local s = tostring(v or ""):gsub("%s+", ""):gsub(",", ".");
            if s == "" then return 0 end;

            local a, b = s:match("^(%d+)%/(%d+)$");
            if a ~= nil and b ~= nil then
                a = tonumber(a);
                b = tonumber(b);
                if a ~= nil and b ~= nil and b ~= 0 then
                    return a / b;
                end;
            end;

            return tonumber(s) or 0;
        end;

        local function _pbFromCR(cr)
            if cr >= 29 then return 9 end
            if cr >= 25 then return 8 end
            if cr >= 21 then return 7 end
            if cr >= 17 then return 6 end
            if cr >= 13 then return 5 end
            if cr >= 9  then return 4 end
            if cr >= 5  then return 3 end
            return 2
        end

        function self:syncPbFromCR()
            if sheet == nil then return end;

            local cr = _parseCR(sheet.CR);
            local pb = _pbFromCR(cr);

            sheet.bonusProficiencia = tostring(pb);

            if sheet.pericias ~= nil and sheet.pericias.bonuspercepcao ~= nil then
                local perc = tonumber(sheet.pericias.bonuspercepcao) or 0;
                sheet.sabedoriaPassiva = tostring(10 + perc);
            end;
        end
        
    


    obj.scrollBox1 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox1:setParent(obj.rectangle1);
    obj.scrollBox1:setAlign("client");
    obj.scrollBox1:setName("scrollBox1");

    obj.fraFrenteLayout = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraFrenteLayout:setParent(obj.scrollBox1);
    obj.fraFrenteLayout:setAlign("top");
    obj.fraFrenteLayout:setHeight(500);
    obj.fraFrenteLayout:setMargins({left=10, right=10, top=10});
    obj.fraFrenteLayout:setAutoHeight(true);
    obj.fraFrenteLayout:setHorzAlign("center");
    obj.fraFrenteLayout:setLineSpacing(2);
    obj.fraFrenteLayout:setName("fraFrenteLayout");
    obj.fraFrenteLayout:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.fraFrenteLayout:setMinScaledWidth(300);
    obj.fraFrenteLayout:setVertAlign("leading");

    obj.flowLayout1 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout1:setParent(obj.fraFrenteLayout);
    obj.flowLayout1:setAutoHeight(true);
    obj.flowLayout1:setMinScaledWidth(290);
    obj.flowLayout1:setHorzAlign("center");
    obj.flowLayout1:setName("flowLayout1");
    obj.flowLayout1:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout1:setVertAlign("leading");

    obj.flwNomeMob = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwNomeMob:setParent(obj.flowLayout1);
    obj.flwNomeMob:setName("flwNomeMob");
    obj.flwNomeMob:setMinWidth(320);
    obj.flwNomeMob:setMaxWidth(1600);
    obj.flwNomeMob:setFrameStyle("frames/banner/dragon.xml");
    obj.flwNomeMob:setHeight(175);
    obj.flwNomeMob:setVertAlign("center");
    obj.flwNomeMob:setAvoidScale(true);
    obj.flwNomeMob:setMargins({left=1, right=1, top=2, bottom=2});

    obj.layNomeHolderFrente = GUI.fromHandle(_obj_newObject("layout"));
    obj.layNomeHolderFrente:setParent(obj.flwNomeMob);
    obj.layNomeHolderFrente:setAlign("client");
    obj.layNomeHolderFrente:setName("layNomeHolderFrente");

    obj.edtNomeMob = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtNomeMob:setParent(obj.layNomeHolderFrente);
    obj.edtNomeMob:setName("edtNomeMob");
    obj.edtNomeMob:setField("nome");
    obj.edtNomeMob:setFontSize(17);
    obj.edtNomeMob:setAlign("client");
    obj.edtNomeMob:setFontColor("white");
    obj.edtNomeMob:setVertTextAlign("center");
    obj.edtNomeMob:setTransparent(true);

    obj.labNomeMob = GUI.fromHandle(_obj_newObject("label"));
    obj.labNomeMob:setParent(obj.layNomeHolderFrente);
    obj.labNomeMob:setMargins({left=3});
    obj.labNomeMob:setName("labNomeMob");
    obj.labNomeMob:setAlign("bottom");
    obj.labNomeMob:setText("Nome do Monstro");
    obj.labNomeMob:setAutoSize(true);
    obj.labNomeMob:setFontSize(12);
    obj.labNomeMob:setFontColor("#D0D0D0");

    obj.fraUpperGridFrenteMob = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraUpperGridFrenteMob:setParent(obj.flowLayout1);
    obj.fraUpperGridFrenteMob:setMinWidth(320);
    obj.fraUpperGridFrenteMob:setMaxWidth(1600);
    obj.fraUpperGridFrenteMob:setName("fraUpperGridFrenteMob");
    obj.fraUpperGridFrenteMob:setAvoidScale(true);
    obj.fraUpperGridFrenteMob:setFrameStyle("frames/upperInfoGrid/frame.xml");
    obj.fraUpperGridFrenteMob:setAutoHeight(true);
    obj.fraUpperGridFrenteMob:setVertAlign("trailing");
    obj.fraUpperGridFrenteMob:setMaxControlsPerLine(3);
    obj.fraUpperGridFrenteMob:setMargins({left=1, right=1, top=2, bottom=2});

    obj.UpperGridCampo1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo1:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo1:setHeight(50);
    obj.UpperGridCampo1:setMinScaledWidth(100);
    obj.UpperGridCampo1:setMinWidth(100);
    obj.UpperGridCampo1:setMaxWidth(233);
    obj.UpperGridCampo1:setMaxScaledWidth(233);
    obj.UpperGridCampo1:setAvoidScale(true);
    obj.UpperGridCampo1:setName("UpperGridCampo1");
    obj.UpperGridCampo1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo1:setVertAlign("leading");

    obj.edtUpperGridCampo1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.edtUpperGridCampo1:setName("edtUpperGridCampo1");
    obj.edtUpperGridCampo1:setAlign("top");
    obj.edtUpperGridCampo1:setField("classeENivel");
    obj.edtUpperGridCampo1:setFontSize(13);
    obj.edtUpperGridCampo1:setHeight(30);
    obj.edtUpperGridCampo1:setTransparent(true);
    obj.edtUpperGridCampo1:setVertTextAlign("trailing");
    obj.edtUpperGridCampo1:setWidth(195);
    obj.edtUpperGridCampo1:setFontColor("white");

    obj.linUpperGridCampo1 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.linUpperGridCampo1:setName("linUpperGridCampo1");
    obj.linUpperGridCampo1:setAlign("top");
    obj.linUpperGridCampo1:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo1:setStrokeSize(1);

    obj.labUpperGridCampo1 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.labUpperGridCampo1:setName("labUpperGridCampo1");
    obj.labUpperGridCampo1:setAlign("top");
    obj.labUpperGridCampo1:setText("Tamanho / Tipo");
    obj.labUpperGridCampo1:setVertTextAlign("leading");
    obj.labUpperGridCampo1:setWordWrap(true);
    obj.labUpperGridCampo1:setTextTrimming("none");
    obj.labUpperGridCampo1:setFontSize(12);
    obj.labUpperGridCampo1:setFontColor("#D0D0D0");

    self.UpperGridCampo1:setHeight(self.edtUpperGridCampo1:getHeight() + self.labUpperGridCampo1:getHeight() + self.linUpperGridCampo1:getHeight());


    obj.UpperGridCampo2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo2:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo2:setHeight(50);
    obj.UpperGridCampo2:setMinScaledWidth(100);
    obj.UpperGridCampo2:setMinWidth(100);
    obj.UpperGridCampo2:setMaxWidth(233);
    obj.UpperGridCampo2:setMaxScaledWidth(233);
    obj.UpperGridCampo2:setAvoidScale(true);
    obj.UpperGridCampo2:setName("UpperGridCampo2");
    obj.UpperGridCampo2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo2:setVertAlign("leading");

    obj.edtUpperGridCampo2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.edtUpperGridCampo2:setName("edtUpperGridCampo2");
    obj.edtUpperGridCampo2:setAlign("top");
    obj.edtUpperGridCampo2:setField("tendencia");
    obj.edtUpperGridCampo2:setFontSize(13);
    obj.edtUpperGridCampo2:setHeight(30);
    obj.edtUpperGridCampo2:setTransparent(true);
    obj.edtUpperGridCampo2:setVertTextAlign("trailing");
    obj.edtUpperGridCampo2:setWidth(195);
    obj.edtUpperGridCampo2:setFontColor("white");

    obj.linUpperGridCampo2 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.linUpperGridCampo2:setName("linUpperGridCampo2");
    obj.linUpperGridCampo2:setAlign("top");
    obj.linUpperGridCampo2:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo2:setStrokeSize(1);

    obj.labUpperGridCampo2 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.labUpperGridCampo2:setName("labUpperGridCampo2");
    obj.labUpperGridCampo2:setAlign("top");
    obj.labUpperGridCampo2:setText("Alinhamento");
    obj.labUpperGridCampo2:setVertTextAlign("leading");
    obj.labUpperGridCampo2:setWordWrap(true);
    obj.labUpperGridCampo2:setTextTrimming("none");
    obj.labUpperGridCampo2:setFontSize(12);
    obj.labUpperGridCampo2:setFontColor("#D0D0D0");

    self.UpperGridCampo2:setHeight(self.edtUpperGridCampo2:getHeight() + self.labUpperGridCampo2:getHeight() + self.linUpperGridCampo2:getHeight());


    obj.UpperGridCampo3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo3:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo3:setHeight(50);
    obj.UpperGridCampo3:setMinScaledWidth(100);
    obj.UpperGridCampo3:setMinWidth(100);
    obj.UpperGridCampo3:setMaxWidth(233);
    obj.UpperGridCampo3:setMaxScaledWidth(233);
    obj.UpperGridCampo3:setAvoidScale(true);
    obj.UpperGridCampo3:setName("UpperGridCampo3");
    obj.UpperGridCampo3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo3:setVertAlign("leading");

    obj.edtUpperGridCampo3 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.edtUpperGridCampo3:setName("edtUpperGridCampo3");
    obj.edtUpperGridCampo3:setAlign("top");
    obj.edtUpperGridCampo3:setField("CR");
    obj.edtUpperGridCampo3:setFontSize(13);
    obj.edtUpperGridCampo3:setHeight(30);
    obj.edtUpperGridCampo3:setTransparent(true);
    obj.edtUpperGridCampo3:setVertTextAlign("trailing");
    obj.edtUpperGridCampo3:setWidth(195);
    obj.edtUpperGridCampo3:setFontColor("white");

    obj.linUpperGridCampo3 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.linUpperGridCampo3:setName("linUpperGridCampo3");
    obj.linUpperGridCampo3:setAlign("top");
    obj.linUpperGridCampo3:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo3:setStrokeSize(1);

    obj.labUpperGridCampo3 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.labUpperGridCampo3:setName("labUpperGridCampo3");
    obj.labUpperGridCampo3:setAlign("top");
    obj.labUpperGridCampo3:setText("CR");
    obj.labUpperGridCampo3:setVertTextAlign("leading");
    obj.labUpperGridCampo3:setWordWrap(true);
    obj.labUpperGridCampo3:setTextTrimming("none");
    obj.labUpperGridCampo3:setFontSize(12);
    obj.labUpperGridCampo3:setFontColor("#D0D0D0");

    self.UpperGridCampo3:setHeight(self.edtUpperGridCampo3:getHeight() + self.labUpperGridCampo3:getHeight() + self.linUpperGridCampo3:getHeight());


    obj.UpperGridCampo4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo4:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo4:setHeight(50);
    obj.UpperGridCampo4:setMinScaledWidth(100);
    obj.UpperGridCampo4:setMinWidth(100);
    obj.UpperGridCampo4:setMaxWidth(233);
    obj.UpperGridCampo4:setMaxScaledWidth(233);
    obj.UpperGridCampo4:setAvoidScale(true);
    obj.UpperGridCampo4:setName("UpperGridCampo4");
    obj.UpperGridCampo4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo4:setVertAlign("leading");

    obj.edtUpperGridCampo4 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.edtUpperGridCampo4:setName("edtUpperGridCampo4");
    obj.edtUpperGridCampo4:setAlign("top");
    obj.edtUpperGridCampo4:setField("experiencia.valor");
    obj.edtUpperGridCampo4:setFontSize(13);
    obj.edtUpperGridCampo4:setHeight(30);
    obj.edtUpperGridCampo4:setTransparent(true);
    obj.edtUpperGridCampo4:setVertTextAlign("trailing");
    obj.edtUpperGridCampo4:setWidth(195);
    obj.edtUpperGridCampo4:setFontColor("white");

    obj.linUpperGridCampo4 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.linUpperGridCampo4:setName("linUpperGridCampo4");
    obj.linUpperGridCampo4:setAlign("top");
    obj.linUpperGridCampo4:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo4:setStrokeSize(1);

    obj.labUpperGridCampo4 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.labUpperGridCampo4:setName("labUpperGridCampo4");
    obj.labUpperGridCampo4:setAlign("top");
    obj.labUpperGridCampo4:setText("XP");
    obj.labUpperGridCampo4:setVertTextAlign("leading");
    obj.labUpperGridCampo4:setWordWrap(true);
    obj.labUpperGridCampo4:setTextTrimming("none");
    obj.labUpperGridCampo4:setFontSize(12);
    obj.labUpperGridCampo4:setFontColor("#D0D0D0");

    self.UpperGridCampo4:setHeight(self.edtUpperGridCampo4:getHeight() + self.labUpperGridCampo4:getHeight() + self.linUpperGridCampo4:getHeight());


    obj.UpperGridCampo5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo5:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo5:setHeight(50);
    obj.UpperGridCampo5:setMinScaledWidth(100);
    obj.UpperGridCampo5:setMinWidth(100);
    obj.UpperGridCampo5:setMaxWidth(233);
    obj.UpperGridCampo5:setMaxScaledWidth(233);
    obj.UpperGridCampo5:setAvoidScale(true);
    obj.UpperGridCampo5:setName("UpperGridCampo5");
    obj.UpperGridCampo5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo5:setVertAlign("leading");

    obj.edtUpperGridCampo5 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.edtUpperGridCampo5:setName("edtUpperGridCampo5");
    obj.edtUpperGridCampo5:setAlign("top");
    obj.edtUpperGridCampo5:setField("raca");
    obj.edtUpperGridCampo5:setFontSize(13);
    obj.edtUpperGridCampo5:setHeight(30);
    obj.edtUpperGridCampo5:setTransparent(true);
    obj.edtUpperGridCampo5:setVertTextAlign("trailing");
    obj.edtUpperGridCampo5:setWidth(195);
    obj.edtUpperGridCampo5:setFontColor("white");

    obj.linUpperGridCampo5 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.linUpperGridCampo5:setName("linUpperGridCampo5");
    obj.linUpperGridCampo5:setAlign("top");
    obj.linUpperGridCampo5:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo5:setStrokeSize(1);

    obj.labUpperGridCampo5 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.labUpperGridCampo5:setName("labUpperGridCampo5");
    obj.labUpperGridCampo5:setAlign("top");
    obj.labUpperGridCampo5:setText("Origem / Grupo");
    obj.labUpperGridCampo5:setVertTextAlign("leading");
    obj.labUpperGridCampo5:setWordWrap(true);
    obj.labUpperGridCampo5:setTextTrimming("none");
    obj.labUpperGridCampo5:setFontSize(12);
    obj.labUpperGridCampo5:setFontColor("#D0D0D0");

    self.UpperGridCampo5:setHeight(self.edtUpperGridCampo5:getHeight() + self.labUpperGridCampo5:getHeight() + self.linUpperGridCampo5:getHeight());


    obj.UpperGridCampo6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo6:setParent(obj.fraUpperGridFrenteMob);
    obj.UpperGridCampo6:setHeight(50);
    obj.UpperGridCampo6:setMinScaledWidth(100);
    obj.UpperGridCampo6:setMinWidth(100);
    obj.UpperGridCampo6:setMaxWidth(233);
    obj.UpperGridCampo6:setMaxScaledWidth(233);
    obj.UpperGridCampo6:setAvoidScale(true);
    obj.UpperGridCampo6:setName("UpperGridCampo6");
    obj.UpperGridCampo6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo6:setVertAlign("leading");

    obj.edtUpperGridCampo6 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.edtUpperGridCampo6:setName("edtUpperGridCampo6");
    obj.edtUpperGridCampo6:setAlign("top");
    obj.edtUpperGridCampo6:setField("nomeDoJogador");
    obj.edtUpperGridCampo6:setFontSize(13);
    obj.edtUpperGridCampo6:setHeight(30);
    obj.edtUpperGridCampo6:setTransparent(true);
    obj.edtUpperGridCampo6:setVertTextAlign("trailing");
    obj.edtUpperGridCampo6:setWidth(195);
    obj.edtUpperGridCampo6:setFontColor("white");

    obj.linUpperGridCampo6 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.linUpperGridCampo6:setName("linUpperGridCampo6");
    obj.linUpperGridCampo6:setAlign("top");
    obj.linUpperGridCampo6:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo6:setStrokeSize(1);

    obj.labUpperGridCampo6 = GUI.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.labUpperGridCampo6:setName("labUpperGridCampo6");
    obj.labUpperGridCampo6:setAlign("top");
    obj.labUpperGridCampo6:setText("Fonte / Livro");
    obj.labUpperGridCampo6:setVertTextAlign("leading");
    obj.labUpperGridCampo6:setWordWrap(true);
    obj.labUpperGridCampo6:setTextTrimming("none");
    obj.labUpperGridCampo6:setFontSize(12);
    obj.labUpperGridCampo6:setFontColor("#D0D0D0");

    self.UpperGridCampo6:setHeight(self.edtUpperGridCampo6:getHeight() + self.labUpperGridCampo6:getHeight() + self.linUpperGridCampo6:getHeight());


    obj.flowLineBreak1 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak1:setParent(obj.fraFrenteLayout);
    obj.flowLineBreak1:setName("flowLineBreak1");

    obj.flowLayout2 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout2:setParent(obj.fraFrenteLayout);
    obj.flowLayout2:setHorzAlign("justify");
    obj.flowLayout2:setAutoHeight(true);
    obj.flowLayout2:setAvoidScale(true);
    obj.flowLayout2:setName("flowLayout2");
    obj.flowLayout2:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout2:setMinScaledWidth(300);
    obj.flowLayout2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout2:setVertAlign("leading");

    obj.flowPart1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart1:setParent(obj.flowLayout2);
    obj.flowPart1:setMinWidth(240);
    obj.flowPart1:setMaxWidth(700);
    obj.flowPart1:setHeight(64);
    obj.flowPart1:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart1:setName("flowPart1");
    obj.flowPart1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart1:setVertAlign("leading");

    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.flowPart1);
    obj.edit1:setAlign("left");
    obj.edit1:setField("bonusProficiencia");
    obj.edit1:setWidth(70);
    obj.edit1:setName("edit1");
    obj.edit1:setTransparent(true);
    obj.edit1:setVertTextAlign("center");
    obj.edit1:setHorzTextAlign("center");
    obj.edit1:setFontSize(15);
    obj.edit1:setFontColor("white");

    obj.label1 = GUI.fromHandle(_obj_newObject("label"));
    obj.label1:setParent(obj.flowPart1);
    obj.label1:setAlign("client");
    obj.label1:setText("Proficiência (auto pela CR)");
    obj.label1:setMargins({left=10});
    obj.label1:setHorzTextAlign("center");
    obj.label1:setName("label1");
    obj.label1:setFontSize(12);
    obj.label1:setFontColor("#D0D0D0");

    obj.flowPart2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart2:setParent(obj.flowLayout2);
    obj.flowPart2:setMinWidth(240);
    obj.flowPart2:setMaxWidth(700);
    obj.flowPart2:setHeight(64);
    obj.flowPart2:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart2:setName("flowPart2");
    obj.flowPart2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart2:setVertAlign("leading");

    obj.edit2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit2:setParent(obj.flowPart2);
    obj.edit2:setAlign("left");
    obj.edit2:setField("bonusHabilidades");
    obj.edit2:setWidth(70);
    obj.edit2:setName("edit2");
    obj.edit2:setTransparent(true);
    obj.edit2:setVertTextAlign("center");
    obj.edit2:setHorzTextAlign("center");
    obj.edit2:setFontSize(15);
    obj.edit2:setFontColor("white");

    obj.label2 = GUI.fromHandle(_obj_newObject("label"));
    obj.label2:setParent(obj.flowPart2);
    obj.label2:setAlign("client");
    obj.label2:setText("Bônus Global de Perícias");
    obj.label2:setMargins({left=10});
    obj.label2:setHorzTextAlign("center");
    obj.label2:setName("label2");
    obj.label2:setFontSize(12);
    obj.label2:setFontColor("#D0D0D0");

    obj.flowPart3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart3:setParent(obj.flowLayout2);
    obj.flowPart3:setMinWidth(240);
    obj.flowPart3:setMaxWidth(700);
    obj.flowPart3:setHeight(64);
    obj.flowPart3:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart3:setName("flowPart3");
    obj.flowPart3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart3:setVertAlign("leading");

    obj.edit3 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit3:setParent(obj.flowPart3);
    obj.edit3:setAlign("left");
    obj.edit3:setField("bonusResistencias");
    obj.edit3:setWidth(70);
    obj.edit3:setName("edit3");
    obj.edit3:setTransparent(true);
    obj.edit3:setVertTextAlign("center");
    obj.edit3:setHorzTextAlign("center");
    obj.edit3:setFontSize(15);
    obj.edit3:setFontColor("white");

    obj.label3 = GUI.fromHandle(_obj_newObject("label"));
    obj.label3:setParent(obj.flowPart3);
    obj.label3:setAlign("client");
    obj.label3:setText("Bônus Global de Resistências");
    obj.label3:setMargins({left=10});
    obj.label3:setHorzTextAlign("center");
    obj.label3:setName("label3");
    obj.label3:setFontSize(12);
    obj.label3:setFontColor("#D0D0D0");

    obj.flowPart4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart4:setParent(obj.flowLayout2);
    obj.flowPart4:setMinWidth(240);
    obj.flowPart4:setMaxWidth(700);
    obj.flowPart4:setHeight(64);
    obj.flowPart4:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart4:setName("flowPart4");
    obj.flowPart4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart4:setVertAlign("leading");

    obj.edit4 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit4:setParent(obj.flowPart4);
    obj.edit4:setAlign("left");
    obj.edit4:setField("sabedoriaPassiva");
    obj.edit4:setWidth(70);
    obj.edit4:setName("edit4");
    obj.edit4:setTransparent(true);
    obj.edit4:setVertTextAlign("center");
    obj.edit4:setHorzTextAlign("center");
    obj.edit4:setFontSize(15);
    obj.edit4:setFontColor("white");

    obj.label4 = GUI.fromHandle(_obj_newObject("label"));
    obj.label4:setParent(obj.flowPart4);
    obj.label4:setAlign("client");
    obj.label4:setText("Percepção Passiva");
    obj.label4:setMargins({left=10});
    obj.label4:setHorzTextAlign("center");
    obj.label4:setName("label4");
    obj.label4:setFontSize(12);
    obj.label4:setFontColor("#D0D0D0");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj.flowLayout2);
    obj.dataLink1:setFields({'CR', 'pericias.bonuspercepcao'});
    obj.dataLink1:setName("dataLink1");

    obj.flowLineBreak2 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak2:setParent(obj.fraFrenteLayout);
    obj.flowLineBreak2:setName("flowLineBreak2");

    obj.flowLayout3 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout3:setParent(obj.fraFrenteLayout);
    obj.flowLayout3:setAutoHeight(true);
    obj.flowLayout3:setMinScaledWidth(290);
    obj.flowLayout3:setHorzAlign("center");
    obj.flowLayout3:setName("flowLayout3");
    obj.flowLayout3:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout3:setVertAlign("leading");

    obj.fraLayAtributos = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraLayAtributos:setParent(obj.flowLayout3);
    obj.fraLayAtributos:setName("fraLayAtributos");
    obj.fraLayAtributos:setVertAlign("leading");
    obj.fraLayAtributos:setAutoHeight(true);
    obj.fraLayAtributos:setMinScaledWidth(290);
    obj.fraLayAtributos:setMaxControlsPerLine(2);
    obj.fraLayAtributos:setHorzAlign("center");
    obj.fraLayAtributos:setLineSpacing(10);
    obj.fraLayAtributos:setFrameStyle("frames/panel1/frame.xml");
    obj.fraLayAtributos:setMargins({left=2, top=2, right=16, bottom=4});
    obj.fraLayAtributos:setAvoidScale(true);
    obj.fraLayAtributos:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});

    obj.dataLink2 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj.fraLayAtributos);
    obj.dataLink2:setField("atributos.forca");
    obj.dataLink2:setName("dataLink2");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.forca = {};
		


    obj.flowPart5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart5:setParent(obj.fraLayAtributos);
    obj.flowPart5:setHeight(140);
    obj.flowPart5:setMinWidth(320);
    obj.flowPart5:setMaxWidth(420);
    obj.flowPart5:setMinScaledWidth(305);
    obj.flowPart5:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart5:setName("flowPart5");
    obj.flowPart5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart5:setVertAlign("leading");

    obj.layout1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout1:setParent(obj.flowPart5);
    obj.layout1:setLeft(6);
    obj.layout1:setTop(12);
    obj.layout1:setWidth(116);
    obj.layout1:setHeight(115);
    obj.layout1:setName("layout1");

    obj.edit5 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit5:setParent(obj.layout1);
    obj.edit5:setAlign("top");
    obj.edit5:setMargins({left=30, right=30});
    obj.edit5:setField("atributos.forca");
    obj.edit5:setHeight(30);
    obj.edit5:setType("number");
    obj.edit5:setMin(0);
    obj.edit5:setMax(99);
    obj.edit5:setName("edit5");
    obj.edit5:setTransparent(true);
    obj.edit5:setVertTextAlign("center");
    obj.edit5:setHorzTextAlign("center");
    obj.edit5:setFontSize(15);
    obj.edit5:setFontColor("white");

    obj.modforcastr = GUI.fromHandle(_obj_newObject("label"));
    obj.modforcastr:setParent(obj.flowPart5);
    obj.modforcastr:setFrameRegion("modificador");
    obj.modforcastr:setName("modforcastr");
    obj.modforcastr:setField("atributos.modforcastr");
    obj.modforcastr:setHorzTextAlign("center");
    obj.modforcastr:setVertTextAlign("center");
    obj.modforcastr:setFontSize(46);
    lfm_setPropAsString(obj.modforcastr, "fontStyle", "bold");
    obj.modforcastr:setFontColor("white");

    obj.layout2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout2:setParent(obj.flowPart5);
    obj.layout2:setFrameRegion("titulo");
    obj.layout2:setName("layout2");

    obj.modforcabutton = GUI.fromHandle(_obj_newObject("button"));
    obj.modforcabutton:setParent(obj.layout2);
    obj.modforcabutton:setAlign("client");
    obj.modforcabutton:setName("modforcabutton");
    obj.modforcabutton:setText("FORÇA");
    obj.modforcabutton:setVertTextAlign("center");
    obj.modforcabutton:setHorzTextAlign("center");
    obj.modforcabutton:setMargins({left=10,right=10});
    obj.modforcabutton:setFontSize(12);

    obj.flowLayout4 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout4:setParent(obj.flowPart5);
    obj.flowLayout4:setFrameRegion("RegiaoDePericias");
    obj.flowLayout4:setAutoHeight(true);
    obj.flowLayout4:setLineSpacing(0);
    obj.flowLayout4:setHorzAlign("leading");
    obj.flowLayout4:setName("flowLayout4");
    obj.flowLayout4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout4:setVertAlign("leading");

    obj.flpSkillFlowPart1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart1:setParent(obj.flowLayout4);
    obj.flpSkillFlowPart1:setMinWidth(206);
    obj.flpSkillFlowPart1:setMaxWidth(250);
    obj.flpSkillFlowPart1:setHeight(17);
    obj.flpSkillFlowPart1:setName("flpSkillFlowPart1");
    obj.flpSkillFlowPart1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart1:setVertAlign("leading");

    obj.image1 = GUI.fromHandle(_obj_newObject("image"));
    obj.image1:setParent(obj.flpSkillFlowPart1);
    obj.image1:setAlign("left");
    obj.image1:setWidth(20);
    obj.image1:setHeight(20);
    obj.image1:setMargins({});
    obj.image1:setName("image1");
    obj.image1:setField("resistencias.forcaIcon");
    obj.image1:setStyle("proportional");
    obj.image1:setHitTest(true);

    obj.dataLink3 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink3:setParent(obj.flpSkillFlowPart1);
    obj.dataLink3:setField("resistencias.forcaIcon");
    obj.dataLink3:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink3:setName("dataLink3");

    obj.dataLink4 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink4:setParent(obj.flpSkillFlowPart1);
    obj.dataLink4:setField("resistencias.forca");
    obj.dataLink4:setName("dataLink4");

    obj.layout3 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout3:setParent(obj.flpSkillFlowPart1);
    obj.layout3:setAlign("left");
    obj.layout3:setWidth(26);
    obj.layout3:setMargins({left=2});
    obj.layout3:setHitTest(true);
    obj.layout3:setName("layout3");

    obj.flpSkillFlowPart1str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart1str:setParent(obj.layout3);
    obj.flpSkillFlowPart1str:setName("flpSkillFlowPart1str");
    obj.flpSkillFlowPart1str:setField("resistencias.bonusforcastr");
    obj.flpSkillFlowPart1str:setAlign("client");
    obj.flpSkillFlowPart1str:setHorzTextAlign("center");
    obj.flpSkillFlowPart1str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart1str:setTextTrimming("none");
    obj.flpSkillFlowPart1str:setFontColor("white");

    obj.horzLine1 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine1:setParent(obj.layout3);
    obj.horzLine1:setStrokeColor("white");
    obj.horzLine1:setStrokeSize(1);
    obj.horzLine1:setAlign("bottom");
    obj.horzLine1:setName("horzLine1");

    obj.flpSkillFlowPart1button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart1button:setParent(obj.flpSkillFlowPart1);
    obj.flpSkillFlowPart1button:setName("flpSkillFlowPart1button");
    obj.flpSkillFlowPart1button:setAlign("left");
    obj.flpSkillFlowPart1button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart1button:setWidth(122);
    obj.flpSkillFlowPart1button:setMargins({left=2});
    obj.flpSkillFlowPart1button:setFontSize(12);

    obj.dataLink5 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink5:setParent(obj.flowLayout4);
    obj.dataLink5:setFields({'atributos.modforca', 'bonusProficiencia', 'resistencias.forca', 'resistencias.forcastrAltAtr', 'bonusResistencias'});
    obj.dataLink5:setName("dataLink5");

    obj.flpSkillFlowPart2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart2:setParent(obj.flowLayout4);
    obj.flpSkillFlowPart2:setMinWidth(206);
    obj.flpSkillFlowPart2:setMaxWidth(250);
    obj.flpSkillFlowPart2:setHeight(17);
    obj.flpSkillFlowPart2:setName("flpSkillFlowPart2");
    obj.flpSkillFlowPart2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart2:setVertAlign("leading");

    obj.image2 = GUI.fromHandle(_obj_newObject("image"));
    obj.image2:setParent(obj.flpSkillFlowPart2);
    obj.image2:setAlign("left");
    obj.image2:setWidth(20);
    obj.image2:setHeight(20);
    obj.image2:setMargins({});
    obj.image2:setName("image2");
    obj.image2:setField("pericias.atletismoIcon");
    obj.image2:setStyle("proportional");
    obj.image2:setHitTest(true);

    obj.dataLink6 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink6:setParent(obj.flpSkillFlowPart2);
    obj.dataLink6:setField("pericias.atletismoIcon");
    obj.dataLink6:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink6:setName("dataLink6");

    obj.dataLink7 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink7:setParent(obj.flpSkillFlowPart2);
    obj.dataLink7:setField("pericias.atletismo");
    obj.dataLink7:setName("dataLink7");

    obj.layout4 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout4:setParent(obj.flpSkillFlowPart2);
    obj.layout4:setAlign("left");
    obj.layout4:setWidth(26);
    obj.layout4:setMargins({left=2});
    obj.layout4:setHitTest(true);
    obj.layout4:setName("layout4");

    obj.flpSkillFlowPart2str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart2str:setParent(obj.layout4);
    obj.flpSkillFlowPart2str:setName("flpSkillFlowPart2str");
    obj.flpSkillFlowPart2str:setField("pericias.bonusatletismostr");
    obj.flpSkillFlowPart2str:setAlign("client");
    obj.flpSkillFlowPart2str:setHorzTextAlign("center");
    obj.flpSkillFlowPart2str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart2str:setTextTrimming("none");
    obj.flpSkillFlowPart2str:setFontColor("white");

    obj.horzLine2 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine2:setParent(obj.layout4);
    obj.horzLine2:setStrokeColor("white");
    obj.horzLine2:setStrokeSize(1);
    obj.horzLine2:setAlign("bottom");
    obj.horzLine2:setName("horzLine2");

    obj.flpSkillFlowPart2button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart2button:setParent(obj.flpSkillFlowPart2);
    obj.flpSkillFlowPart2button:setName("flpSkillFlowPart2button");
    obj.flpSkillFlowPart2button:setAlign("left");
    obj.flpSkillFlowPart2button:setText("@@DnD5e.skills.athletics");
    obj.flpSkillFlowPart2button:setWidth(122);
    obj.flpSkillFlowPart2button:setMargins({left=2});
    obj.flpSkillFlowPart2button:setFontSize(12);


				table.insert(self.__attrSortData.forca, {title="@@DnD5e.skills.athletics", controlName="flpSkillFlowPart2"});				
			


    obj.dataLink8 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink8:setParent(obj.flowLayout4);
    obj.dataLink8:setFields({'atributos.modforca', 'bonusProficiencia', 'pericias.atletismo', 'pericias.bonusatletismostrAltAtr', 'bonusHabilidades'});
    obj.dataLink8:setName("dataLink8");

    obj.dataLink9 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink9:setParent(obj.fraLayAtributos);
    obj.dataLink9:setField("atributos.destreza");
    obj.dataLink9:setName("dataLink9");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.destreza = {};
		


    obj.flowPart6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart6:setParent(obj.fraLayAtributos);
    obj.flowPart6:setHeight(140);
    obj.flowPart6:setMinWidth(320);
    obj.flowPart6:setMaxWidth(420);
    obj.flowPart6:setMinScaledWidth(305);
    obj.flowPart6:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart6:setName("flowPart6");
    obj.flowPart6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart6:setVertAlign("leading");

    obj.layout5 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout5:setParent(obj.flowPart6);
    obj.layout5:setLeft(6);
    obj.layout5:setTop(12);
    obj.layout5:setWidth(116);
    obj.layout5:setHeight(115);
    obj.layout5:setName("layout5");

    obj.edit6 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit6:setParent(obj.layout5);
    obj.edit6:setAlign("top");
    obj.edit6:setMargins({left=30, right=30});
    obj.edit6:setField("atributos.destreza");
    obj.edit6:setHeight(30);
    obj.edit6:setType("number");
    obj.edit6:setMin(0);
    obj.edit6:setMax(99);
    obj.edit6:setName("edit6");
    obj.edit6:setTransparent(true);
    obj.edit6:setVertTextAlign("center");
    obj.edit6:setHorzTextAlign("center");
    obj.edit6:setFontSize(15);
    obj.edit6:setFontColor("white");

    obj.moddestrezastr = GUI.fromHandle(_obj_newObject("label"));
    obj.moddestrezastr:setParent(obj.flowPart6);
    obj.moddestrezastr:setFrameRegion("modificador");
    obj.moddestrezastr:setName("moddestrezastr");
    obj.moddestrezastr:setField("atributos.moddestrezastr");
    obj.moddestrezastr:setHorzTextAlign("center");
    obj.moddestrezastr:setVertTextAlign("center");
    obj.moddestrezastr:setFontSize(46);
    lfm_setPropAsString(obj.moddestrezastr, "fontStyle", "bold");
    obj.moddestrezastr:setFontColor("white");

    obj.layout6 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout6:setParent(obj.flowPart6);
    obj.layout6:setFrameRegion("titulo");
    obj.layout6:setName("layout6");

    obj.moddestrezabutton = GUI.fromHandle(_obj_newObject("button"));
    obj.moddestrezabutton:setParent(obj.layout6);
    obj.moddestrezabutton:setAlign("client");
    obj.moddestrezabutton:setName("moddestrezabutton");
    obj.moddestrezabutton:setText("DESTREZA");
    obj.moddestrezabutton:setVertTextAlign("center");
    obj.moddestrezabutton:setHorzTextAlign("center");
    obj.moddestrezabutton:setMargins({left=10,right=10});
    obj.moddestrezabutton:setFontSize(12);

    obj.flowLayout5 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout5:setParent(obj.flowPart6);
    obj.flowLayout5:setFrameRegion("RegiaoDePericias");
    obj.flowLayout5:setAutoHeight(true);
    obj.flowLayout5:setLineSpacing(0);
    obj.flowLayout5:setHorzAlign("leading");
    obj.flowLayout5:setName("flowLayout5");
    obj.flowLayout5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout5:setVertAlign("leading");

    obj.flpSkillFlowPart3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart3:setParent(obj.flowLayout5);
    obj.flpSkillFlowPart3:setMinWidth(206);
    obj.flpSkillFlowPart3:setMaxWidth(250);
    obj.flpSkillFlowPart3:setHeight(17);
    obj.flpSkillFlowPart3:setName("flpSkillFlowPart3");
    obj.flpSkillFlowPart3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart3:setVertAlign("leading");

    obj.image3 = GUI.fromHandle(_obj_newObject("image"));
    obj.image3:setParent(obj.flpSkillFlowPart3);
    obj.image3:setAlign("left");
    obj.image3:setWidth(20);
    obj.image3:setHeight(20);
    obj.image3:setMargins({});
    obj.image3:setName("image3");
    obj.image3:setField("resistencias.destrezaIcon");
    obj.image3:setStyle("proportional");
    obj.image3:setHitTest(true);

    obj.dataLink10 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink10:setParent(obj.flpSkillFlowPart3);
    obj.dataLink10:setField("resistencias.destrezaIcon");
    obj.dataLink10:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink10:setName("dataLink10");

    obj.dataLink11 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink11:setParent(obj.flpSkillFlowPart3);
    obj.dataLink11:setField("resistencias.destreza");
    obj.dataLink11:setName("dataLink11");

    obj.layout7 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout7:setParent(obj.flpSkillFlowPart3);
    obj.layout7:setAlign("left");
    obj.layout7:setWidth(26);
    obj.layout7:setMargins({left=2});
    obj.layout7:setHitTest(true);
    obj.layout7:setName("layout7");

    obj.flpSkillFlowPart3str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart3str:setParent(obj.layout7);
    obj.flpSkillFlowPart3str:setName("flpSkillFlowPart3str");
    obj.flpSkillFlowPart3str:setField("resistencias.bonusdestrezastr");
    obj.flpSkillFlowPart3str:setAlign("client");
    obj.flpSkillFlowPart3str:setHorzTextAlign("center");
    obj.flpSkillFlowPart3str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart3str:setTextTrimming("none");
    obj.flpSkillFlowPart3str:setFontColor("white");

    obj.horzLine3 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine3:setParent(obj.layout7);
    obj.horzLine3:setStrokeColor("white");
    obj.horzLine3:setStrokeSize(1);
    obj.horzLine3:setAlign("bottom");
    obj.horzLine3:setName("horzLine3");

    obj.flpSkillFlowPart3button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart3button:setParent(obj.flpSkillFlowPart3);
    obj.flpSkillFlowPart3button:setName("flpSkillFlowPart3button");
    obj.flpSkillFlowPart3button:setAlign("left");
    obj.flpSkillFlowPart3button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart3button:setWidth(122);
    obj.flpSkillFlowPart3button:setMargins({left=2});
    obj.flpSkillFlowPart3button:setFontSize(12);

    obj.dataLink12 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink12:setParent(obj.flowLayout5);
    obj.dataLink12:setFields({'atributos.moddestreza', 'bonusProficiencia', 'resistencias.destreza', 'resistencias.destrezastrAltAtr', 'bonusResistencias'});
    obj.dataLink12:setName("dataLink12");

    obj.flpSkillFlowPart4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart4:setParent(obj.flowLayout5);
    obj.flpSkillFlowPart4:setMinWidth(206);
    obj.flpSkillFlowPart4:setMaxWidth(250);
    obj.flpSkillFlowPart4:setHeight(17);
    obj.flpSkillFlowPart4:setName("flpSkillFlowPart4");
    obj.flpSkillFlowPart4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart4:setVertAlign("leading");

    obj.image4 = GUI.fromHandle(_obj_newObject("image"));
    obj.image4:setParent(obj.flpSkillFlowPart4);
    obj.image4:setAlign("left");
    obj.image4:setWidth(20);
    obj.image4:setHeight(20);
    obj.image4:setMargins({});
    obj.image4:setName("image4");
    obj.image4:setField("pericias.acrobaciaIcon");
    obj.image4:setStyle("proportional");
    obj.image4:setHitTest(true);

    obj.dataLink13 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink13:setParent(obj.flpSkillFlowPart4);
    obj.dataLink13:setField("pericias.acrobaciaIcon");
    obj.dataLink13:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink13:setName("dataLink13");

    obj.dataLink14 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink14:setParent(obj.flpSkillFlowPart4);
    obj.dataLink14:setField("pericias.acrobacia");
    obj.dataLink14:setName("dataLink14");

    obj.layout8 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout8:setParent(obj.flpSkillFlowPart4);
    obj.layout8:setAlign("left");
    obj.layout8:setWidth(26);
    obj.layout8:setMargins({left=2});
    obj.layout8:setHitTest(true);
    obj.layout8:setName("layout8");

    obj.flpSkillFlowPart4str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart4str:setParent(obj.layout8);
    obj.flpSkillFlowPart4str:setName("flpSkillFlowPart4str");
    obj.flpSkillFlowPart4str:setField("pericias.bonusacrobaciastr");
    obj.flpSkillFlowPart4str:setAlign("client");
    obj.flpSkillFlowPart4str:setHorzTextAlign("center");
    obj.flpSkillFlowPart4str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart4str:setTextTrimming("none");
    obj.flpSkillFlowPart4str:setFontColor("white");

    obj.horzLine4 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine4:setParent(obj.layout8);
    obj.horzLine4:setStrokeColor("white");
    obj.horzLine4:setStrokeSize(1);
    obj.horzLine4:setAlign("bottom");
    obj.horzLine4:setName("horzLine4");

    obj.flpSkillFlowPart4button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart4button:setParent(obj.flpSkillFlowPart4);
    obj.flpSkillFlowPart4button:setName("flpSkillFlowPart4button");
    obj.flpSkillFlowPart4button:setAlign("left");
    obj.flpSkillFlowPart4button:setText("@@DnD5e.skills.acrobatics");
    obj.flpSkillFlowPart4button:setWidth(122);
    obj.flpSkillFlowPart4button:setMargins({left=2});
    obj.flpSkillFlowPart4button:setFontSize(12);


				table.insert(self.__attrSortData.destreza, {title="@@DnD5e.skills.acrobatics", controlName="flpSkillFlowPart4"});				
			


    obj.dataLink15 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink15:setParent(obj.flowLayout5);
    obj.dataLink15:setFields({'atributos.moddestreza', 'bonusProficiencia', 'pericias.acrobacia', 'pericias.bonusacrobaciastrAltAtr', 'bonusHabilidades'});
    obj.dataLink15:setName("dataLink15");

    obj.flpSkillFlowPart5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart5:setParent(obj.flowLayout5);
    obj.flpSkillFlowPart5:setMinWidth(206);
    obj.flpSkillFlowPart5:setMaxWidth(250);
    obj.flpSkillFlowPart5:setHeight(17);
    obj.flpSkillFlowPart5:setName("flpSkillFlowPart5");
    obj.flpSkillFlowPart5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart5:setVertAlign("leading");

    obj.image5 = GUI.fromHandle(_obj_newObject("image"));
    obj.image5:setParent(obj.flpSkillFlowPart5);
    obj.image5:setAlign("left");
    obj.image5:setWidth(20);
    obj.image5:setHeight(20);
    obj.image5:setMargins({});
    obj.image5:setName("image5");
    obj.image5:setField("pericias.furtividadeIcon");
    obj.image5:setStyle("proportional");
    obj.image5:setHitTest(true);

    obj.dataLink16 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink16:setParent(obj.flpSkillFlowPart5);
    obj.dataLink16:setField("pericias.furtividadeIcon");
    obj.dataLink16:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink16:setName("dataLink16");

    obj.dataLink17 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink17:setParent(obj.flpSkillFlowPart5);
    obj.dataLink17:setField("pericias.furtividade");
    obj.dataLink17:setName("dataLink17");

    obj.layout9 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout9:setParent(obj.flpSkillFlowPart5);
    obj.layout9:setAlign("left");
    obj.layout9:setWidth(26);
    obj.layout9:setMargins({left=2});
    obj.layout9:setHitTest(true);
    obj.layout9:setName("layout9");

    obj.flpSkillFlowPart5str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart5str:setParent(obj.layout9);
    obj.flpSkillFlowPart5str:setName("flpSkillFlowPart5str");
    obj.flpSkillFlowPart5str:setField("pericias.bonusfurtividadestr");
    obj.flpSkillFlowPart5str:setAlign("client");
    obj.flpSkillFlowPart5str:setHorzTextAlign("center");
    obj.flpSkillFlowPart5str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart5str:setTextTrimming("none");
    obj.flpSkillFlowPart5str:setFontColor("white");

    obj.horzLine5 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine5:setParent(obj.layout9);
    obj.horzLine5:setStrokeColor("white");
    obj.horzLine5:setStrokeSize(1);
    obj.horzLine5:setAlign("bottom");
    obj.horzLine5:setName("horzLine5");

    obj.flpSkillFlowPart5button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart5button:setParent(obj.flpSkillFlowPart5);
    obj.flpSkillFlowPart5button:setName("flpSkillFlowPart5button");
    obj.flpSkillFlowPart5button:setAlign("left");
    obj.flpSkillFlowPart5button:setText("@@DnD5e.skills.stealth");
    obj.flpSkillFlowPart5button:setWidth(122);
    obj.flpSkillFlowPart5button:setMargins({left=2});
    obj.flpSkillFlowPart5button:setFontSize(12);


				table.insert(self.__attrSortData.destreza, {title="@@DnD5e.skills.stealth", controlName="flpSkillFlowPart5"});				
			


    obj.dataLink18 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink18:setParent(obj.flowLayout5);
    obj.dataLink18:setFields({'atributos.moddestreza', 'bonusProficiencia', 'pericias.furtividade', 'pericias.bonusfurtividadestrAltAtr', 'bonusHabilidades'});
    obj.dataLink18:setName("dataLink18");

    obj.flpSkillFlowPart6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart6:setParent(obj.flowLayout5);
    obj.flpSkillFlowPart6:setMinWidth(206);
    obj.flpSkillFlowPart6:setMaxWidth(250);
    obj.flpSkillFlowPart6:setHeight(17);
    obj.flpSkillFlowPart6:setName("flpSkillFlowPart6");
    obj.flpSkillFlowPart6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart6:setVertAlign("leading");

    obj.image6 = GUI.fromHandle(_obj_newObject("image"));
    obj.image6:setParent(obj.flpSkillFlowPart6);
    obj.image6:setAlign("left");
    obj.image6:setWidth(20);
    obj.image6:setHeight(20);
    obj.image6:setMargins({});
    obj.image6:setName("image6");
    obj.image6:setField("pericias.prestidigitacaoIcon");
    obj.image6:setStyle("proportional");
    obj.image6:setHitTest(true);

    obj.dataLink19 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink19:setParent(obj.flpSkillFlowPart6);
    obj.dataLink19:setField("pericias.prestidigitacaoIcon");
    obj.dataLink19:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink19:setName("dataLink19");

    obj.dataLink20 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink20:setParent(obj.flpSkillFlowPart6);
    obj.dataLink20:setField("pericias.prestidigitacao");
    obj.dataLink20:setName("dataLink20");

    obj.layout10 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout10:setParent(obj.flpSkillFlowPart6);
    obj.layout10:setAlign("left");
    obj.layout10:setWidth(26);
    obj.layout10:setMargins({left=2});
    obj.layout10:setHitTest(true);
    obj.layout10:setName("layout10");

    obj.flpSkillFlowPart6str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart6str:setParent(obj.layout10);
    obj.flpSkillFlowPart6str:setName("flpSkillFlowPart6str");
    obj.flpSkillFlowPart6str:setField("pericias.bonusprestidigitacaostr");
    obj.flpSkillFlowPart6str:setAlign("client");
    obj.flpSkillFlowPart6str:setHorzTextAlign("center");
    obj.flpSkillFlowPart6str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart6str:setTextTrimming("none");
    obj.flpSkillFlowPart6str:setFontColor("white");

    obj.horzLine6 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine6:setParent(obj.layout10);
    obj.horzLine6:setStrokeColor("white");
    obj.horzLine6:setStrokeSize(1);
    obj.horzLine6:setAlign("bottom");
    obj.horzLine6:setName("horzLine6");

    obj.flpSkillFlowPart6button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart6button:setParent(obj.flpSkillFlowPart6);
    obj.flpSkillFlowPart6button:setName("flpSkillFlowPart6button");
    obj.flpSkillFlowPart6button:setAlign("left");
    obj.flpSkillFlowPart6button:setText("@@DnD5e.skills.sleighthand");
    obj.flpSkillFlowPart6button:setWidth(122);
    obj.flpSkillFlowPart6button:setMargins({left=2});
    obj.flpSkillFlowPart6button:setFontSize(12);


				table.insert(self.__attrSortData.destreza, {title="@@DnD5e.skills.sleighthand", controlName="flpSkillFlowPart6"});				
			


    obj.dataLink21 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink21:setParent(obj.flowLayout5);
    obj.dataLink21:setFields({'atributos.moddestreza', 'bonusProficiencia', 'pericias.prestidigitacao', 'pericias.bonusprestidigitacaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink21:setName("dataLink21");

    obj.dataLink22 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink22:setParent(obj.fraLayAtributos);
    obj.dataLink22:setField("atributos.constituicao");
    obj.dataLink22:setName("dataLink22");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.constituicao = {};
		


    obj.flowPart7 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart7:setParent(obj.fraLayAtributos);
    obj.flowPart7:setHeight(140);
    obj.flowPart7:setMinWidth(320);
    obj.flowPart7:setMaxWidth(420);
    obj.flowPart7:setMinScaledWidth(305);
    obj.flowPart7:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart7:setName("flowPart7");
    obj.flowPart7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart7:setVertAlign("leading");

    obj.layout11 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout11:setParent(obj.flowPart7);
    obj.layout11:setLeft(6);
    obj.layout11:setTop(12);
    obj.layout11:setWidth(116);
    obj.layout11:setHeight(115);
    obj.layout11:setName("layout11");

    obj.edit7 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit7:setParent(obj.layout11);
    obj.edit7:setAlign("top");
    obj.edit7:setMargins({left=30, right=30});
    obj.edit7:setField("atributos.constituicao");
    obj.edit7:setHeight(30);
    obj.edit7:setType("number");
    obj.edit7:setMin(0);
    obj.edit7:setMax(99);
    obj.edit7:setName("edit7");
    obj.edit7:setTransparent(true);
    obj.edit7:setVertTextAlign("center");
    obj.edit7:setHorzTextAlign("center");
    obj.edit7:setFontSize(15);
    obj.edit7:setFontColor("white");

    obj.modconstituicaostr = GUI.fromHandle(_obj_newObject("label"));
    obj.modconstituicaostr:setParent(obj.flowPart7);
    obj.modconstituicaostr:setFrameRegion("modificador");
    obj.modconstituicaostr:setName("modconstituicaostr");
    obj.modconstituicaostr:setField("atributos.modconstituicaostr");
    obj.modconstituicaostr:setHorzTextAlign("center");
    obj.modconstituicaostr:setVertTextAlign("center");
    obj.modconstituicaostr:setFontSize(46);
    lfm_setPropAsString(obj.modconstituicaostr, "fontStyle", "bold");
    obj.modconstituicaostr:setFontColor("white");

    obj.layout12 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout12:setParent(obj.flowPart7);
    obj.layout12:setFrameRegion("titulo");
    obj.layout12:setName("layout12");

    obj.modconstituicaobutton = GUI.fromHandle(_obj_newObject("button"));
    obj.modconstituicaobutton:setParent(obj.layout12);
    obj.modconstituicaobutton:setAlign("client");
    obj.modconstituicaobutton:setName("modconstituicaobutton");
    obj.modconstituicaobutton:setText("CONSTITUIÇÃO");
    obj.modconstituicaobutton:setVertTextAlign("center");
    obj.modconstituicaobutton:setHorzTextAlign("center");
    obj.modconstituicaobutton:setMargins({left=10,right=10});
    obj.modconstituicaobutton:setFontSize(12);

    obj.flowLayout6 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout6:setParent(obj.flowPart7);
    obj.flowLayout6:setFrameRegion("RegiaoDePericias");
    obj.flowLayout6:setAutoHeight(true);
    obj.flowLayout6:setLineSpacing(0);
    obj.flowLayout6:setHorzAlign("leading");
    obj.flowLayout6:setName("flowLayout6");
    obj.flowLayout6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout6:setVertAlign("leading");

    obj.flpSkillFlowPart7 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart7:setParent(obj.flowLayout6);
    obj.flpSkillFlowPart7:setMinWidth(206);
    obj.flpSkillFlowPart7:setMaxWidth(250);
    obj.flpSkillFlowPart7:setHeight(17);
    obj.flpSkillFlowPart7:setName("flpSkillFlowPart7");
    obj.flpSkillFlowPart7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart7:setVertAlign("leading");

    obj.image7 = GUI.fromHandle(_obj_newObject("image"));
    obj.image7:setParent(obj.flpSkillFlowPart7);
    obj.image7:setAlign("left");
    obj.image7:setWidth(20);
    obj.image7:setHeight(20);
    obj.image7:setMargins({});
    obj.image7:setName("image7");
    obj.image7:setField("resistencias.constituicaoIcon");
    obj.image7:setStyle("proportional");
    obj.image7:setHitTest(true);

    obj.dataLink23 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink23:setParent(obj.flpSkillFlowPart7);
    obj.dataLink23:setField("resistencias.constituicaoIcon");
    obj.dataLink23:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink23:setName("dataLink23");

    obj.dataLink24 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink24:setParent(obj.flpSkillFlowPart7);
    obj.dataLink24:setField("resistencias.constituicao");
    obj.dataLink24:setName("dataLink24");

    obj.layout13 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout13:setParent(obj.flpSkillFlowPart7);
    obj.layout13:setAlign("left");
    obj.layout13:setWidth(26);
    obj.layout13:setMargins({left=2});
    obj.layout13:setHitTest(true);
    obj.layout13:setName("layout13");

    obj.flpSkillFlowPart7str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart7str:setParent(obj.layout13);
    obj.flpSkillFlowPart7str:setName("flpSkillFlowPart7str");
    obj.flpSkillFlowPart7str:setField("resistencias.bonusconstituicaostr");
    obj.flpSkillFlowPart7str:setAlign("client");
    obj.flpSkillFlowPart7str:setHorzTextAlign("center");
    obj.flpSkillFlowPart7str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart7str:setTextTrimming("none");
    obj.flpSkillFlowPart7str:setFontColor("white");

    obj.horzLine7 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine7:setParent(obj.layout13);
    obj.horzLine7:setStrokeColor("white");
    obj.horzLine7:setStrokeSize(1);
    obj.horzLine7:setAlign("bottom");
    obj.horzLine7:setName("horzLine7");

    obj.flpSkillFlowPart7button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart7button:setParent(obj.flpSkillFlowPart7);
    obj.flpSkillFlowPart7button:setName("flpSkillFlowPart7button");
    obj.flpSkillFlowPart7button:setAlign("left");
    obj.flpSkillFlowPart7button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart7button:setWidth(122);
    obj.flpSkillFlowPart7button:setMargins({left=2});
    obj.flpSkillFlowPart7button:setFontSize(12);

    obj.dataLink25 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink25:setParent(obj.flowLayout6);
    obj.dataLink25:setFields({'atributos.modconstituicao', 'bonusProficiencia', 'resistencias.constituicao', 'resistencias.constituicaostrAltAtr', 'bonusResistencias'});
    obj.dataLink25:setName("dataLink25");

    obj.dataLink26 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink26:setParent(obj.fraLayAtributos);
    obj.dataLink26:setField("atributos.inteligencia");
    obj.dataLink26:setName("dataLink26");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.inteligencia = {};
		


    obj.flowPart8 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart8:setParent(obj.fraLayAtributos);
    obj.flowPart8:setHeight(140);
    obj.flowPart8:setMinWidth(320);
    obj.flowPart8:setMaxWidth(420);
    obj.flowPart8:setMinScaledWidth(305);
    obj.flowPart8:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart8:setName("flowPart8");
    obj.flowPart8:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart8:setVertAlign("leading");

    obj.layout14 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout14:setParent(obj.flowPart8);
    obj.layout14:setLeft(6);
    obj.layout14:setTop(12);
    obj.layout14:setWidth(116);
    obj.layout14:setHeight(115);
    obj.layout14:setName("layout14");

    obj.edit8 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit8:setParent(obj.layout14);
    obj.edit8:setAlign("top");
    obj.edit8:setMargins({left=30, right=30});
    obj.edit8:setField("atributos.inteligencia");
    obj.edit8:setHeight(30);
    obj.edit8:setType("number");
    obj.edit8:setMin(0);
    obj.edit8:setMax(99);
    obj.edit8:setName("edit8");
    obj.edit8:setTransparent(true);
    obj.edit8:setVertTextAlign("center");
    obj.edit8:setHorzTextAlign("center");
    obj.edit8:setFontSize(15);
    obj.edit8:setFontColor("white");

    obj.modinteligenciastr = GUI.fromHandle(_obj_newObject("label"));
    obj.modinteligenciastr:setParent(obj.flowPart8);
    obj.modinteligenciastr:setFrameRegion("modificador");
    obj.modinteligenciastr:setName("modinteligenciastr");
    obj.modinteligenciastr:setField("atributos.modinteligenciastr");
    obj.modinteligenciastr:setHorzTextAlign("center");
    obj.modinteligenciastr:setVertTextAlign("center");
    obj.modinteligenciastr:setFontSize(46);
    lfm_setPropAsString(obj.modinteligenciastr, "fontStyle", "bold");
    obj.modinteligenciastr:setFontColor("white");

    obj.layout15 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout15:setParent(obj.flowPart8);
    obj.layout15:setFrameRegion("titulo");
    obj.layout15:setName("layout15");

    obj.modinteligenciabutton = GUI.fromHandle(_obj_newObject("button"));
    obj.modinteligenciabutton:setParent(obj.layout15);
    obj.modinteligenciabutton:setAlign("client");
    obj.modinteligenciabutton:setName("modinteligenciabutton");
    obj.modinteligenciabutton:setText("INTELIGÊNCIA");
    obj.modinteligenciabutton:setVertTextAlign("center");
    obj.modinteligenciabutton:setHorzTextAlign("center");
    obj.modinteligenciabutton:setMargins({left=10,right=10});
    obj.modinteligenciabutton:setFontSize(12);

    obj.flowLayout7 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout7:setParent(obj.flowPart8);
    obj.flowLayout7:setFrameRegion("RegiaoDePericias");
    obj.flowLayout7:setAutoHeight(true);
    obj.flowLayout7:setLineSpacing(0);
    obj.flowLayout7:setHorzAlign("leading");
    obj.flowLayout7:setName("flowLayout7");
    obj.flowLayout7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout7:setVertAlign("leading");

    obj.flpSkillFlowPart8 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart8:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart8:setMinWidth(206);
    obj.flpSkillFlowPart8:setMaxWidth(250);
    obj.flpSkillFlowPart8:setHeight(17);
    obj.flpSkillFlowPart8:setName("flpSkillFlowPart8");
    obj.flpSkillFlowPart8:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart8:setVertAlign("leading");

    obj.image8 = GUI.fromHandle(_obj_newObject("image"));
    obj.image8:setParent(obj.flpSkillFlowPart8);
    obj.image8:setAlign("left");
    obj.image8:setWidth(20);
    obj.image8:setHeight(20);
    obj.image8:setMargins({});
    obj.image8:setName("image8");
    obj.image8:setField("resistencias.inteligenciaIcon");
    obj.image8:setStyle("proportional");
    obj.image8:setHitTest(true);

    obj.dataLink27 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink27:setParent(obj.flpSkillFlowPart8);
    obj.dataLink27:setField("resistencias.inteligenciaIcon");
    obj.dataLink27:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink27:setName("dataLink27");

    obj.dataLink28 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink28:setParent(obj.flpSkillFlowPart8);
    obj.dataLink28:setField("resistencias.inteligencia");
    obj.dataLink28:setName("dataLink28");

    obj.layout16 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout16:setParent(obj.flpSkillFlowPart8);
    obj.layout16:setAlign("left");
    obj.layout16:setWidth(26);
    obj.layout16:setMargins({left=2});
    obj.layout16:setHitTest(true);
    obj.layout16:setName("layout16");

    obj.flpSkillFlowPart8str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart8str:setParent(obj.layout16);
    obj.flpSkillFlowPart8str:setName("flpSkillFlowPart8str");
    obj.flpSkillFlowPart8str:setField("resistencias.bonusinteligenciastr");
    obj.flpSkillFlowPart8str:setAlign("client");
    obj.flpSkillFlowPart8str:setHorzTextAlign("center");
    obj.flpSkillFlowPart8str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart8str:setTextTrimming("none");
    obj.flpSkillFlowPart8str:setFontColor("white");

    obj.horzLine8 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine8:setParent(obj.layout16);
    obj.horzLine8:setStrokeColor("white");
    obj.horzLine8:setStrokeSize(1);
    obj.horzLine8:setAlign("bottom");
    obj.horzLine8:setName("horzLine8");

    obj.flpSkillFlowPart8button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart8button:setParent(obj.flpSkillFlowPart8);
    obj.flpSkillFlowPart8button:setName("flpSkillFlowPart8button");
    obj.flpSkillFlowPart8button:setAlign("left");
    obj.flpSkillFlowPart8button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart8button:setWidth(122);
    obj.flpSkillFlowPart8button:setMargins({left=2});
    obj.flpSkillFlowPart8button:setFontSize(12);

    obj.dataLink29 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink29:setParent(obj.flowLayout7);
    obj.dataLink29:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'resistencias.inteligencia', 'resistencias.inteligenciastrAltAtr', 'bonusResistencias'});
    obj.dataLink29:setName("dataLink29");

    obj.flpSkillFlowPart9 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart9:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart9:setMinWidth(206);
    obj.flpSkillFlowPart9:setMaxWidth(250);
    obj.flpSkillFlowPart9:setHeight(17);
    obj.flpSkillFlowPart9:setName("flpSkillFlowPart9");
    obj.flpSkillFlowPart9:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart9:setVertAlign("leading");

    obj.image9 = GUI.fromHandle(_obj_newObject("image"));
    obj.image9:setParent(obj.flpSkillFlowPart9);
    obj.image9:setAlign("left");
    obj.image9:setWidth(20);
    obj.image9:setHeight(20);
    obj.image9:setMargins({});
    obj.image9:setName("image9");
    obj.image9:setField("pericias.arcanismoIcon");
    obj.image9:setStyle("proportional");
    obj.image9:setHitTest(true);

    obj.dataLink30 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink30:setParent(obj.flpSkillFlowPart9);
    obj.dataLink30:setField("pericias.arcanismoIcon");
    obj.dataLink30:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink30:setName("dataLink30");

    obj.dataLink31 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink31:setParent(obj.flpSkillFlowPart9);
    obj.dataLink31:setField("pericias.arcanismo");
    obj.dataLink31:setName("dataLink31");

    obj.layout17 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout17:setParent(obj.flpSkillFlowPart9);
    obj.layout17:setAlign("left");
    obj.layout17:setWidth(26);
    obj.layout17:setMargins({left=2});
    obj.layout17:setHitTest(true);
    obj.layout17:setName("layout17");

    obj.flpSkillFlowPart9str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart9str:setParent(obj.layout17);
    obj.flpSkillFlowPart9str:setName("flpSkillFlowPart9str");
    obj.flpSkillFlowPart9str:setField("pericias.bonusarcanismostr");
    obj.flpSkillFlowPart9str:setAlign("client");
    obj.flpSkillFlowPart9str:setHorzTextAlign("center");
    obj.flpSkillFlowPart9str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart9str:setTextTrimming("none");
    obj.flpSkillFlowPart9str:setFontColor("white");

    obj.horzLine9 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine9:setParent(obj.layout17);
    obj.horzLine9:setStrokeColor("white");
    obj.horzLine9:setStrokeSize(1);
    obj.horzLine9:setAlign("bottom");
    obj.horzLine9:setName("horzLine9");

    obj.flpSkillFlowPart9button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart9button:setParent(obj.flpSkillFlowPart9);
    obj.flpSkillFlowPart9button:setName("flpSkillFlowPart9button");
    obj.flpSkillFlowPart9button:setAlign("left");
    obj.flpSkillFlowPart9button:setText("@@DnD5e.skills.arcana");
    obj.flpSkillFlowPart9button:setWidth(122);
    obj.flpSkillFlowPart9button:setMargins({left=2});
    obj.flpSkillFlowPart9button:setFontSize(12);


				table.insert(self.__attrSortData.inteligencia, {title="@@DnD5e.skills.arcana", controlName="flpSkillFlowPart9"});				
			


    obj.dataLink32 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink32:setParent(obj.flowLayout7);
    obj.dataLink32:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'pericias.arcanismo', 'pericias.bonusarcanismostrAltAtr', 'bonusHabilidades'});
    obj.dataLink32:setName("dataLink32");

    obj.flpSkillFlowPart10 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart10:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart10:setMinWidth(206);
    obj.flpSkillFlowPart10:setMaxWidth(250);
    obj.flpSkillFlowPart10:setHeight(17);
    obj.flpSkillFlowPart10:setName("flpSkillFlowPart10");
    obj.flpSkillFlowPart10:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart10:setVertAlign("leading");

    obj.image10 = GUI.fromHandle(_obj_newObject("image"));
    obj.image10:setParent(obj.flpSkillFlowPart10);
    obj.image10:setAlign("left");
    obj.image10:setWidth(20);
    obj.image10:setHeight(20);
    obj.image10:setMargins({});
    obj.image10:setName("image10");
    obj.image10:setField("pericias.historiaIcon");
    obj.image10:setStyle("proportional");
    obj.image10:setHitTest(true);

    obj.dataLink33 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink33:setParent(obj.flpSkillFlowPart10);
    obj.dataLink33:setField("pericias.historiaIcon");
    obj.dataLink33:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink33:setName("dataLink33");

    obj.dataLink34 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink34:setParent(obj.flpSkillFlowPart10);
    obj.dataLink34:setField("pericias.historia");
    obj.dataLink34:setName("dataLink34");

    obj.layout18 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout18:setParent(obj.flpSkillFlowPart10);
    obj.layout18:setAlign("left");
    obj.layout18:setWidth(26);
    obj.layout18:setMargins({left=2});
    obj.layout18:setHitTest(true);
    obj.layout18:setName("layout18");

    obj.flpSkillFlowPart10str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart10str:setParent(obj.layout18);
    obj.flpSkillFlowPart10str:setName("flpSkillFlowPart10str");
    obj.flpSkillFlowPart10str:setField("pericias.bonushistoriastr");
    obj.flpSkillFlowPart10str:setAlign("client");
    obj.flpSkillFlowPart10str:setHorzTextAlign("center");
    obj.flpSkillFlowPart10str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart10str:setTextTrimming("none");
    obj.flpSkillFlowPart10str:setFontColor("white");

    obj.horzLine10 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine10:setParent(obj.layout18);
    obj.horzLine10:setStrokeColor("white");
    obj.horzLine10:setStrokeSize(1);
    obj.horzLine10:setAlign("bottom");
    obj.horzLine10:setName("horzLine10");

    obj.flpSkillFlowPart10button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart10button:setParent(obj.flpSkillFlowPart10);
    obj.flpSkillFlowPart10button:setName("flpSkillFlowPart10button");
    obj.flpSkillFlowPart10button:setAlign("left");
    obj.flpSkillFlowPart10button:setText("@@DnD5e.skills.history");
    obj.flpSkillFlowPart10button:setWidth(122);
    obj.flpSkillFlowPart10button:setMargins({left=2});
    obj.flpSkillFlowPart10button:setFontSize(12);


				table.insert(self.__attrSortData.inteligencia, {title="@@DnD5e.skills.history", controlName="flpSkillFlowPart10"});				
			


    obj.dataLink35 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink35:setParent(obj.flowLayout7);
    obj.dataLink35:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'pericias.historia', 'pericias.bonushistoriastrAltAtr', 'bonusHabilidades'});
    obj.dataLink35:setName("dataLink35");

    obj.flpSkillFlowPart11 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart11:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart11:setMinWidth(206);
    obj.flpSkillFlowPart11:setMaxWidth(250);
    obj.flpSkillFlowPart11:setHeight(17);
    obj.flpSkillFlowPart11:setName("flpSkillFlowPart11");
    obj.flpSkillFlowPart11:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart11:setVertAlign("leading");

    obj.image11 = GUI.fromHandle(_obj_newObject("image"));
    obj.image11:setParent(obj.flpSkillFlowPart11);
    obj.image11:setAlign("left");
    obj.image11:setWidth(20);
    obj.image11:setHeight(20);
    obj.image11:setMargins({});
    obj.image11:setName("image11");
    obj.image11:setField("pericias.investigacaoIcon");
    obj.image11:setStyle("proportional");
    obj.image11:setHitTest(true);

    obj.dataLink36 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink36:setParent(obj.flpSkillFlowPart11);
    obj.dataLink36:setField("pericias.investigacaoIcon");
    obj.dataLink36:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink36:setName("dataLink36");

    obj.dataLink37 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink37:setParent(obj.flpSkillFlowPart11);
    obj.dataLink37:setField("pericias.investigacao");
    obj.dataLink37:setName("dataLink37");

    obj.layout19 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout19:setParent(obj.flpSkillFlowPart11);
    obj.layout19:setAlign("left");
    obj.layout19:setWidth(26);
    obj.layout19:setMargins({left=2});
    obj.layout19:setHitTest(true);
    obj.layout19:setName("layout19");

    obj.flpSkillFlowPart11str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart11str:setParent(obj.layout19);
    obj.flpSkillFlowPart11str:setName("flpSkillFlowPart11str");
    obj.flpSkillFlowPart11str:setField("pericias.bonusinvestigacaostr");
    obj.flpSkillFlowPart11str:setAlign("client");
    obj.flpSkillFlowPart11str:setHorzTextAlign("center");
    obj.flpSkillFlowPart11str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart11str:setTextTrimming("none");
    obj.flpSkillFlowPart11str:setFontColor("white");

    obj.horzLine11 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine11:setParent(obj.layout19);
    obj.horzLine11:setStrokeColor("white");
    obj.horzLine11:setStrokeSize(1);
    obj.horzLine11:setAlign("bottom");
    obj.horzLine11:setName("horzLine11");

    obj.flpSkillFlowPart11button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart11button:setParent(obj.flpSkillFlowPart11);
    obj.flpSkillFlowPart11button:setName("flpSkillFlowPart11button");
    obj.flpSkillFlowPart11button:setAlign("left");
    obj.flpSkillFlowPart11button:setText("@@DnD5e.skills.investigation");
    obj.flpSkillFlowPart11button:setWidth(122);
    obj.flpSkillFlowPart11button:setMargins({left=2});
    obj.flpSkillFlowPart11button:setFontSize(12);


				table.insert(self.__attrSortData.inteligencia, {title="@@DnD5e.skills.investigation", controlName="flpSkillFlowPart11"});				
			


    obj.dataLink38 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink38:setParent(obj.flowLayout7);
    obj.dataLink38:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'pericias.investigacao', 'pericias.bonusinvestigacaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink38:setName("dataLink38");

    obj.flpSkillFlowPart12 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart12:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart12:setMinWidth(206);
    obj.flpSkillFlowPart12:setMaxWidth(250);
    obj.flpSkillFlowPart12:setHeight(17);
    obj.flpSkillFlowPart12:setName("flpSkillFlowPart12");
    obj.flpSkillFlowPart12:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart12:setVertAlign("leading");

    obj.image12 = GUI.fromHandle(_obj_newObject("image"));
    obj.image12:setParent(obj.flpSkillFlowPart12);
    obj.image12:setAlign("left");
    obj.image12:setWidth(20);
    obj.image12:setHeight(20);
    obj.image12:setMargins({});
    obj.image12:setName("image12");
    obj.image12:setField("pericias.naturezaIcon");
    obj.image12:setStyle("proportional");
    obj.image12:setHitTest(true);

    obj.dataLink39 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink39:setParent(obj.flpSkillFlowPart12);
    obj.dataLink39:setField("pericias.naturezaIcon");
    obj.dataLink39:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink39:setName("dataLink39");

    obj.dataLink40 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink40:setParent(obj.flpSkillFlowPart12);
    obj.dataLink40:setField("pericias.natureza");
    obj.dataLink40:setName("dataLink40");

    obj.layout20 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout20:setParent(obj.flpSkillFlowPart12);
    obj.layout20:setAlign("left");
    obj.layout20:setWidth(26);
    obj.layout20:setMargins({left=2});
    obj.layout20:setHitTest(true);
    obj.layout20:setName("layout20");

    obj.flpSkillFlowPart12str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart12str:setParent(obj.layout20);
    obj.flpSkillFlowPart12str:setName("flpSkillFlowPart12str");
    obj.flpSkillFlowPart12str:setField("pericias.bonusnaturezastr");
    obj.flpSkillFlowPart12str:setAlign("client");
    obj.flpSkillFlowPart12str:setHorzTextAlign("center");
    obj.flpSkillFlowPart12str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart12str:setTextTrimming("none");
    obj.flpSkillFlowPart12str:setFontColor("white");

    obj.horzLine12 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine12:setParent(obj.layout20);
    obj.horzLine12:setStrokeColor("white");
    obj.horzLine12:setStrokeSize(1);
    obj.horzLine12:setAlign("bottom");
    obj.horzLine12:setName("horzLine12");

    obj.flpSkillFlowPart12button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart12button:setParent(obj.flpSkillFlowPart12);
    obj.flpSkillFlowPart12button:setName("flpSkillFlowPart12button");
    obj.flpSkillFlowPart12button:setAlign("left");
    obj.flpSkillFlowPart12button:setText("@@DnD5e.skills.nature");
    obj.flpSkillFlowPart12button:setWidth(122);
    obj.flpSkillFlowPart12button:setMargins({left=2});
    obj.flpSkillFlowPart12button:setFontSize(12);


				table.insert(self.__attrSortData.inteligencia, {title="@@DnD5e.skills.nature", controlName="flpSkillFlowPart12"});				
			


    obj.dataLink41 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink41:setParent(obj.flowLayout7);
    obj.dataLink41:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'pericias.natureza', 'pericias.bonusnaturezastrAltAtr', 'bonusHabilidades'});
    obj.dataLink41:setName("dataLink41");

    obj.flpSkillFlowPart13 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart13:setParent(obj.flowLayout7);
    obj.flpSkillFlowPart13:setMinWidth(206);
    obj.flpSkillFlowPart13:setMaxWidth(250);
    obj.flpSkillFlowPart13:setHeight(17);
    obj.flpSkillFlowPart13:setName("flpSkillFlowPart13");
    obj.flpSkillFlowPart13:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart13:setVertAlign("leading");

    obj.image13 = GUI.fromHandle(_obj_newObject("image"));
    obj.image13:setParent(obj.flpSkillFlowPart13);
    obj.image13:setAlign("left");
    obj.image13:setWidth(20);
    obj.image13:setHeight(20);
    obj.image13:setMargins({});
    obj.image13:setName("image13");
    obj.image13:setField("pericias.religiaoIcon");
    obj.image13:setStyle("proportional");
    obj.image13:setHitTest(true);

    obj.dataLink42 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink42:setParent(obj.flpSkillFlowPart13);
    obj.dataLink42:setField("pericias.religiaoIcon");
    obj.dataLink42:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink42:setName("dataLink42");

    obj.dataLink43 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink43:setParent(obj.flpSkillFlowPart13);
    obj.dataLink43:setField("pericias.religiao");
    obj.dataLink43:setName("dataLink43");

    obj.layout21 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout21:setParent(obj.flpSkillFlowPart13);
    obj.layout21:setAlign("left");
    obj.layout21:setWidth(26);
    obj.layout21:setMargins({left=2});
    obj.layout21:setHitTest(true);
    obj.layout21:setName("layout21");

    obj.flpSkillFlowPart13str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart13str:setParent(obj.layout21);
    obj.flpSkillFlowPart13str:setName("flpSkillFlowPart13str");
    obj.flpSkillFlowPart13str:setField("pericias.bonusreligiaostr");
    obj.flpSkillFlowPart13str:setAlign("client");
    obj.flpSkillFlowPart13str:setHorzTextAlign("center");
    obj.flpSkillFlowPart13str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart13str:setTextTrimming("none");
    obj.flpSkillFlowPart13str:setFontColor("white");

    obj.horzLine13 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine13:setParent(obj.layout21);
    obj.horzLine13:setStrokeColor("white");
    obj.horzLine13:setStrokeSize(1);
    obj.horzLine13:setAlign("bottom");
    obj.horzLine13:setName("horzLine13");

    obj.flpSkillFlowPart13button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart13button:setParent(obj.flpSkillFlowPart13);
    obj.flpSkillFlowPart13button:setName("flpSkillFlowPart13button");
    obj.flpSkillFlowPart13button:setAlign("left");
    obj.flpSkillFlowPart13button:setText("@@DnD5e.skills.religion");
    obj.flpSkillFlowPart13button:setWidth(122);
    obj.flpSkillFlowPart13button:setMargins({left=2});
    obj.flpSkillFlowPart13button:setFontSize(12);


				table.insert(self.__attrSortData.inteligencia, {title="@@DnD5e.skills.religion", controlName="flpSkillFlowPart13"});				
			


    obj.dataLink44 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink44:setParent(obj.flowLayout7);
    obj.dataLink44:setFields({'atributos.modinteligencia', 'bonusProficiencia', 'pericias.religiao', 'pericias.bonusreligiaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink44:setName("dataLink44");

    obj.dataLink45 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink45:setParent(obj.fraLayAtributos);
    obj.dataLink45:setField("atributos.sabedoria");
    obj.dataLink45:setName("dataLink45");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.sabedoria = {};
		


    obj.flowPart9 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart9:setParent(obj.fraLayAtributos);
    obj.flowPart9:setHeight(140);
    obj.flowPart9:setMinWidth(320);
    obj.flowPart9:setMaxWidth(420);
    obj.flowPart9:setMinScaledWidth(305);
    obj.flowPart9:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart9:setName("flowPart9");
    obj.flowPart9:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart9:setVertAlign("leading");

    obj.layout22 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout22:setParent(obj.flowPart9);
    obj.layout22:setLeft(6);
    obj.layout22:setTop(12);
    obj.layout22:setWidth(116);
    obj.layout22:setHeight(115);
    obj.layout22:setName("layout22");

    obj.edit9 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit9:setParent(obj.layout22);
    obj.edit9:setAlign("top");
    obj.edit9:setMargins({left=30, right=30});
    obj.edit9:setField("atributos.sabedoria");
    obj.edit9:setHeight(30);
    obj.edit9:setType("number");
    obj.edit9:setMin(0);
    obj.edit9:setMax(99);
    obj.edit9:setName("edit9");
    obj.edit9:setTransparent(true);
    obj.edit9:setVertTextAlign("center");
    obj.edit9:setHorzTextAlign("center");
    obj.edit9:setFontSize(15);
    obj.edit9:setFontColor("white");

    obj.modsabedoriastr = GUI.fromHandle(_obj_newObject("label"));
    obj.modsabedoriastr:setParent(obj.flowPart9);
    obj.modsabedoriastr:setFrameRegion("modificador");
    obj.modsabedoriastr:setName("modsabedoriastr");
    obj.modsabedoriastr:setField("atributos.modsabedoriastr");
    obj.modsabedoriastr:setHorzTextAlign("center");
    obj.modsabedoriastr:setVertTextAlign("center");
    obj.modsabedoriastr:setFontSize(46);
    lfm_setPropAsString(obj.modsabedoriastr, "fontStyle", "bold");
    obj.modsabedoriastr:setFontColor("white");

    obj.layout23 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout23:setParent(obj.flowPart9);
    obj.layout23:setFrameRegion("titulo");
    obj.layout23:setName("layout23");

    obj.modsabedoriabutton = GUI.fromHandle(_obj_newObject("button"));
    obj.modsabedoriabutton:setParent(obj.layout23);
    obj.modsabedoriabutton:setAlign("client");
    obj.modsabedoriabutton:setName("modsabedoriabutton");
    obj.modsabedoriabutton:setText("SABEDORIA");
    obj.modsabedoriabutton:setVertTextAlign("center");
    obj.modsabedoriabutton:setHorzTextAlign("center");
    obj.modsabedoriabutton:setMargins({left=10,right=10});
    obj.modsabedoriabutton:setFontSize(12);

    obj.flowLayout8 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout8:setParent(obj.flowPart9);
    obj.flowLayout8:setFrameRegion("RegiaoDePericias");
    obj.flowLayout8:setAutoHeight(true);
    obj.flowLayout8:setLineSpacing(0);
    obj.flowLayout8:setHorzAlign("leading");
    obj.flowLayout8:setName("flowLayout8");
    obj.flowLayout8:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout8:setVertAlign("leading");

    obj.flpSkillFlowPart14 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart14:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart14:setMinWidth(206);
    obj.flpSkillFlowPart14:setMaxWidth(250);
    obj.flpSkillFlowPart14:setHeight(17);
    obj.flpSkillFlowPart14:setName("flpSkillFlowPart14");
    obj.flpSkillFlowPart14:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart14:setVertAlign("leading");

    obj.image14 = GUI.fromHandle(_obj_newObject("image"));
    obj.image14:setParent(obj.flpSkillFlowPart14);
    obj.image14:setAlign("left");
    obj.image14:setWidth(20);
    obj.image14:setHeight(20);
    obj.image14:setMargins({});
    obj.image14:setName("image14");
    obj.image14:setField("resistencias.sabedoriaIcon");
    obj.image14:setStyle("proportional");
    obj.image14:setHitTest(true);

    obj.dataLink46 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink46:setParent(obj.flpSkillFlowPart14);
    obj.dataLink46:setField("resistencias.sabedoriaIcon");
    obj.dataLink46:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink46:setName("dataLink46");

    obj.dataLink47 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink47:setParent(obj.flpSkillFlowPart14);
    obj.dataLink47:setField("resistencias.sabedoria");
    obj.dataLink47:setName("dataLink47");

    obj.layout24 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout24:setParent(obj.flpSkillFlowPart14);
    obj.layout24:setAlign("left");
    obj.layout24:setWidth(26);
    obj.layout24:setMargins({left=2});
    obj.layout24:setHitTest(true);
    obj.layout24:setName("layout24");

    obj.flpSkillFlowPart14str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart14str:setParent(obj.layout24);
    obj.flpSkillFlowPart14str:setName("flpSkillFlowPart14str");
    obj.flpSkillFlowPart14str:setField("resistencias.bonussabedoriastr");
    obj.flpSkillFlowPart14str:setAlign("client");
    obj.flpSkillFlowPart14str:setHorzTextAlign("center");
    obj.flpSkillFlowPart14str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart14str:setTextTrimming("none");
    obj.flpSkillFlowPart14str:setFontColor("white");

    obj.horzLine14 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine14:setParent(obj.layout24);
    obj.horzLine14:setStrokeColor("white");
    obj.horzLine14:setStrokeSize(1);
    obj.horzLine14:setAlign("bottom");
    obj.horzLine14:setName("horzLine14");

    obj.flpSkillFlowPart14button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart14button:setParent(obj.flpSkillFlowPart14);
    obj.flpSkillFlowPart14button:setName("flpSkillFlowPart14button");
    obj.flpSkillFlowPart14button:setAlign("left");
    obj.flpSkillFlowPart14button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart14button:setWidth(122);
    obj.flpSkillFlowPart14button:setMargins({left=2});
    obj.flpSkillFlowPart14button:setFontSize(12);

    obj.dataLink48 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink48:setParent(obj.flowLayout8);
    obj.dataLink48:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'resistencias.sabedoria', 'resistencias.sabedoriastrAltAtr', 'bonusResistencias'});
    obj.dataLink48:setName("dataLink48");

    obj.flpSkillFlowPart15 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart15:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart15:setMinWidth(206);
    obj.flpSkillFlowPart15:setMaxWidth(250);
    obj.flpSkillFlowPart15:setHeight(17);
    obj.flpSkillFlowPart15:setName("flpSkillFlowPart15");
    obj.flpSkillFlowPart15:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart15:setVertAlign("leading");

    obj.image15 = GUI.fromHandle(_obj_newObject("image"));
    obj.image15:setParent(obj.flpSkillFlowPart15);
    obj.image15:setAlign("left");
    obj.image15:setWidth(20);
    obj.image15:setHeight(20);
    obj.image15:setMargins({});
    obj.image15:setName("image15");
    obj.image15:setField("pericias.adestrarAnimaisIcon");
    obj.image15:setStyle("proportional");
    obj.image15:setHitTest(true);

    obj.dataLink49 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink49:setParent(obj.flpSkillFlowPart15);
    obj.dataLink49:setField("pericias.adestrarAnimaisIcon");
    obj.dataLink49:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink49:setName("dataLink49");

    obj.dataLink50 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink50:setParent(obj.flpSkillFlowPart15);
    obj.dataLink50:setField("pericias.adestrarAnimais");
    obj.dataLink50:setName("dataLink50");

    obj.layout25 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout25:setParent(obj.flpSkillFlowPart15);
    obj.layout25:setAlign("left");
    obj.layout25:setWidth(26);
    obj.layout25:setMargins({left=2});
    obj.layout25:setHitTest(true);
    obj.layout25:setName("layout25");

    obj.flpSkillFlowPart15str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart15str:setParent(obj.layout25);
    obj.flpSkillFlowPart15str:setName("flpSkillFlowPart15str");
    obj.flpSkillFlowPart15str:setField("pericias.bonusadestrarAnimaisstr");
    obj.flpSkillFlowPart15str:setAlign("client");
    obj.flpSkillFlowPart15str:setHorzTextAlign("center");
    obj.flpSkillFlowPart15str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart15str:setTextTrimming("none");
    obj.flpSkillFlowPart15str:setFontColor("white");

    obj.horzLine15 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine15:setParent(obj.layout25);
    obj.horzLine15:setStrokeColor("white");
    obj.horzLine15:setStrokeSize(1);
    obj.horzLine15:setAlign("bottom");
    obj.horzLine15:setName("horzLine15");

    obj.flpSkillFlowPart15button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart15button:setParent(obj.flpSkillFlowPart15);
    obj.flpSkillFlowPart15button:setName("flpSkillFlowPart15button");
    obj.flpSkillFlowPart15button:setAlign("left");
    obj.flpSkillFlowPart15button:setText("@@DnD5e.skills.animalhandling");
    obj.flpSkillFlowPart15button:setWidth(122);
    obj.flpSkillFlowPart15button:setMargins({left=2});
    obj.flpSkillFlowPart15button:setFontSize(12);


				table.insert(self.__attrSortData.sabedoria, {title="@@DnD5e.skills.animalhandling", controlName="flpSkillFlowPart15"});				
			


    obj.dataLink51 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink51:setParent(obj.flowLayout8);
    obj.dataLink51:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'pericias.adestrarAnimais', 'pericias.bonusadestrarAnimaisstrAltAtr', 'bonusHabilidades'});
    obj.dataLink51:setName("dataLink51");

    obj.flpSkillFlowPart16 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart16:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart16:setMinWidth(206);
    obj.flpSkillFlowPart16:setMaxWidth(250);
    obj.flpSkillFlowPart16:setHeight(17);
    obj.flpSkillFlowPart16:setName("flpSkillFlowPart16");
    obj.flpSkillFlowPart16:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart16:setVertAlign("leading");

    obj.image16 = GUI.fromHandle(_obj_newObject("image"));
    obj.image16:setParent(obj.flpSkillFlowPart16);
    obj.image16:setAlign("left");
    obj.image16:setWidth(20);
    obj.image16:setHeight(20);
    obj.image16:setMargins({});
    obj.image16:setName("image16");
    obj.image16:setField("pericias.intuicaoIcon");
    obj.image16:setStyle("proportional");
    obj.image16:setHitTest(true);

    obj.dataLink52 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink52:setParent(obj.flpSkillFlowPart16);
    obj.dataLink52:setField("pericias.intuicaoIcon");
    obj.dataLink52:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink52:setName("dataLink52");

    obj.dataLink53 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink53:setParent(obj.flpSkillFlowPart16);
    obj.dataLink53:setField("pericias.intuicao");
    obj.dataLink53:setName("dataLink53");

    obj.layout26 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout26:setParent(obj.flpSkillFlowPart16);
    obj.layout26:setAlign("left");
    obj.layout26:setWidth(26);
    obj.layout26:setMargins({left=2});
    obj.layout26:setHitTest(true);
    obj.layout26:setName("layout26");

    obj.flpSkillFlowPart16str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart16str:setParent(obj.layout26);
    obj.flpSkillFlowPart16str:setName("flpSkillFlowPart16str");
    obj.flpSkillFlowPart16str:setField("pericias.bonusintuicaostr");
    obj.flpSkillFlowPart16str:setAlign("client");
    obj.flpSkillFlowPart16str:setHorzTextAlign("center");
    obj.flpSkillFlowPart16str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart16str:setTextTrimming("none");
    obj.flpSkillFlowPart16str:setFontColor("white");

    obj.horzLine16 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine16:setParent(obj.layout26);
    obj.horzLine16:setStrokeColor("white");
    obj.horzLine16:setStrokeSize(1);
    obj.horzLine16:setAlign("bottom");
    obj.horzLine16:setName("horzLine16");

    obj.flpSkillFlowPart16button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart16button:setParent(obj.flpSkillFlowPart16);
    obj.flpSkillFlowPart16button:setName("flpSkillFlowPart16button");
    obj.flpSkillFlowPart16button:setAlign("left");
    obj.flpSkillFlowPart16button:setText("@@DnD5e.skills.insight");
    obj.flpSkillFlowPart16button:setWidth(122);
    obj.flpSkillFlowPart16button:setMargins({left=2});
    obj.flpSkillFlowPart16button:setFontSize(12);


				table.insert(self.__attrSortData.sabedoria, {title="@@DnD5e.skills.insight", controlName="flpSkillFlowPart16"});				
			


    obj.dataLink54 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink54:setParent(obj.flowLayout8);
    obj.dataLink54:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'pericias.intuicao', 'pericias.bonusintuicaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink54:setName("dataLink54");

    obj.flpSkillFlowPart17 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart17:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart17:setMinWidth(206);
    obj.flpSkillFlowPart17:setMaxWidth(250);
    obj.flpSkillFlowPart17:setHeight(17);
    obj.flpSkillFlowPart17:setName("flpSkillFlowPart17");
    obj.flpSkillFlowPart17:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart17:setVertAlign("leading");

    obj.image17 = GUI.fromHandle(_obj_newObject("image"));
    obj.image17:setParent(obj.flpSkillFlowPart17);
    obj.image17:setAlign("left");
    obj.image17:setWidth(20);
    obj.image17:setHeight(20);
    obj.image17:setMargins({});
    obj.image17:setName("image17");
    obj.image17:setField("pericias.medicinaIcon");
    obj.image17:setStyle("proportional");
    obj.image17:setHitTest(true);

    obj.dataLink55 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink55:setParent(obj.flpSkillFlowPart17);
    obj.dataLink55:setField("pericias.medicinaIcon");
    obj.dataLink55:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink55:setName("dataLink55");

    obj.dataLink56 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink56:setParent(obj.flpSkillFlowPart17);
    obj.dataLink56:setField("pericias.medicina");
    obj.dataLink56:setName("dataLink56");

    obj.layout27 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout27:setParent(obj.flpSkillFlowPart17);
    obj.layout27:setAlign("left");
    obj.layout27:setWidth(26);
    obj.layout27:setMargins({left=2});
    obj.layout27:setHitTest(true);
    obj.layout27:setName("layout27");

    obj.flpSkillFlowPart17str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart17str:setParent(obj.layout27);
    obj.flpSkillFlowPart17str:setName("flpSkillFlowPart17str");
    obj.flpSkillFlowPart17str:setField("pericias.bonusmedicinastr");
    obj.flpSkillFlowPart17str:setAlign("client");
    obj.flpSkillFlowPart17str:setHorzTextAlign("center");
    obj.flpSkillFlowPart17str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart17str:setTextTrimming("none");
    obj.flpSkillFlowPart17str:setFontColor("white");

    obj.horzLine17 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine17:setParent(obj.layout27);
    obj.horzLine17:setStrokeColor("white");
    obj.horzLine17:setStrokeSize(1);
    obj.horzLine17:setAlign("bottom");
    obj.horzLine17:setName("horzLine17");

    obj.flpSkillFlowPart17button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart17button:setParent(obj.flpSkillFlowPart17);
    obj.flpSkillFlowPart17button:setName("flpSkillFlowPart17button");
    obj.flpSkillFlowPart17button:setAlign("left");
    obj.flpSkillFlowPart17button:setText("@@DnD5e.skills.medicine");
    obj.flpSkillFlowPart17button:setWidth(122);
    obj.flpSkillFlowPart17button:setMargins({left=2});
    obj.flpSkillFlowPart17button:setFontSize(12);


				table.insert(self.__attrSortData.sabedoria, {title="@@DnD5e.skills.medicine", controlName="flpSkillFlowPart17"});				
			


    obj.dataLink57 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink57:setParent(obj.flowLayout8);
    obj.dataLink57:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'pericias.medicina', 'pericias.bonusmedicinastrAltAtr', 'bonusHabilidades'});
    obj.dataLink57:setName("dataLink57");

    obj.flpSkillFlowPart18 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart18:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart18:setMinWidth(206);
    obj.flpSkillFlowPart18:setMaxWidth(250);
    obj.flpSkillFlowPart18:setHeight(17);
    obj.flpSkillFlowPart18:setName("flpSkillFlowPart18");
    obj.flpSkillFlowPart18:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart18:setVertAlign("leading");

    obj.image18 = GUI.fromHandle(_obj_newObject("image"));
    obj.image18:setParent(obj.flpSkillFlowPart18);
    obj.image18:setAlign("left");
    obj.image18:setWidth(20);
    obj.image18:setHeight(20);
    obj.image18:setMargins({});
    obj.image18:setName("image18");
    obj.image18:setField("pericias.percepcaoIcon");
    obj.image18:setStyle("proportional");
    obj.image18:setHitTest(true);

    obj.dataLink58 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink58:setParent(obj.flpSkillFlowPart18);
    obj.dataLink58:setField("pericias.percepcaoIcon");
    obj.dataLink58:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink58:setName("dataLink58");

    obj.dataLink59 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink59:setParent(obj.flpSkillFlowPart18);
    obj.dataLink59:setField("pericias.percepcao");
    obj.dataLink59:setName("dataLink59");

    obj.layout28 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout28:setParent(obj.flpSkillFlowPart18);
    obj.layout28:setAlign("left");
    obj.layout28:setWidth(26);
    obj.layout28:setMargins({left=2});
    obj.layout28:setHitTest(true);
    obj.layout28:setName("layout28");

    obj.flpSkillFlowPart18str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart18str:setParent(obj.layout28);
    obj.flpSkillFlowPart18str:setName("flpSkillFlowPart18str");
    obj.flpSkillFlowPart18str:setField("pericias.bonuspercepcaostr");
    obj.flpSkillFlowPart18str:setAlign("client");
    obj.flpSkillFlowPart18str:setHorzTextAlign("center");
    obj.flpSkillFlowPart18str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart18str:setTextTrimming("none");
    obj.flpSkillFlowPart18str:setFontColor("white");

    obj.horzLine18 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine18:setParent(obj.layout28);
    obj.horzLine18:setStrokeColor("white");
    obj.horzLine18:setStrokeSize(1);
    obj.horzLine18:setAlign("bottom");
    obj.horzLine18:setName("horzLine18");

    obj.flpSkillFlowPart18button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart18button:setParent(obj.flpSkillFlowPart18);
    obj.flpSkillFlowPart18button:setName("flpSkillFlowPart18button");
    obj.flpSkillFlowPart18button:setAlign("left");
    obj.flpSkillFlowPart18button:setText("@@DnD5e.skills.perception");
    obj.flpSkillFlowPart18button:setWidth(122);
    obj.flpSkillFlowPart18button:setMargins({left=2});
    obj.flpSkillFlowPart18button:setFontSize(12);


				table.insert(self.__attrSortData.sabedoria, {title="@@DnD5e.skills.perception", controlName="flpSkillFlowPart18"});				
			


    obj.dataLink60 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink60:setParent(obj.flowLayout8);
    obj.dataLink60:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'pericias.percepcao', 'pericias.bonuspercepcaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink60:setName("dataLink60");

    obj.flpSkillFlowPart19 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart19:setParent(obj.flowLayout8);
    obj.flpSkillFlowPart19:setMinWidth(206);
    obj.flpSkillFlowPart19:setMaxWidth(250);
    obj.flpSkillFlowPart19:setHeight(17);
    obj.flpSkillFlowPart19:setName("flpSkillFlowPart19");
    obj.flpSkillFlowPart19:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart19:setVertAlign("leading");

    obj.image19 = GUI.fromHandle(_obj_newObject("image"));
    obj.image19:setParent(obj.flpSkillFlowPart19);
    obj.image19:setAlign("left");
    obj.image19:setWidth(20);
    obj.image19:setHeight(20);
    obj.image19:setMargins({});
    obj.image19:setName("image19");
    obj.image19:setField("pericias.sobrevivenciaIcon");
    obj.image19:setStyle("proportional");
    obj.image19:setHitTest(true);

    obj.dataLink61 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink61:setParent(obj.flpSkillFlowPart19);
    obj.dataLink61:setField("pericias.sobrevivenciaIcon");
    obj.dataLink61:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink61:setName("dataLink61");

    obj.dataLink62 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink62:setParent(obj.flpSkillFlowPart19);
    obj.dataLink62:setField("pericias.sobrevivencia");
    obj.dataLink62:setName("dataLink62");

    obj.layout29 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout29:setParent(obj.flpSkillFlowPart19);
    obj.layout29:setAlign("left");
    obj.layout29:setWidth(26);
    obj.layout29:setMargins({left=2});
    obj.layout29:setHitTest(true);
    obj.layout29:setName("layout29");

    obj.flpSkillFlowPart19str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart19str:setParent(obj.layout29);
    obj.flpSkillFlowPart19str:setName("flpSkillFlowPart19str");
    obj.flpSkillFlowPart19str:setField("pericias.bonussobrevivenciastr");
    obj.flpSkillFlowPart19str:setAlign("client");
    obj.flpSkillFlowPart19str:setHorzTextAlign("center");
    obj.flpSkillFlowPart19str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart19str:setTextTrimming("none");
    obj.flpSkillFlowPart19str:setFontColor("white");

    obj.horzLine19 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine19:setParent(obj.layout29);
    obj.horzLine19:setStrokeColor("white");
    obj.horzLine19:setStrokeSize(1);
    obj.horzLine19:setAlign("bottom");
    obj.horzLine19:setName("horzLine19");

    obj.flpSkillFlowPart19button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart19button:setParent(obj.flpSkillFlowPart19);
    obj.flpSkillFlowPart19button:setName("flpSkillFlowPart19button");
    obj.flpSkillFlowPart19button:setAlign("left");
    obj.flpSkillFlowPart19button:setText("@@DnD5e.skills.survival");
    obj.flpSkillFlowPart19button:setWidth(122);
    obj.flpSkillFlowPart19button:setMargins({left=2});
    obj.flpSkillFlowPart19button:setFontSize(12);


				table.insert(self.__attrSortData.sabedoria, {title="@@DnD5e.skills.survival", controlName="flpSkillFlowPart19"});				
			


    obj.dataLink63 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink63:setParent(obj.flowLayout8);
    obj.dataLink63:setFields({'atributos.modsabedoria', 'bonusProficiencia', 'pericias.sobrevivencia', 'pericias.bonussobrevivenciastrAltAtr', 'bonusHabilidades'});
    obj.dataLink63:setName("dataLink63");

    obj.dataLink64 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink64:setParent(obj.fraLayAtributos);
    obj.dataLink64:setField("atributos.carisma");
    obj.dataLink64:setName("dataLink64");


			if self.__attrSortData == nil then
				self.__attrSortData = {};
			end;
			
			self.__attrSortData.carisma = {};
		


    obj.flowPart10 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart10:setParent(obj.fraLayAtributos);
    obj.flowPart10:setHeight(140);
    obj.flowPart10:setMinWidth(320);
    obj.flowPart10:setMaxWidth(420);
    obj.flowPart10:setMinScaledWidth(305);
    obj.flowPart10:setFrameStyle("frames/atributeFrame2/frame.xml");
    obj.flowPart10:setName("flowPart10");
    obj.flowPart10:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart10:setVertAlign("leading");

    obj.layout30 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout30:setParent(obj.flowPart10);
    obj.layout30:setLeft(6);
    obj.layout30:setTop(12);
    obj.layout30:setWidth(116);
    obj.layout30:setHeight(115);
    obj.layout30:setName("layout30");

    obj.edit10 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit10:setParent(obj.layout30);
    obj.edit10:setAlign("top");
    obj.edit10:setMargins({left=30, right=30});
    obj.edit10:setField("atributos.carisma");
    obj.edit10:setHeight(30);
    obj.edit10:setType("number");
    obj.edit10:setMin(0);
    obj.edit10:setMax(99);
    obj.edit10:setName("edit10");
    obj.edit10:setTransparent(true);
    obj.edit10:setVertTextAlign("center");
    obj.edit10:setHorzTextAlign("center");
    obj.edit10:setFontSize(15);
    obj.edit10:setFontColor("white");

    obj.modcarismastr = GUI.fromHandle(_obj_newObject("label"));
    obj.modcarismastr:setParent(obj.flowPart10);
    obj.modcarismastr:setFrameRegion("modificador");
    obj.modcarismastr:setName("modcarismastr");
    obj.modcarismastr:setField("atributos.modcarismastr");
    obj.modcarismastr:setHorzTextAlign("center");
    obj.modcarismastr:setVertTextAlign("center");
    obj.modcarismastr:setFontSize(46);
    lfm_setPropAsString(obj.modcarismastr, "fontStyle", "bold");
    obj.modcarismastr:setFontColor("white");

    obj.layout31 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout31:setParent(obj.flowPart10);
    obj.layout31:setFrameRegion("titulo");
    obj.layout31:setName("layout31");

    obj.modcarismabutton = GUI.fromHandle(_obj_newObject("button"));
    obj.modcarismabutton:setParent(obj.layout31);
    obj.modcarismabutton:setAlign("client");
    obj.modcarismabutton:setName("modcarismabutton");
    obj.modcarismabutton:setText("CARISMA");
    obj.modcarismabutton:setVertTextAlign("center");
    obj.modcarismabutton:setHorzTextAlign("center");
    obj.modcarismabutton:setMargins({left=10,right=10});
    obj.modcarismabutton:setFontSize(12);

    obj.flowLayout9 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout9:setParent(obj.flowPart10);
    obj.flowLayout9:setFrameRegion("RegiaoDePericias");
    obj.flowLayout9:setAutoHeight(true);
    obj.flowLayout9:setLineSpacing(0);
    obj.flowLayout9:setHorzAlign("leading");
    obj.flowLayout9:setName("flowLayout9");
    obj.flowLayout9:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout9:setVertAlign("leading");

    obj.flpSkillFlowPart20 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart20:setParent(obj.flowLayout9);
    obj.flpSkillFlowPart20:setMinWidth(206);
    obj.flpSkillFlowPart20:setMaxWidth(250);
    obj.flpSkillFlowPart20:setHeight(17);
    obj.flpSkillFlowPart20:setName("flpSkillFlowPart20");
    obj.flpSkillFlowPart20:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart20:setVertAlign("leading");

    obj.image20 = GUI.fromHandle(_obj_newObject("image"));
    obj.image20:setParent(obj.flpSkillFlowPart20);
    obj.image20:setAlign("left");
    obj.image20:setWidth(20);
    obj.image20:setHeight(20);
    obj.image20:setMargins({});
    obj.image20:setName("image20");
    obj.image20:setField("resistencias.carismaIcon");
    obj.image20:setStyle("proportional");
    obj.image20:setHitTest(true);

    obj.dataLink65 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink65:setParent(obj.flpSkillFlowPart20);
    obj.dataLink65:setField("resistencias.carismaIcon");
    obj.dataLink65:setDefaultValue("http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png");
    obj.dataLink65:setName("dataLink65");

    obj.dataLink66 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink66:setParent(obj.flpSkillFlowPart20);
    obj.dataLink66:setField("resistencias.carisma");
    obj.dataLink66:setName("dataLink66");

    obj.layout32 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout32:setParent(obj.flpSkillFlowPart20);
    obj.layout32:setAlign("left");
    obj.layout32:setWidth(26);
    obj.layout32:setMargins({left=2});
    obj.layout32:setHitTest(true);
    obj.layout32:setName("layout32");

    obj.flpSkillFlowPart20str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart20str:setParent(obj.layout32);
    obj.flpSkillFlowPart20str:setName("flpSkillFlowPart20str");
    obj.flpSkillFlowPart20str:setField("resistencias.bonuscarismastr");
    obj.flpSkillFlowPart20str:setAlign("client");
    obj.flpSkillFlowPart20str:setHorzTextAlign("center");
    obj.flpSkillFlowPart20str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart20str:setTextTrimming("none");
    obj.flpSkillFlowPart20str:setFontColor("white");

    obj.horzLine20 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine20:setParent(obj.layout32);
    obj.horzLine20:setStrokeColor("white");
    obj.horzLine20:setStrokeSize(1);
    obj.horzLine20:setAlign("bottom");
    obj.horzLine20:setName("horzLine20");

    obj.flpSkillFlowPart20button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart20button:setParent(obj.flpSkillFlowPart20);
    obj.flpSkillFlowPart20button:setName("flpSkillFlowPart20button");
    obj.flpSkillFlowPart20button:setAlign("left");
    obj.flpSkillFlowPart20button:setText("@@DnD5e.savingThrows.title");
    obj.flpSkillFlowPart20button:setWidth(122);
    obj.flpSkillFlowPart20button:setMargins({left=2});
    obj.flpSkillFlowPart20button:setFontSize(12);

    obj.dataLink67 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink67:setParent(obj.flowLayout9);
    obj.dataLink67:setFields({'atributos.modcarisma', 'bonusProficiencia', 'resistencias.carisma', 'resistencias.carismastrAltAtr', 'bonusResistencias'});
    obj.dataLink67:setName("dataLink67");

    obj.flpSkillFlowPart21 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart21:setParent(obj.flowLayout9);
    obj.flpSkillFlowPart21:setMinWidth(206);
    obj.flpSkillFlowPart21:setMaxWidth(250);
    obj.flpSkillFlowPart21:setHeight(17);
    obj.flpSkillFlowPart21:setName("flpSkillFlowPart21");
    obj.flpSkillFlowPart21:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart21:setVertAlign("leading");

    obj.image21 = GUI.fromHandle(_obj_newObject("image"));
    obj.image21:setParent(obj.flpSkillFlowPart21);
    obj.image21:setAlign("left");
    obj.image21:setWidth(20);
    obj.image21:setHeight(20);
    obj.image21:setMargins({});
    obj.image21:setName("image21");
    obj.image21:setField("pericias.atuacaoIcon");
    obj.image21:setStyle("proportional");
    obj.image21:setHitTest(true);

    obj.dataLink68 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink68:setParent(obj.flpSkillFlowPart21);
    obj.dataLink68:setField("pericias.atuacaoIcon");
    obj.dataLink68:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink68:setName("dataLink68");

    obj.dataLink69 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink69:setParent(obj.flpSkillFlowPart21);
    obj.dataLink69:setField("pericias.atuacao");
    obj.dataLink69:setName("dataLink69");

    obj.layout33 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout33:setParent(obj.flpSkillFlowPart21);
    obj.layout33:setAlign("left");
    obj.layout33:setWidth(26);
    obj.layout33:setMargins({left=2});
    obj.layout33:setHitTest(true);
    obj.layout33:setName("layout33");

    obj.flpSkillFlowPart21str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart21str:setParent(obj.layout33);
    obj.flpSkillFlowPart21str:setName("flpSkillFlowPart21str");
    obj.flpSkillFlowPart21str:setField("pericias.bonusatuacaostr");
    obj.flpSkillFlowPart21str:setAlign("client");
    obj.flpSkillFlowPart21str:setHorzTextAlign("center");
    obj.flpSkillFlowPart21str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart21str:setTextTrimming("none");
    obj.flpSkillFlowPart21str:setFontColor("white");

    obj.horzLine21 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine21:setParent(obj.layout33);
    obj.horzLine21:setStrokeColor("white");
    obj.horzLine21:setStrokeSize(1);
    obj.horzLine21:setAlign("bottom");
    obj.horzLine21:setName("horzLine21");

    obj.flpSkillFlowPart21button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart21button:setParent(obj.flpSkillFlowPart21);
    obj.flpSkillFlowPart21button:setName("flpSkillFlowPart21button");
    obj.flpSkillFlowPart21button:setAlign("left");
    obj.flpSkillFlowPart21button:setText("@@DnD5e.skills.performance");
    obj.flpSkillFlowPart21button:setWidth(122);
    obj.flpSkillFlowPart21button:setMargins({left=2});
    obj.flpSkillFlowPart21button:setFontSize(12);


				table.insert(self.__attrSortData.carisma, {title="@@DnD5e.skills.performance", controlName="flpSkillFlowPart21"});				
			


    obj.dataLink70 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink70:setParent(obj.flowLayout9);
    obj.dataLink70:setFields({'atributos.modcarisma', 'bonusProficiencia', 'pericias.atuacao', 'pericias.bonusatuacaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink70:setName("dataLink70");

    obj.flpSkillFlowPart22 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart22:setParent(obj.flowLayout9);
    obj.flpSkillFlowPart22:setMinWidth(206);
    obj.flpSkillFlowPart22:setMaxWidth(250);
    obj.flpSkillFlowPart22:setHeight(17);
    obj.flpSkillFlowPart22:setName("flpSkillFlowPart22");
    obj.flpSkillFlowPart22:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart22:setVertAlign("leading");

    obj.image22 = GUI.fromHandle(_obj_newObject("image"));
    obj.image22:setParent(obj.flpSkillFlowPart22);
    obj.image22:setAlign("left");
    obj.image22:setWidth(20);
    obj.image22:setHeight(20);
    obj.image22:setMargins({});
    obj.image22:setName("image22");
    obj.image22:setField("pericias.enganacaoIcon");
    obj.image22:setStyle("proportional");
    obj.image22:setHitTest(true);

    obj.dataLink71 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink71:setParent(obj.flpSkillFlowPart22);
    obj.dataLink71:setField("pericias.enganacaoIcon");
    obj.dataLink71:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink71:setName("dataLink71");

    obj.dataLink72 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink72:setParent(obj.flpSkillFlowPart22);
    obj.dataLink72:setField("pericias.enganacao");
    obj.dataLink72:setName("dataLink72");

    obj.layout34 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout34:setParent(obj.flpSkillFlowPart22);
    obj.layout34:setAlign("left");
    obj.layout34:setWidth(26);
    obj.layout34:setMargins({left=2});
    obj.layout34:setHitTest(true);
    obj.layout34:setName("layout34");

    obj.flpSkillFlowPart22str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart22str:setParent(obj.layout34);
    obj.flpSkillFlowPart22str:setName("flpSkillFlowPart22str");
    obj.flpSkillFlowPart22str:setField("pericias.bonusenganacaostr");
    obj.flpSkillFlowPart22str:setAlign("client");
    obj.flpSkillFlowPart22str:setHorzTextAlign("center");
    obj.flpSkillFlowPart22str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart22str:setTextTrimming("none");
    obj.flpSkillFlowPart22str:setFontColor("white");

    obj.horzLine22 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine22:setParent(obj.layout34);
    obj.horzLine22:setStrokeColor("white");
    obj.horzLine22:setStrokeSize(1);
    obj.horzLine22:setAlign("bottom");
    obj.horzLine22:setName("horzLine22");

    obj.flpSkillFlowPart22button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart22button:setParent(obj.flpSkillFlowPart22);
    obj.flpSkillFlowPart22button:setName("flpSkillFlowPart22button");
    obj.flpSkillFlowPart22button:setAlign("left");
    obj.flpSkillFlowPart22button:setText("@@DnD5e.skills.deception");
    obj.flpSkillFlowPart22button:setWidth(122);
    obj.flpSkillFlowPart22button:setMargins({left=2});
    obj.flpSkillFlowPart22button:setFontSize(12);


				table.insert(self.__attrSortData.carisma, {title="@@DnD5e.skills.deception", controlName="flpSkillFlowPart22"});				
			


    obj.dataLink73 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink73:setParent(obj.flowLayout9);
    obj.dataLink73:setFields({'atributos.modcarisma', 'bonusProficiencia', 'pericias.enganacao', 'pericias.bonusenganacaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink73:setName("dataLink73");

    obj.flpSkillFlowPart23 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart23:setParent(obj.flowLayout9);
    obj.flpSkillFlowPart23:setMinWidth(206);
    obj.flpSkillFlowPart23:setMaxWidth(250);
    obj.flpSkillFlowPart23:setHeight(17);
    obj.flpSkillFlowPart23:setName("flpSkillFlowPart23");
    obj.flpSkillFlowPart23:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart23:setVertAlign("leading");

    obj.image23 = GUI.fromHandle(_obj_newObject("image"));
    obj.image23:setParent(obj.flpSkillFlowPart23);
    obj.image23:setAlign("left");
    obj.image23:setWidth(20);
    obj.image23:setHeight(20);
    obj.image23:setMargins({});
    obj.image23:setName("image23");
    obj.image23:setField("pericias.intimidacaoIcon");
    obj.image23:setStyle("proportional");
    obj.image23:setHitTest(true);

    obj.dataLink74 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink74:setParent(obj.flpSkillFlowPart23);
    obj.dataLink74:setField("pericias.intimidacaoIcon");
    obj.dataLink74:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink74:setName("dataLink74");

    obj.dataLink75 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink75:setParent(obj.flpSkillFlowPart23);
    obj.dataLink75:setField("pericias.intimidacao");
    obj.dataLink75:setName("dataLink75");

    obj.layout35 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout35:setParent(obj.flpSkillFlowPart23);
    obj.layout35:setAlign("left");
    obj.layout35:setWidth(26);
    obj.layout35:setMargins({left=2});
    obj.layout35:setHitTest(true);
    obj.layout35:setName("layout35");

    obj.flpSkillFlowPart23str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart23str:setParent(obj.layout35);
    obj.flpSkillFlowPart23str:setName("flpSkillFlowPart23str");
    obj.flpSkillFlowPart23str:setField("pericias.bonusintimidacaostr");
    obj.flpSkillFlowPart23str:setAlign("client");
    obj.flpSkillFlowPart23str:setHorzTextAlign("center");
    obj.flpSkillFlowPart23str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart23str:setTextTrimming("none");
    obj.flpSkillFlowPart23str:setFontColor("white");

    obj.horzLine23 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine23:setParent(obj.layout35);
    obj.horzLine23:setStrokeColor("white");
    obj.horzLine23:setStrokeSize(1);
    obj.horzLine23:setAlign("bottom");
    obj.horzLine23:setName("horzLine23");

    obj.flpSkillFlowPart23button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart23button:setParent(obj.flpSkillFlowPart23);
    obj.flpSkillFlowPart23button:setName("flpSkillFlowPart23button");
    obj.flpSkillFlowPart23button:setAlign("left");
    obj.flpSkillFlowPart23button:setText("@@DnD5e.skills.intimidation");
    obj.flpSkillFlowPart23button:setWidth(122);
    obj.flpSkillFlowPart23button:setMargins({left=2});
    obj.flpSkillFlowPart23button:setFontSize(12);


				table.insert(self.__attrSortData.carisma, {title="@@DnD5e.skills.intimidation", controlName="flpSkillFlowPart23"});				
			


    obj.dataLink76 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink76:setParent(obj.flowLayout9);
    obj.dataLink76:setFields({'atributos.modcarisma', 'bonusProficiencia', 'pericias.intimidacao', 'pericias.bonusintimidacaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink76:setName("dataLink76");

    obj.flpSkillFlowPart24 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flpSkillFlowPart24:setParent(obj.flowLayout9);
    obj.flpSkillFlowPart24:setMinWidth(206);
    obj.flpSkillFlowPart24:setMaxWidth(250);
    obj.flpSkillFlowPart24:setHeight(17);
    obj.flpSkillFlowPart24:setName("flpSkillFlowPart24");
    obj.flpSkillFlowPart24:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flpSkillFlowPart24:setVertAlign("leading");

    obj.image24 = GUI.fromHandle(_obj_newObject("image"));
    obj.image24:setParent(obj.flpSkillFlowPart24);
    obj.image24:setAlign("left");
    obj.image24:setWidth(20);
    obj.image24:setHeight(20);
    obj.image24:setMargins({});
    obj.image24:setName("image24");
    obj.image24:setField("pericias.persuasaoIcon");
    obj.image24:setStyle("proportional");
    obj.image24:setHitTest(true);

    obj.dataLink77 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink77:setParent(obj.flpSkillFlowPart24);
    obj.dataLink77:setField("pericias.persuasaoIcon");
    obj.dataLink77:setDefaultValue("http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png");
    obj.dataLink77:setName("dataLink77");

    obj.dataLink78 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink78:setParent(obj.flpSkillFlowPart24);
    obj.dataLink78:setField("pericias.persuasao");
    obj.dataLink78:setName("dataLink78");

    obj.layout36 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout36:setParent(obj.flpSkillFlowPart24);
    obj.layout36:setAlign("left");
    obj.layout36:setWidth(26);
    obj.layout36:setMargins({left=2});
    obj.layout36:setHitTest(true);
    obj.layout36:setName("layout36");

    obj.flpSkillFlowPart24str = GUI.fromHandle(_obj_newObject("label"));
    obj.flpSkillFlowPart24str:setParent(obj.layout36);
    obj.flpSkillFlowPart24str:setName("flpSkillFlowPart24str");
    obj.flpSkillFlowPart24str:setField("pericias.bonuspersuasaostr");
    obj.flpSkillFlowPart24str:setAlign("client");
    obj.flpSkillFlowPart24str:setHorzTextAlign("center");
    obj.flpSkillFlowPart24str:setVertTextAlign("trailing");
    obj.flpSkillFlowPart24str:setTextTrimming("none");
    obj.flpSkillFlowPart24str:setFontColor("white");

    obj.horzLine24 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine24:setParent(obj.layout36);
    obj.horzLine24:setStrokeColor("white");
    obj.horzLine24:setStrokeSize(1);
    obj.horzLine24:setAlign("bottom");
    obj.horzLine24:setName("horzLine24");

    obj.flpSkillFlowPart24button = GUI.fromHandle(_obj_newObject("button"));
    obj.flpSkillFlowPart24button:setParent(obj.flpSkillFlowPart24);
    obj.flpSkillFlowPart24button:setName("flpSkillFlowPart24button");
    obj.flpSkillFlowPart24button:setAlign("left");
    obj.flpSkillFlowPart24button:setText("@@DnD5e.skills.persuasion");
    obj.flpSkillFlowPart24button:setWidth(122);
    obj.flpSkillFlowPart24button:setMargins({left=2});
    obj.flpSkillFlowPart24button:setFontSize(12);


				table.insert(self.__attrSortData.carisma, {title="@@DnD5e.skills.persuasion", controlName="flpSkillFlowPart24"});				
			


    obj.dataLink79 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink79:setParent(obj.flowLayout9);
    obj.dataLink79:setFields({'atributos.modcarisma', 'bonusProficiencia', 'pericias.persuasao', 'pericias.bonuspersuasaostrAltAtr', 'bonusHabilidades'});
    obj.dataLink79:setName("dataLink79");


                    self:sortFrontSkillBoxes();
                


    obj.flowLayout10 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout10:setParent(obj.flowLayout3);
    obj.flowLayout10:setAutoHeight(true);
    obj.flowLayout10:setHorzAlign("center");
    obj.flowLayout10:setVertAlign("leading");
    obj.flowLayout10:setMaxControlsPerLine(1);
    obj.flowLayout10:setName("flowLayout10");
    obj.flowLayout10:setStepSizes({310, 360});
    obj.flowLayout10:setMinScaledWidth(300);
    obj.flowLayout10:setMaxScaledWidth(340);
    obj.flowLayout10:setAvoidScale(true);
    obj.flowLayout10:setMargins({left=1, right=1, top=2, bottom=2});

    obj.flowLayout11 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout11:setParent(obj.flowLayout10);
    obj.flowLayout11:setMinWidth(235);
    obj.flowLayout11:setMaxWidth(475);
    obj.flowLayout11:setAutoHeight(true);
    obj.flowLayout11:setAvoidScale(false);
    obj.flowLayout11:setVertAlign("center");
    obj.flowLayout11:setHorzAlign("justify");
    obj.flowLayout11:setName("flowLayout11");
    obj.flowLayout11:setMargins({left=1, right=1, top=2, bottom=2});

    obj.flowPart11 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart11:setParent(obj.flowLayout11);
    obj.flowPart11:setStepSizes({105});
    obj.flowPart11:setMinScaledWidth(75);
    obj.flowPart11:setHeight(120);
    obj.flowPart11:setFrameStyle("frames/shield/frame.xml");
    obj.flowPart11:setName("flowPart11");
    obj.flowPart11:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart11:setVertAlign("leading");

    obj.label5 = GUI.fromHandle(_obj_newObject("label"));
    obj.label5:setParent(obj.flowPart11);
    obj.label5:setAlign("top");
    obj.label5:setText("CA");
    obj.label5:setHeight(20);
    obj.label5:setFontSize(9);
    obj.label5:setWordWrap(true);
    obj.label5:setHorzTextAlign("center");
    obj.label5:setTextTrimming("none");
    obj.label5:setName("label5");
    obj.label5:setFontColor("white");

    obj.edit11 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit11:setParent(obj.flowPart11);
    obj.edit11:setAlign("client");
    obj.edit11:setField("CA");
    obj.edit11:setFontSize(30);
    obj.edit11:setName("edit11");
    obj.edit11:setTransparent(true);
    obj.edit11:setVertTextAlign("center");
    obj.edit11:setHorzTextAlign("center");
    obj.edit11:setFontColor("white");

    obj.flowPart12 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart12:setParent(obj.flowLayout11);
    obj.flowPart12:setStepSizes({105});
    obj.flowPart12:setMinScaledWidth(75);
    obj.flowPart12:setHeight(120);
    obj.flowPart12:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart12:setName("flowPart12");
    obj.flowPart12:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart12:setVertAlign("leading");

    obj.initiativeBut = GUI.fromHandle(_obj_newObject("button"));
    obj.initiativeBut:setParent(obj.flowPart12);
    obj.initiativeBut:setName("initiativeBut");
    obj.initiativeBut:setAlign("top");
    obj.initiativeBut:setText("Iniciativa");
    obj.initiativeBut:setHeight(20);
    obj.initiativeBut:setFontSize(9);
    obj.initiativeBut:setWordWrap(true);
    obj.initiativeBut:setHorzTextAlign("center");
    obj.initiativeBut:setTextTrimming("none");
    obj.initiativeBut:setMargins({left=10,right=10});

    obj.initiativeVal = GUI.fromHandle(_obj_newObject("edit"));
    obj.initiativeVal:setParent(obj.flowPart12);
    obj.initiativeVal:setName("initiativeVal");
    obj.initiativeVal:setAlign("client");
    obj.initiativeVal:setField("iniciativa");
    obj.initiativeVal:setFontSize(30);
    obj.initiativeVal:setTransparent(true);
    obj.initiativeVal:setVertTextAlign("center");
    obj.initiativeVal:setHorzTextAlign("center");
    obj.initiativeVal:setFontColor("white");

    obj.flowPart13 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart13:setParent(obj.flowLayout10);
    obj.flowPart13:setMinWidth(235);
    obj.flowPart13:setMaxWidth(475);
    obj.flowPart13:setMinScaledWidth(200);
    obj.flowPart13:setHeight(175);
    obj.flowPart13:setMargins({left=2, right=2, top=4, bottom=8});
    obj.flowPart13:setName("flowPart13");
    obj.flowPart13:setVertAlign("leading");

    obj.frame1 = GUI.fromHandle(_obj_newObject("frame"));
    obj.frame1:setParent(obj.flowPart13);
    obj.frame1:setAlign("client");
    obj.frame1:setFrameStyle("frames/panel5/topPanel.xml");
    obj.frame1:setMargins({left = 4, right = 4, bottom=4});
    obj.frame1:setName("frame1");

    obj.layout37 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout37:setParent(obj.frame1);
    obj.layout37:setAlign("top");
    obj.layout37:setHeight(25);
    obj.layout37:setName("layout37");

    obj.label6 = GUI.fromHandle(_obj_newObject("label"));
    obj.label6:setParent(obj.layout37);
    obj.label6:setAlign("left");
    obj.label6:setAutoSize(true);
    obj.label6:setText("PV Máx");
    obj.label6:setTextTrimming("none");
    obj.label6:setWordWrap(false);
    obj.label6:setFontSize(12);
    obj.label6:setHorzTextAlign("trailing");
    obj.label6:setName("label6");
    obj.label6:setFontColor("#D0D0D0");

    obj.layout38 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout38:setParent(obj.layout37);
    obj.layout38:setAlign("client");
    obj.layout38:setMargins({left=5, right=3});
    obj.layout38:setName("layout38");

    obj.edit12 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit12:setParent(obj.layout38);
    obj.edit12:setAlign("client");
    obj.edit12:setField("PVMax");
    obj.edit12:setVertTextAlign("center");
    obj.edit12:setHorzTextAlign("center");
    obj.edit12:setName("edit12");
    obj.edit12:setFontSize(15);
    obj.edit12:setFontColor("white");
    obj.edit12:setTransparent(true);

    obj.horzLine25 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine25:setParent(obj.layout38);
    obj.horzLine25:setAlign("bottom");
    obj.horzLine25:setStrokeColor("gray");
    obj.horzLine25:setName("horzLine25");

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj.layout37);
    obj.button1:setText("Dano");
    obj.button1:setAlign("right");
    obj.button1:setWidth(50);
    obj.button1:setMargins({right=5});
    obj.button1:setName("button1");

    obj.edit13 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit13:setParent(obj.frame1);
    obj.edit13:setAlign("client");
    obj.edit13:setField("PV");
    obj.edit13:setMargins({top=2});
    obj.edit13:setHorzTextAlign("center");
    obj.edit13:setVertTextAlign("center");
    obj.edit13:setFontSize(36);
    lfm_setPropAsString(obj.edit13, "fontStyle", "bold");
    obj.edit13:setName("edit13");
    obj.edit13:setFontColor("white");
    obj.edit13:setTransparent(true);

    obj.label7 = GUI.fromHandle(_obj_newObject("label"));
    obj.label7:setParent(obj.frame1);
    obj.label7:setAlign("bottom");
    obj.label7:setAutoSize(true);
    obj.label7:setText("PV Atual");
    obj.label7:setFontSize(11);
    obj.label7:setVertTextAlign("center");
    obj.label7:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label7, "fontStyle", "bold");
    obj.label7:setName("label7");
    obj.label7:setFontColor("white");

    obj.frame2 = GUI.fromHandle(_obj_newObject("frame"));
    obj.frame2:setParent(obj.flowPart13);
    obj.frame2:setAlign("bottom");
    obj.frame2:setHeight(70);
    obj.frame2:setFrameStyle("frames/panel5/bottomPanel.xml");
    obj.frame2:setMargins({left = 4, right = 4});
    obj.frame2:setName("frame2");

    obj.edit14 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit14:setParent(obj.frame2);
    obj.edit14:setAlign("client");
    obj.edit14:setField("PVTemporario");
    obj.edit14:setMargins({top=2});
    obj.edit14:setHorzTextAlign("center");
    obj.edit14:setVertTextAlign("center");
    obj.edit14:setFontSize(36);
    lfm_setPropAsString(obj.edit14, "fontStyle", "bold");
    obj.edit14:setName("edit14");
    obj.edit14:setFontColor("white");
    obj.edit14:setTransparent(true);

    obj.label8 = GUI.fromHandle(_obj_newObject("label"));
    obj.label8:setParent(obj.frame2);
    obj.label8:setAlign("bottom");
    obj.label8:setAutoSize(true);
    obj.label8:setText("PV Temporário");
    obj.label8:setFontSize(11);
    obj.label8:setVertTextAlign("center");
    obj.label8:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label8, "fontStyle", "bold");
    obj.label8:setName("label8");
    obj.label8:setFontColor("white");

    obj.flowPart14 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart14:setParent(obj.flowLayout10);
    obj.flowPart14:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart14:setMinWidth(235);
    obj.flowPart14:setMaxWidth(475);
    obj.flowPart14:setMinScaledWidth(235);
    obj.flowPart14:setHeight(132);
    obj.flowPart14:setName("flowPart14");
    obj.flowPart14:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart14:setVertAlign("leading");

    obj.label9 = GUI.fromHandle(_obj_newObject("label"));
    obj.label9:setParent(obj.flowPart14);
    obj.label9:setAlign("top");
    obj.label9:setText("Hit Dice");
    obj.label9:setHeight(22);
    obj.label9:setHorzTextAlign("center");
    obj.label9:setName("label9");
    obj.label9:setFontSize(12);
    obj.label9:setFontColor("#D0D0D0");

    obj.layout39 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout39:setParent(obj.flowPart14);
    obj.layout39:setAlign("top");
    obj.layout39:setHeight(30);
    obj.layout39:setMargins({left=8,right=8,top=4});
    obj.layout39:setName("layout39");

    obj.label10 = GUI.fromHandle(_obj_newObject("label"));
    obj.label10:setParent(obj.layout39);
    obj.label10:setAlign("left");
    obj.label10:setWidth(70);
    obj.label10:setText("Total");
    obj.label10:setFontSize(11);
    obj.label10:setName("label10");
    obj.label10:setFontColor("#D0D0D0");

    obj.edit15 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit15:setParent(obj.layout39);
    obj.edit15:setAlign("client");
    obj.edit15:setField("DadosDeVida");
    obj.edit15:setName("edit15");
    obj.edit15:setFontSize(15);
    obj.edit15:setFontColor("white");
    obj.edit15:setTransparent(true);

    obj.layout40 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout40:setParent(obj.flowPart14);
    obj.layout40:setAlign("top");
    obj.layout40:setHeight(30);
    obj.layout40:setMargins({left=8,right=8,top=1});
    obj.layout40:setName("layout40");

    obj.label11 = GUI.fromHandle(_obj_newObject("label"));
    obj.label11:setParent(obj.layout40);
    obj.label11:setAlign("left");
    obj.label11:setWidth(70);
    obj.label11:setText("Tipo");
    obj.label11:setFontSize(11);
    obj.label11:setName("label11");
    obj.label11:setFontColor("#D0D0D0");

    obj.comboBox1 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox1:setParent(obj.layout40);
    obj.comboBox1:setAlign("client");
    obj.comboBox1:setField("mobHitDieTipo");
    obj.comboBox1:setItems({'d4','d6','d8','d10','d12','d20'});
    obj.comboBox1:setValues({'d4','d6','d8','d10','d12','d20'});
    obj.comboBox1:setName("comboBox1");

    obj.layout41 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout41:setParent(obj.flowPart14);
    obj.layout41:setAlign("client");
    obj.layout41:setHeight(30);
    obj.layout41:setMargins({left=8,right=8,top=1,bottom=6});
    obj.layout41:setName("layout41");

    obj.label12 = GUI.fromHandle(_obj_newObject("label"));
    obj.label12:setParent(obj.layout41);
    obj.label12:setAlign("left");
    obj.label12:setWidth(70);
    obj.label12:setText("Rest.");
    obj.label12:setFontSize(11);
    obj.label12:setName("label12");
    obj.label12:setFontColor("#D0D0D0");

    obj.edit16 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit16:setParent(obj.layout41);
    obj.edit16:setAlign("client");
    obj.edit16:setField("DadosDeVidaAtuais");
    obj.edit16:setName("edit16");
    obj.edit16:setFontSize(15);
    obj.edit16:setFontColor("white");
    obj.edit16:setTransparent(true);

    obj.flowLayout12 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout12:setParent(obj.flowLayout10);
    obj.flowLayout12:setAutoHeight(true);
    obj.flowLayout12:setAvoidScale(true);
    obj.flowLayout12:setHorzAlign("center");
    obj.flowLayout12:setMinScaledWidth(235);
    obj.flowLayout12:setName("flowLayout12");
    obj.flowLayout12:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout12:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout12:setVertAlign("leading");

    obj.flowPart15 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart15:setParent(obj.flowLayout12);
    obj.flowPart15:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart15:setMinWidth(235);
    obj.flowPart15:setMaxWidth(475);
    obj.flowPart15:setMinScaledWidth(235);
    obj.flowPart15:setHeight(188);
    obj.flowPart15:setName("flowPart15");
    obj.flowPart15:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart15:setVertAlign("leading");

    obj.label13 = GUI.fromHandle(_obj_newObject("label"));
    obj.label13:setParent(obj.flowPart15);
    obj.label13:setAlign("top");
    obj.label13:setText("Sentidos");
    obj.label13:setHeight(22);
    obj.label13:setHorzTextAlign("center");
    obj.label13:setName("label13");
    obj.label13:setFontSize(12);
    obj.label13:setFontColor("#D0D0D0");

    obj.layout42 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout42:setParent(obj.flowPart15);
    obj.layout42:setAlign("top");
    obj.layout42:setHeight(26);
    obj.layout42:setMargins({left=6,right=6,top=4});
    obj.layout42:setName("layout42");

    obj.label14 = GUI.fromHandle(_obj_newObject("label"));
    obj.label14:setParent(obj.layout42);
    obj.label14:setAlign("left");
    obj.label14:setWidth(88);
    obj.label14:setText("Blindsight");
    obj.label14:setFontSize(10);
    obj.label14:setName("label14");
    obj.label14:setFontColor("#D0D0D0");

    obj.edit17 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit17:setParent(obj.layout42);
    obj.edit17:setAlign("client");
    obj.edit17:setField("mobSenseBlindsight");
    obj.edit17:setName("edit17");
    obj.edit17:setFontSize(15);
    obj.edit17:setFontColor("white");
    obj.edit17:setTransparent(true);

    obj.layout43 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout43:setParent(obj.flowPart15);
    obj.layout43:setAlign("top");
    obj.layout43:setHeight(26);
    obj.layout43:setMargins({left=6,right=6});
    obj.layout43:setName("layout43");

    obj.label15 = GUI.fromHandle(_obj_newObject("label"));
    obj.label15:setParent(obj.layout43);
    obj.label15:setAlign("left");
    obj.label15:setWidth(88);
    obj.label15:setText("Darkvision");
    obj.label15:setFontSize(10);
    obj.label15:setName("label15");
    obj.label15:setFontColor("#D0D0D0");

    obj.edit18 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit18:setParent(obj.layout43);
    obj.edit18:setAlign("client");
    obj.edit18:setField("mobSenseDarkvision");
    obj.edit18:setName("edit18");
    obj.edit18:setFontSize(15);
    obj.edit18:setFontColor("white");
    obj.edit18:setTransparent(true);

    obj.layout44 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout44:setParent(obj.flowPart15);
    obj.layout44:setAlign("top");
    obj.layout44:setHeight(26);
    obj.layout44:setMargins({left=6,right=6});
    obj.layout44:setName("layout44");

    obj.label16 = GUI.fromHandle(_obj_newObject("label"));
    obj.label16:setParent(obj.layout44);
    obj.label16:setAlign("left");
    obj.label16:setWidth(88);
    obj.label16:setText("Tremorsense");
    obj.label16:setFontSize(10);
    obj.label16:setName("label16");
    obj.label16:setFontColor("#D0D0D0");

    obj.edit19 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit19:setParent(obj.layout44);
    obj.edit19:setAlign("client");
    obj.edit19:setField("mobSenseTremorsense");
    obj.edit19:setName("edit19");
    obj.edit19:setFontSize(15);
    obj.edit19:setFontColor("white");
    obj.edit19:setTransparent(true);

    obj.layout45 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout45:setParent(obj.flowPart15);
    obj.layout45:setAlign("top");
    obj.layout45:setHeight(26);
    obj.layout45:setMargins({left=6,right=6});
    obj.layout45:setName("layout45");

    obj.label17 = GUI.fromHandle(_obj_newObject("label"));
    obj.label17:setParent(obj.layout45);
    obj.label17:setAlign("left");
    obj.label17:setWidth(88);
    obj.label17:setText("Truesight");
    obj.label17:setFontSize(10);
    obj.label17:setName("label17");
    obj.label17:setFontColor("#D0D0D0");

    obj.edit20 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit20:setParent(obj.layout45);
    obj.edit20:setAlign("client");
    obj.edit20:setField("mobSenseTruesight");
    obj.edit20:setName("edit20");
    obj.edit20:setFontSize(15);
    obj.edit20:setFontColor("white");
    obj.edit20:setTransparent(true);

    obj.layout46 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout46:setParent(obj.flowPart15);
    obj.layout46:setAlign("client");
    obj.layout46:setHeight(26);
    obj.layout46:setMargins({left=6,right=6,bottom=6});
    obj.layout46:setName("layout46");

    obj.label18 = GUI.fromHandle(_obj_newObject("label"));
    obj.label18:setParent(obj.layout46);
    obj.label18:setAlign("left");
    obj.label18:setWidth(88);
    obj.label18:setText("Outros");
    obj.label18:setFontSize(10);
    obj.label18:setName("label18");
    obj.label18:setFontColor("#D0D0D0");

    obj.edit21 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit21:setParent(obj.layout46);
    obj.edit21:setAlign("client");
    obj.edit21:setField("sentidos");
    obj.edit21:setName("edit21");
    obj.edit21:setFontSize(15);
    obj.edit21:setFontColor("white");
    obj.edit21:setTransparent(true);

    obj.flowPart16 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart16:setParent(obj.flowLayout12);
    obj.flowPart16:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart16:setMinWidth(235);
    obj.flowPart16:setMaxWidth(475);
    obj.flowPart16:setMinScaledWidth(235);
    obj.flowPart16:setHeight(188);
    obj.flowPart16:setName("flowPart16");
    obj.flowPart16:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart16:setVertAlign("leading");

    obj.label19 = GUI.fromHandle(_obj_newObject("label"));
    obj.label19:setParent(obj.flowPart16);
    obj.label19:setAlign("top");
    obj.label19:setText("Movimentações");
    obj.label19:setHeight(22);
    obj.label19:setHorzTextAlign("center");
    obj.label19:setName("label19");
    obj.label19:setFontSize(12);
    obj.label19:setFontColor("#D0D0D0");

    obj.layout47 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout47:setParent(obj.flowPart16);
    obj.layout47:setAlign("top");
    obj.layout47:setHeight(26);
    obj.layout47:setMargins({left=6,right=6,top=4});
    obj.layout47:setName("layout47");

    obj.label20 = GUI.fromHandle(_obj_newObject("label"));
    obj.label20:setParent(obj.layout47);
    obj.label20:setAlign("left");
    obj.label20:setWidth(78);
    obj.label20:setText("Walk");
    obj.label20:setFontSize(10);
    obj.label20:setName("label20");
    obj.label20:setFontColor("#D0D0D0");

    obj.edit22 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit22:setParent(obj.layout47);
    obj.edit22:setAlign("client");
    obj.edit22:setField("deslocamento");
    obj.edit22:setName("edit22");
    obj.edit22:setFontSize(15);
    obj.edit22:setFontColor("white");
    obj.edit22:setTransparent(true);

    obj.layout48 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout48:setParent(obj.flowPart16);
    obj.layout48:setAlign("top");
    obj.layout48:setHeight(26);
    obj.layout48:setMargins({left=6,right=6});
    obj.layout48:setName("layout48");

    obj.label21 = GUI.fromHandle(_obj_newObject("label"));
    obj.label21:setParent(obj.layout48);
    obj.label21:setAlign("left");
    obj.label21:setWidth(78);
    obj.label21:setText("Fly");
    obj.label21:setFontSize(10);
    obj.label21:setName("label21");
    obj.label21:setFontColor("#D0D0D0");

    obj.edit23 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit23:setParent(obj.layout48);
    obj.edit23:setAlign("client");
    obj.edit23:setField("mobMoveFly");
    obj.edit23:setName("edit23");
    obj.edit23:setFontSize(15);
    obj.edit23:setFontColor("white");
    obj.edit23:setTransparent(true);

    obj.layout49 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout49:setParent(obj.flowPart16);
    obj.layout49:setAlign("top");
    obj.layout49:setHeight(26);
    obj.layout49:setMargins({left=6,right=6});
    obj.layout49:setName("layout49");

    obj.label22 = GUI.fromHandle(_obj_newObject("label"));
    obj.label22:setParent(obj.layout49);
    obj.label22:setAlign("left");
    obj.label22:setWidth(78);
    obj.label22:setText("Burrow");
    obj.label22:setFontSize(10);
    obj.label22:setName("label22");
    obj.label22:setFontColor("#D0D0D0");

    obj.edit24 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit24:setParent(obj.layout49);
    obj.edit24:setAlign("client");
    obj.edit24:setField("mobMoveBurrow");
    obj.edit24:setName("edit24");
    obj.edit24:setFontSize(15);
    obj.edit24:setFontColor("white");
    obj.edit24:setTransparent(true);

    obj.layout50 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout50:setParent(obj.flowPart16);
    obj.layout50:setAlign("top");
    obj.layout50:setHeight(26);
    obj.layout50:setMargins({left=6,right=6});
    obj.layout50:setName("layout50");

    obj.label23 = GUI.fromHandle(_obj_newObject("label"));
    obj.label23:setParent(obj.layout50);
    obj.label23:setAlign("left");
    obj.label23:setWidth(78);
    obj.label23:setText("Climb");
    obj.label23:setFontSize(10);
    obj.label23:setName("label23");
    obj.label23:setFontColor("#D0D0D0");

    obj.edit25 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit25:setParent(obj.layout50);
    obj.edit25:setAlign("client");
    obj.edit25:setField("mobMoveClimb");
    obj.edit25:setName("edit25");
    obj.edit25:setFontSize(15);
    obj.edit25:setFontColor("white");
    obj.edit25:setTransparent(true);

    obj.layout51 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout51:setParent(obj.flowPart16);
    obj.layout51:setAlign("top");
    obj.layout51:setHeight(26);
    obj.layout51:setMargins({left=6,right=6});
    obj.layout51:setName("layout51");

    obj.label24 = GUI.fromHandle(_obj_newObject("label"));
    obj.label24:setParent(obj.layout51);
    obj.label24:setAlign("left");
    obj.label24:setWidth(78);
    obj.label24:setText("Swim");
    obj.label24:setFontSize(10);
    obj.label24:setName("label24");
    obj.label24:setFontColor("#D0D0D0");

    obj.edit26 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit26:setParent(obj.layout51);
    obj.edit26:setAlign("client");
    obj.edit26:setField("mobMoveSwim");
    obj.edit26:setName("edit26");
    obj.edit26:setFontSize(15);
    obj.edit26:setFontColor("white");
    obj.edit26:setTransparent(true);

    obj.tab2 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab2:setParent(obj.pgcPrincipal);
    obj.tab2:setTitle("Traços");
    obj.tab2:setName("tab2");

    obj.rectangle2 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle2:setParent(obj.tab2);
    obj.rectangle2:setName("rectangle2");
    obj.rectangle2:setAlign("client");
    obj.rectangle2:setColor("#40000000");
    obj.rectangle2:setXradius(10);
    obj.rectangle2:setYradius(10);

    obj.scrollBox2 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox2:setParent(obj.rectangle2);
    obj.scrollBox2:setAlign("client");
    obj.scrollBox2:setName("scrollBox2");

    obj.flowLayout13 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout13:setParent(obj.scrollBox2);
    obj.flowLayout13:setAlign("top");
    obj.flowLayout13:setAutoHeight(true);
    obj.flowLayout13:setMargins({left=10,right=10,top=10});
    obj.flowLayout13:setLineSpacing(6);
    obj.flowLayout13:setHorzAlign("center");
    obj.flowLayout13:setName("flowLayout13");
    obj.flowLayout13:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.flowLayout13:setMinScaledWidth(300);
    obj.flowLayout13:setVertAlign("leading");

    obj.flowLayout14 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout14:setParent(obj.flowLayout13);
    obj.flowLayout14:setAutoHeight(true);
    obj.flowLayout14:setHorzAlign("justify");
    obj.flowLayout14:setAvoidScale(true);
    obj.flowLayout14:setName("flowLayout14");
    obj.flowLayout14:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout14:setMinScaledWidth(300);
    obj.flowLayout14:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout14:setVertAlign("leading");

    obj.flowPart17 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart17:setParent(obj.flowLayout14);
    obj.flowPart17:setMinWidth(420);
    obj.flowPart17:setMaxWidth(1600);
    obj.flowPart17:setHeight(120);
    obj.flowPart17:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart17:setName("flowPart17");
    obj.flowPart17:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart17:setVertAlign("leading");

    obj.label25 = GUI.fromHandle(_obj_newObject("label"));
    obj.label25:setParent(obj.flowPart17);
    obj.label25:setAlign("top");
    obj.label25:setText("Informações de Traços");
    obj.label25:setHeight(22);
    obj.label25:setHorzTextAlign("center");
    obj.label25:setName("label25");
    obj.label25:setFontSize(12);
    obj.label25:setFontColor("#D0D0D0");

    obj.layout52 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout52:setParent(obj.flowPart17);
    obj.layout52:setAlign("top");
    obj.layout52:setHeight(28);
    obj.layout52:setMargins({left=6,right=6,top=2});
    obj.layout52:setName("layout52");

    obj.label26 = GUI.fromHandle(_obj_newObject("label"));
    obj.label26:setParent(obj.layout52);
    obj.label26:setAlign("left");
    obj.label26:setWidth(80);
    obj.label26:setText("Saves");
    obj.label26:setFontSize(11);
    obj.label26:setName("label26");
    obj.label26:setFontColor("#D0D0D0");

    obj.edit27 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit27:setParent(obj.layout52);
    obj.edit27:setAlign("client");
    obj.edit27:setField("mobSaves");
    obj.edit27:setName("edit27");
    obj.edit27:setFontSize(15);
    obj.edit27:setFontColor("white");
    obj.edit27:setTransparent(true);

    obj.layout53 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout53:setParent(obj.flowPart17);
    obj.layout53:setAlign("top");
    obj.layout53:setHeight(28);
    obj.layout53:setMargins({left=6,right=6});
    obj.layout53:setName("layout53");

    obj.label27 = GUI.fromHandle(_obj_newObject("label"));
    obj.label27:setParent(obj.layout53);
    obj.label27:setAlign("left");
    obj.label27:setWidth(80);
    obj.label27:setText("Skills");
    obj.label27:setFontSize(11);
    obj.label27:setName("label27");
    obj.label27:setFontColor("#D0D0D0");

    obj.edit28 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit28:setParent(obj.layout53);
    obj.edit28:setAlign("client");
    obj.edit28:setField("mobSkills");
    obj.edit28:setName("edit28");
    obj.edit28:setFontSize(15);
    obj.edit28:setFontColor("white");
    obj.edit28:setTransparent(true);

    obj.layout54 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout54:setParent(obj.flowPart17);
    obj.layout54:setAlign("client");
    obj.layout54:setMargins({left=6,right=6,bottom=6});
    obj.layout54:setName("layout54");

    obj.label28 = GUI.fromHandle(_obj_newObject("label"));
    obj.label28:setParent(obj.layout54);
    obj.label28:setAlign("left");
    obj.label28:setWidth(80);
    obj.label28:setText("Idiomas");
    obj.label28:setFontSize(11);
    obj.label28:setName("label28");
    obj.label28:setFontColor("#D0D0D0");

    obj.edit29 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit29:setParent(obj.layout54);
    obj.edit29:setAlign("client");
    obj.edit29:setField("idiomas");
    obj.edit29:setName("edit29");
    obj.edit29:setFontSize(15);
    obj.edit29:setFontColor("white");
    obj.edit29:setTransparent(true);

    obj.flowPart18 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart18:setParent(obj.flowLayout14);
    obj.flowPart18:setMinWidth(420);
    obj.flowPart18:setMaxWidth(1600);
    obj.flowPart18:setHeight(120);
    obj.flowPart18:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart18:setName("flowPart18");
    obj.flowPart18:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart18:setVertAlign("leading");

    obj.label29 = GUI.fromHandle(_obj_newObject("label"));
    obj.label29:setParent(obj.flowPart18);
    obj.label29:setAlign("top");
    obj.label29:setText("Resistências Lendárias");
    obj.label29:setHeight(22);
    obj.label29:setHorzTextAlign("center");
    obj.label29:setName("label29");
    obj.label29:setFontSize(12);
    obj.label29:setFontColor("#D0D0D0");

    obj.layout55 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout55:setParent(obj.flowPart18);
    obj.layout55:setAlign("top");
    obj.layout55:setHeight(34);
    obj.layout55:setMargins({left=8,right=8,top=6});
    obj.layout55:setName("layout55");

    obj.label30 = GUI.fromHandle(_obj_newObject("label"));
    obj.label30:setParent(obj.layout55);
    obj.label30:setAlign("left");
    obj.label30:setWidth(50);
    obj.label30:setText("Atual");
    obj.label30:setFontSize(11);
    obj.label30:setName("label30");
    obj.label30:setFontColor("#D0D0D0");

    obj.edit30 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit30:setParent(obj.layout55);
    obj.edit30:setAlign("left");
    obj.edit30:setWidth(55);
    obj.edit30:setField("mobResLendAtual");
    obj.edit30:setHorzTextAlign("center");
    obj.edit30:setName("edit30");
    obj.edit30:setFontSize(15);
    obj.edit30:setFontColor("white");
    obj.edit30:setTransparent(true);

    obj.label31 = GUI.fromHandle(_obj_newObject("label"));
    obj.label31:setParent(obj.layout55);
    obj.label31:setAlign("left");
    obj.label31:setWidth(38);
    obj.label31:setText("/");
    obj.label31:setHorzTextAlign("center");
    obj.label31:setName("label31");
    obj.label31:setFontSize(12);
    obj.label31:setFontColor("#D0D0D0");

    obj.edit31 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit31:setParent(obj.layout55);
    obj.edit31:setAlign("left");
    obj.edit31:setWidth(55);
    obj.edit31:setField("mobResLendMax");
    obj.edit31:setHorzTextAlign("center");
    obj.edit31:setName("edit31");
    obj.edit31:setFontSize(15);
    obj.edit31:setFontColor("white");
    obj.edit31:setTransparent(true);

    obj.label32 = GUI.fromHandle(_obj_newObject("label"));
    obj.label32:setParent(obj.layout55);
    obj.label32:setAlign("client");
    obj.label32:setText("máximo por dia");
    obj.label32:setFontSize(10);
    obj.label32:setMargins({left=8});
    obj.label32:setVertTextAlign("center");
    obj.label32:setName("label32");
    obj.label32:setFontColor("#D0D0D0");

    obj.layout56 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout56:setParent(obj.flowPart18);
    obj.layout56:setAlign("top");
    obj.layout56:setHeight(30);
    obj.layout56:setMargins({left=8,right=8});
    obj.layout56:setName("layout56");

    obj.button2 = GUI.fromHandle(_obj_newObject("button"));
    obj.button2:setParent(obj.layout56);
    obj.button2:setAlign("left");
    obj.button2:setWidth(70);
    obj.button2:setText("-1");
    obj.button2:setName("button2");

    obj.button3 = GUI.fromHandle(_obj_newObject("button"));
    obj.button3:setParent(obj.layout56);
    obj.button3:setAlign("left");
    obj.button3:setWidth(70);
    obj.button3:setText("+1");
    obj.button3:setMargins({left=6});
    obj.button3:setName("button3");

    obj.button4 = GUI.fromHandle(_obj_newObject("button"));
    obj.button4:setParent(obj.layout56);
    obj.button4:setAlign("left");
    obj.button4:setWidth(90);
    obj.button4:setText("Resetar");
    obj.button4:setMargins({left=6});
    obj.button4:setName("button4");

    obj.button5 = GUI.fromHandle(_obj_newObject("button"));
    obj.button5:setParent(obj.layout56);
    obj.button5:setAlign("client");
    obj.button5:setText("Usar 1");
    obj.button5:setMargins({left=6});
    obj.button5:setName("button5");

    obj.label33 = GUI.fromHandle(_obj_newObject("label"));
    obj.label33:setParent(obj.flowPart18);
    obj.label33:setAlign("client");
    obj.label33:setText("Dica: preencha 3/3 para monstros com Resistência Lendária (3/dia).");
    obj.label33:setFontSize(10);
    obj.label33:setMargins({left=8,right=8,bottom=4});
    obj.label33:setWordWrap(true);
    obj.label33:setName("label33");
    obj.label33:setFontColor("#D0D0D0");

    obj.flowLineBreak3 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak3:setParent(obj.flowLayout13);
    obj.flowLineBreak3:setName("flowLineBreak3");

    obj.flowLayout15 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout15:setParent(obj.flowLayout13);
    obj.flowLayout15:setAutoHeight(true);
    obj.flowLayout15:setHorzAlign("justify");
    obj.flowLayout15:setAvoidScale(true);
    obj.flowLayout15:setName("flowLayout15");
    obj.flowLayout15:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout15:setMinScaledWidth(300);
    obj.flowLayout15:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout15:setVertAlign("leading");

    obj.flowPart19 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart19:setParent(obj.flowLayout15);
    obj.flowPart19:setMinWidth(260);
    obj.flowPart19:setMaxWidth(420);
    obj.flowPart19:setHeight(260);
    obj.flowPart19:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart19:setName("flowPart19");
    obj.flowPart19:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart19:setVertAlign("leading");

    obj.label34 = GUI.fromHandle(_obj_newObject("label"));
    obj.label34:setParent(obj.flowPart19);
    obj.label34:setAlign("top");
    obj.label34:setText("Foto do Mob");
    obj.label34:setHeight(22);
    obj.label34:setHorzTextAlign("center");
    obj.label34:setName("label34");
    obj.label34:setFontSize(12);
    obj.label34:setFontColor("#D0D0D0");

    obj.image25 = GUI.fromHandle(_obj_newObject("image"));
    obj.image25:setParent(obj.flowPart19);
    obj.image25:setAlign("client");
    obj.image25:setField("mobFoto");
    obj.image25:setEditable(true);
    obj.image25:setStyle("autoFit");
    obj.image25:setMargins({left=8,right=8,top=4,bottom=8});
    obj.image25:setName("image25");

    obj.flowPart20 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart20:setParent(obj.flowLayout15);
    obj.flowPart20:setMinWidth(560);
    obj.flowPart20:setMaxWidth(2400);
    obj.flowPart20:setHeight(260);
    obj.flowPart20:setFrameStyle("frames/panel1/frame.xml");
    obj.flowPart20:setName("flowPart20");
    obj.flowPart20:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart20:setVertAlign("leading");

    obj.label35 = GUI.fromHandle(_obj_newObject("label"));
    obj.label35:setParent(obj.flowPart20);
    obj.label35:setAlign("top");
    obj.label35:setText("Traços do Monstro");
    obj.label35:setHeight(22);
    obj.label35:setHorzTextAlign("center");
    obj.label35:setName("label35");
    obj.label35:setFontSize(12);
    obj.label35:setFontColor("#D0D0D0");

    obj.textEditor1 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor1:setParent(obj.flowPart20);
    obj.textEditor1:setAlign("client");
    obj.textEditor1:setField("mobTraitsTexto");
    obj.textEditor1:setMargins({left=6,right=6,top=4,bottom=6});
    obj.textEditor1:setName("textEditor1");
    obj.textEditor1:setTransparent(true);

    obj.flowLineBreak4 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak4:setParent(obj.flowLayout13);
    obj.flowLineBreak4:setName("flowLineBreak4");

    obj.flowLayout16 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout16:setParent(obj.flowLayout13);
    obj.flowLayout16:setAutoHeight(true);
    obj.flowLayout16:setHorzAlign("justify");
    obj.flowLayout16:setAvoidScale(true);
    obj.flowLayout16:setName("flowLayout16");
    obj.flowLayout16:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout16:setMinScaledWidth(300);
    obj.flowLayout16:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout16:setVertAlign("leading");

    obj.flowPart21 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart21:setParent(obj.flowLayout16);
    obj.flowPart21:setMinWidth(420);
    obj.flowPart21:setMaxWidth(1600);
    obj.flowPart21:setHeight(210);
    obj.flowPart21:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart21:setName("flowPart21");
    obj.flowPart21:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart21:setVertAlign("leading");

    obj.label36 = GUI.fromHandle(_obj_newObject("label"));
    obj.label36:setParent(obj.flowPart21);
    obj.label36:setAlign("top");
    obj.label36:setText("Conjuração / Traços Extras");
    obj.label36:setHeight(22);
    obj.label36:setHorzTextAlign("center");
    obj.label36:setName("label36");
    obj.label36:setFontSize(12);
    obj.label36:setFontColor("#D0D0D0");

    obj.textEditor2 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor2:setParent(obj.flowPart21);
    obj.textEditor2:setAlign("client");
    obj.textEditor2:setField("mobTraitsExtras");
    obj.textEditor2:setMargins({left=6,right=6,top=4,bottom=6});
    obj.textEditor2:setName("textEditor2");
    obj.textEditor2:setTransparent(true);

    obj.flowPart22 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart22:setParent(obj.flowLayout16);
    obj.flowPart22:setMinWidth(420);
    obj.flowPart22:setMaxWidth(1600);
    obj.flowPart22:setHeight(210);
    obj.flowPart22:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart22:setName("flowPart22");
    obj.flowPart22:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart22:setVertAlign("leading");

    obj.label37 = GUI.fromHandle(_obj_newObject("label"));
    obj.label37:setParent(obj.flowPart22);
    obj.label37:setAlign("top");
    obj.label37:setText("Efeitos Regionais");
    obj.label37:setHeight(22);
    obj.label37:setHorzTextAlign("center");
    obj.label37:setName("label37");
    obj.label37:setFontSize(12);
    obj.label37:setFontColor("#D0D0D0");

    obj.textEditor3 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor3:setParent(obj.flowPart22);
    obj.textEditor3:setAlign("client");
    obj.textEditor3:setField("mobEfeitosRegionais");
    obj.textEditor3:setMargins({left=6,right=6,top=4,bottom=6});
    obj.textEditor3:setName("textEditor3");
    obj.textEditor3:setTransparent(true);

    obj.flowLineBreak5 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak5:setParent(obj.flowLayout13);
    obj.flowLineBreak5:setName("flowLineBreak5");

    obj.flowLayout17 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout17:setParent(obj.flowLayout13);
    obj.flowLayout17:setAutoHeight(true);
    obj.flowLayout17:setHorzAlign("justify");
    obj.flowLayout17:setAvoidScale(true);
    obj.flowLayout17:setName("flowLayout17");
    obj.flowLayout17:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout17:setMinScaledWidth(300);
    obj.flowLayout17:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout17:setVertAlign("leading");

    obj.flowPart23 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart23:setParent(obj.flowLayout17);
    obj.flowPart23:setMinWidth(420);
    obj.flowPart23:setMaxWidth(1600);
    obj.flowPart23:setHeight(190);
    obj.flowPart23:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart23:setName("flowPart23");
    obj.flowPart23:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart23:setVertAlign("leading");

    obj.label38 = GUI.fromHandle(_obj_newObject("label"));
    obj.label38:setParent(obj.flowPart23);
    obj.label38:setAlign("top");
    obj.label38:setText("Ações de Covil / Ambiente");
    obj.label38:setHeight(22);
    obj.label38:setHorzTextAlign("center");
    obj.label38:setName("label38");
    obj.label38:setFontSize(12);
    obj.label38:setFontColor("#D0D0D0");

    obj.textEditor4 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor4:setParent(obj.flowPart23);
    obj.textEditor4:setAlign("client");
    obj.textEditor4:setField("mobLairActions");
    obj.textEditor4:setMargins({left=6,right=6,top=4,bottom=6});
    obj.textEditor4:setName("textEditor4");
    obj.textEditor4:setTransparent(true);

    obj.flowPart24 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart24:setParent(obj.flowLayout17);
    obj.flowPart24:setMinWidth(420);
    obj.flowPart24:setMaxWidth(1600);
    obj.flowPart24:setHeight(190);
    obj.flowPart24:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart24:setName("flowPart24");
    obj.flowPart24:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart24:setVertAlign("leading");

    obj.label39 = GUI.fromHandle(_obj_newObject("label"));
    obj.label39:setParent(obj.flowPart24);
    obj.label39:setAlign("top");
    obj.label39:setText("Notas Táticas / Encontro");
    obj.label39:setHeight(22);
    obj.label39:setHorzTextAlign("center");
    obj.label39:setName("label39");
    obj.label39:setFontSize(12);
    obj.label39:setFontColor("#D0D0D0");

    obj.textEditor5 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor5:setParent(obj.flowPart24);
    obj.textEditor5:setAlign("client");
    obj.textEditor5:setField("mobTraitsNotas");
    obj.textEditor5:setMargins({left=6,right=6,top=4,bottom=6});
    obj.textEditor5:setName("textEditor5");
    obj.textEditor5:setTransparent(true);

    obj.tab3 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab3:setParent(obj.pgcPrincipal);
    obj.tab3:setTitle("Ações");
    obj.tab3:setName("tab3");

    obj.rectangle3 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle3:setParent(obj.tab3);
    obj.rectangle3:setName("rectangle3");
    obj.rectangle3:setAlign("client");
    obj.rectangle3:setColor("#40000000");
    obj.rectangle3:setXradius(10);
    obj.rectangle3:setYradius(10);

    obj.scrollBox3 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox3:setParent(obj.rectangle3);
    obj.scrollBox3:setAlign("client");
    obj.scrollBox3:setName("scrollBox3");

    obj.fraEquipamentoLayout = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraEquipamentoLayout:setParent(obj.scrollBox3);
    obj.fraEquipamentoLayout:setAlign("top");
    obj.fraEquipamentoLayout:setHeight(500);
    obj.fraEquipamentoLayout:setMargins({left=10, right=10, top=10});
    obj.fraEquipamentoLayout:setAutoHeight(true);
    obj.fraEquipamentoLayout:setHorzAlign("center");
    obj.fraEquipamentoLayout:setLineSpacing(3);
    obj.fraEquipamentoLayout:setName("fraEquipamentoLayout");
    obj.fraEquipamentoLayout:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.fraEquipamentoLayout:setMinScaledWidth(300);
    obj.fraEquipamentoLayout:setVertAlign("leading");


				



					local function recalcularTamanhoEquipsDefesa()
						if self.flwPartEquipDefense == nil or self.rclEquipsDefense == nil or self.labEquipDefense == nil or self.layEquipDefenseBottom == nil then return end;
						self.flwPartEquipDefense.height = self.rclEquipsDefense.height + self.labEquipDefense.height +
												self.layEquipDefenseBottom.height + 
												self.flwPartEquipDefense.padding.top + self.flwPartEquipDefense.padding.bottom + 7;
					end;

					local function _bindAcaoSelecionada()
						local node = self.rclMobAcoes and self.rclMobAcoes.selectedNode;
						self.dsbMobAcao.node = node;
						self.dsbMobAcao.enabled = (node ~= nil);
					end

					local function _appendAndSelect(list)
						if list == nil then return end
						local node = list:append();
						list.selectedNode = node;
					end

					local function _rollRechargeForSelectedAction()
						if self.dsbMobAcao == nil or self.dsbMobAcao.node == nil then
							showMessage("Selecione uma ação primeiro.");
							return;
						end

						local node = self.dsbMobAcao.node;
						local minv = tonumber(node.rechargeMin) or 5;
						local nome = tostring(node.texto or "Ação");

						local function _finalize(result)
							local v = tonumber(result) or 0;
							node.rechargeLast = tostring(v);
							node.rechargeReady = (v >= minv) and "Pronto" or "Não";
						end

						local mesa = nil;
						pcall(function() mesa = Firecast.getMesaDe(node) end);

						if mesa ~= nil and mesa.chat ~= nil then
							mesa.chat:rolarDados(Firecast.interpretarRolagem("1d6"), "Recharge - " .. nome, function(r)
								if r ~= nil then
									_finalize(r.resultado);
									if (tonumber(r.resultado) or 0) >= minv then
										mesa.chat:enviarMensagem("✅ " .. nome .. " recarregou (" .. tostring(r.resultado) .. ")");
									else
										mesa.chat:enviarMensagem("❌ " .. nome .. " não recarregou (" .. tostring(r.resultado) .. ")");
									end
								end
							end);
						else
							local v = math.random(1, 6);
							_finalize(v);
							showMessage(nome .. ": Recharge " .. tostring(minv) .. "-6 => " .. tostring(v));
						end
					end

					local function _usarCargaAcaoSelecionada()
						if self.dsbMobAcao == nil or self.dsbMobAcao.node == nil then return end
						local node = self.dsbMobAcao.node;
						local cur = tonumber(node.usosAtual) or 0;
						node.usosAtual = math.max(0, cur - 1);
					end

					local function _resetCargasAcaoSelecionada()
						if self.dsbMobAcao == nil or self.dsbMobAcao.node == nil then return end
						local node = self.dsbMobAcao.node;
						local maxv = tonumber(node.usosMax) or 1;
						node.usosAtual = maxv;
					end


					local function _toNumber(v, default)
						local n = tonumber(v);
						if n == nil then return default or 0; end;
						return n;
					end

					local function _parsePB(v)
						local s = tostring(v or "0");
						s = s:gsub("[^%-%d]", "");
						return tonumber(s) or 0;
					end

					local function _attrFieldFromValue(v)
						local s = tostring(v or ""):lower();
						if s == "for" or s == "forca" then return "forca"; end;
						if s == "des" or s == "destreza" then return "destreza"; end;
						if s == "con" or s == "constituicao" then return "constituicao"; end;
						if s == "int" or s == "inteligencia" then return "inteligencia"; end;
						if s == "sab" or s == "sabedoria" then return "sabedoria"; end;
						if s == "car" or s == "carisma" then return "carisma"; end;
						return nil;
					end

					local function _recalcCDAcaoSelecionada()
						if self == nil or self.dsbMobAcao == nil or self.dsbMobAcao.node == nil or sheet == nil then return end;
						local node = self.dsbMobAcao.node;
						local attrField = _attrFieldFromValue(node.atribSave);
						if attrField == nil then return end;

						local score = _toNumber(sheet[attrField], 10);
						local mod = math.floor((score - 10) / 2);
						local pb = _parsePB(sheet.bonusProficiencia);
						node.cdSave = tostring(8 + pb + mod);
					end

					local function _consumirCustoLendario(node)
						if node == nil or sheet == nil then return end;
						if tostring(node.tipoAcao or "") ~= "lendaria" then return end;

						local custo = math.max(1, _toNumber(node.custoLendario, 1));
						local cur = tonumber(sheet.mobLendariasAtual);
						if cur == nil then cur = tonumber(sheet.mobLendariasMax) or 0; end;
						sheet.mobLendariasAtual = math.max(0, cur - custo);
					end

					local function _usarAcaoSelecionada()
						if self == nil or self.dsbMobAcao == nil or self.dsbMobAcao.node == nil then
							showMessage("Selecione uma ação primeiro.");
							return;
						end;

						local node = self.dsbMobAcao.node;
						local nome = tostring(node.texto or "Ação");
						local expr = tostring(node.dano or "");
						if expr == "" then expr = tostring(node.rolagemExtra or ""); end;
						if expr ~= "" then
							local mesa = nil;
							pcall(function() mesa = Firecast.getMesaDe(node) end);
							if mesa ~= nil and mesa.chat ~= nil then
								mesa.chat:rolarDados(Firecast.interpretarRolagem(expr), "Uso da ação - " .. nome);
							else
								showMessage("Entre em uma mesa para rolar o dano da ação.");
							end;
						end;

						local curUsos = tonumber(node.usosAtual);
						if curUsos ~= nil then node.usosAtual = math.max(0, curUsos - 1); end;
						_consumirCustoLendario(node);
					end

					local function _usarCustoLendarioDaSelecionada()
						if self == nil or self.dsbMobAcao == nil or self.dsbMobAcao.node == nil then return end;
						_consumirCustoLendario(self.dsbMobAcao.node);
					end

					local function _resetLendarias()
						if sheet == nil then return end;
						local maxv = tonumber(sheet.mobLendariasMax) or 3;
						sheet.mobLendariasAtual = maxv;
					end
				



			


    obj.flowLayout18 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout18:setParent(obj.fraEquipamentoLayout);
    obj.flowLayout18:setHorzAlign("justify");
    obj.flowLayout18:setAutoHeight(true);
    obj.flowLayout18:setAvoidScale(true);
    obj.flowLayout18:setName("flowLayout18");
    obj.flowLayout18:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout18:setMinScaledWidth(300);
    obj.flowLayout18:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout18:setVertAlign("leading");

    obj.flowPart25 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart25:setParent(obj.flowLayout18);
    obj.flowPart25:setMinWidth(280);
    obj.flowPart25:setMaxWidth(800);
    obj.flowPart25:setHeight(64);
    obj.flowPart25:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart25:setName("flowPart25");
    obj.flowPart25:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart25:setVertAlign("leading");

    obj.edit32 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit32:setParent(obj.flowPart25);
    obj.edit32:setAlign("left");
    obj.edit32:setField("critChance");
    obj.edit32:setWidth(70);
    obj.edit32:setName("edit32");
    obj.edit32:setTransparent(true);
    obj.edit32:setVertTextAlign("center");
    obj.edit32:setHorzTextAlign("center");
    obj.edit32:setFontSize(15);
    obj.edit32:setFontColor("white");

    obj.label40 = GUI.fromHandle(_obj_newObject("label"));
    obj.label40:setParent(obj.flowPart25);
    obj.label40:setAlign("client");
    obj.label40:setText("@@Dnd5e.equipment.criticalChance");
    obj.label40:setMargins({left=10});
    obj.label40:setHorzTextAlign("center");
    obj.label40:setName("label40");
    obj.label40:setFontSize(12);
    obj.label40:setFontColor("#D0D0D0");

    obj.dataLink80 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink80:setParent(obj.flowLayout18);
    obj.dataLink80:setField("critChance");
    obj.dataLink80:setDefaultValue("20");
    obj.dataLink80:setName("dataLink80");

    obj.flowPart26 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart26:setParent(obj.flowLayout18);
    obj.flowPart26:setMinWidth(280);
    obj.flowPart26:setMaxWidth(800);
    obj.flowPart26:setHeight(64);
    obj.flowPart26:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart26:setName("flowPart26");
    obj.flowPart26:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart26:setVertAlign("leading");

    obj.edit33 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit33:setParent(obj.flowPart26);
    obj.edit33:setAlign("left");
    obj.edit33:setField("critDamage");
    obj.edit33:setWidth(70);
    obj.edit33:setName("edit33");
    obj.edit33:setTransparent(true);
    obj.edit33:setVertTextAlign("center");
    obj.edit33:setHorzTextAlign("center");
    obj.edit33:setFontSize(15);
    obj.edit33:setFontColor("white");

    obj.label41 = GUI.fromHandle(_obj_newObject("label"));
    obj.label41:setParent(obj.flowPart26);
    obj.label41:setAlign("client");
    obj.label41:setText("@@Dnd5e.equipment.criticalDamage");
    obj.label41:setMargins({left=10});
    obj.label41:setHorzTextAlign("center");
    obj.label41:setName("label41");
    obj.label41:setFontSize(12);
    obj.label41:setFontColor("#D0D0D0");

    obj.flowPart27 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart27:setParent(obj.flowLayout18);
    obj.flowPart27:setMinWidth(280);
    obj.flowPart27:setMaxWidth(800);
    obj.flowPart27:setHeight(64);
    obj.flowPart27:setFrameStyle("frames/posCaptionEdit2/frame.xml");
    obj.flowPart27:setName("flowPart27");
    obj.flowPart27:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart27:setVertAlign("leading");

    obj.edit34 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit34:setParent(obj.flowPart27);
    obj.edit34:setAlign("left");
    obj.edit34:setField("damageReroll");
    obj.edit34:setWidth(70);
    obj.edit34:setName("edit34");
    obj.edit34:setTransparent(true);
    obj.edit34:setVertTextAlign("center");
    obj.edit34:setHorzTextAlign("center");
    obj.edit34:setFontSize(15);
    obj.edit34:setFontColor("white");

    obj.label42 = GUI.fromHandle(_obj_newObject("label"));
    obj.label42:setParent(obj.flowPart27);
    obj.label42:setAlign("client");
    obj.label42:setText("@@Dnd5e.equipment.reroll");
    obj.label42:setMargins({left=10});
    obj.label42:setHorzTextAlign("center");
    obj.label42:setName("label42");
    obj.label42:setFontSize(12);
    obj.label42:setFontColor("#D0D0D0");

    obj.dataLink81 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink81:setParent(obj.flowLayout18);
    obj.dataLink81:setField("damageReroll");
    obj.dataLink81:setDefaultValue("0");
    obj.dataLink81:setName("dataLink81");

    obj.flowLineBreak6 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak6:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak6:setName("flowLineBreak6");

    obj.flwPartEquipAttack = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flwPartEquipAttack:setParent(obj.fraEquipamentoLayout);
    obj.flwPartEquipAttack:setName("flwPartEquipAttack");
    obj.flwPartEquipAttack:setHeight(250);
    obj.flwPartEquipAttack:setAutoHeight(true);
    obj.flwPartEquipAttack:setFrameStyle("frames/panel5/frame.xml");
    obj.flwPartEquipAttack:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.flwPartEquipAttack:setMinScaledWidth(300);
    obj.flwPartEquipAttack:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwPartEquipAttack:setVertAlign("leading");

    obj.layEquipAttackLeft = GUI.fromHandle(_obj_newObject("layout"));
    obj.layEquipAttackLeft:setParent(obj.flwPartEquipAttack);
    obj.layEquipAttackLeft.grid.role = "col";
    obj.layEquipAttackLeft.grid.width = 3;
    obj.layEquipAttackLeft:setName("layEquipAttackLeft");
    obj.layEquipAttackLeft.grid["min-height"] = 250;

    obj.label43 = GUI.fromHandle(_obj_newObject("label"));
    obj.label43:setParent(obj.layEquipAttackLeft);
    obj.label43:setAlign("top");
    obj.label43:setAutoSize(true);
    obj.label43:setText("ATTACKS");
    obj.label43:setFontSize(12);
    obj.label43:setVertTextAlign("center");
    obj.label43:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label43, "fontStyle", "bold");
    obj.label43:setName("label43");
    obj.label43:setFontColor("white");

    obj.rclEquips = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclEquips:setParent(obj.layEquipAttackLeft);
    obj.rclEquips:setName("rclEquips");
    obj.rclEquips:setAlign("client");
    obj.rclEquips:setField("equipamentos.ataques");
    obj.rclEquips:setTemplateForm("frmEquipamentoItem");
    obj.rclEquips:setMinQt(1);
    obj.rclEquips:setHitTest(true);
    obj.rclEquips:setMargins({top=5, bottom=5});

    obj.button6 = GUI.fromHandle(_obj_newObject("button"));
    obj.button6:setParent(obj.layEquipAttackLeft);
    obj.button6:setAlign("bottom");
    obj.button6:setText("@@DnD5e.tab.equipament.btn.newItem");
    obj.button6:setName("button6");

    obj.layEquipAttackRight = GUI.fromHandle(_obj_newObject("layout"));
    obj.layEquipAttackRight:setParent(obj.flwPartEquipAttack);
    obj.layEquipAttackRight.grid.role = "col";
    obj.layEquipAttackRight.grid.width = 9;
    obj.layEquipAttackRight:setName("layEquipAttackRight");
    obj.layEquipAttackRight.grid["min-height"] = 250;
    obj.layEquipAttackRight.grid["cnt-gutter"] = 5;
    obj.layEquipAttackRight.grid["cnt-line-spacing"] = 5;

    obj.dataEquipAttackDetails = GUI.fromHandle(_obj_newObject("dataScopeBox"));
    obj.dataEquipAttackDetails:setParent(obj.layEquipAttackRight);
    obj.dataEquipAttackDetails:setName("dataEquipAttackDetails");
    obj.dataEquipAttackDetails:setAlign("client");
    obj.dataEquipAttackDetails:setFrameStyle("frames/panel5/frame.xml");
    obj.dataEquipAttackDetails:setMargins({left=10});
    obj.dataEquipAttackDetails:setEnabled(false);

    obj.layEquipAttackImg = GUI.fromHandle(_obj_newObject("layout"));
    obj.layEquipAttackImg:setParent(obj.dataEquipAttackDetails);
    obj.layEquipAttackImg:setName("layEquipAttackImg");
    obj.layEquipAttackImg.grid.role = "col";
    obj.layEquipAttackImg.grid.width = 2;
    obj.layEquipAttackImg.grid["vert-tile"] = true;

    obj.imgEquipAttackImg = GUI.fromHandle(_obj_newObject("image"));
    obj.imgEquipAttackImg:setParent(obj.layEquipAttackImg);
    obj.imgEquipAttackImg:setName("imgEquipAttackImg");
    obj.imgEquipAttackImg:setAlign("client");
    obj.imgEquipAttackImg:setURL("https://clipartart.com/images/cross-sword-clipart.png");
    obj.imgEquipAttackImg:setShowProgress(false);
    obj.imgEquipAttackImg.animate = true;

    obj.image26 = GUI.fromHandle(_obj_newObject("image"));
    obj.image26:setParent(obj.layEquipAttackImg);
    obj.image26:setAlign("client");
    obj.image26:setField("imagem");
    obj.image26:setShowProgress(false);
    obj.image26:setEditable(true);
    obj.image26.animate = true;
    obj.image26:setName("image26");

    obj.layEquipPropriedades = GUI.fromHandle(_obj_newObject("layout"));
    obj.layEquipPropriedades:setParent(obj.dataEquipAttackDetails);
    obj.layEquipPropriedades:setName("layEquipPropriedades");
    obj.layEquipPropriedades.grid.role = "col";
    obj.layEquipPropriedades.grid.width = 2;
    obj.layEquipPropriedades.grid["vert-tile"] = true;
    obj.layEquipPropriedades:setMargins({left=5});

    obj.label44 = GUI.fromHandle(_obj_newObject("label"));
    obj.label44:setParent(obj.layEquipPropriedades);
    obj.label44:setText("@@DnD5e.tab.equipament.atack.lab.property");
    obj.label44:setAlign("top");
    obj.label44:setHorzTextAlign("center");
    obj.label44:setName("label44");
    obj.label44:setFontSize(12);
    obj.label44:setFontColor("#D0D0D0");

    obj.rclProps = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclProps:setParent(obj.layEquipPropriedades);
    obj.rclProps:setName("rclProps");
    obj.rclProps:setAlign("client");
    obj.rclProps:setField("listaPropriedades");
    obj.rclProps:setTemplateForm("frmText");

    obj.button7 = GUI.fromHandle(_obj_newObject("button"));
    obj.button7:setParent(obj.layEquipPropriedades);
    obj.button7:setAlign("bottom");
    obj.button7:setText("@@DnD5e.tab.equipament.btn.property");
    obj.button7:setFontSize(11);
    obj.button7:setName("button7");

    obj.dataLink82 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink82:setParent(obj.layEquipPropriedades);
    obj.dataLink82:setField("propriedades");
    obj.dataLink82:setName("dataLink82");

    obj.layPrincipal = GUI.fromHandle(_obj_newObject("layout"));
    obj.layPrincipal:setParent(obj.dataEquipAttackDetails);
    obj.layPrincipal.grid.role = "col";
    obj.layPrincipal.grid.width = 8;
    obj.layPrincipal.grid["vert-tile"] = true;
    obj.layPrincipal:setName("layPrincipal");
    obj.layPrincipal:setMargins({left=5});

    obj.optAtaqueLegenda = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.optAtaqueLegenda:setParent(obj.layPrincipal);
    obj.optAtaqueLegenda:setAlign("top");
    obj.optAtaqueLegenda:setHeight(15);
    obj.optAtaqueLegenda:setName("optAtaqueLegenda");
    obj.optAtaqueLegenda:setHorzAlign("justify");
    obj.optAtaqueLegenda:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.optAtaqueLegenda:setMinScaledWidth(300);
    obj.optAtaqueLegenda:setMargins({left=1, right=1, top=2, bottom=2});
    obj.optAtaqueLegenda:setVertAlign("leading");

    obj.flowPart28 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart28:setParent(obj.optAtaqueLegenda);
    obj.flowPart28:setHeight(15);
    obj.flowPart28:setMinWidth(20);
    obj.flowPart28:setMaxWidth(20);
    obj.flowPart28:setName("flowPart28");
    obj.flowPart28:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart28:setVertAlign("leading");

    obj.label45 = GUI.fromHandle(_obj_newObject("label"));
    obj.label45:setParent(obj.flowPart28);
    obj.label45:setAlign("client");
    obj.label45:setText(" ");
    obj.label45:setHorzTextAlign("center");
    obj.label45:setVertTextAlign("leading");
    obj.label45:setWordWrap(true);
    obj.label45:setTextTrimming("none");
    obj.label45:setName("label45");
    obj.label45:setFontSize(12);
    obj.label45:setFontColor("#D0D0D0");

    obj.flowPart29 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart29:setParent(obj.optAtaqueLegenda);
    obj.flowPart29:setHeight(15);
    obj.flowPart29:setMinWidth(80);
    obj.flowPart29:setMaxWidth(150);
    obj.flowPart29:setName("flowPart29");
    obj.flowPart29:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart29:setVertAlign("leading");

    obj.label46 = GUI.fromHandle(_obj_newObject("label"));
    obj.label46:setParent(obj.flowPart29);
    obj.label46:setAlign("client");
    obj.label46:setText("@@DnD5e.tab.equipament.atack.lab.range");
    obj.label46:setHorzTextAlign("center");
    obj.label46:setVertTextAlign("leading");
    obj.label46:setWordWrap(true);
    obj.label46:setTextTrimming("none");
    obj.label46:setName("label46");
    obj.label46:setFontSize(12);
    obj.label46:setFontColor("#D0D0D0");

    obj.flowPart30 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart30:setParent(obj.optAtaqueLegenda);
    obj.flowPart30:setHeight(15);
    obj.flowPart30:setMinWidth(110);
    obj.flowPart30:setMaxWidth(200);
    obj.flowPart30:setName("flowPart30");
    obj.flowPart30:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart30:setVertAlign("leading");

    obj.label47 = GUI.fromHandle(_obj_newObject("label"));
    obj.label47:setParent(obj.flowPart30);
    obj.label47:setAlign("client");
    obj.label47:setText("@@DnD5e.tab.equipament.atack.lab.attack");
    obj.label47:setHorzTextAlign("center");
    obj.label47:setVertTextAlign("leading");
    obj.label47:setWordWrap(true);
    obj.label47:setTextTrimming("none");
    obj.label47:setName("label47");
    obj.label47:setFontSize(12);
    obj.label47:setFontColor("#D0D0D0");

    obj.flowPart31 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart31:setParent(obj.optAtaqueLegenda);
    obj.flowPart31:setHeight(15);
    obj.flowPart31:setMinWidth(80);
    obj.flowPart31:setMaxWidth(170);
    obj.flowPart31:setName("flowPart31");
    obj.flowPart31:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart31:setVertAlign("leading");

    obj.label48 = GUI.fromHandle(_obj_newObject("label"));
    obj.label48:setParent(obj.flowPart31);
    obj.label48:setAlign("client");
    obj.label48:setText("@@DnD5e.tab.equipament.atack.lab.damage");
    obj.label48:setHorzTextAlign("center");
    obj.label48:setVertTextAlign("leading");
    obj.label48:setWordWrap(true);
    obj.label48:setTextTrimming("none");
    obj.label48:setName("label48");
    obj.label48:setFontSize(12);
    obj.label48:setFontColor("#D0D0D0");

    obj.flowPart32 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart32:setParent(obj.optAtaqueLegenda);
    obj.flowPart32:setHeight(15);
    obj.flowPart32:setMinWidth(80);
    obj.flowPart32:setMaxWidth(180);
    obj.flowPart32:setName("flowPart32");
    obj.flowPart32:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart32:setVertAlign("leading");

    obj.label49 = GUI.fromHandle(_obj_newObject("label"));
    obj.label49:setParent(obj.flowPart32);
    obj.label49:setAlign("client");
    obj.label49:setText("@@DnD5e.tab.equipament.atack.lab.type");
    obj.label49:setHorzTextAlign("center");
    obj.label49:setVertTextAlign("leading");
    obj.label49:setWordWrap(true);
    obj.label49:setTextTrimming("none");
    obj.label49:setName("label49");
    obj.label49:setFontSize(12);
    obj.label49:setFontColor("#D0D0D0");

    obj.flowPart33 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart33:setParent(obj.optAtaqueLegenda);
    obj.flowPart33:setHeight(15);
    obj.flowPart33:setMinWidth(100);
    obj.flowPart33:setMaxWidth(200);
    obj.flowPart33:setName("flowPart33");
    obj.flowPart33:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart33:setVertAlign("leading");

    obj.label50 = GUI.fromHandle(_obj_newObject("label"));
    obj.label50:setParent(obj.flowPart33);
    obj.label50:setAlign("client");
    obj.label50:setText("@@DnD5e.tab.equipament.atack.lab.ammunition");
    obj.label50:setHorzTextAlign("center");
    obj.label50:setVertTextAlign("leading");
    obj.label50:setWordWrap(true);
    obj.label50:setTextTrimming("none");
    obj.label50:setName("label50");
    obj.label50:setFontSize(12);
    obj.label50:setFontColor("#D0D0D0");

    obj.flowPart34 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart34:setParent(obj.optAtaqueLegenda);
    obj.flowPart34:setHeight(15);
    obj.flowPart34:setMinWidth(25);
    obj.flowPart34:setMaxWidth(50);
    obj.flowPart34:setName("flowPart34");
    obj.flowPart34:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart34:setVertAlign("leading");

    obj.label51 = GUI.fromHandle(_obj_newObject("label"));
    obj.label51:setParent(obj.flowPart34);
    obj.label51:setAlign("client");
    obj.label51:setText("@@DnD5e.tab.equipament.atack.lab.ammunitionAmount");
    obj.label51:setHorzTextAlign("center");
    obj.label51:setVertTextAlign("leading");
    obj.label51:setWordWrap(true);
    obj.label51:setTextTrimming("none");
    obj.label51:setName("label51");
    obj.label51:setFontSize(12);
    obj.label51:setFontColor("#D0D0D0");

    obj.flowPart35 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart35:setParent(obj.optAtaqueLegenda);
    obj.flowPart35:setHeight(25);
    obj.flowPart35:setMinWidth(25);
    obj.flowPart35:setMaxWidth(25);
    obj.flowPart35:setName("flowPart35");
    obj.flowPart35:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart35:setVertAlign("leading");

    obj.label52 = GUI.fromHandle(_obj_newObject("label"));
    obj.label52:setParent(obj.flowPart35);
    obj.label52:setAlign("client");
    obj.label52:setText(" ");
    obj.label52:setHorzTextAlign("center");
    obj.label52:setVertTextAlign("leading");
    obj.label52:setWordWrap(true);
    obj.label52:setTextTrimming("none");
    obj.label52:setName("label52");
    obj.label52:setFontSize(12);
    obj.label52:setFontColor("#D0D0D0");

    obj.optAtaquePadrao = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.optAtaquePadrao:setParent(obj.layPrincipal);
    obj.optAtaquePadrao:setAlign("top");
    obj.optAtaquePadrao:setHeight(30);
    obj.optAtaquePadrao:setWidth(200);
    obj.optAtaquePadrao:setName("optAtaquePadrao");
    obj.optAtaquePadrao:setHorzAlign("justify");
    obj.optAtaquePadrao:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.optAtaquePadrao:setMinScaledWidth(300);
    obj.optAtaquePadrao:setMargins({left=1, right=1, top=2, bottom=2});
    obj.optAtaquePadrao:setVertAlign("leading");

    obj.flowPart36 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart36:setParent(obj.optAtaquePadrao);
    obj.flowPart36:setHeight(30);
    obj.flowPart36:setWidth(20);
    obj.flowPart36:setName("flowPart36");
    obj.flowPart36:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart36:setVertAlign("leading");

    obj.checkBox1 = GUI.fromHandle(_obj_newObject("checkBox"));
    obj.checkBox1:setParent(obj.flowPart36);
    obj.checkBox1:setAlign("client");
    obj.checkBox1:setChecked(true);
    obj.checkBox1:setEnabled(false);
    obj.checkBox1:setName("checkBox1");

    obj.flowPart37 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart37:setParent(obj.optAtaquePadrao);
    obj.flowPart37:setHeight(30);
    obj.flowPart37:setMinWidth(80);
    obj.flowPart37:setMaxWidth(150);
    obj.flowPart37:setAvoidScale(true);
    obj.flowPart37:setName("flowPart37");
    obj.flowPart37:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart37:setVertAlign("leading");

    obj.edit35 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit35:setParent(obj.flowPart37);
    obj.edit35:setAlign("client");
    obj.edit35:setField("alcance");
    obj.edit35:setHorzTextAlign("center");
    obj.edit35:setVertTextAlign("center");
    obj.edit35:setFontSize(13);
    obj.edit35:setTransparent(false);
    obj.edit35:setHitTest(true);
    obj.edit35:setName("edit35");
    obj.edit35:setHeight(30);
    obj.edit35:setWidth(195);
    obj.edit35:setFontColor("white");

    obj.flowPart38 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart38:setParent(obj.optAtaquePadrao);
    obj.flowPart38:setHeight(30);
    obj.flowPart38:setMinWidth(110);
    obj.flowPart38:setMaxWidth(200);
    obj.flowPart38:setAvoidScale(true);
    obj.flowPart38:setName("flowPart38");
    obj.flowPart38:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart38:setVertAlign("leading");

    obj.edit36 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit36:setParent(obj.flowPart38);
    obj.edit36:setAlign("client");
    obj.edit36:setField("ataque");
    obj.edit36:setHorzTextAlign("center");
    obj.edit36:setVertTextAlign("center");
    obj.edit36:setFontSize(13);
    obj.edit36:setTransparent(false);
    obj.edit36:setHitTest(true);
    obj.edit36:setName("edit36");
    obj.edit36:setHeight(30);
    obj.edit36:setWidth(195);
    obj.edit36:setFontColor("white");

    obj.flowPart39 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart39:setParent(obj.optAtaquePadrao);
    obj.flowPart39:setHeight(30);
    obj.flowPart39:setMinWidth(80);
    obj.flowPart39:setMaxWidth(170);
    obj.flowPart39:setAvoidScale(true);
    obj.flowPart39:setName("flowPart39");
    obj.flowPart39:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart39:setVertAlign("leading");

    obj.edit37 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit37:setParent(obj.flowPart39);
    obj.edit37:setAlign("client");
    obj.edit37:setField("dano");
    obj.edit37:setHorzTextAlign("center");
    obj.edit37:setVertTextAlign("center");
    obj.edit37:setFontSize(13);
    obj.edit37:setTransparent(false);
    obj.edit37:setHitTest(true);
    obj.edit37:setName("edit37");
    obj.edit37:setHeight(30);
    obj.edit37:setWidth(195);
    obj.edit37:setFontColor("white");

    obj.flowPart40 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart40:setParent(obj.optAtaquePadrao);
    obj.flowPart40:setHeight(30);
    obj.flowPart40:setMinWidth(80);
    obj.flowPart40:setMaxWidth(180);
    obj.flowPart40:setAvoidScale(true);
    obj.flowPart40:setName("flowPart40");
    obj.flowPart40:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart40:setVertAlign("leading");

    obj.edit38 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit38:setParent(obj.flowPart40);
    obj.edit38:setAlign("client");
    obj.edit38:setField("tipo");
    obj.edit38:setHorzTextAlign("center");
    obj.edit38:setVertTextAlign("center");
    obj.edit38:setFontSize(13);
    obj.edit38:setTransparent(false);
    obj.edit38:setHitTest(true);
    obj.edit38:setName("edit38");
    obj.edit38:setHeight(30);
    obj.edit38:setWidth(195);
    obj.edit38:setFontColor("white");

    obj.flowPart41 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart41:setParent(obj.optAtaquePadrao);
    obj.flowPart41:setHeight(30);
    obj.flowPart41:setMinWidth(100);
    obj.flowPart41:setMaxWidth(200);
    obj.flowPart41:setAvoidScale(true);
    obj.flowPart41:setName("flowPart41");
    obj.flowPart41:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart41:setVertAlign("leading");

    obj.cbOptAtaqueMunicao = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.cbOptAtaqueMunicao:setParent(obj.flowPart41);
    obj.cbOptAtaqueMunicao:setName("cbOptAtaqueMunicao");
    obj.cbOptAtaqueMunicao:setAlign("client");
    obj.cbOptAtaqueMunicao:setField("municao");
    obj.cbOptAtaqueMunicao:setHint("Qual 'contador' deve ser gasto");
    obj.cbOptAtaqueMunicao:setFontSize(18);
    obj.cbOptAtaqueMunicao:setHeight(30);
    obj.cbOptAtaqueMunicao:setTransparent(true);
    obj.cbOptAtaqueMunicao:setWidth(195);

    obj.dataLink83 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink83:setParent(obj.flowPart41);
    obj.dataLink83:setField("contadoresMudaram");
    obj.dataLink83:setName("dataLink83");

    obj.flowPart42 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart42:setParent(obj.optAtaquePadrao);
    obj.flowPart42:setHeight(30);
    obj.flowPart42:setMinWidth(25);
    obj.flowPart42:setMaxWidth(50);
    obj.flowPart42:setAvoidScale(true);
    obj.flowPart42:setName("flowPart42");
    obj.flowPart42:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart42:setVertAlign("leading");

    obj.edit39 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit39:setParent(obj.flowPart42);
    obj.edit39:setAlign("client");
    obj.edit39:setField("qtMunicao");
    obj.edit39:setHorzTextAlign("center");
    obj.edit39:setVertTextAlign("center");
    obj.edit39:setFontSize(13);
    obj.edit39:setTransparent(false);
    obj.edit39:setHitTest(true);
    obj.edit39:setName("edit39");
    obj.edit39:setHeight(30);
    obj.edit39:setWidth(195);
    obj.edit39:setFontColor("white");

    obj.flowPart43 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart43:setParent(obj.optAtaquePadrao);
    obj.flowPart43:setHeight(30);
    obj.flowPart43:setWidth(25);
    obj.flowPart43:setName("flowPart43");
    obj.flowPart43:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart43:setVertAlign("leading");

    obj.btnApagar = GUI.fromHandle(_obj_newObject("button"));
    obj.btnApagar:setParent(obj.flowPart43);
    obj.btnApagar:setName("btnApagar");
    obj.btnApagar:setAlign("client");
    obj.btnApagar:setText("✖");
    obj.btnApagar:setEnabled(false);

    obj.horzLine26 = GUI.fromHandle(_obj_newObject("horzLine"));
    obj.horzLine26:setParent(obj.layPrincipal);
    obj.horzLine26:setAlign("top");
    obj.horzLine26:setStrokeColor("lightGray");
    obj.horzLine26:setOpacity(0.3);
    obj.horzLine26:setMargins({top=2});
    obj.horzLine26:setName("horzLine26");

    obj.rclOptsAttack = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclOptsAttack:setParent(obj.layPrincipal);
    obj.rclOptsAttack:setName("rclOptsAttack");
    obj.rclOptsAttack:setAlign("client");
    obj.rclOptsAttack:setField("optsAttack");
    obj.rclOptsAttack:setTemplateForm("frmOptAtaque");

    obj.button8 = GUI.fromHandle(_obj_newObject("button"));
    obj.button8:setParent(obj.layPrincipal);
    obj.button8:setAlign("bottom");
    obj.button8:setText("@@DnD5e.tab.equipament.btn.addAttackOption");
    obj.button8:setMargins({left=150, right=150});
    obj.button8:setFontSize(11);
    obj.button8:setName("button8");

    obj.dataLink84 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink84:setParent(obj.layPrincipal);
    obj.dataLink84:setField("contadoresMudaram");
    obj.dataLink84:setName("dataLink84");

    obj.flowLineBreak7 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak7:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak7:setName("flowLineBreak7");

    obj.flowLayout19 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout19:setParent(obj.fraEquipamentoLayout);
    obj.flowLayout19:setAutoHeight(true);
    obj.flowLayout19:setHorzAlign("justify");
    obj.flowLayout19:setAvoidScale(true);
    obj.flowLayout19:setName("flowLayout19");
    obj.flowLayout19:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout19:setMinScaledWidth(300);
    obj.flowLayout19:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout19:setVertAlign("leading");

    obj.flowPart44 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart44:setParent(obj.flowLayout19);
    obj.flowPart44:setMinWidth(330);
    obj.flowPart44:setMaxWidth(800);
    obj.flowPart44:setHeight(420);
    obj.flowPart44:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart44:setName("flowPart44");
    obj.flowPart44:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart44:setVertAlign("leading");

    obj.label53 = GUI.fromHandle(_obj_newObject("label"));
    obj.label53:setParent(obj.flowPart44);
    obj.label53:setAlign("top");
    obj.label53:setHeight(24);
    obj.label53:setText("Ações");
    obj.label53:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label53, "fontStyle", "bold");
    obj.label53:setName("label53");
    obj.label53:setFontSize(12);
    obj.label53:setFontColor("#D0D0D0");

    obj.rclMobAcoes = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclMobAcoes:setParent(obj.flowPart44);
    obj.rclMobAcoes:setName("rclMobAcoes");
    obj.rclMobAcoes:setAlign("client");
    obj.rclMobAcoes:setField("mobAcoesLista");
    obj.rclMobAcoes:setTemplateForm("frmText");
    obj.rclMobAcoes:setMinQt(0);
    obj.rclMobAcoes:setMargins({left=8,right=8,top=4,bottom=4});

    obj.layout57 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout57:setParent(obj.flowPart44);
    obj.layout57:setAlign("bottom");
    obj.layout57:setHeight(36);
    obj.layout57:setMargins({left=8,right=8,bottom=8});
    obj.layout57:setName("layout57");

    obj.button9 = GUI.fromHandle(_obj_newObject("button"));
    obj.button9:setParent(obj.layout57);
    obj.button9:setAlign("left");
    obj.button9:setWidth(100);
    obj.button9:setText("Nova");
    obj.button9:setName("button9");

    obj.button10 = GUI.fromHandle(_obj_newObject("button"));
    obj.button10:setParent(obj.layout57);
    obj.button10:setAlign("left");
    obj.button10:setWidth(100);
    obj.button10:setText("Remover");
    obj.button10:setMargins({left=6});
    obj.button10:setName("button10");

    obj.button11 = GUI.fromHandle(_obj_newObject("button"));
    obj.button11:setParent(obj.layout57);
    obj.button11:setAlign("client");
    obj.button11:setText("Duplicar");
    obj.button11:setMargins({left=6});
    obj.button11:setName("button11");

    obj.flowPart45 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart45:setParent(obj.flowLayout19);
    obj.flowPart45:setMinWidth(520);
    obj.flowPart45:setMaxWidth(1400);
    obj.flowPart45:setHeight(420);
    obj.flowPart45:setFrameStyle("frames/panel1/frame.xml");
    obj.flowPart45:setName("flowPart45");
    obj.flowPart45:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart45:setVertAlign("leading");

    obj.label54 = GUI.fromHandle(_obj_newObject("label"));
    obj.label54:setParent(obj.flowPart45);
    obj.label54:setAlign("top");
    obj.label54:setHeight(24);
    obj.label54:setText("Detalhes da Ação");
    obj.label54:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label54, "fontStyle", "bold");
    obj.label54:setName("label54");
    obj.label54:setFontSize(12);
    obj.label54:setFontColor("#D0D0D0");

    obj.dsbMobAcao = GUI.fromHandle(_obj_newObject("dataScopeBox"));
    obj.dsbMobAcao:setParent(obj.flowPart45);
    obj.dsbMobAcao:setName("dsbMobAcao");
    obj.dsbMobAcao:setAlign("client");
    obj.dsbMobAcao:setEnabled(false);
    obj.dsbMobAcao:setMargins({left=6,right=6,bottom=6});

    obj.dataLink85 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink85:setParent(obj.dsbMobAcao);
    obj.dataLink85:setField("atribSave");
    obj.dataLink85:setName("dataLink85");

    obj.dataLink86 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink86:setParent(obj.dsbMobAcao);
    obj.dataLink86:setField("custoLendario");
    obj.dataLink86:setDefaultValue("1");
    obj.dataLink86:setName("dataLink86");

    obj.layout58 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout58:setParent(obj.dsbMobAcao);
    obj.layout58:setAlign("top");
    obj.layout58:setHeight(28);
    obj.layout58:setMargins({top=4});
    obj.layout58:setName("layout58");

    obj.label55 = GUI.fromHandle(_obj_newObject("label"));
    obj.label55:setParent(obj.layout58);
    obj.label55:setAlign("left");
    obj.label55:setWidth(100);
    obj.label55:setText("Nome");
    obj.label55:setFontSize(11);
    obj.label55:setName("label55");
    obj.label55:setFontColor("#D0D0D0");

    obj.edit40 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit40:setParent(obj.layout58);
    obj.edit40:setAlign("client");
    obj.edit40:setField("texto");
    obj.edit40:setName("edit40");
    obj.edit40:setFontSize(15);
    obj.edit40:setFontColor("white");
    obj.edit40:setTransparent(true);

    obj.layout59 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout59:setParent(obj.dsbMobAcao);
    obj.layout59:setAlign("top");
    obj.layout59:setHeight(28);
    obj.layout59:setMargins({top=4});
    obj.layout59:setName("layout59");

    obj.label56 = GUI.fromHandle(_obj_newObject("label"));
    obj.label56:setParent(obj.layout59);
    obj.label56:setAlign("left");
    obj.label56:setWidth(100);
    obj.label56:setText("Tipo");
    obj.label56:setFontSize(11);
    obj.label56:setName("label56");
    obj.label56:setFontColor("#D0D0D0");

    obj.comboBox2 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox2:setParent(obj.layout59);
    obj.comboBox2:setAlign("left");
    obj.comboBox2:setWidth(160);
    obj.comboBox2:setField("tipoAcao");
    obj.comboBox2:setItems({'Ação','Ação Bônus','Reação','Lendária','Mítica'});
    obj.comboBox2:setValues({'acao','bonus','reacao','lendaria','mitica'});
    obj.comboBox2:setName("comboBox2");

    obj.label57 = GUI.fromHandle(_obj_newObject("label"));
    obj.label57:setParent(obj.layout59);
    obj.label57:setAlign("left");
    obj.label57:setWidth(70);
    obj.label57:setText("Ordem");
    obj.label57:setFontSize(11);
    obj.label57:setMargins({left=8});
    obj.label57:setName("label57");
    obj.label57:setFontColor("#D0D0D0");

    obj.edit41 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit41:setParent(obj.layout59);
    obj.edit41:setAlign("client");
    obj.edit41:setField("ordem");
    obj.edit41:setName("edit41");
    obj.edit41:setFontSize(15);
    obj.edit41:setFontColor("white");
    obj.edit41:setTransparent(true);

    obj.layout60 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout60:setParent(obj.dsbMobAcao);
    obj.layout60:setAlign("top");
    obj.layout60:setHeight(28);
    obj.layout60:setMargins({top=4});
    obj.layout60:setName("layout60");

    obj.label58 = GUI.fromHandle(_obj_newObject("label"));
    obj.label58:setParent(obj.layout60);
    obj.label58:setAlign("left");
    obj.label58:setWidth(100);
    obj.label58:setText("Uso");
    obj.label58:setFontSize(11);
    obj.label58:setName("label58");
    obj.label58:setFontColor("#D0D0D0");

    obj.comboBox3 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox3:setParent(obj.layout60);
    obj.comboBox3:setAlign("left");
    obj.comboBox3:setWidth(220);
    obj.comboBox3:setField("usoTipo");
    obj.comboBox3:setItems({'Livre','1 vez por dia','2x por dia','3x por dia','X vezes por dia','1 vez por semana','X vezes por semana','Recarrega (d6)','Ativável (manual)'});
    obj.comboBox3:setValues({'Livre','1/dia','2/dia','3/dia','x/dia','1/semana','x/semana','recharge','manual'});
    obj.comboBox3:setName("comboBox3");

    obj.label59 = GUI.fromHandle(_obj_newObject("label"));
    obj.label59:setParent(obj.layout60);
    obj.label59:setAlign("left");
    obj.label59:setWidth(88);
    obj.label59:setText("Usos Atual/Max");
    obj.label59:setFontSize(10);
    obj.label59:setMargins({left=8});
    obj.label59:setName("label59");
    obj.label59:setFontColor("#D0D0D0");

    obj.edit42 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit42:setParent(obj.layout60);
    obj.edit42:setAlign("left");
    obj.edit42:setWidth(42);
    obj.edit42:setField("usosAtual");
    obj.edit42:setHorzTextAlign("center");
    obj.edit42:setName("edit42");
    obj.edit42:setFontSize(15);
    obj.edit42:setFontColor("white");
    obj.edit42:setTransparent(true);

    obj.label60 = GUI.fromHandle(_obj_newObject("label"));
    obj.label60:setParent(obj.layout60);
    obj.label60:setAlign("left");
    obj.label60:setWidth(14);
    obj.label60:setText("/");
    obj.label60:setHorzTextAlign("center");
    obj.label60:setName("label60");
    obj.label60:setFontSize(12);
    obj.label60:setFontColor("#D0D0D0");

    obj.edit43 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit43:setParent(obj.layout60);
    obj.edit43:setAlign("client");
    obj.edit43:setField("usosMax");
    obj.edit43:setHorzTextAlign("center");
    obj.edit43:setName("edit43");
    obj.edit43:setFontSize(15);
    obj.edit43:setFontColor("white");
    obj.edit43:setTransparent(true);

    obj.layout61 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout61:setParent(obj.dsbMobAcao);
    obj.layout61:setAlign("top");
    obj.layout61:setHeight(32);
    obj.layout61:setMargins({top=4});
    obj.layout61:setName("layout61");

    obj.label61 = GUI.fromHandle(_obj_newObject("label"));
    obj.label61:setParent(obj.layout61);
    obj.label61:setAlign("left");
    obj.label61:setWidth(100);
    obj.label61:setText("Recharge");
    obj.label61:setFontSize(11);
    obj.label61:setName("label61");
    obj.label61:setFontColor("#D0D0D0");

    obj.label62 = GUI.fromHandle(_obj_newObject("label"));
    obj.label62:setParent(obj.layout61);
    obj.label62:setAlign("left");
    obj.label62:setWidth(40);
    obj.label62:setText("d6");
    obj.label62:setHorzTextAlign("center");
    obj.label62:setName("label62");
    obj.label62:setFontSize(12);
    obj.label62:setFontColor("#D0D0D0");

    obj.comboBox4 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox4:setParent(obj.layout61);
    obj.comboBox4:setAlign("left");
    obj.comboBox4:setWidth(70);
    obj.comboBox4:setField("rechargeMin");
    obj.comboBox4:setItems({'2','3','4','5','6'});
    obj.comboBox4:setValues({'2','3','4','5','6'});
    obj.comboBox4:setName("comboBox4");

    obj.label63 = GUI.fromHandle(_obj_newObject("label"));
    obj.label63:setParent(obj.layout61);
    obj.label63:setAlign("left");
    obj.label63:setWidth(28);
    obj.label63:setText("-6");
    obj.label63:setHorzTextAlign("center");
    obj.label63:setName("label63");
    obj.label63:setFontSize(12);
    obj.label63:setFontColor("#D0D0D0");

    obj.button12 = GUI.fromHandle(_obj_newObject("button"));
    obj.button12:setParent(obj.layout61);
    obj.button12:setAlign("left");
    obj.button12:setWidth(120);
    obj.button12:setText("Rolar Recharge");
    obj.button12:setMargins({left=6});
    obj.button12:setName("button12");

    obj.button13 = GUI.fromHandle(_obj_newObject("button"));
    obj.button13:setParent(obj.layout61);
    obj.button13:setAlign("left");
    obj.button13:setWidth(64);
    obj.button13:setText("Usar 1");
    obj.button13:setMargins({left=6});
    obj.button13:setName("button13");

    obj.button14 = GUI.fromHandle(_obj_newObject("button"));
    obj.button14:setParent(obj.layout61);
    obj.button14:setAlign("left");
    obj.button14:setWidth(64);
    obj.button14:setText("Reset");
    obj.button14:setMargins({left=6});
    obj.button14:setName("button14");

    obj.label64 = GUI.fromHandle(_obj_newObject("label"));
    obj.label64:setParent(obj.layout61);
    obj.label64:setAlign("left");
    obj.label64:setWidth(54);
    obj.label64:setText("Últ.");
    obj.label64:setFontSize(10);
    obj.label64:setMargins({left=8});
    obj.label64:setName("label64");
    obj.label64:setFontColor("#D0D0D0");

    obj.edit44 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit44:setParent(obj.layout61);
    obj.edit44:setAlign("left");
    obj.edit44:setWidth(36);
    obj.edit44:setField("rechargeLast");
    obj.edit44:setHorzTextAlign("center");
    obj.edit44:setName("edit44");
    obj.edit44:setFontSize(15);
    obj.edit44:setFontColor("white");
    obj.edit44:setTransparent(true);

    obj.label65 = GUI.fromHandle(_obj_newObject("label"));
    obj.label65:setParent(obj.layout61);
    obj.label65:setAlign("left");
    obj.label65:setWidth(54);
    obj.label65:setText("Status");
    obj.label65:setFontSize(10);
    obj.label65:setMargins({left=8});
    obj.label65:setName("label65");
    obj.label65:setFontColor("#D0D0D0");

    obj.edit45 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit45:setParent(obj.layout61);
    obj.edit45:setAlign("client");
    obj.edit45:setField("rechargeReady");
    obj.edit45:setHorzTextAlign("center");
    obj.edit45:setName("edit45");
    obj.edit45:setFontSize(15);
    obj.edit45:setFontColor("white");
    obj.edit45:setTransparent(true);

    obj.layout62 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout62:setParent(obj.dsbMobAcao);
    obj.layout62:setAlign("top");
    obj.layout62:setHeight(28);
    obj.layout62:setMargins({top=4});
    obj.layout62:setName("layout62");

    obj.label66 = GUI.fromHandle(_obj_newObject("label"));
    obj.label66:setParent(obj.layout62);
    obj.label66:setAlign("left");
    obj.label66:setWidth(100);
    obj.label66:setText("Ataque");
    obj.label66:setFontSize(11);
    obj.label66:setName("label66");
    obj.label66:setFontColor("#D0D0D0");

    obj.edit46 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit46:setParent(obj.layout62);
    obj.edit46:setAlign("left");
    obj.edit46:setWidth(120);
    obj.edit46:setField("bonusAtaque");
    obj.edit46:setHint("Ex.: +8");
    obj.edit46:setName("edit46");
    obj.edit46:setFontSize(15);
    obj.edit46:setFontColor("white");
    obj.edit46:setTransparent(true);

    obj.label67 = GUI.fromHandle(_obj_newObject("label"));
    obj.label67:setParent(obj.layout62);
    obj.label67:setAlign("left");
    obj.label67:setWidth(68);
    obj.label67:setText("Alcance");
    obj.label67:setFontSize(11);
    obj.label67:setMargins({left=8});
    obj.label67:setName("label67");
    obj.label67:setFontColor("#D0D0D0");

    obj.edit47 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit47:setParent(obj.layout62);
    obj.edit47:setAlign("left");
    obj.edit47:setWidth(140);
    obj.edit47:setField("alcance");
    obj.edit47:setHint("Ex.: 1,5m / 18m");
    obj.edit47:setName("edit47");
    obj.edit47:setFontSize(15);
    obj.edit47:setFontColor("white");
    obj.edit47:setTransparent(true);

    obj.label68 = GUI.fromHandle(_obj_newObject("label"));
    obj.label68:setParent(obj.layout62);
    obj.label68:setAlign("left");
    obj.label68:setWidth(52);
    obj.label68:setText("Alvo");
    obj.label68:setFontSize(11);
    obj.label68:setMargins({left=8});
    obj.label68:setName("label68");
    obj.label68:setFontColor("#D0D0D0");

    obj.edit48 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit48:setParent(obj.layout62);
    obj.edit48:setAlign("client");
    obj.edit48:setField("alvo");
    obj.edit48:setName("edit48");
    obj.edit48:setFontSize(15);
    obj.edit48:setFontColor("white");
    obj.edit48:setTransparent(true);

    obj.layout63 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout63:setParent(obj.dsbMobAcao);
    obj.layout63:setAlign("top");
    obj.layout63:setHeight(30);
    obj.layout63:setMargins({top=4});
    obj.layout63:setName("layout63");

    obj.label69 = GUI.fromHandle(_obj_newObject("label"));
    obj.label69:setParent(obj.layout63);
    obj.label69:setAlign("left");
    obj.label69:setWidth(100);
    obj.label69:setText("Dano");
    obj.label69:setFontSize(11);
    obj.label69:setName("label69");
    obj.label69:setFontColor("#D0D0D0");

    obj.edit49 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit49:setParent(obj.layout63);
    obj.edit49:setAlign("left");
    obj.edit49:setWidth(160);
    obj.edit49:setField("dano");
    obj.edit49:setHint("Ex.: 2d6+4");
    obj.edit49:setName("edit49");
    obj.edit49:setFontSize(15);
    obj.edit49:setFontColor("white");
    obj.edit49:setTransparent(true);

    obj.label70 = GUI.fromHandle(_obj_newObject("label"));
    obj.label70:setParent(obj.layout63);
    obj.label70:setAlign("left");
    obj.label70:setWidth(54);
    obj.label70:setText("Tipo");
    obj.label70:setFontSize(11);
    obj.label70:setMargins({left=8});
    obj.label70:setName("label70");
    obj.label70:setFontColor("#D0D0D0");

    obj.edit50 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit50:setParent(obj.layout63);
    obj.edit50:setAlign("left");
    obj.edit50:setWidth(120);
    obj.edit50:setField("tipoDano");
    obj.edit50:setHint("Ex.: fogo");
    obj.edit50:setName("edit50");
    obj.edit50:setFontSize(15);
    obj.edit50:setFontColor("white");
    obj.edit50:setTransparent(true);

    obj.label71 = GUI.fromHandle(_obj_newObject("label"));
    obj.label71:setParent(obj.layout63);
    obj.label71:setAlign("left");
    obj.label71:setWidth(32);
    obj.label71:setText("CD");
    obj.label71:setFontSize(11);
    obj.label71:setMargins({left=8});
    obj.label71:setName("label71");
    obj.label71:setFontColor("#D0D0D0");

    obj.edit51 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit51:setParent(obj.layout63);
    obj.edit51:setAlign("left");
    obj.edit51:setWidth(46);
    obj.edit51:setField("cdSave");
    obj.edit51:setHorzTextAlign("center");
    obj.edit51:setName("edit51");
    obj.edit51:setFontSize(15);
    obj.edit51:setFontColor("white");
    obj.edit51:setTransparent(true);

    obj.label72 = GUI.fromHandle(_obj_newObject("label"));
    obj.label72:setParent(obj.layout63);
    obj.label72:setAlign("left");
    obj.label72:setWidth(36);
    obj.label72:setText("Atrib");
    obj.label72:setFontSize(11);
    obj.label72:setMargins({left=8});
    obj.label72:setName("label72");
    obj.label72:setFontColor("#D0D0D0");

    obj.comboBox5 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox5:setParent(obj.layout63);
    obj.comboBox5:setAlign("left");
    obj.comboBox5:setWidth(70);
    obj.comboBox5:setField("atribSave");
    obj.comboBox5:setItems({'FOR','DES','CON','INT','SAB','CAR'});
    obj.comboBox5:setValues({'forca','destreza','constituicao','inteligencia','sabedoria','carisma'});
    obj.comboBox5:setName("comboBox5");

    obj.label73 = GUI.fromHandle(_obj_newObject("label"));
    obj.label73:setParent(obj.layout63);
    obj.label73:setAlign("left");
    obj.label73:setWidth(66);
    obj.label73:setText("Custo Lend.");
    obj.label73:setFontSize(10);
    obj.label73:setMargins({left=8});
    obj.label73:setName("label73");
    obj.label73:setFontColor("#D0D0D0");

    obj.edit52 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit52:setParent(obj.layout63);
    obj.edit52:setAlign("left");
    obj.edit52:setWidth(42);
    obj.edit52:setField("custoLendario");
    obj.edit52:setHorzTextAlign("center");
    obj.edit52:setName("edit52");
    obj.edit52:setFontSize(15);
    obj.edit52:setFontColor("white");
    obj.edit52:setTransparent(true);

    obj.button15 = GUI.fromHandle(_obj_newObject("button"));
    obj.button15:setParent(obj.layout63);
    obj.button15:setAlign("client");
    obj.button15:setText("Usar Ação");
    obj.button15:setMargins({left=8});
    obj.button15:setName("button15");

    obj.label74 = GUI.fromHandle(_obj_newObject("label"));
    obj.label74:setParent(obj.dsbMobAcao);
    obj.label74:setAlign("top");
    obj.label74:setHeight(18);
    obj.label74:setText("Descrição");
    obj.label74:setFontSize(11);
    obj.label74:setMargins({top=6});
    obj.label74:setName("label74");
    obj.label74:setFontColor("#D0D0D0");

    obj.textEditor6 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor6:setParent(obj.dsbMobAcao);
    obj.textEditor6:setAlign("client");
    obj.textEditor6:setField("descricao");
    obj.textEditor6:setName("textEditor6");
    obj.textEditor6:setTransparent(true);

    obj.dataLink87 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink87:setParent(obj.flowPart45);
    obj.dataLink87:setField("bonusProficiencia");
    obj.dataLink87:setName("dataLink87");

    obj.dataLink88 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink88:setParent(obj.flowPart45);
    obj.dataLink88:setField("forca");
    obj.dataLink88:setName("dataLink88");

    obj.dataLink89 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink89:setParent(obj.flowPart45);
    obj.dataLink89:setField("destreza");
    obj.dataLink89:setName("dataLink89");

    obj.dataLink90 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink90:setParent(obj.flowPart45);
    obj.dataLink90:setField("constituicao");
    obj.dataLink90:setName("dataLink90");

    obj.dataLink91 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink91:setParent(obj.flowPart45);
    obj.dataLink91:setField("inteligencia");
    obj.dataLink91:setName("dataLink91");

    obj.dataLink92 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink92:setParent(obj.flowPart45);
    obj.dataLink92:setField("sabedoria");
    obj.dataLink92:setName("dataLink92");

    obj.dataLink93 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink93:setParent(obj.flowPart45);
    obj.dataLink93:setField("carisma");
    obj.dataLink93:setName("dataLink93");

    obj.flowLineBreak8 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak8:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak8:setName("flowLineBreak8");

    obj.flowLayout20 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout20:setParent(obj.fraEquipamentoLayout);
    obj.flowLayout20:setAutoHeight(true);
    obj.flowLayout20:setHorzAlign("justify");
    obj.flowLayout20:setAvoidScale(true);
    obj.flowLayout20:setName("flowLayout20");
    obj.flowLayout20:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout20:setMinScaledWidth(300);
    obj.flowLayout20:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout20:setVertAlign("leading");

    obj.flowPart46 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart46:setParent(obj.flowLayout20);
    obj.flowPart46:setMinWidth(420);
    obj.flowPart46:setMaxWidth(1200);
    obj.flowPart46:setHeight(220);
    obj.flowPart46:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart46:setName("flowPart46");
    obj.flowPart46:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart46:setVertAlign("leading");

    obj.label75 = GUI.fromHandle(_obj_newObject("label"));
    obj.label75:setParent(obj.flowPart46);
    obj.label75:setAlign("top");
    obj.label75:setHeight(24);
    obj.label75:setText("Ações Bônus");
    obj.label75:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label75, "fontStyle", "bold");
    obj.label75:setName("label75");
    obj.label75:setFontSize(12);
    obj.label75:setFontColor("#D0D0D0");

    obj.textEditor7 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor7:setParent(obj.flowPart46);
    obj.textEditor7:setAlign("client");
    obj.textEditor7:setField("mobAcoesBonusTexto");
    obj.textEditor7:setMargins({left=8,right=8,top=4,bottom=8});
    obj.textEditor7:setName("textEditor7");
    obj.textEditor7:setTransparent(true);

    obj.flowPart47 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart47:setParent(obj.flowLayout20);
    obj.flowPart47:setMinWidth(420);
    obj.flowPart47:setMaxWidth(1200);
    obj.flowPart47:setHeight(220);
    obj.flowPart47:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart47:setName("flowPart47");
    obj.flowPart47:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart47:setVertAlign("leading");

    obj.label76 = GUI.fromHandle(_obj_newObject("label"));
    obj.label76:setParent(obj.flowPart47);
    obj.label76:setAlign("top");
    obj.label76:setHeight(24);
    obj.label76:setText("Reações");
    obj.label76:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label76, "fontStyle", "bold");
    obj.label76:setName("label76");
    obj.label76:setFontSize(12);
    obj.label76:setFontColor("#D0D0D0");

    obj.textEditor8 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor8:setParent(obj.flowPart47);
    obj.textEditor8:setAlign("client");
    obj.textEditor8:setField("mobReacoesTexto");
    obj.textEditor8:setMargins({left=8,right=8,top=4,bottom=8});
    obj.textEditor8:setName("textEditor8");
    obj.textEditor8:setTransparent(true);

    obj.flowLineBreak9 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak9:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak9:setName("flowLineBreak9");

    obj.flowLayout21 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout21:setParent(obj.fraEquipamentoLayout);
    obj.flowLayout21:setAutoHeight(true);
    obj.flowLayout21:setHorzAlign("justify");
    obj.flowLayout21:setAvoidScale(true);
    obj.flowLayout21:setName("flowLayout21");
    obj.flowLayout21:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout21:setMinScaledWidth(300);
    obj.flowLayout21:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout21:setVertAlign("leading");

    obj.flowPart48 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart48:setParent(obj.flowLayout21);
    obj.flowPart48:setMinWidth(860);
    obj.flowPart48:setMaxWidth(2400);
    obj.flowPart48:setHeight(230);
    obj.flowPart48:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart48:setName("flowPart48");
    obj.flowPart48:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart48:setVertAlign("leading");

    obj.label77 = GUI.fromHandle(_obj_newObject("label"));
    obj.label77:setParent(obj.flowPart48);
    obj.label77:setAlign("top");
    obj.label77:setHeight(24);
    obj.label77:setText("Ações Lendárias");
    obj.label77:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label77, "fontStyle", "bold");
    obj.label77:setName("label77");
    obj.label77:setFontSize(12);
    obj.label77:setFontColor("#D0D0D0");

    obj.layout64 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout64:setParent(obj.flowPart48);
    obj.layout64:setAlign("top");
    obj.layout64:setHeight(32);
    obj.layout64:setMargins({left=8,right=8,top=4});
    obj.layout64:setName("layout64");

    obj.label78 = GUI.fromHandle(_obj_newObject("label"));
    obj.label78:setParent(obj.layout64);
    obj.label78:setAlign("left");
    obj.label78:setWidth(120);
    obj.label78:setText("Contador (Atual/Max)");
    obj.label78:setFontSize(10);
    obj.label78:setName("label78");
    obj.label78:setFontColor("#D0D0D0");

    obj.edit53 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit53:setParent(obj.layout64);
    obj.edit53:setAlign("left");
    obj.edit53:setWidth(44);
    obj.edit53:setField("mobLendariasAtual");
    obj.edit53:setHorzTextAlign("center");
    obj.edit53:setName("edit53");
    obj.edit53:setFontSize(15);
    obj.edit53:setFontColor("white");
    obj.edit53:setTransparent(true);

    obj.label79 = GUI.fromHandle(_obj_newObject("label"));
    obj.label79:setParent(obj.layout64);
    obj.label79:setAlign("left");
    obj.label79:setWidth(14);
    obj.label79:setText("/");
    obj.label79:setHorzTextAlign("center");
    obj.label79:setName("label79");
    obj.label79:setFontSize(12);
    obj.label79:setFontColor("#D0D0D0");

    obj.edit54 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit54:setParent(obj.layout64);
    obj.edit54:setAlign("left");
    obj.edit54:setWidth(44);
    obj.edit54:setField("mobLendariasMax");
    obj.edit54:setHorzTextAlign("center");
    obj.edit54:setName("edit54");
    obj.edit54:setFontSize(15);
    obj.edit54:setFontColor("white");
    obj.edit54:setTransparent(true);

    obj.button16 = GUI.fromHandle(_obj_newObject("button"));
    obj.button16:setParent(obj.layout64);
    obj.button16:setAlign("left");
    obj.button16:setWidth(62);
    obj.button16:setText("-1");
    obj.button16:setMargins({left=8});
    obj.button16:setName("button16");

    obj.button17 = GUI.fromHandle(_obj_newObject("button"));
    obj.button17:setParent(obj.layout64);
    obj.button17:setAlign("left");
    obj.button17:setWidth(62);
    obj.button17:setText("+1");
    obj.button17:setMargins({left=6});
    obj.button17:setName("button17");

    obj.button18 = GUI.fromHandle(_obj_newObject("button"));
    obj.button18:setParent(obj.layout64);
    obj.button18:setAlign("left");
    obj.button18:setWidth(110);
    obj.button18:setText("Usar custo sel.");
    obj.button18:setMargins({left=6});
    obj.button18:setName("button18");

    obj.button19 = GUI.fromHandle(_obj_newObject("button"));
    obj.button19:setParent(obj.layout64);
    obj.button19:setAlign("left");
    obj.button19:setWidth(80);
    obj.button19:setText("Reset");
    obj.button19:setMargins({left=6});
    obj.button19:setName("button19");

    obj.label80 = GUI.fromHandle(_obj_newObject("label"));
    obj.label80:setParent(obj.layout64);
    obj.label80:setAlign("client");
    obj.label80:setText("Defina o custo no campo Custo Lend. de cada ação lendária.");
    obj.label80:setFontSize(10);
    obj.label80:setHorzTextAlign("trailing");
    obj.label80:setName("label80");
    obj.label80:setFontColor("#D0D0D0");

    obj.textEditor9 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor9:setParent(obj.flowPart48);
    obj.textEditor9:setAlign("client");
    obj.textEditor9:setField("mobAcoesLendariasTexto");
    obj.textEditor9:setMargins({left=8,right=8,top=4,bottom=8});
    obj.textEditor9:setName("textEditor9");
    obj.textEditor9:setTransparent(true);

    obj.dataLink94 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink94:setParent(obj.flowPart48);
    obj.dataLink94:setField("mobLendariasMax");
    obj.dataLink94:setDefaultValue("3");
    obj.dataLink94:setName("dataLink94");

    obj.dataLink95 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink95:setParent(obj.flowPart48);
    obj.dataLink95:setField("mobLendariasAtual");
    obj.dataLink95:setName("dataLink95");

    obj.flowLineBreak10 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak10:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak10:setName("flowLineBreak10");

    obj.flowLineBreak11 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak11:setParent(obj.fraEquipamentoLayout);
    obj.flowLineBreak11:setName("flowLineBreak11");

    obj.tab4 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab4:setParent(obj.pgcPrincipal);
    obj.tab4:setTitle("Spellcasting");
    obj.tab4:setName("tab4");

    obj.rectangle4 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle4:setParent(obj.tab4);
    obj.rectangle4:setName("rectangle4");
    obj.rectangle4:setAlign("client");
    obj.rectangle4:setColor("#40000000");
    obj.rectangle4:setXradius(10);
    obj.rectangle4:setYradius(10);

    obj.popMagia = GUI.fromHandle(_obj_newObject("popup"));
    obj.popMagia:setParent(obj.rectangle4);
    obj.popMagia:setName("popMagia");
    obj.popMagia:setAlign("client");
    obj.popMagia:setMargins({left=100,right=100,top=100,bottom=100});
    obj.popMagia:setBackOpacity(0.4);
    obj.popMagia.autoScopeNode = false;

    obj.edit55 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit55:setParent(obj.popMagia);
    obj.edit55:setAlign("top");
    obj.edit55:setField("nome");
    obj.edit55:setTextPrompt("NOME DA MAGIA");
    obj.edit55:setHorzTextAlign("center");
    obj.edit55:setName("edit55");
    obj.edit55:setFontSize(15);
    obj.edit55:setFontColor("white");

    obj.flowLayout22 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout22:setParent(obj.popMagia);
    obj.flowLayout22:setAlign("top");
    obj.flowLayout22:setAutoHeight(true);
    obj.flowLayout22:setMaxControlsPerLine(2);
    obj.flowLayout22:setMargins({bottom=4});
    obj.flowLayout22:setHorzAlign("center");
    obj.flowLayout22:setName("flowLayout22");
    obj.flowLayout22:setVertAlign("leading");

    obj.flowPart49 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart49:setParent(obj.flowLayout22);
    obj.flowPart49:setMinWidth(30);
    obj.flowPart49:setMaxWidth(800);
    obj.flowPart49:setHeight(35);
    obj.flowPart49:setName("flowPart49");
    obj.flowPart49:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart49:setVertAlign("leading");

    obj.label81 = GUI.fromHandle(_obj_newObject("label"));
    obj.label81:setParent(obj.flowPart49);
    obj.label81:setAlign("top");
    obj.label81:setFontSize(10);
    obj.label81:setText("@@DnD5e.spells.formulationTime");
    obj.label81:setHorzTextAlign("center");
    obj.label81:setWordWrap(true);
    obj.label81:setTextTrimming("none");
    obj.label81:setAutoSize(true);
    obj.label81:setName("label81");
    obj.label81:setFontColor("#D0D0D0");

    obj.edit56 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit56:setParent(obj.flowPart49);
    obj.edit56:setAlign("client");
    obj.edit56:setField("tempoDeFormulacao");
    obj.edit56:setHorzTextAlign("center");
    obj.edit56:setFontSize(12);
    obj.edit56:setName("edit56");
    obj.edit56:setFontColor("white");

    obj.flowPart50 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart50:setParent(obj.flowLayout22);
    obj.flowPart50:setMinWidth(30);
    obj.flowPart50:setMaxWidth(800);
    obj.flowPart50:setHeight(35);
    obj.flowPart50:setName("flowPart50");
    obj.flowPart50:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart50:setVertAlign("leading");

    obj.label82 = GUI.fromHandle(_obj_newObject("label"));
    obj.label82:setParent(obj.flowPart50);
    obj.label82:setAlign("top");
    obj.label82:setFontSize(10);
    obj.label82:setText("@@DnD5e.spells.range");
    obj.label82:setHorzTextAlign("center");
    obj.label82:setWordWrap(true);
    obj.label82:setTextTrimming("none");
    obj.label82:setAutoSize(true);
    obj.label82:setName("label82");
    obj.label82:setFontColor("#D0D0D0");

    obj.edit57 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit57:setParent(obj.flowPart50);
    obj.edit57:setAlign("client");
    obj.edit57:setField("alcance");
    obj.edit57:setHorzTextAlign("center");
    obj.edit57:setFontSize(12);
    obj.edit57:setName("edit57");
    obj.edit57:setFontColor("white");

    obj.flowPart51 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart51:setParent(obj.flowLayout22);
    obj.flowPart51:setMinWidth(30);
    obj.flowPart51:setMaxWidth(800);
    obj.flowPart51:setHeight(35);
    obj.flowPart51:setName("flowPart51");
    obj.flowPart51:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart51:setVertAlign("leading");

    obj.label83 = GUI.fromHandle(_obj_newObject("label"));
    obj.label83:setParent(obj.flowPart51);
    obj.label83:setAlign("top");
    obj.label83:setFontSize(10);
    obj.label83:setText("@@DnD5e.spells.component");
    obj.label83:setHorzTextAlign("center");
    obj.label83:setWordWrap(true);
    obj.label83:setTextTrimming("none");
    obj.label83:setAutoSize(true);
    obj.label83:setName("label83");
    obj.label83:setFontColor("#D0D0D0");

    obj.edit58 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit58:setParent(obj.flowPart51);
    obj.edit58:setAlign("client");
    obj.edit58:setField("componentes");
    obj.edit58:setHorzTextAlign("center");
    obj.edit58:setFontSize(12);
    obj.edit58:setName("edit58");
    obj.edit58:setFontColor("white");

    obj.flowPart52 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart52:setParent(obj.flowLayout22);
    obj.flowPart52:setMinWidth(30);
    obj.flowPart52:setMaxWidth(800);
    obj.flowPart52:setHeight(35);
    obj.flowPart52:setName("flowPart52");
    obj.flowPart52:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart52:setVertAlign("leading");

    obj.label84 = GUI.fromHandle(_obj_newObject("label"));
    obj.label84:setParent(obj.flowPart52);
    obj.label84:setAlign("top");
    obj.label84:setFontSize(10);
    obj.label84:setText("@@DnD5e.spells.duration");
    obj.label84:setHorzTextAlign("center");
    obj.label84:setWordWrap(true);
    obj.label84:setTextTrimming("none");
    obj.label84:setAutoSize(true);
    obj.label84:setName("label84");
    obj.label84:setFontColor("#D0D0D0");

    obj.edit59 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit59:setParent(obj.flowPart52);
    obj.edit59:setAlign("client");
    obj.edit59:setField("duracao");
    obj.edit59:setHorzTextAlign("center");
    obj.edit59:setFontSize(12);
    obj.edit59:setName("edit59");
    obj.edit59:setFontColor("white");

    obj.flowPart53 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart53:setParent(obj.flowLayout22);
    obj.flowPart53:setMinWidth(30);
    obj.flowPart53:setMaxWidth(800);
    obj.flowPart53:setHeight(35);
    obj.flowPart53:setName("flowPart53");
    obj.flowPart53:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart53:setVertAlign("leading");

    obj.label85 = GUI.fromHandle(_obj_newObject("label"));
    obj.label85:setParent(obj.flowPart53);
    obj.label85:setAlign("top");
    obj.label85:setFontSize(10);
    obj.label85:setText("@@DnD5e.generic.attack");
    obj.label85:setHorzTextAlign("center");
    obj.label85:setAutoSize(true);
    obj.label85:setName("label85");
    obj.label85:setFontColor("#D0D0D0");

    obj.comboBox6 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox6:setParent(obj.flowPart53);
    obj.comboBox6:setAlign("client");
    obj.comboBox6:setField("ataque");
    obj.comboBox6:setHorzTextAlign("center");
    obj.comboBox6:setFontSize(12);
    obj.comboBox6:setItems({'@@DnD5e.spells.attack.none', '@@DnD5e.spells.attack.melee', '@@DnD5e.spells.attack.ranger'});
    obj.comboBox6:setValues({'Sem ataque', 'Ataque Corpo-a-Corpo', 'Ataque a Distância'});
    obj.comboBox6:setName("comboBox6");

    obj.flowPart54 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart54:setParent(obj.flowLayout22);
    obj.flowPart54:setMinWidth(30);
    obj.flowPart54:setMaxWidth(800);
    obj.flowPart54:setHeight(35);
    obj.flowPart54:setName("flowPart54");
    obj.flowPart54:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart54:setVertAlign("leading");

    obj.label86 = GUI.fromHandle(_obj_newObject("label"));
    obj.label86:setParent(obj.flowPart54);
    obj.label86:setAlign("top");
    obj.label86:setFontSize(10);
    obj.label86:setText("@@DnD5e.savingThrows.title");
    obj.label86:setHorzTextAlign("center");
    obj.label86:setAutoSize(true);
    obj.label86:setName("label86");
    obj.label86:setFontColor("#D0D0D0");

    obj.comboBox7 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox7:setParent(obj.flowPart54);
    obj.comboBox7:setAlign("client");
    obj.comboBox7:setField("resistencia");
    obj.comboBox7:setHorzTextAlign("center");
    obj.comboBox7:setFontSize(12);
    obj.comboBox7:setItems({'@@DnD5e.spells.resistance.none', '@@DnD5e.spells.resistance.str', '@@DnD5e.spells.resistance.dex', '@@DnD5e.spells.resistance.con', '@@DnD5e.spells.resistance.int', '@@DnD5e.spells.resistance.wis', '@@DnD5e.spells.resistance.cha'});
    obj.comboBox7:setValues({'Nenhum', 'Força', 'Destreza', 'Constituição', 'Inteligência', 'Sabedoria', 'Carisma'});
    obj.comboBox7:setName("comboBox7");

    obj.flowPart55 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart55:setParent(obj.flowLayout22);
    obj.flowPart55:setMinWidth(30);
    obj.flowPart55:setMaxWidth(800);
    obj.flowPart55:setHeight(35);
    obj.flowPart55:setName("flowPart55");
    obj.flowPart55:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart55:setVertAlign("leading");

    obj.label87 = GUI.fromHandle(_obj_newObject("label"));
    obj.label87:setParent(obj.flowPart55);
    obj.label87:setAlign("top");
    obj.label87:setFontSize(10);
    obj.label87:setText("");
    obj.label87:setHorzTextAlign("center");
    obj.label87:setAutoSize(true);
    obj.label87:setName("label87");
    obj.label87:setFontColor("#D0D0D0");

    obj.comboBox8 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox8:setParent(obj.flowPart55);
    obj.comboBox8:setAlign("client");
    obj.comboBox8:setField("damageType");
    obj.comboBox8:setHorzTextAlign("center");
    obj.comboBox8:setFontSize(12);
    obj.comboBox8:setItems({'@@DnD5e.spells.damage.none', '@@DnD5e.spells.damage'});
    obj.comboBox8:setValues({'Sem dano', 'Dano'});
    obj.comboBox8:setName("comboBox8");

    obj.flowPart56 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart56:setParent(obj.flowLayout22);
    obj.flowPart56:setMinWidth(30);
    obj.flowPart56:setMaxWidth(800);
    obj.flowPart56:setHeight(35);
    obj.flowPart56:setName("flowPart56");
    obj.flowPart56:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart56:setVertAlign("leading");

    obj.label88 = GUI.fromHandle(_obj_newObject("label"));
    obj.label88:setParent(obj.flowPart56);
    obj.label88:setAlign("top");
    obj.label88:setFontSize(10);
    obj.label88:setText("@@DnD5e.spells.damage");
    obj.label88:setHorzTextAlign("center");
    obj.label88:setWordWrap(true);
    obj.label88:setTextTrimming("none");
    obj.label88:setAutoSize(true);
    obj.label88:setName("label88");
    obj.label88:setFontColor("#D0D0D0");

    obj.edit60 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit60:setParent(obj.flowPart56);
    obj.edit60:setAlign("client");
    obj.edit60:setField("damageValue");
    obj.edit60:setHorzTextAlign("center");
    obj.edit60:setFontSize(12);
    obj.edit60:setName("edit60");
    obj.edit60:setFontColor("white");

    obj.textEditor10 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor10:setParent(obj.popMagia);
    obj.textEditor10:setAlign("client");
    obj.textEditor10:setField("descricao");
    obj.textEditor10:setName("textEditor10");

    obj.scrollBox4 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox4:setParent(obj.rectangle4);
    obj.scrollBox4:setAlign("client");
    obj.scrollBox4:setName("scrollBox4");

    obj.fraMagiasLayoutSpc = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraMagiasLayoutSpc:setParent(obj.scrollBox4);
    obj.fraMagiasLayoutSpc:setAlign("top");
    obj.fraMagiasLayoutSpc:setHeight(500);
    obj.fraMagiasLayoutSpc:setMargins({left=10, right=10, top=10});
    obj.fraMagiasLayoutSpc:setAutoHeight(true);
    obj.fraMagiasLayoutSpc:setHorzAlign("center");
    obj.fraMagiasLayoutSpc:setLineSpacing(3);
    obj.fraMagiasLayoutSpc:setName("fraMagiasLayoutSpc");
    obj.fraMagiasLayoutSpc:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.fraMagiasLayoutSpc:setMinScaledWidth(300);
    obj.fraMagiasLayoutSpc:setVertAlign("leading");

    obj.flowLayout23 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout23:setParent(obj.fraMagiasLayoutSpc);
    obj.flowLayout23:setAutoHeight(true);
    obj.flowLayout23:setMinScaledWidth(290);
    obj.flowLayout23:setHorzAlign("center");
    obj.flowLayout23:setName("flowLayout23");
    obj.flowLayout23:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.flowLayout23:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout23:setVertAlign("leading");

    obj.flowPart57 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart57:setParent(obj.flowLayout23);
    obj.flowPart57:setMinWidth(320);
    obj.flowPart57:setMaxWidth(1600);
    obj.flowPart57:setFrameStyle("frames/banner/magicGroup.xml");
    obj.flowPart57:setHeight(175);
    obj.flowPart57:setVertAlign("center");
    obj.flowPart57:setAvoidScale(true);
    obj.flowPart57:setName("flowPart57");
    obj.flowPart57:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.flowPart57:setMinScaledWidth(300);
    obj.flowPart57:setMargins({left=1, right=1, top=2, bottom=2});

    obj.layout65 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout65:setParent(obj.flowPart57);
    obj.layout65:setAlign("client");
    obj.layout65:setName("layout65");

    obj.comboBox9 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox9:setParent(obj.layout65);
    obj.comboBox9:setField("magias.classeConjuradora");
    obj.comboBox9:setFontSize(17);
    obj.comboBox9:setAlign("client");
    obj.comboBox9:setItems({'', 'Artificer', 'Bard', 'Cleric', 'Druid', 'Paladin', 'Ranger', 'Sorcerer', 'Warlock', 'Wizard'});
    obj.comboBox9:setValues({'', 'Artificer', 'Bard', 'Cleric', 'Druid', 'Paladin', 'Ranger', 'Sorcerer', 'Warlock', 'Wizard'});
    obj.comboBox9:setName("comboBox9");
    obj.comboBox9:setTransparent(true);

    obj.label89 = GUI.fromHandle(_obj_newObject("label"));
    obj.label89:setParent(obj.layout65);
    obj.label89:setAlign("bottom");
    obj.label89:setText("@@DnD5e.spells.spellcasterClass");
    obj.label89:setAutoSize(true);
    obj.label89:setMargins({left=3});
    obj.label89:setName("label89");
    obj.label89:setFontSize(12);
    obj.label89:setFontColor("#D0D0D0");

    obj.fraUpperGridMagiasSpc = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraUpperGridMagiasSpc:setParent(obj.flowLayout23);
    obj.fraUpperGridMagiasSpc:setMinWidth(320);
    obj.fraUpperGridMagiasSpc:setMaxWidth(1600);
    obj.fraUpperGridMagiasSpc:setName("fraUpperGridMagiasSpc");
    obj.fraUpperGridMagiasSpc:setAvoidScale(true);
    obj.fraUpperGridMagiasSpc:setFrameStyle("frames/upperInfoGrid/frame.xml");
    obj.fraUpperGridMagiasSpc:setAutoHeight(true);
    obj.fraUpperGridMagiasSpc:setVertAlign("trailing");
    obj.fraUpperGridMagiasSpc:setMaxControlsPerLine(3);
    obj.fraUpperGridMagiasSpc:setHorzAlign("center");
    obj.fraUpperGridMagiasSpc:setLineSpacing(8);
    obj.fraUpperGridMagiasSpc:setStepSizes({310, 360, 420});
    obj.fraUpperGridMagiasSpc:setMinScaledWidth(300);
    obj.fraUpperGridMagiasSpc:setMaxScaledWidth(340);
    obj.fraUpperGridMagiasSpc:setMargins({left=1, right=1, top=2, bottom=2});

    obj.upperGridMagicBox1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox1:setParent(obj.fraUpperGridMagiasSpc);
    obj.upperGridMagicBox1:setHeight(50);
    obj.upperGridMagicBox1:setMinScaledWidth(145);
    obj.upperGridMagicBox1:setMinWidth(145);
    obj.upperGridMagicBox1:setMaxWidth(160);
    obj.upperGridMagicBox1:setMaxScaledWidth(160);
    obj.upperGridMagicBox1:setAvoidScale(true);
    obj.upperGridMagicBox1:setName("upperGridMagicBox1");
    obj.upperGridMagicBox1:setVertAlign("leading");
    obj.upperGridMagicBox1:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox1, "_RecalcSize", 
						function ()
							self.upperGridMagicBox1:setHeight(self.panupperGridMagicBox1:getHeight() + self.labupperGridMagicBox1:getHeight());
						end);														
				


    obj.panupperGridMagicBox1 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox1:setParent(obj.upperGridMagicBox1);
    obj.panupperGridMagicBox1:setName("panupperGridMagicBox1");
    obj.panupperGridMagicBox1:setAlign("top");
    obj.panupperGridMagicBox1:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox1:setHeight(60);

    obj.cmbupperGridMagicBox1 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.cmbupperGridMagicBox1:setParent(obj.panupperGridMagicBox1);
    obj.cmbupperGridMagicBox1:setName("cmbupperGridMagicBox1");
    obj.cmbupperGridMagicBox1:setFrameRegion("ContentRegion");
    obj.cmbupperGridMagicBox1:setField("magias.habilidadeDeConjuracao");
    obj.cmbupperGridMagicBox1:setItems({'', 'FORÇA', 'DESTREZA', 'CONSTITUIÇÃO', '@@DnD5e.frente.box.intelligence', '@@DnD5e.frente.box.wisdom', '@@DnD5e.frente.box.charisma'});
    obj.cmbupperGridMagicBox1:setValues({'', 'for', 'des', 'con', 'int', 'sab', 'car'});
    obj.cmbupperGridMagicBox1:setHorzTextAlign("center");
    obj.cmbupperGridMagicBox1:setVertTextAlign("center");
    obj.cmbupperGridMagicBox1:setFontSize(13);
    obj.cmbupperGridMagicBox1:setTransparent(true);

    obj.labupperGridMagicBox1 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox1:setParent(obj.upperGridMagicBox1);
    obj.labupperGridMagicBox1:setName("labupperGridMagicBox1");
    obj.labupperGridMagicBox1:setAlign("top");
    obj.labupperGridMagicBox1:setAutoSize(true);
    obj.labupperGridMagicBox1:setText("@@DnD5e.spells.spellcasterAbility");
    obj.labupperGridMagicBox1:setHorzTextAlign("center");
    obj.labupperGridMagicBox1:setVertTextAlign("leading");
    obj.labupperGridMagicBox1:setWordWrap(true);
    obj.labupperGridMagicBox1:setTextTrimming("none");
    obj.labupperGridMagicBox1:setFontSize(12);
    obj.labupperGridMagicBox1:setFontColor("#D0D0D0");

self.upperGridMagicBox1._RecalcSize();	


    obj.upperGridMagicBox2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox2:setParent(obj.fraUpperGridMagiasSpc);
    obj.upperGridMagicBox2:setHeight(50);
    obj.upperGridMagicBox2:setMinScaledWidth(100);
    obj.upperGridMagicBox2:setMinWidth(100);
    obj.upperGridMagicBox2:setMaxWidth(160);
    obj.upperGridMagicBox2:setMaxScaledWidth(160);
    obj.upperGridMagicBox2:setAvoidScale(true);
    obj.upperGridMagicBox2:setName("upperGridMagicBox2");
    obj.upperGridMagicBox2:setVertAlign("leading");
    obj.upperGridMagicBox2:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox2, "_RecalcSize", 
						function ()
							self.upperGridMagicBox2:setHeight(self.panupperGridMagicBox2:getHeight() + self.labupperGridMagicBox2:getHeight());
						end);														
				


    obj.panupperGridMagicBox2 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox2:setParent(obj.upperGridMagicBox2);
    obj.panupperGridMagicBox2:setName("panupperGridMagicBox2");
    obj.panupperGridMagicBox2:setAlign("top");
    obj.panupperGridMagicBox2:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox2:setHeight(60);

    obj.labupperGridMagicBox2val = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox2val:setParent(obj.panupperGridMagicBox2);
    obj.labupperGridMagicBox2val:setName("labupperGridMagicBox2val");
    obj.labupperGridMagicBox2val:setFrameRegion("ContentRegion");
    obj.labupperGridMagicBox2val:setField("magias.cdDaMagia");
    obj.labupperGridMagicBox2val:setFontSize(22);
    obj.labupperGridMagicBox2val:setVertTextAlign("center");
    obj.labupperGridMagicBox2val:setHorzTextAlign("center");
    obj.labupperGridMagicBox2val:setFontColor("white");

    obj.labupperGridMagicBox2 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox2:setParent(obj.upperGridMagicBox2);
    obj.labupperGridMagicBox2:setName("labupperGridMagicBox2");
    obj.labupperGridMagicBox2:setAlign("top");
    obj.labupperGridMagicBox2:setAutoSize(true);
    obj.labupperGridMagicBox2:setText("@@DnD5e.spells.spellSaveDC");
    obj.labupperGridMagicBox2:setHorzTextAlign("center");
    obj.labupperGridMagicBox2:setVertTextAlign("leading");
    obj.labupperGridMagicBox2:setWordWrap(true);
    obj.labupperGridMagicBox2:setTextTrimming("none");
    obj.labupperGridMagicBox2:setFontSize(12);
    obj.labupperGridMagicBox2:setFontColor("#D0D0D0");

self.upperGridMagicBox2._RecalcSize();	


    obj.upperGridMagicBox3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox3:setParent(obj.fraUpperGridMagiasSpc);
    obj.upperGridMagicBox3:setHeight(50);
    obj.upperGridMagicBox3:setMinScaledWidth(100);
    obj.upperGridMagicBox3:setMinWidth(100);
    obj.upperGridMagicBox3:setMaxWidth(160);
    obj.upperGridMagicBox3:setMaxScaledWidth(160);
    obj.upperGridMagicBox3:setAvoidScale(true);
    obj.upperGridMagicBox3:setName("upperGridMagicBox3");
    obj.upperGridMagicBox3:setVertAlign("leading");
    obj.upperGridMagicBox3:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox3, "_RecalcSize", 
						function ()
							self.upperGridMagicBox3:setHeight(self.panupperGridMagicBox3:getHeight() + self.labupperGridMagicBox3:getHeight());
						end);														
				


    obj.panupperGridMagicBox3 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox3:setParent(obj.upperGridMagicBox3);
    obj.panupperGridMagicBox3:setName("panupperGridMagicBox3");
    obj.panupperGridMagicBox3:setAlign("top");
    obj.panupperGridMagicBox3:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox3:setHeight(60);

    obj.labupperGridMagicBox3val = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox3val:setParent(obj.panupperGridMagicBox3);
    obj.labupperGridMagicBox3val:setName("labupperGridMagicBox3val");
    obj.labupperGridMagicBox3val:setFrameRegion("ContentRegion");
    obj.labupperGridMagicBox3val:setField("magias.bonusAtaqueSTR");
    obj.labupperGridMagicBox3val:setFontSize(22);
    obj.labupperGridMagicBox3val:setVertTextAlign("center");
    obj.labupperGridMagicBox3val:setHorzTextAlign("center");
    obj.labupperGridMagicBox3val:setFontColor("white");

    obj.labupperGridMagicBox3 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox3:setParent(obj.upperGridMagicBox3);
    obj.labupperGridMagicBox3:setName("labupperGridMagicBox3");
    obj.labupperGridMagicBox3:setAlign("top");
    obj.labupperGridMagicBox3:setAutoSize(true);
    obj.labupperGridMagicBox3:setText("@@DnD5e.spells.spellAttackBonus");
    obj.labupperGridMagicBox3:setHorzTextAlign("center");
    obj.labupperGridMagicBox3:setVertTextAlign("leading");
    obj.labupperGridMagicBox3:setWordWrap(true);
    obj.labupperGridMagicBox3:setTextTrimming("none");
    obj.labupperGridMagicBox3:setFontSize(12);
    obj.labupperGridMagicBox3:setFontColor("#D0D0D0");

self.upperGridMagicBox3._RecalcSize();	


    obj.dataLink96 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink96:setParent(obj.fraMagiasLayoutSpc);
    obj.dataLink96:setFields({'magias.habilidadeDeConjuracao', 'atributos.modForca', 'atributos.modDestreza', 'atributos.modConstituicao', 'atributos.modInteligencia', 'atributos.modSabedoria', 'atributos.modCarisma', 'bonusProficiencia'});
    obj.dataLink96:setName("dataLink96");

    obj.flowLineBreak12 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak12:setParent(obj.fraMagiasLayoutSpc);
    obj.flowLineBreak12:setName("flowLineBreak12");

    obj.flowLayout24 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout24:setParent(obj.fraMagiasLayoutSpc);
    obj.flowLayout24:setAutoHeight(true);
    obj.flowLayout24:setMaxColumns(3);
    obj.flowLayout24:setHorzAlign("center");
    obj.flowLayout24:setOrientation("vertical");
    obj.flowLayout24:setName("flowLayout24");
    obj.flowLayout24:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.flowLayout24:setMinScaledWidth(300);
    obj.flowLayout24:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout24:setVertAlign("leading");

    obj.flowLayout25 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout25:setParent(obj.flowLayout24);
    obj.flowLayout25:setHeight(100);
    obj.flowLayout25:setAvoidScale(true);
    obj.flowLayout25:setMaxControlsPerLine(1);
    obj.flowLayout25:setAutoHeight(true);
    obj.flowLayout25:setName("flowLayout25");
    obj.flowLayout25:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout25:setStepSizes({310, 360, 420, 600});
    obj.flowLayout25:setMinScaledWidth(300);
    obj.flowLayout25:setMaxScaledWidth(600);
    obj.flowLayout25:setVertAlign("leading");

    obj.flowPart58 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart58:setParent(obj.flowLayout25);
    obj.flowPart58:setFrameStyle("frames/magicHeader/header0.xml");
    obj.flowPart58:setName("flowPart58");
    obj.flowPart58:setAvoidScale(true);
    obj.flowPart58:setMinScaledWidth(280);
    obj.flowPart58:setMinWidth(300);
    obj.flowPart58:setMaxWidth(600);
    obj.flowPart58:setHeight(80);
    obj.flowPart58:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart58:setVertAlign("leading");

    obj.label90 = GUI.fromHandle(_obj_newObject("label"));
    obj.label90:setParent(obj.flowPart58);
    obj.label90:setFrameRegion("RegiaoSmallTitulo");
    obj.label90:setText("0");
    obj.label90:setName("label90");
    obj.label90:setHorzTextAlign("center");
    obj.label90:setVertTextAlign("center");
    obj.label90:setFontSize(18);
    obj.label90:setFontColor("white");

    obj.label91 = GUI.fromHandle(_obj_newObject("label"));
    obj.label91:setParent(obj.flowPart58);
    obj.label91:setFrameRegion("RegiaoConteudo");
    obj.label91:setText("@@DnD5e.spells.cantrip");
    obj.label91:setFontSize(15);
    obj.label91:setHorzTextAlign("center");
    obj.label91:setVertTextAlign("center");
    obj.label91:setName("label91");
    obj.label91:setFontColor("white");

    obj.flwMagicRecordListSpc1 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc1:setParent(obj.flowLayout25);
    obj.flwMagicRecordListSpc1:setMinWidth(300);
    obj.flwMagicRecordListSpc1:setMaxWidth(600);
    obj.flwMagicRecordListSpc1:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc1:setName("flwMagicRecordListSpc1");
    obj.flwMagicRecordListSpc1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc1:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc1, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc1.height = self.rclflwMagicRecordListSpc1.height + self.layBottomflwMagicRecordListSpc1.height +
							self.flwMagicRecordListSpc1.padding.top + self.flwMagicRecordListSpc1.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc1 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc1:setParent(obj.flwMagicRecordListSpc1);
    obj.rclflwMagicRecordListSpc1:setName("rclflwMagicRecordListSpc1");
    obj.rclflwMagicRecordListSpc1:setAlign("top");
    obj.rclflwMagicRecordListSpc1:setField("magias.magias.nivel0");
    obj.rclflwMagicRecordListSpc1:setTemplateForm("frmMagiaItemSemCheckbox");
    obj.rclflwMagicRecordListSpc1:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc1:setMinHeight(5);
    obj.rclflwMagicRecordListSpc1:setHitTest(false);
    obj.rclflwMagicRecordListSpc1:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc1:setParent(obj.flwMagicRecordListSpc1);
    obj.layBottomflwMagicRecordListSpc1:setName("layBottomflwMagicRecordListSpc1");
    obj.layBottomflwMagicRecordListSpc1:setAlign("top");
    obj.layBottomflwMagicRecordListSpc1:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc1 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc1:setParent(obj.layBottomflwMagicRecordListSpc1);
    obj.btnNovoflwMagicRecordListSpc1:setName("btnNovoflwMagicRecordListSpc1");
    obj.btnNovoflwMagicRecordListSpc1:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc1:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc1:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc1:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc1._recalcHeight();


    obj.flowLayout26 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout26:setParent(obj.flowLayout24);
    obj.flowLayout26:setHeight(100);
    obj.flowLayout26:setAvoidScale(true);
    obj.flowLayout26:setMaxControlsPerLine(1);
    obj.flowLayout26:setAutoHeight(true);
    obj.flowLayout26:setName("flowLayout26");
    obj.flowLayout26:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout26:setStepSizes({310, 360, 420, 600});
    obj.flowLayout26:setMinScaledWidth(300);
    obj.flowLayout26:setMaxScaledWidth(600);
    obj.flowLayout26:setVertAlign("leading");

    obj.flowPart59 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart59:setParent(obj.flowLayout26);
    obj.flowPart59:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart59:setName("flowPart59");
    obj.flowPart59:setAvoidScale(true);
    obj.flowPart59:setMinScaledWidth(280);
    obj.flowPart59:setMinWidth(300);
    obj.flowPart59:setMaxWidth(600);
    obj.flowPart59:setHeight(80);
    obj.flowPart59:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart59:setVertAlign("leading");

    obj.label92 = GUI.fromHandle(_obj_newObject("label"));
    obj.label92:setParent(obj.flowPart59);
    obj.label92:setFrameRegion("RegiaoSmallTitulo");
    obj.label92:setText("1");
    obj.label92:setName("label92");
    obj.label92:setHorzTextAlign("center");
    obj.label92:setVertTextAlign("center");
    obj.label92:setFontSize(18);
    obj.label92:setFontColor("white");

    obj.edit61 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit61:setParent(obj.flowPart59);
    obj.edit61:setFrameRegion("RegiaoConteudo1");
    obj.edit61:setField("magias.espacosTotais1");
    obj.edit61:setName("edit61");
    obj.edit61:setHorzTextAlign("center");
    obj.edit61:setVertTextAlign("center");
    obj.edit61:setFontSize(18);
    obj.edit61:setTransparent(true);
    obj.edit61:setFontColor("white");

    obj.dataLink97 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink97:setParent(obj.flowPart59);
    obj.dataLink97:setField("magias.espacosTotais1");
    obj.dataLink97:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink97:setName("dataLink97");

    obj.edit62 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit62:setParent(obj.flowPart59);
    obj.edit62:setFrameRegion("RegiaoConteudo2");
    obj.edit62:setField("magias.espacosGastos1");
    obj.edit62:setName("edit62");
    obj.edit62:setHorzTextAlign("center");
    obj.edit62:setVertTextAlign("center");
    obj.edit62:setFontSize(18);
    obj.edit62:setTransparent(true);
    obj.edit62:setFontColor("white");

    obj.dataLink98 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink98:setParent(obj.flowPart59);
    obj.dataLink98:setField("magias.espacosGastos1");
    obj.dataLink98:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink98:setName("dataLink98");

    obj.flwMagicRecordListSpc2 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc2:setParent(obj.flowLayout26);
    obj.flwMagicRecordListSpc2:setMinWidth(300);
    obj.flwMagicRecordListSpc2:setMaxWidth(600);
    obj.flwMagicRecordListSpc2:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc2:setName("flwMagicRecordListSpc2");
    obj.flwMagicRecordListSpc2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc2:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc2, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc2.height = self.rclflwMagicRecordListSpc2.height + self.layBottomflwMagicRecordListSpc2.height +
							self.flwMagicRecordListSpc2.padding.top + self.flwMagicRecordListSpc2.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc2 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc2:setParent(obj.flwMagicRecordListSpc2);
    obj.rclflwMagicRecordListSpc2:setName("rclflwMagicRecordListSpc2");
    obj.rclflwMagicRecordListSpc2:setAlign("top");
    obj.rclflwMagicRecordListSpc2:setField("magias.magias.nivel1");
    obj.rclflwMagicRecordListSpc2:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc2:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc2:setMinHeight(5);
    obj.rclflwMagicRecordListSpc2:setHitTest(false);
    obj.rclflwMagicRecordListSpc2:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc2:setParent(obj.flwMagicRecordListSpc2);
    obj.layBottomflwMagicRecordListSpc2:setName("layBottomflwMagicRecordListSpc2");
    obj.layBottomflwMagicRecordListSpc2:setAlign("top");
    obj.layBottomflwMagicRecordListSpc2:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc2 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc2:setParent(obj.layBottomflwMagicRecordListSpc2);
    obj.btnNovoflwMagicRecordListSpc2:setName("btnNovoflwMagicRecordListSpc2");
    obj.btnNovoflwMagicRecordListSpc2:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc2:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc2:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc2:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc2._recalcHeight();


    obj.flowLayout27 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout27:setParent(obj.flowLayout24);
    obj.flowLayout27:setHeight(100);
    obj.flowLayout27:setAvoidScale(true);
    obj.flowLayout27:setMaxControlsPerLine(1);
    obj.flowLayout27:setAutoHeight(true);
    obj.flowLayout27:setName("flowLayout27");
    obj.flowLayout27:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout27:setStepSizes({310, 360, 420, 600});
    obj.flowLayout27:setMinScaledWidth(300);
    obj.flowLayout27:setMaxScaledWidth(600);
    obj.flowLayout27:setVertAlign("leading");

    obj.flowPart60 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart60:setParent(obj.flowLayout27);
    obj.flowPart60:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart60:setName("flowPart60");
    obj.flowPart60:setAvoidScale(true);
    obj.flowPart60:setMinScaledWidth(280);
    obj.flowPart60:setMinWidth(300);
    obj.flowPart60:setMaxWidth(600);
    obj.flowPart60:setHeight(80);
    obj.flowPart60:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart60:setVertAlign("leading");

    obj.label93 = GUI.fromHandle(_obj_newObject("label"));
    obj.label93:setParent(obj.flowPart60);
    obj.label93:setFrameRegion("RegiaoSmallTitulo");
    obj.label93:setText("2");
    obj.label93:setName("label93");
    obj.label93:setHorzTextAlign("center");
    obj.label93:setVertTextAlign("center");
    obj.label93:setFontSize(18);
    obj.label93:setFontColor("white");

    obj.edit63 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit63:setParent(obj.flowPart60);
    obj.edit63:setFrameRegion("RegiaoConteudo1");
    obj.edit63:setField("magias.espacosTotais2");
    obj.edit63:setName("edit63");
    obj.edit63:setHorzTextAlign("center");
    obj.edit63:setVertTextAlign("center");
    obj.edit63:setFontSize(18);
    obj.edit63:setTransparent(true);
    obj.edit63:setFontColor("white");

    obj.dataLink99 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink99:setParent(obj.flowPart60);
    obj.dataLink99:setField("magias.espacosTotais2");
    obj.dataLink99:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink99:setName("dataLink99");

    obj.edit64 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit64:setParent(obj.flowPart60);
    obj.edit64:setFrameRegion("RegiaoConteudo2");
    obj.edit64:setField("magias.espacosGastos2");
    obj.edit64:setName("edit64");
    obj.edit64:setHorzTextAlign("center");
    obj.edit64:setVertTextAlign("center");
    obj.edit64:setFontSize(18);
    obj.edit64:setTransparent(true);
    obj.edit64:setFontColor("white");

    obj.dataLink100 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink100:setParent(obj.flowPart60);
    obj.dataLink100:setField("magias.espacosGastos2");
    obj.dataLink100:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink100:setName("dataLink100");

    obj.flwMagicRecordListSpc3 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc3:setParent(obj.flowLayout27);
    obj.flwMagicRecordListSpc3:setMinWidth(300);
    obj.flwMagicRecordListSpc3:setMaxWidth(600);
    obj.flwMagicRecordListSpc3:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc3:setName("flwMagicRecordListSpc3");
    obj.flwMagicRecordListSpc3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc3:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc3, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc3.height = self.rclflwMagicRecordListSpc3.height + self.layBottomflwMagicRecordListSpc3.height +
							self.flwMagicRecordListSpc3.padding.top + self.flwMagicRecordListSpc3.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc3 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc3:setParent(obj.flwMagicRecordListSpc3);
    obj.rclflwMagicRecordListSpc3:setName("rclflwMagicRecordListSpc3");
    obj.rclflwMagicRecordListSpc3:setAlign("top");
    obj.rclflwMagicRecordListSpc3:setField("magias.magias.nivel2");
    obj.rclflwMagicRecordListSpc3:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc3:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc3:setMinHeight(5);
    obj.rclflwMagicRecordListSpc3:setHitTest(false);
    obj.rclflwMagicRecordListSpc3:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc3 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc3:setParent(obj.flwMagicRecordListSpc3);
    obj.layBottomflwMagicRecordListSpc3:setName("layBottomflwMagicRecordListSpc3");
    obj.layBottomflwMagicRecordListSpc3:setAlign("top");
    obj.layBottomflwMagicRecordListSpc3:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc3 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc3:setParent(obj.layBottomflwMagicRecordListSpc3);
    obj.btnNovoflwMagicRecordListSpc3:setName("btnNovoflwMagicRecordListSpc3");
    obj.btnNovoflwMagicRecordListSpc3:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc3:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc3:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc3:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc3._recalcHeight();


    obj.flowLayout28 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout28:setParent(obj.flowLayout24);
    obj.flowLayout28:setHeight(100);
    obj.flowLayout28:setAvoidScale(true);
    obj.flowLayout28:setMaxControlsPerLine(1);
    obj.flowLayout28:setAutoHeight(true);
    obj.flowLayout28:setName("flowLayout28");
    obj.flowLayout28:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout28:setStepSizes({310, 360, 420, 600});
    obj.flowLayout28:setMinScaledWidth(300);
    obj.flowLayout28:setMaxScaledWidth(600);
    obj.flowLayout28:setVertAlign("leading");

    obj.flowPart61 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart61:setParent(obj.flowLayout28);
    obj.flowPart61:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart61:setName("flowPart61");
    obj.flowPart61:setAvoidScale(true);
    obj.flowPart61:setMinScaledWidth(280);
    obj.flowPart61:setMinWidth(300);
    obj.flowPart61:setMaxWidth(600);
    obj.flowPart61:setHeight(80);
    obj.flowPart61:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart61:setVertAlign("leading");

    obj.label94 = GUI.fromHandle(_obj_newObject("label"));
    obj.label94:setParent(obj.flowPart61);
    obj.label94:setFrameRegion("RegiaoSmallTitulo");
    obj.label94:setText("3");
    obj.label94:setName("label94");
    obj.label94:setHorzTextAlign("center");
    obj.label94:setVertTextAlign("center");
    obj.label94:setFontSize(18);
    obj.label94:setFontColor("white");

    obj.edit65 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit65:setParent(obj.flowPart61);
    obj.edit65:setFrameRegion("RegiaoConteudo1");
    obj.edit65:setField("magias.espacosTotais3");
    obj.edit65:setName("edit65");
    obj.edit65:setHorzTextAlign("center");
    obj.edit65:setVertTextAlign("center");
    obj.edit65:setFontSize(18);
    obj.edit65:setTransparent(true);
    obj.edit65:setFontColor("white");

    obj.dataLink101 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink101:setParent(obj.flowPart61);
    obj.dataLink101:setField("magias.espacosTotais3");
    obj.dataLink101:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink101:setName("dataLink101");

    obj.edit66 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit66:setParent(obj.flowPart61);
    obj.edit66:setFrameRegion("RegiaoConteudo2");
    obj.edit66:setField("magias.espacosGastos3");
    obj.edit66:setName("edit66");
    obj.edit66:setHorzTextAlign("center");
    obj.edit66:setVertTextAlign("center");
    obj.edit66:setFontSize(18);
    obj.edit66:setTransparent(true);
    obj.edit66:setFontColor("white");

    obj.dataLink102 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink102:setParent(obj.flowPart61);
    obj.dataLink102:setField("magias.espacosGastos3");
    obj.dataLink102:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink102:setName("dataLink102");

    obj.flwMagicRecordListSpc4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc4:setParent(obj.flowLayout28);
    obj.flwMagicRecordListSpc4:setMinWidth(300);
    obj.flwMagicRecordListSpc4:setMaxWidth(600);
    obj.flwMagicRecordListSpc4:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc4:setName("flwMagicRecordListSpc4");
    obj.flwMagicRecordListSpc4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc4:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc4, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc4.height = self.rclflwMagicRecordListSpc4.height + self.layBottomflwMagicRecordListSpc4.height +
							self.flwMagicRecordListSpc4.padding.top + self.flwMagicRecordListSpc4.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc4 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc4:setParent(obj.flwMagicRecordListSpc4);
    obj.rclflwMagicRecordListSpc4:setName("rclflwMagicRecordListSpc4");
    obj.rclflwMagicRecordListSpc4:setAlign("top");
    obj.rclflwMagicRecordListSpc4:setField("magias.magias.nivel3");
    obj.rclflwMagicRecordListSpc4:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc4:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc4:setMinHeight(5);
    obj.rclflwMagicRecordListSpc4:setHitTest(false);
    obj.rclflwMagicRecordListSpc4:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc4 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc4:setParent(obj.flwMagicRecordListSpc4);
    obj.layBottomflwMagicRecordListSpc4:setName("layBottomflwMagicRecordListSpc4");
    obj.layBottomflwMagicRecordListSpc4:setAlign("top");
    obj.layBottomflwMagicRecordListSpc4:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc4 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc4:setParent(obj.layBottomflwMagicRecordListSpc4);
    obj.btnNovoflwMagicRecordListSpc4:setName("btnNovoflwMagicRecordListSpc4");
    obj.btnNovoflwMagicRecordListSpc4:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc4:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc4:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc4:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc4._recalcHeight();


    obj.flowLayout29 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout29:setParent(obj.flowLayout24);
    obj.flowLayout29:setHeight(100);
    obj.flowLayout29:setAvoidScale(true);
    obj.flowLayout29:setMaxControlsPerLine(1);
    obj.flowLayout29:setAutoHeight(true);
    obj.flowLayout29:setName("flowLayout29");
    obj.flowLayout29:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout29:setStepSizes({310, 360, 420, 600});
    obj.flowLayout29:setMinScaledWidth(300);
    obj.flowLayout29:setMaxScaledWidth(600);
    obj.flowLayout29:setVertAlign("leading");

    obj.flowPart62 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart62:setParent(obj.flowLayout29);
    obj.flowPart62:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart62:setName("flowPart62");
    obj.flowPart62:setAvoidScale(true);
    obj.flowPart62:setMinScaledWidth(280);
    obj.flowPart62:setMinWidth(300);
    obj.flowPart62:setMaxWidth(600);
    obj.flowPart62:setHeight(80);
    obj.flowPart62:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart62:setVertAlign("leading");

    obj.label95 = GUI.fromHandle(_obj_newObject("label"));
    obj.label95:setParent(obj.flowPart62);
    obj.label95:setFrameRegion("RegiaoSmallTitulo");
    obj.label95:setText("4");
    obj.label95:setName("label95");
    obj.label95:setHorzTextAlign("center");
    obj.label95:setVertTextAlign("center");
    obj.label95:setFontSize(18);
    obj.label95:setFontColor("white");

    obj.edit67 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit67:setParent(obj.flowPart62);
    obj.edit67:setFrameRegion("RegiaoConteudo1");
    obj.edit67:setField("magias.espacosTotais4");
    obj.edit67:setName("edit67");
    obj.edit67:setHorzTextAlign("center");
    obj.edit67:setVertTextAlign("center");
    obj.edit67:setFontSize(18);
    obj.edit67:setTransparent(true);
    obj.edit67:setFontColor("white");

    obj.dataLink103 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink103:setParent(obj.flowPart62);
    obj.dataLink103:setField("magias.espacosTotais4");
    obj.dataLink103:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink103:setName("dataLink103");

    obj.edit68 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit68:setParent(obj.flowPart62);
    obj.edit68:setFrameRegion("RegiaoConteudo2");
    obj.edit68:setField("magias.espacosGastos4");
    obj.edit68:setName("edit68");
    obj.edit68:setHorzTextAlign("center");
    obj.edit68:setVertTextAlign("center");
    obj.edit68:setFontSize(18);
    obj.edit68:setTransparent(true);
    obj.edit68:setFontColor("white");

    obj.dataLink104 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink104:setParent(obj.flowPart62);
    obj.dataLink104:setField("magias.espacosGastos4");
    obj.dataLink104:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink104:setName("dataLink104");

    obj.flwMagicRecordListSpc5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc5:setParent(obj.flowLayout29);
    obj.flwMagicRecordListSpc5:setMinWidth(300);
    obj.flwMagicRecordListSpc5:setMaxWidth(600);
    obj.flwMagicRecordListSpc5:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc5:setName("flwMagicRecordListSpc5");
    obj.flwMagicRecordListSpc5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc5:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc5, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc5.height = self.rclflwMagicRecordListSpc5.height + self.layBottomflwMagicRecordListSpc5.height +
							self.flwMagicRecordListSpc5.padding.top + self.flwMagicRecordListSpc5.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc5 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc5:setParent(obj.flwMagicRecordListSpc5);
    obj.rclflwMagicRecordListSpc5:setName("rclflwMagicRecordListSpc5");
    obj.rclflwMagicRecordListSpc5:setAlign("top");
    obj.rclflwMagicRecordListSpc5:setField("magias.magias.nivel4");
    obj.rclflwMagicRecordListSpc5:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc5:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc5:setMinHeight(5);
    obj.rclflwMagicRecordListSpc5:setHitTest(false);
    obj.rclflwMagicRecordListSpc5:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc5 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc5:setParent(obj.flwMagicRecordListSpc5);
    obj.layBottomflwMagicRecordListSpc5:setName("layBottomflwMagicRecordListSpc5");
    obj.layBottomflwMagicRecordListSpc5:setAlign("top");
    obj.layBottomflwMagicRecordListSpc5:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc5 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc5:setParent(obj.layBottomflwMagicRecordListSpc5);
    obj.btnNovoflwMagicRecordListSpc5:setName("btnNovoflwMagicRecordListSpc5");
    obj.btnNovoflwMagicRecordListSpc5:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc5:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc5:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc5:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc5._recalcHeight();


    obj.flowLayout30 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout30:setParent(obj.flowLayout24);
    obj.flowLayout30:setHeight(100);
    obj.flowLayout30:setAvoidScale(true);
    obj.flowLayout30:setMaxControlsPerLine(1);
    obj.flowLayout30:setAutoHeight(true);
    obj.flowLayout30:setName("flowLayout30");
    obj.flowLayout30:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout30:setStepSizes({310, 360, 420, 600});
    obj.flowLayout30:setMinScaledWidth(300);
    obj.flowLayout30:setMaxScaledWidth(600);
    obj.flowLayout30:setVertAlign("leading");

    obj.flowPart63 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart63:setParent(obj.flowLayout30);
    obj.flowPart63:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart63:setName("flowPart63");
    obj.flowPart63:setAvoidScale(true);
    obj.flowPart63:setMinScaledWidth(280);
    obj.flowPart63:setMinWidth(300);
    obj.flowPart63:setMaxWidth(600);
    obj.flowPart63:setHeight(80);
    obj.flowPart63:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart63:setVertAlign("leading");

    obj.label96 = GUI.fromHandle(_obj_newObject("label"));
    obj.label96:setParent(obj.flowPart63);
    obj.label96:setFrameRegion("RegiaoSmallTitulo");
    obj.label96:setText("5");
    obj.label96:setName("label96");
    obj.label96:setHorzTextAlign("center");
    obj.label96:setVertTextAlign("center");
    obj.label96:setFontSize(18);
    obj.label96:setFontColor("white");

    obj.edit69 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit69:setParent(obj.flowPart63);
    obj.edit69:setFrameRegion("RegiaoConteudo1");
    obj.edit69:setField("magias.espacosTotais5");
    obj.edit69:setName("edit69");
    obj.edit69:setHorzTextAlign("center");
    obj.edit69:setVertTextAlign("center");
    obj.edit69:setFontSize(18);
    obj.edit69:setTransparent(true);
    obj.edit69:setFontColor("white");

    obj.dataLink105 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink105:setParent(obj.flowPart63);
    obj.dataLink105:setField("magias.espacosTotais5");
    obj.dataLink105:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink105:setName("dataLink105");

    obj.edit70 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit70:setParent(obj.flowPart63);
    obj.edit70:setFrameRegion("RegiaoConteudo2");
    obj.edit70:setField("magias.espacosGastos5");
    obj.edit70:setName("edit70");
    obj.edit70:setHorzTextAlign("center");
    obj.edit70:setVertTextAlign("center");
    obj.edit70:setFontSize(18);
    obj.edit70:setTransparent(true);
    obj.edit70:setFontColor("white");

    obj.dataLink106 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink106:setParent(obj.flowPart63);
    obj.dataLink106:setField("magias.espacosGastos5");
    obj.dataLink106:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink106:setName("dataLink106");

    obj.flwMagicRecordListSpc6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc6:setParent(obj.flowLayout30);
    obj.flwMagicRecordListSpc6:setMinWidth(300);
    obj.flwMagicRecordListSpc6:setMaxWidth(600);
    obj.flwMagicRecordListSpc6:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc6:setName("flwMagicRecordListSpc6");
    obj.flwMagicRecordListSpc6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc6:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc6, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc6.height = self.rclflwMagicRecordListSpc6.height + self.layBottomflwMagicRecordListSpc6.height +
							self.flwMagicRecordListSpc6.padding.top + self.flwMagicRecordListSpc6.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc6 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc6:setParent(obj.flwMagicRecordListSpc6);
    obj.rclflwMagicRecordListSpc6:setName("rclflwMagicRecordListSpc6");
    obj.rclflwMagicRecordListSpc6:setAlign("top");
    obj.rclflwMagicRecordListSpc6:setField("magias.magias.nivel5");
    obj.rclflwMagicRecordListSpc6:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc6:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc6:setMinHeight(5);
    obj.rclflwMagicRecordListSpc6:setHitTest(false);
    obj.rclflwMagicRecordListSpc6:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc6 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc6:setParent(obj.flwMagicRecordListSpc6);
    obj.layBottomflwMagicRecordListSpc6:setName("layBottomflwMagicRecordListSpc6");
    obj.layBottomflwMagicRecordListSpc6:setAlign("top");
    obj.layBottomflwMagicRecordListSpc6:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc6 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc6:setParent(obj.layBottomflwMagicRecordListSpc6);
    obj.btnNovoflwMagicRecordListSpc6:setName("btnNovoflwMagicRecordListSpc6");
    obj.btnNovoflwMagicRecordListSpc6:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc6:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc6:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc6:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc6._recalcHeight();


    obj.flowLayout31 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout31:setParent(obj.flowLayout24);
    obj.flowLayout31:setHeight(100);
    obj.flowLayout31:setAvoidScale(true);
    obj.flowLayout31:setMaxControlsPerLine(1);
    obj.flowLayout31:setAutoHeight(true);
    obj.flowLayout31:setName("flowLayout31");
    obj.flowLayout31:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout31:setStepSizes({310, 360, 420, 600});
    obj.flowLayout31:setMinScaledWidth(300);
    obj.flowLayout31:setMaxScaledWidth(600);
    obj.flowLayout31:setVertAlign("leading");

    obj.flowPart64 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart64:setParent(obj.flowLayout31);
    obj.flowPart64:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart64:setName("flowPart64");
    obj.flowPart64:setAvoidScale(true);
    obj.flowPart64:setMinScaledWidth(280);
    obj.flowPart64:setMinWidth(300);
    obj.flowPart64:setMaxWidth(600);
    obj.flowPart64:setHeight(80);
    obj.flowPart64:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart64:setVertAlign("leading");

    obj.label97 = GUI.fromHandle(_obj_newObject("label"));
    obj.label97:setParent(obj.flowPart64);
    obj.label97:setFrameRegion("RegiaoSmallTitulo");
    obj.label97:setText("6");
    obj.label97:setName("label97");
    obj.label97:setHorzTextAlign("center");
    obj.label97:setVertTextAlign("center");
    obj.label97:setFontSize(18);
    obj.label97:setFontColor("white");

    obj.edit71 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit71:setParent(obj.flowPart64);
    obj.edit71:setFrameRegion("RegiaoConteudo1");
    obj.edit71:setField("magias.espacosTotais6");
    obj.edit71:setName("edit71");
    obj.edit71:setHorzTextAlign("center");
    obj.edit71:setVertTextAlign("center");
    obj.edit71:setFontSize(18);
    obj.edit71:setTransparent(true);
    obj.edit71:setFontColor("white");

    obj.dataLink107 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink107:setParent(obj.flowPart64);
    obj.dataLink107:setField("magias.espacosTotais6");
    obj.dataLink107:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink107:setName("dataLink107");

    obj.edit72 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit72:setParent(obj.flowPart64);
    obj.edit72:setFrameRegion("RegiaoConteudo2");
    obj.edit72:setField("magias.espacosGastos6");
    obj.edit72:setName("edit72");
    obj.edit72:setHorzTextAlign("center");
    obj.edit72:setVertTextAlign("center");
    obj.edit72:setFontSize(18);
    obj.edit72:setTransparent(true);
    obj.edit72:setFontColor("white");

    obj.dataLink108 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink108:setParent(obj.flowPart64);
    obj.dataLink108:setField("magias.espacosGastos6");
    obj.dataLink108:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink108:setName("dataLink108");

    obj.flwMagicRecordListSpc7 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc7:setParent(obj.flowLayout31);
    obj.flwMagicRecordListSpc7:setMinWidth(300);
    obj.flwMagicRecordListSpc7:setMaxWidth(600);
    obj.flwMagicRecordListSpc7:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc7:setName("flwMagicRecordListSpc7");
    obj.flwMagicRecordListSpc7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc7:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc7, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc7.height = self.rclflwMagicRecordListSpc7.height + self.layBottomflwMagicRecordListSpc7.height +
							self.flwMagicRecordListSpc7.padding.top + self.flwMagicRecordListSpc7.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc7 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc7:setParent(obj.flwMagicRecordListSpc7);
    obj.rclflwMagicRecordListSpc7:setName("rclflwMagicRecordListSpc7");
    obj.rclflwMagicRecordListSpc7:setAlign("top");
    obj.rclflwMagicRecordListSpc7:setField("magias.magias.nivel6");
    obj.rclflwMagicRecordListSpc7:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc7:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc7:setMinHeight(5);
    obj.rclflwMagicRecordListSpc7:setHitTest(false);
    obj.rclflwMagicRecordListSpc7:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc7 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc7:setParent(obj.flwMagicRecordListSpc7);
    obj.layBottomflwMagicRecordListSpc7:setName("layBottomflwMagicRecordListSpc7");
    obj.layBottomflwMagicRecordListSpc7:setAlign("top");
    obj.layBottomflwMagicRecordListSpc7:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc7 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc7:setParent(obj.layBottomflwMagicRecordListSpc7);
    obj.btnNovoflwMagicRecordListSpc7:setName("btnNovoflwMagicRecordListSpc7");
    obj.btnNovoflwMagicRecordListSpc7:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc7:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc7:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc7:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc7._recalcHeight();


    obj.flowLayout32 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout32:setParent(obj.flowLayout24);
    obj.flowLayout32:setHeight(100);
    obj.flowLayout32:setAvoidScale(true);
    obj.flowLayout32:setMaxControlsPerLine(1);
    obj.flowLayout32:setAutoHeight(true);
    obj.flowLayout32:setName("flowLayout32");
    obj.flowLayout32:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout32:setStepSizes({310, 360, 420, 600});
    obj.flowLayout32:setMinScaledWidth(300);
    obj.flowLayout32:setMaxScaledWidth(600);
    obj.flowLayout32:setVertAlign("leading");

    obj.flowPart65 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart65:setParent(obj.flowLayout32);
    obj.flowPart65:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart65:setName("flowPart65");
    obj.flowPart65:setAvoidScale(true);
    obj.flowPart65:setMinScaledWidth(280);
    obj.flowPart65:setMinWidth(300);
    obj.flowPart65:setMaxWidth(600);
    obj.flowPart65:setHeight(80);
    obj.flowPart65:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart65:setVertAlign("leading");

    obj.label98 = GUI.fromHandle(_obj_newObject("label"));
    obj.label98:setParent(obj.flowPart65);
    obj.label98:setFrameRegion("RegiaoSmallTitulo");
    obj.label98:setText("7");
    obj.label98:setName("label98");
    obj.label98:setHorzTextAlign("center");
    obj.label98:setVertTextAlign("center");
    obj.label98:setFontSize(18);
    obj.label98:setFontColor("white");

    obj.edit73 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit73:setParent(obj.flowPart65);
    obj.edit73:setFrameRegion("RegiaoConteudo1");
    obj.edit73:setField("magias.espacosTotais7");
    obj.edit73:setName("edit73");
    obj.edit73:setHorzTextAlign("center");
    obj.edit73:setVertTextAlign("center");
    obj.edit73:setFontSize(18);
    obj.edit73:setTransparent(true);
    obj.edit73:setFontColor("white");

    obj.dataLink109 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink109:setParent(obj.flowPart65);
    obj.dataLink109:setField("magias.espacosTotais7");
    obj.dataLink109:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink109:setName("dataLink109");

    obj.edit74 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit74:setParent(obj.flowPart65);
    obj.edit74:setFrameRegion("RegiaoConteudo2");
    obj.edit74:setField("magias.espacosGastos7");
    obj.edit74:setName("edit74");
    obj.edit74:setHorzTextAlign("center");
    obj.edit74:setVertTextAlign("center");
    obj.edit74:setFontSize(18);
    obj.edit74:setTransparent(true);
    obj.edit74:setFontColor("white");

    obj.dataLink110 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink110:setParent(obj.flowPart65);
    obj.dataLink110:setField("magias.espacosGastos7");
    obj.dataLink110:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink110:setName("dataLink110");

    obj.flwMagicRecordListSpc8 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc8:setParent(obj.flowLayout32);
    obj.flwMagicRecordListSpc8:setMinWidth(300);
    obj.flwMagicRecordListSpc8:setMaxWidth(600);
    obj.flwMagicRecordListSpc8:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc8:setName("flwMagicRecordListSpc8");
    obj.flwMagicRecordListSpc8:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc8:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc8, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc8.height = self.rclflwMagicRecordListSpc8.height + self.layBottomflwMagicRecordListSpc8.height +
							self.flwMagicRecordListSpc8.padding.top + self.flwMagicRecordListSpc8.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc8 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc8:setParent(obj.flwMagicRecordListSpc8);
    obj.rclflwMagicRecordListSpc8:setName("rclflwMagicRecordListSpc8");
    obj.rclflwMagicRecordListSpc8:setAlign("top");
    obj.rclflwMagicRecordListSpc8:setField("magias.magias.nivel7");
    obj.rclflwMagicRecordListSpc8:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc8:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc8:setMinHeight(5);
    obj.rclflwMagicRecordListSpc8:setHitTest(false);
    obj.rclflwMagicRecordListSpc8:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc8 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc8:setParent(obj.flwMagicRecordListSpc8);
    obj.layBottomflwMagicRecordListSpc8:setName("layBottomflwMagicRecordListSpc8");
    obj.layBottomflwMagicRecordListSpc8:setAlign("top");
    obj.layBottomflwMagicRecordListSpc8:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc8 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc8:setParent(obj.layBottomflwMagicRecordListSpc8);
    obj.btnNovoflwMagicRecordListSpc8:setName("btnNovoflwMagicRecordListSpc8");
    obj.btnNovoflwMagicRecordListSpc8:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc8:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc8:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc8:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc8._recalcHeight();


    obj.flowLayout33 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout33:setParent(obj.flowLayout24);
    obj.flowLayout33:setHeight(100);
    obj.flowLayout33:setAvoidScale(true);
    obj.flowLayout33:setMaxControlsPerLine(1);
    obj.flowLayout33:setAutoHeight(true);
    obj.flowLayout33:setName("flowLayout33");
    obj.flowLayout33:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout33:setStepSizes({310, 360, 420, 600});
    obj.flowLayout33:setMinScaledWidth(300);
    obj.flowLayout33:setMaxScaledWidth(600);
    obj.flowLayout33:setVertAlign("leading");

    obj.flowPart66 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart66:setParent(obj.flowLayout33);
    obj.flowPart66:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart66:setName("flowPart66");
    obj.flowPart66:setAvoidScale(true);
    obj.flowPart66:setMinScaledWidth(280);
    obj.flowPart66:setMinWidth(300);
    obj.flowPart66:setMaxWidth(600);
    obj.flowPart66:setHeight(80);
    obj.flowPart66:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart66:setVertAlign("leading");

    obj.label99 = GUI.fromHandle(_obj_newObject("label"));
    obj.label99:setParent(obj.flowPart66);
    obj.label99:setFrameRegion("RegiaoSmallTitulo");
    obj.label99:setText("8");
    obj.label99:setName("label99");
    obj.label99:setHorzTextAlign("center");
    obj.label99:setVertTextAlign("center");
    obj.label99:setFontSize(18);
    obj.label99:setFontColor("white");

    obj.edit75 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit75:setParent(obj.flowPart66);
    obj.edit75:setFrameRegion("RegiaoConteudo1");
    obj.edit75:setField("magias.espacosTotais8");
    obj.edit75:setName("edit75");
    obj.edit75:setHorzTextAlign("center");
    obj.edit75:setVertTextAlign("center");
    obj.edit75:setFontSize(18);
    obj.edit75:setTransparent(true);
    obj.edit75:setFontColor("white");

    obj.dataLink111 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink111:setParent(obj.flowPart66);
    obj.dataLink111:setField("magias.espacosTotais8");
    obj.dataLink111:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink111:setName("dataLink111");

    obj.edit76 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit76:setParent(obj.flowPart66);
    obj.edit76:setFrameRegion("RegiaoConteudo2");
    obj.edit76:setField("magias.espacosGastos8");
    obj.edit76:setName("edit76");
    obj.edit76:setHorzTextAlign("center");
    obj.edit76:setVertTextAlign("center");
    obj.edit76:setFontSize(18);
    obj.edit76:setTransparent(true);
    obj.edit76:setFontColor("white");

    obj.dataLink112 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink112:setParent(obj.flowPart66);
    obj.dataLink112:setField("magias.espacosGastos8");
    obj.dataLink112:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink112:setName("dataLink112");

    obj.flwMagicRecordListSpc9 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc9:setParent(obj.flowLayout33);
    obj.flwMagicRecordListSpc9:setMinWidth(300);
    obj.flwMagicRecordListSpc9:setMaxWidth(600);
    obj.flwMagicRecordListSpc9:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc9:setName("flwMagicRecordListSpc9");
    obj.flwMagicRecordListSpc9:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc9:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc9, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc9.height = self.rclflwMagicRecordListSpc9.height + self.layBottomflwMagicRecordListSpc9.height +
							self.flwMagicRecordListSpc9.padding.top + self.flwMagicRecordListSpc9.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc9 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc9:setParent(obj.flwMagicRecordListSpc9);
    obj.rclflwMagicRecordListSpc9:setName("rclflwMagicRecordListSpc9");
    obj.rclflwMagicRecordListSpc9:setAlign("top");
    obj.rclflwMagicRecordListSpc9:setField("magias.magias.nivel8");
    obj.rclflwMagicRecordListSpc9:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc9:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc9:setMinHeight(5);
    obj.rclflwMagicRecordListSpc9:setHitTest(false);
    obj.rclflwMagicRecordListSpc9:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc9 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc9:setParent(obj.flwMagicRecordListSpc9);
    obj.layBottomflwMagicRecordListSpc9:setName("layBottomflwMagicRecordListSpc9");
    obj.layBottomflwMagicRecordListSpc9:setAlign("top");
    obj.layBottomflwMagicRecordListSpc9:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc9 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc9:setParent(obj.layBottomflwMagicRecordListSpc9);
    obj.btnNovoflwMagicRecordListSpc9:setName("btnNovoflwMagicRecordListSpc9");
    obj.btnNovoflwMagicRecordListSpc9:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc9:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc9:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc9:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc9._recalcHeight();


    obj.flowLayout34 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout34:setParent(obj.flowLayout24);
    obj.flowLayout34:setHeight(100);
    obj.flowLayout34:setAvoidScale(true);
    obj.flowLayout34:setMaxControlsPerLine(1);
    obj.flowLayout34:setAutoHeight(true);
    obj.flowLayout34:setName("flowLayout34");
    obj.flowLayout34:setMargins({left=10, right=10, top=4, bottom=4});
    obj.flowLayout34:setStepSizes({310, 360, 420, 600});
    obj.flowLayout34:setMinScaledWidth(300);
    obj.flowLayout34:setMaxScaledWidth(600);
    obj.flowLayout34:setVertAlign("leading");

    obj.flowPart67 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart67:setParent(obj.flowLayout34);
    obj.flowPart67:setFrameStyle("frames/magicHeader/header1.xml");
    obj.flowPart67:setName("flowPart67");
    obj.flowPart67:setAvoidScale(true);
    obj.flowPart67:setMinScaledWidth(280);
    obj.flowPart67:setMinWidth(300);
    obj.flowPart67:setMaxWidth(600);
    obj.flowPart67:setHeight(80);
    obj.flowPart67:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart67:setVertAlign("leading");

    obj.label100 = GUI.fromHandle(_obj_newObject("label"));
    obj.label100:setParent(obj.flowPart67);
    obj.label100:setFrameRegion("RegiaoSmallTitulo");
    obj.label100:setText("9");
    obj.label100:setName("label100");
    obj.label100:setHorzTextAlign("center");
    obj.label100:setVertTextAlign("center");
    obj.label100:setFontSize(18);
    obj.label100:setFontColor("white");

    obj.edit77 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit77:setParent(obj.flowPart67);
    obj.edit77:setFrameRegion("RegiaoConteudo1");
    obj.edit77:setField("magias.espacosTotais9");
    obj.edit77:setName("edit77");
    obj.edit77:setHorzTextAlign("center");
    obj.edit77:setVertTextAlign("center");
    obj.edit77:setFontSize(18);
    obj.edit77:setTransparent(true);
    obj.edit77:setFontColor("white");

    obj.dataLink113 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink113:setParent(obj.flowPart67);
    obj.dataLink113:setField("magias.espacosTotais9");
    obj.dataLink113:setDefaultValue("@@DnD5e.spells.uses.total");
    obj.dataLink113:setName("dataLink113");

    obj.edit78 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit78:setParent(obj.flowPart67);
    obj.edit78:setFrameRegion("RegiaoConteudo2");
    obj.edit78:setField("magias.espacosGastos9");
    obj.edit78:setName("edit78");
    obj.edit78:setHorzTextAlign("center");
    obj.edit78:setVertTextAlign("center");
    obj.edit78:setFontSize(18);
    obj.edit78:setTransparent(true);
    obj.edit78:setFontColor("white");

    obj.dataLink114 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink114:setParent(obj.flowPart67);
    obj.dataLink114:setField("magias.espacosGastos9");
    obj.dataLink114:setDefaultValue("@@DnD5e.spells.uses.spent");
    obj.dataLink114:setName("dataLink114");

    obj.flwMagicRecordListSpc10 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flwMagicRecordListSpc10:setParent(obj.flowLayout34);
    obj.flwMagicRecordListSpc10:setMinWidth(300);
    obj.flwMagicRecordListSpc10:setMaxWidth(600);
    obj.flwMagicRecordListSpc10:setMinScaledWidth(280);
    obj.flwMagicRecordListSpc10:setName("flwMagicRecordListSpc10");
    obj.flwMagicRecordListSpc10:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flwMagicRecordListSpc10:setVertAlign("leading");


				rawset(self.flwMagicRecordListSpc10, "_recalcHeight",
					function ()
						self.flwMagicRecordListSpc10.height = self.rclflwMagicRecordListSpc10.height + self.layBottomflwMagicRecordListSpc10.height +
							self.flwMagicRecordListSpc10.padding.top + self.flwMagicRecordListSpc10.padding.bottom + 7;
					end);
			


    obj.rclflwMagicRecordListSpc10 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwMagicRecordListSpc10:setParent(obj.flwMagicRecordListSpc10);
    obj.rclflwMagicRecordListSpc10:setName("rclflwMagicRecordListSpc10");
    obj.rclflwMagicRecordListSpc10:setAlign("top");
    obj.rclflwMagicRecordListSpc10:setField("magias.magias.nivel9");
    obj.rclflwMagicRecordListSpc10:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwMagicRecordListSpc10:setAutoHeight(true);
    obj.rclflwMagicRecordListSpc10:setMinHeight(5);
    obj.rclflwMagicRecordListSpc10:setHitTest(false);
    obj.rclflwMagicRecordListSpc10:setMargins({left=10, right=10});

    obj.layBottomflwMagicRecordListSpc10 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layBottomflwMagicRecordListSpc10:setParent(obj.flwMagicRecordListSpc10);
    obj.layBottomflwMagicRecordListSpc10:setName("layBottomflwMagicRecordListSpc10");
    obj.layBottomflwMagicRecordListSpc10:setAlign("top");
    obj.layBottomflwMagicRecordListSpc10:setHeight(36);

    obj.btnNovoflwMagicRecordListSpc10 = GUI.fromHandle(_obj_newObject("button"));
    obj.btnNovoflwMagicRecordListSpc10:setParent(obj.layBottomflwMagicRecordListSpc10);
    obj.btnNovoflwMagicRecordListSpc10:setName("btnNovoflwMagicRecordListSpc10");
    obj.btnNovoflwMagicRecordListSpc10:setAlign("left");
    obj.btnNovoflwMagicRecordListSpc10:setText("@@DnD5e.spells.btn.newspell");
    obj.btnNovoflwMagicRecordListSpc10:setWidth(160);
    obj.btnNovoflwMagicRecordListSpc10:setMargins({top=4, bottom=4, left=48});

self.flwMagicRecordListSpc10._recalcHeight();


    obj.tab5 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab5:setParent(obj.pgcPrincipal);
    obj.tab5:setTitle("Innate Spellcast");
    obj.tab5:setName("tab5");

    obj.rectangle5 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle5:setParent(obj.tab5);
    obj.rectangle5:setName("rectangle5");
    obj.rectangle5:setAlign("client");
    obj.rectangle5:setColor("#40000000");
    obj.rectangle5:setXradius(10);
    obj.rectangle5:setYradius(10);

    obj.popMagiaInnate = GUI.fromHandle(_obj_newObject("popup"));
    obj.popMagiaInnate:setParent(obj.rectangle5);
    obj.popMagiaInnate:setName("popMagiaInnate");
    obj.popMagiaInnate:setAlign("client");
    obj.popMagiaInnate:setMargins({left=100,right=100,top=100,bottom=100});
    obj.popMagiaInnate:setBackOpacity(0.4);
    obj.popMagiaInnate.autoScopeNode = false;

    obj.edit79 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit79:setParent(obj.popMagiaInnate);
    obj.edit79:setAlign("top");
    obj.edit79:setField("nome");
    obj.edit79:setTextPrompt("NOME DA MAGIA");
    obj.edit79:setHorzTextAlign("center");
    obj.edit79:setName("edit79");
    obj.edit79:setFontSize(15);
    obj.edit79:setFontColor("white");

    obj.flowLayout35 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout35:setParent(obj.popMagiaInnate);
    obj.flowLayout35:setAlign("top");
    obj.flowLayout35:setAutoHeight(true);
    obj.flowLayout35:setMaxControlsPerLine(2);
    obj.flowLayout35:setMargins({bottom=4});
    obj.flowLayout35:setHorzAlign("center");
    obj.flowLayout35:setName("flowLayout35");
    obj.flowLayout35:setVertAlign("leading");

    obj.flowPart68 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart68:setParent(obj.flowLayout35);
    obj.flowPart68:setMinWidth(30);
    obj.flowPart68:setMaxWidth(800);
    obj.flowPart68:setHeight(35);
    obj.flowPart68:setName("flowPart68");
    obj.flowPart68:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart68:setVertAlign("leading");

    obj.label101 = GUI.fromHandle(_obj_newObject("label"));
    obj.label101:setParent(obj.flowPart68);
    obj.label101:setAlign("top");
    obj.label101:setFontSize(10);
    obj.label101:setText("@@DnD5e.spells.formulationTime");
    obj.label101:setHorzTextAlign("center");
    obj.label101:setWordWrap(true);
    obj.label101:setTextTrimming("none");
    obj.label101:setAutoSize(true);
    obj.label101:setName("label101");
    obj.label101:setFontColor("#D0D0D0");

    obj.edit80 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit80:setParent(obj.flowPart68);
    obj.edit80:setAlign("client");
    obj.edit80:setField("tempoDeFormulacao");
    obj.edit80:setHorzTextAlign("center");
    obj.edit80:setFontSize(12);
    obj.edit80:setName("edit80");
    obj.edit80:setFontColor("white");

    obj.flowPart69 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart69:setParent(obj.flowLayout35);
    obj.flowPart69:setMinWidth(30);
    obj.flowPart69:setMaxWidth(800);
    obj.flowPart69:setHeight(35);
    obj.flowPart69:setName("flowPart69");
    obj.flowPart69:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart69:setVertAlign("leading");

    obj.label102 = GUI.fromHandle(_obj_newObject("label"));
    obj.label102:setParent(obj.flowPart69);
    obj.label102:setAlign("top");
    obj.label102:setFontSize(10);
    obj.label102:setText("@@DnD5e.spells.range");
    obj.label102:setHorzTextAlign("center");
    obj.label102:setWordWrap(true);
    obj.label102:setTextTrimming("none");
    obj.label102:setAutoSize(true);
    obj.label102:setName("label102");
    obj.label102:setFontColor("#D0D0D0");

    obj.edit81 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit81:setParent(obj.flowPart69);
    obj.edit81:setAlign("client");
    obj.edit81:setField("alcance");
    obj.edit81:setHorzTextAlign("center");
    obj.edit81:setFontSize(12);
    obj.edit81:setName("edit81");
    obj.edit81:setFontColor("white");

    obj.flowPart70 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart70:setParent(obj.flowLayout35);
    obj.flowPart70:setMinWidth(30);
    obj.flowPart70:setMaxWidth(800);
    obj.flowPart70:setHeight(35);
    obj.flowPart70:setName("flowPart70");
    obj.flowPart70:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart70:setVertAlign("leading");

    obj.label103 = GUI.fromHandle(_obj_newObject("label"));
    obj.label103:setParent(obj.flowPart70);
    obj.label103:setAlign("top");
    obj.label103:setFontSize(10);
    obj.label103:setText("@@DnD5e.spells.component");
    obj.label103:setHorzTextAlign("center");
    obj.label103:setWordWrap(true);
    obj.label103:setTextTrimming("none");
    obj.label103:setAutoSize(true);
    obj.label103:setName("label103");
    obj.label103:setFontColor("#D0D0D0");

    obj.edit82 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit82:setParent(obj.flowPart70);
    obj.edit82:setAlign("client");
    obj.edit82:setField("componentes");
    obj.edit82:setHorzTextAlign("center");
    obj.edit82:setFontSize(12);
    obj.edit82:setName("edit82");
    obj.edit82:setFontColor("white");

    obj.flowPart71 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart71:setParent(obj.flowLayout35);
    obj.flowPart71:setMinWidth(30);
    obj.flowPart71:setMaxWidth(800);
    obj.flowPart71:setHeight(35);
    obj.flowPart71:setName("flowPart71");
    obj.flowPart71:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart71:setVertAlign("leading");

    obj.label104 = GUI.fromHandle(_obj_newObject("label"));
    obj.label104:setParent(obj.flowPart71);
    obj.label104:setAlign("top");
    obj.label104:setFontSize(10);
    obj.label104:setText("@@DnD5e.spells.duration");
    obj.label104:setHorzTextAlign("center");
    obj.label104:setWordWrap(true);
    obj.label104:setTextTrimming("none");
    obj.label104:setAutoSize(true);
    obj.label104:setName("label104");
    obj.label104:setFontColor("#D0D0D0");

    obj.edit83 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit83:setParent(obj.flowPart71);
    obj.edit83:setAlign("client");
    obj.edit83:setField("duracao");
    obj.edit83:setHorzTextAlign("center");
    obj.edit83:setFontSize(12);
    obj.edit83:setName("edit83");
    obj.edit83:setFontColor("white");

    obj.flowPart72 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart72:setParent(obj.flowLayout35);
    obj.flowPart72:setMinWidth(30);
    obj.flowPart72:setMaxWidth(800);
    obj.flowPart72:setHeight(35);
    obj.flowPart72:setName("flowPart72");
    obj.flowPart72:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart72:setVertAlign("leading");

    obj.label105 = GUI.fromHandle(_obj_newObject("label"));
    obj.label105:setParent(obj.flowPart72);
    obj.label105:setAlign("top");
    obj.label105:setFontSize(10);
    obj.label105:setText("@@DnD5e.generic.attack");
    obj.label105:setHorzTextAlign("center");
    obj.label105:setAutoSize(true);
    obj.label105:setName("label105");
    obj.label105:setFontColor("#D0D0D0");

    obj.comboBox10 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox10:setParent(obj.flowPart72);
    obj.comboBox10:setAlign("client");
    obj.comboBox10:setField("ataque");
    obj.comboBox10:setHorzTextAlign("center");
    obj.comboBox10:setFontSize(12);
    obj.comboBox10:setItems({'@@DnD5e.spells.attack.none', '@@DnD5e.spells.attack.melee', '@@DnD5e.spells.attack.ranger'});
    obj.comboBox10:setValues({'Sem ataque', 'Ataque Corpo-a-Corpo', 'Ataque a Distância'});
    obj.comboBox10:setName("comboBox10");

    obj.flowPart73 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart73:setParent(obj.flowLayout35);
    obj.flowPart73:setMinWidth(30);
    obj.flowPart73:setMaxWidth(800);
    obj.flowPart73:setHeight(35);
    obj.flowPart73:setName("flowPart73");
    obj.flowPart73:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart73:setVertAlign("leading");

    obj.label106 = GUI.fromHandle(_obj_newObject("label"));
    obj.label106:setParent(obj.flowPart73);
    obj.label106:setAlign("top");
    obj.label106:setFontSize(10);
    obj.label106:setText("@@DnD5e.savingThrows.title");
    obj.label106:setHorzTextAlign("center");
    obj.label106:setAutoSize(true);
    obj.label106:setName("label106");
    obj.label106:setFontColor("#D0D0D0");

    obj.comboBox11 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox11:setParent(obj.flowPart73);
    obj.comboBox11:setAlign("client");
    obj.comboBox11:setField("resistencia");
    obj.comboBox11:setHorzTextAlign("center");
    obj.comboBox11:setFontSize(12);
    obj.comboBox11:setItems({'@@DnD5e.spells.resistance.none', '@@DnD5e.spells.resistance.str', '@@DnD5e.spells.resistance.dex', '@@DnD5e.spells.resistance.con', '@@DnD5e.spells.resistance.int', '@@DnD5e.spells.resistance.wis', '@@DnD5e.spells.resistance.cha'});
    obj.comboBox11:setValues({'Nenhum', 'Força', 'Destreza', 'Constituição', 'Inteligência', 'Sabedoria', 'Carisma'});
    obj.comboBox11:setName("comboBox11");

    obj.flowPart74 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart74:setParent(obj.flowLayout35);
    obj.flowPart74:setMinWidth(30);
    obj.flowPart74:setMaxWidth(800);
    obj.flowPart74:setHeight(35);
    obj.flowPart74:setName("flowPart74");
    obj.flowPart74:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart74:setVertAlign("leading");

    obj.label107 = GUI.fromHandle(_obj_newObject("label"));
    obj.label107:setParent(obj.flowPart74);
    obj.label107:setAlign("top");
    obj.label107:setFontSize(10);
    obj.label107:setText("");
    obj.label107:setHorzTextAlign("center");
    obj.label107:setAutoSize(true);
    obj.label107:setName("label107");
    obj.label107:setFontColor("#D0D0D0");

    obj.comboBox12 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.comboBox12:setParent(obj.flowPart74);
    obj.comboBox12:setAlign("client");
    obj.comboBox12:setField("damageType");
    obj.comboBox12:setHorzTextAlign("center");
    obj.comboBox12:setFontSize(12);
    obj.comboBox12:setItems({'@@DnD5e.spells.damage.none', '@@DnD5e.spells.damage'});
    obj.comboBox12:setValues({'Sem dano', 'Dano'});
    obj.comboBox12:setName("comboBox12");

    obj.flowPart75 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart75:setParent(obj.flowLayout35);
    obj.flowPart75:setMinWidth(30);
    obj.flowPart75:setMaxWidth(800);
    obj.flowPart75:setHeight(35);
    obj.flowPart75:setName("flowPart75");
    obj.flowPart75:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart75:setVertAlign("leading");

    obj.label108 = GUI.fromHandle(_obj_newObject("label"));
    obj.label108:setParent(obj.flowPart75);
    obj.label108:setAlign("top");
    obj.label108:setFontSize(10);
    obj.label108:setText("@@DnD5e.spells.damage");
    obj.label108:setHorzTextAlign("center");
    obj.label108:setWordWrap(true);
    obj.label108:setTextTrimming("none");
    obj.label108:setAutoSize(true);
    obj.label108:setName("label108");
    obj.label108:setFontColor("#D0D0D0");

    obj.edit84 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit84:setParent(obj.flowPart75);
    obj.edit84:setAlign("client");
    obj.edit84:setField("damageValue");
    obj.edit84:setHorzTextAlign("center");
    obj.edit84:setFontSize(12);
    obj.edit84:setName("edit84");
    obj.edit84:setFontColor("white");

    obj.textEditor11 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor11:setParent(obj.popMagiaInnate);
    obj.textEditor11:setAlign("client");
    obj.textEditor11:setField("descricao");
    obj.textEditor11:setName("textEditor11");

    obj.scrollBox5 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox5:setParent(obj.rectangle5);
    obj.scrollBox5:setAlign("client");
    obj.scrollBox5:setName("scrollBox5");

    obj.fraMagiasLayoutInnate = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraMagiasLayoutInnate:setParent(obj.scrollBox5);
    obj.fraMagiasLayoutInnate:setAlign("top");
    obj.fraMagiasLayoutInnate:setHeight(500);
    obj.fraMagiasLayoutInnate:setMargins({left=10, right=10, top=10});
    obj.fraMagiasLayoutInnate:setAutoHeight(true);
    obj.fraMagiasLayoutInnate:setHorzAlign("center");
    obj.fraMagiasLayoutInnate:setLineSpacing(3);
    obj.fraMagiasLayoutInnate:setName("fraMagiasLayoutInnate");
    obj.fraMagiasLayoutInnate:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.fraMagiasLayoutInnate:setMinScaledWidth(300);
    obj.fraMagiasLayoutInnate:setVertAlign("leading");

    obj.flowLayout36 = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout36:setParent(obj.fraMagiasLayoutInnate);
    obj.flowLayout36:setAutoHeight(true);
    obj.flowLayout36:setMinScaledWidth(290);
    obj.flowLayout36:setHorzAlign("center");
    obj.flowLayout36:setName("flowLayout36");
    obj.flowLayout36:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.flowLayout36:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout36:setVertAlign("leading");

    obj.fraUpperGridMagiasInnate = GUI.fromHandle(_obj_newObject("flowLayout"));
    obj.fraUpperGridMagiasInnate:setParent(obj.flowLayout36);
    obj.fraUpperGridMagiasInnate:setMinWidth(320);
    obj.fraUpperGridMagiasInnate:setMaxWidth(1600);
    obj.fraUpperGridMagiasInnate:setName("fraUpperGridMagiasInnate");
    obj.fraUpperGridMagiasInnate:setAvoidScale(true);
    obj.fraUpperGridMagiasInnate:setFrameStyle("frames/upperInfoGrid/frame.xml");
    obj.fraUpperGridMagiasInnate:setAutoHeight(true);
    obj.fraUpperGridMagiasInnate:setVertAlign("trailing");
    obj.fraUpperGridMagiasInnate:setMaxControlsPerLine(3);
    obj.fraUpperGridMagiasInnate:setHorzAlign("center");
    obj.fraUpperGridMagiasInnate:setLineSpacing(8);
    obj.fraUpperGridMagiasInnate:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.fraUpperGridMagiasInnate:setMinScaledWidth(300);
    obj.fraUpperGridMagiasInnate:setMargins({left=1, right=1, top=2, bottom=2});

    obj.upperGridMagicBox4 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox4:setParent(obj.fraUpperGridMagiasInnate);
    obj.upperGridMagicBox4:setHeight(50);
    obj.upperGridMagicBox4:setMinScaledWidth(145);
    obj.upperGridMagicBox4:setMinWidth(145);
    obj.upperGridMagicBox4:setMaxWidth(160);
    obj.upperGridMagicBox4:setMaxScaledWidth(160);
    obj.upperGridMagicBox4:setAvoidScale(true);
    obj.upperGridMagicBox4:setName("upperGridMagicBox4");
    obj.upperGridMagicBox4:setVertAlign("leading");
    obj.upperGridMagicBox4:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox4, "_RecalcSize", 
						function ()
							self.upperGridMagicBox4:setHeight(self.panupperGridMagicBox4:getHeight() + self.labupperGridMagicBox4:getHeight());
						end);														
				


    obj.panupperGridMagicBox4 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox4:setParent(obj.upperGridMagicBox4);
    obj.panupperGridMagicBox4:setName("panupperGridMagicBox4");
    obj.panupperGridMagicBox4:setAlign("top");
    obj.panupperGridMagicBox4:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox4:setHeight(60);

    obj.cmbupperGridMagicBox4 = GUI.fromHandle(_obj_newObject("comboBox"));
    obj.cmbupperGridMagicBox4:setParent(obj.panupperGridMagicBox4);
    obj.cmbupperGridMagicBox4:setName("cmbupperGridMagicBox4");
    obj.cmbupperGridMagicBox4:setFrameRegion("ContentRegion");
    obj.cmbupperGridMagicBox4:setField("magiasInatas.habilidadeDeConjuracao");
    obj.cmbupperGridMagicBox4:setItems({'', 'Força', 'Destreza', 'Constituição', '@@DnD5e.frente.box.intelligence', '@@DnD5e.frente.box.wisdom', '@@DnD5e.frente.box.charisma'});
    obj.cmbupperGridMagicBox4:setValues({'', 'for', 'des', 'con', 'int', 'sab', 'car'});
    obj.cmbupperGridMagicBox4:setHorzTextAlign("center");
    obj.cmbupperGridMagicBox4:setVertTextAlign("center");
    obj.cmbupperGridMagicBox4:setFontSize(13);
    obj.cmbupperGridMagicBox4:setTransparent(true);

    obj.labupperGridMagicBox4 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox4:setParent(obj.upperGridMagicBox4);
    obj.labupperGridMagicBox4:setName("labupperGridMagicBox4");
    obj.labupperGridMagicBox4:setAlign("top");
    obj.labupperGridMagicBox4:setAutoSize(true);
    obj.labupperGridMagicBox4:setText("@@DnD5e.spells.spellcasterAbility");
    obj.labupperGridMagicBox4:setHorzTextAlign("center");
    obj.labupperGridMagicBox4:setVertTextAlign("leading");
    obj.labupperGridMagicBox4:setWordWrap(true);
    obj.labupperGridMagicBox4:setTextTrimming("none");
    obj.labupperGridMagicBox4:setFontSize(12);
    obj.labupperGridMagicBox4:setFontColor("#D0D0D0");

self.upperGridMagicBox4._RecalcSize();	


    obj.upperGridMagicBox5 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox5:setParent(obj.fraUpperGridMagiasInnate);
    obj.upperGridMagicBox5:setHeight(50);
    obj.upperGridMagicBox5:setMinScaledWidth(100);
    obj.upperGridMagicBox5:setMinWidth(100);
    obj.upperGridMagicBox5:setMaxWidth(160);
    obj.upperGridMagicBox5:setMaxScaledWidth(160);
    obj.upperGridMagicBox5:setAvoidScale(true);
    obj.upperGridMagicBox5:setName("upperGridMagicBox5");
    obj.upperGridMagicBox5:setVertAlign("leading");
    obj.upperGridMagicBox5:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox5, "_RecalcSize", 
						function ()
							self.upperGridMagicBox5:setHeight(self.panupperGridMagicBox5:getHeight() + self.labupperGridMagicBox5:getHeight());
						end);														
				


    obj.panupperGridMagicBox5 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox5:setParent(obj.upperGridMagicBox5);
    obj.panupperGridMagicBox5:setName("panupperGridMagicBox5");
    obj.panupperGridMagicBox5:setAlign("top");
    obj.panupperGridMagicBox5:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox5:setHeight(60);

    obj.labupperGridMagicBox5val = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox5val:setParent(obj.panupperGridMagicBox5);
    obj.labupperGridMagicBox5val:setName("labupperGridMagicBox5val");
    obj.labupperGridMagicBox5val:setFrameRegion("ContentRegion");
    obj.labupperGridMagicBox5val:setField("magiasInatas.cdDaMagia");
    obj.labupperGridMagicBox5val:setFontSize(22);
    obj.labupperGridMagicBox5val:setVertTextAlign("center");
    obj.labupperGridMagicBox5val:setHorzTextAlign("center");
    obj.labupperGridMagicBox5val:setFontColor("white");

    obj.labupperGridMagicBox5 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox5:setParent(obj.upperGridMagicBox5);
    obj.labupperGridMagicBox5:setName("labupperGridMagicBox5");
    obj.labupperGridMagicBox5:setAlign("top");
    obj.labupperGridMagicBox5:setAutoSize(true);
    obj.labupperGridMagicBox5:setText("@@DnD5e.spells.spellSaveDC");
    obj.labupperGridMagicBox5:setHorzTextAlign("center");
    obj.labupperGridMagicBox5:setVertTextAlign("leading");
    obj.labupperGridMagicBox5:setWordWrap(true);
    obj.labupperGridMagicBox5:setTextTrimming("none");
    obj.labupperGridMagicBox5:setFontSize(12);
    obj.labupperGridMagicBox5:setFontColor("#D0D0D0");

self.upperGridMagicBox5._RecalcSize();	


    obj.upperGridMagicBox6 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox6:setParent(obj.fraUpperGridMagiasInnate);
    obj.upperGridMagicBox6:setHeight(50);
    obj.upperGridMagicBox6:setMinScaledWidth(100);
    obj.upperGridMagicBox6:setMinWidth(100);
    obj.upperGridMagicBox6:setMaxWidth(160);
    obj.upperGridMagicBox6:setMaxScaledWidth(160);
    obj.upperGridMagicBox6:setAvoidScale(true);
    obj.upperGridMagicBox6:setName("upperGridMagicBox6");
    obj.upperGridMagicBox6:setVertAlign("leading");
    obj.upperGridMagicBox6:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox6, "_RecalcSize", 
						function ()
							self.upperGridMagicBox6:setHeight(self.panupperGridMagicBox6:getHeight() + self.labupperGridMagicBox6:getHeight());
						end);														
				


    obj.panupperGridMagicBox6 = GUI.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox6:setParent(obj.upperGridMagicBox6);
    obj.panupperGridMagicBox6:setName("panupperGridMagicBox6");
    obj.panupperGridMagicBox6:setAlign("top");
    obj.panupperGridMagicBox6:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox6:setHeight(60);

    obj.labupperGridMagicBox6val = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox6val:setParent(obj.panupperGridMagicBox6);
    obj.labupperGridMagicBox6val:setName("labupperGridMagicBox6val");
    obj.labupperGridMagicBox6val:setFrameRegion("ContentRegion");
    obj.labupperGridMagicBox6val:setField("magiasInatas.bonusAtaqueSTR");
    obj.labupperGridMagicBox6val:setFontSize(22);
    obj.labupperGridMagicBox6val:setVertTextAlign("center");
    obj.labupperGridMagicBox6val:setHorzTextAlign("center");
    obj.labupperGridMagicBox6val:setFontColor("white");

    obj.labupperGridMagicBox6 = GUI.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox6:setParent(obj.upperGridMagicBox6);
    obj.labupperGridMagicBox6:setName("labupperGridMagicBox6");
    obj.labupperGridMagicBox6:setAlign("top");
    obj.labupperGridMagicBox6:setAutoSize(true);
    obj.labupperGridMagicBox6:setText("@@DnD5e.spells.spellAttackBonus");
    obj.labupperGridMagicBox6:setHorzTextAlign("center");
    obj.labupperGridMagicBox6:setVertTextAlign("leading");
    obj.labupperGridMagicBox6:setWordWrap(true);
    obj.labupperGridMagicBox6:setTextTrimming("none");
    obj.labupperGridMagicBox6:setFontSize(12);
    obj.labupperGridMagicBox6:setFontColor("#D0D0D0");

self.upperGridMagicBox6._RecalcSize();	


    obj.dataLink115 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink115:setParent(obj.fraMagiasLayoutInnate);
    obj.dataLink115:setFields({'magiasInatas.habilidadeDeConjuracao', 'atributos.modForca', 'atributos.modDestreza', 'atributos.modConstituicao', 'atributos.modInteligencia', 'atributos.modSabedoria', 'atributos.modCarisma', 'bonusProficiencia'});
    obj.dataLink115:setName("dataLink115");

    obj.flowLineBreak13 = GUI.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak13:setParent(obj.fraMagiasLayoutInnate);
    obj.flowLineBreak13:setName("flowLineBreak13");

    obj.flowPart76 = GUI.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart76:setParent(obj.fraMagiasLayoutInnate);
    obj.flowPart76:setMinWidth(680);
    obj.flowPart76:setMaxWidth(1600);
    obj.flowPart76:setFrameStyle("frames/panel2/frame.xml");
    obj.flowPart76:setHeight(560);
    obj.flowPart76:setAvoidScale(true);
    obj.flowPart76:setName("flowPart76");
    obj.flowPart76:setStepSizes({310, 420, 640, 760, 900, 1150, 1200});
    obj.flowPart76:setMinScaledWidth(300);
    obj.flowPart76:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart76:setVertAlign("leading");

    obj.tabInnateByUse = GUI.fromHandle(_obj_newObject("tabControl"));
    obj.tabInnateByUse:setParent(obj.flowPart76);
    obj.tabInnateByUse:setAlign("client");
    obj.tabInnateByUse:setMargins({left=8,right=8,top=8,bottom=8});
    obj.tabInnateByUse:setName("tabInnateByUse");

    obj.tab6 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab6:setParent(obj.tabInnateByUse);
    obj.tab6:setTitle("À vontade");
    obj.tab6:setName("tab6");

    obj.flwInnateUsage1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage1:setParent(obj.tab6);
    obj.flwInnateUsage1:setAlign("client");
    obj.flwInnateUsage1:setName("flwInnateUsage1");

    obj.rclflwInnateUsage1 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage1:setParent(obj.flwInnateUsage1);
    obj.rclflwInnateUsage1:setName("rclflwInnateUsage1");
    obj.rclflwInnateUsage1:setAlign("client");
    obj.rclflwInnateUsage1:setField("magiasInatas.listas.atWill");
    obj.rclflwInnateUsage1:setTemplateForm("frmMagiaItemSemCheckbox");
    obj.rclflwInnateUsage1:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button20 = GUI.fromHandle(_obj_newObject("button"));
    obj.button20:setParent(obj.flwInnateUsage1);
    obj.button20:setAlign("bottom");
    obj.button20:setHeight(28);
    obj.button20:setText("@@DnD5e.spells.btn.newspell");
    obj.button20:setMargins({left=8,right=8,bottom=8});
    obj.button20:setName("button20");

    obj.tab7 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab7:setParent(obj.tabInnateByUse);
    obj.tab7:setTitle("1/dia");
    obj.tab7:setName("tab7");

    obj.flwInnateUsage2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage2:setParent(obj.tab7);
    obj.flwInnateUsage2:setAlign("client");
    obj.flwInnateUsage2:setName("flwInnateUsage2");

    obj.rclflwInnateUsage2 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage2:setParent(obj.flwInnateUsage2);
    obj.rclflwInnateUsage2:setName("rclflwInnateUsage2");
    obj.rclflwInnateUsage2:setAlign("client");
    obj.rclflwInnateUsage2:setField("magiasInatas.listas.porDia1");
    obj.rclflwInnateUsage2:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwInnateUsage2:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button21 = GUI.fromHandle(_obj_newObject("button"));
    obj.button21:setParent(obj.flwInnateUsage2);
    obj.button21:setAlign("bottom");
    obj.button21:setHeight(28);
    obj.button21:setText("@@DnD5e.spells.btn.newspell");
    obj.button21:setMargins({left=8,right=8,bottom=8});
    obj.button21:setName("button21");

    obj.tab8 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab8:setParent(obj.tabInnateByUse);
    obj.tab8:setTitle("2/dia");
    obj.tab8:setName("tab8");

    obj.flwInnateUsage3 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage3:setParent(obj.tab8);
    obj.flwInnateUsage3:setAlign("client");
    obj.flwInnateUsage3:setName("flwInnateUsage3");

    obj.rclflwInnateUsage3 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage3:setParent(obj.flwInnateUsage3);
    obj.rclflwInnateUsage3:setName("rclflwInnateUsage3");
    obj.rclflwInnateUsage3:setAlign("client");
    obj.rclflwInnateUsage3:setField("magiasInatas.listas.porDia2");
    obj.rclflwInnateUsage3:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwInnateUsage3:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button22 = GUI.fromHandle(_obj_newObject("button"));
    obj.button22:setParent(obj.flwInnateUsage3);
    obj.button22:setAlign("bottom");
    obj.button22:setHeight(28);
    obj.button22:setText("@@DnD5e.spells.btn.newspell");
    obj.button22:setMargins({left=8,right=8,bottom=8});
    obj.button22:setName("button22");

    obj.tab9 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab9:setParent(obj.tabInnateByUse);
    obj.tab9:setTitle("3/dia");
    obj.tab9:setName("tab9");

    obj.flwInnateUsage4 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage4:setParent(obj.tab9);
    obj.flwInnateUsage4:setAlign("client");
    obj.flwInnateUsage4:setName("flwInnateUsage4");

    obj.rclflwInnateUsage4 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage4:setParent(obj.flwInnateUsage4);
    obj.rclflwInnateUsage4:setName("rclflwInnateUsage4");
    obj.rclflwInnateUsage4:setAlign("client");
    obj.rclflwInnateUsage4:setField("magiasInatas.listas.porDia3");
    obj.rclflwInnateUsage4:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwInnateUsage4:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button23 = GUI.fromHandle(_obj_newObject("button"));
    obj.button23:setParent(obj.flwInnateUsage4);
    obj.button23:setAlign("bottom");
    obj.button23:setHeight(28);
    obj.button23:setText("@@DnD5e.spells.btn.newspell");
    obj.button23:setMargins({left=8,right=8,bottom=8});
    obj.button23:setName("button23");

    obj.tab10 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab10:setParent(obj.tabInnateByUse);
    obj.tab10:setTitle("X/dia");
    obj.tab10:setName("tab10");

    obj.layout66 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout66:setParent(obj.tab10);
    obj.layout66:setAlign("client");
    obj.layout66:setName("layout66");

    obj.edit85 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit85:setParent(obj.layout66);
    obj.edit85:setAlign("top");
    obj.edit85:setField("magiasInatas.rotuloCustomDia");
    obj.edit85:setTextPrompt("Ex.: 5/dia cada");
    obj.edit85:setMargins({left=8,right=8,top=8,bottom=4});
    obj.edit85:setName("edit85");
    obj.edit85:setFontSize(15);
    obj.edit85:setFontColor("white");

    obj.flwInnateUsage5 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage5:setParent(obj.layout66);
    obj.flwInnateUsage5:setAlign("client");
    obj.flwInnateUsage5:setName("flwInnateUsage5");

    obj.rclflwInnateUsage5 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage5:setParent(obj.flwInnateUsage5);
    obj.rclflwInnateUsage5:setName("rclflwInnateUsage5");
    obj.rclflwInnateUsage5:setAlign("client");
    obj.rclflwInnateUsage5:setField("magiasInatas.listas.customDia");
    obj.rclflwInnateUsage5:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwInnateUsage5:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button24 = GUI.fromHandle(_obj_newObject("button"));
    obj.button24:setParent(obj.flwInnateUsage5);
    obj.button24:setAlign("bottom");
    obj.button24:setHeight(28);
    obj.button24:setText("@@DnD5e.spells.btn.newspell");
    obj.button24:setMargins({left=8,right=8,bottom=8});
    obj.button24:setName("button24");

    obj.tab11 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab11:setParent(obj.tabInnateByUse);
    obj.tab11:setTitle("X/semana");
    obj.tab11:setName("tab11");

    obj.layout67 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout67:setParent(obj.tab11);
    obj.layout67:setAlign("client");
    obj.layout67:setName("layout67");

    obj.edit86 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit86:setParent(obj.layout67);
    obj.edit86:setAlign("top");
    obj.edit86:setField("magiasInatas.rotuloCustomSemana");
    obj.edit86:setTextPrompt("Ex.: 1/semana cada");
    obj.edit86:setMargins({left=8,right=8,top=8,bottom=4});
    obj.edit86:setName("edit86");
    obj.edit86:setFontSize(15);
    obj.edit86:setFontColor("white");

    obj.flwInnateUsage6 = GUI.fromHandle(_obj_newObject("layout"));
    obj.flwInnateUsage6:setParent(obj.layout67);
    obj.flwInnateUsage6:setAlign("client");
    obj.flwInnateUsage6:setName("flwInnateUsage6");

    obj.rclflwInnateUsage6 = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclflwInnateUsage6:setParent(obj.flwInnateUsage6);
    obj.rclflwInnateUsage6:setName("rclflwInnateUsage6");
    obj.rclflwInnateUsage6:setAlign("client");
    obj.rclflwInnateUsage6:setField("magiasInatas.listas.customSemana");
    obj.rclflwInnateUsage6:setTemplateForm("frmMagiaItemComCheckbox");
    obj.rclflwInnateUsage6:setMargins({left=8,right=8,top=8,bottom=40});

    obj.button25 = GUI.fromHandle(_obj_newObject("button"));
    obj.button25:setParent(obj.flwInnateUsage6);
    obj.button25:setAlign("bottom");
    obj.button25:setHeight(28);
    obj.button25:setText("@@DnD5e.spells.btn.newspell");
    obj.button25:setMargins({left=8,right=8,bottom=8});
    obj.button25:setName("button25");

    obj.tab12 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab12:setParent(obj.pgcPrincipal);
    obj.tab12:setTitle("@@DnD5e.tabControl.tab.counter");
    obj.tab12:setName("tab12");

    obj.rectangle6 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle6:setParent(obj.tab12);
    obj.rectangle6:setName("rectangle6");
    obj.rectangle6:setAlign("client");
    obj.rectangle6:setColor("#40000000");
    obj.rectangle6:setXradius(10);
    obj.rectangle6:setYradius(10);

    obj.scrollBox6 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox6:setParent(obj.rectangle6);
    obj.scrollBox6:setAlign("client");
    obj.scrollBox6:setName("scrollBox6");

    obj.button26 = GUI.fromHandle(_obj_newObject("button"));
    obj.button26:setParent(obj.scrollBox6);
    obj.button26:setText("@@DnD5e.tab.counter.add");
    obj.button26:setAlign("top");
    obj.button26:setName("button26");

    obj.rclContadores = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclContadores:setParent(obj.scrollBox6);
    obj.rclContadores:setName("rclContadores");
    obj.rclContadores:setAlign("top");
    obj.rclContadores:setField("contadores");
    obj.rclContadores:setTemplateForm("frmContador");
    obj.rclContadores:setAutoHeight(true);
    obj.rclContadores:setMinHeight(5);
    obj.rclContadores:setHitTest(false);
    obj.rclContadores:setMargins({top=10, bottom=10, left=10, right=10});

    obj.dataLink116 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink116:setParent(obj.rectangle6);
    obj.dataLink116:setFields({'descansoLongo', 'descansoCurto'});
    obj.dataLink116:setName("dataLink116");

    obj.tab13 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab13:setParent(obj.pgcPrincipal);
    obj.tab13:setTitle("@@DnD5e.tabControl.tab.annotations");
    obj.tab13:setName("tab13");

    obj.rectangle7 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle7:setParent(obj.tab13);
    obj.rectangle7:setName("rectangle7");
    obj.rectangle7:setAlign("client");
    obj.rectangle7:setColor("#40000000");
    obj.rectangle7:setXradius(10);
    obj.rectangle7:setYradius(10);

    obj.checkBox2 = GUI.fromHandle(_obj_newObject("checkBox"));
    obj.checkBox2:setParent(obj.rectangle7);
    obj.checkBox2:setAlign("right");
    obj.checkBox2:setWidth(15);
    obj.checkBox2:setField("outros.anotacoes_melhorado");
    obj.checkBox2:setName("checkBox2");

    obj.anotacoesFancy = GUI.fromHandle(_obj_newObject("richEdit"));
    obj.anotacoesFancy:setParent(obj.rectangle7);
    obj.anotacoesFancy:setName("anotacoesFancy");
    obj.anotacoesFancy:setAlign("client");
    obj.anotacoesFancy.backgroundColor = "#333333";
    obj.anotacoesFancy.defaultFontColor = "white";
    obj.anotacoesFancy:setField("outros.anotacoes2");
    obj.anotacoesFancy.hideSelection = false;
    obj.anotacoesFancy.defaultFontSize = 15;
    obj.anotacoesFancy.animateImages = true;
    obj.anotacoesFancy:setMargins({left=2, right=2, top=2, bottom=2});
    obj.anotacoesFancy:setVisible(false);

    obj.anotacoesOld = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.anotacoesOld:setParent(obj.rectangle7);
    obj.anotacoesOld:setName("anotacoesOld");
    obj.anotacoesOld:setAlign("client");
    obj.anotacoesOld:setField("outros.anotacoes");
    obj.anotacoesOld:setMargins({left=2, right=2, top=2, bottom=2});
    obj.anotacoesOld:setVisible(true);
    obj.anotacoesOld:setTransparent(true);

    obj.tab14 = GUI.fromHandle(_obj_newObject("tab"));
    obj.tab14:setParent(obj.pgcPrincipal);
    obj.tab14:setTitle("@@DnD5e.tabControl.tab.other");
    obj.tab14:setName("tab14");

    obj.button27 = GUI.fromHandle(_obj_newObject("button"));
    obj.button27:setParent(obj.tab14);
    obj.button27:setLeft(0);
    obj.button27:setTop(0);
    obj.button27:setWidth(150);
    obj.button27:setHeight(20);
    obj.button27:setText("@@Dnd5e.other.export");
    obj.button27:setName("button27");

    obj.button28 = GUI.fromHandle(_obj_newObject("button"));
    obj.button28:setParent(obj.tab14);
    obj.button28:setLeft(0);
    obj.button28:setTop(25);
    obj.button28:setWidth(150);
    obj.button28:setHeight(20);
    obj.button28:setText("@@Dnd5e.other.import");
    obj.button28:setName("button28");

    obj.button29 = GUI.fromHandle(_obj_newObject("button"));
    obj.button29:setParent(obj.tab14);
    obj.button29:setLeft(0);
    obj.button29:setTop(50);
    obj.button29:setWidth(150);
    obj.button29:setHeight(20);
    obj.button29:setText("@@Dnd5e.other.shortRest");
    obj.button29:setName("button29");

    obj.button30 = GUI.fromHandle(_obj_newObject("button"));
    obj.button30:setParent(obj.tab14);
    obj.button30:setLeft(0);
    obj.button30:setTop(75);
    obj.button30:setWidth(150);
    obj.button30:setHeight(20);
    obj.button30:setText("@@Dnd5e.other.longRest");
    obj.button30:setName("button30");

    obj.button31 = GUI.fromHandle(_obj_newObject("button"));
    obj.button31:setParent(obj.tab14);
    obj.button31:setLeft(160);
    obj.button31:setTop(0);
    obj.button31:setWidth(190);
    obj.button31:setHeight(20);
    obj.button31:setText("Exportar Statblock (.txt)");
    obj.button31:setName("button31");

    obj.button32 = GUI.fromHandle(_obj_newObject("button"));
    obj.button32:setParent(obj.tab14);
    obj.button32:setLeft(160);
    obj.button32:setTop(25);
    obj.button32:setWidth(190);
    obj.button32:setHeight(20);
    obj.button32:setText("Copiar Statblock");
    obj.button32:setName("button32");

    obj._e_event0 = obj.dataLink1:addEventListener("onChange",
        function (field, oldValue, newValue)
            self:syncPbFromCR();
        end);

    obj._e_event1 = obj.dataLink2:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.modforca = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.modforcastr = "+" .. modificador;
            					else	
            						sheet.atributos.modforcastr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.modforca = nil;
            					sheet.atributos.modforcastr = nil;
            				end;
        end);

    obj._e_event2 = obj.modforcabutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.modforcastr);
        end);

    obj._e_event3 = obj.modforcabutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.modforcastr);
        end);

    obj._e_event4 = obj.modforcabutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'forca'}, nil, true);
        end);

    obj._e_event5 = obj.modforcabutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'forca'}, nil, false);
        end);

    obj._e_event6 = obj.modforcabutton:addEventListener("onMouseEnter",
        function ()
            self.modforcabutton:setFocus();
        end);

    obj._e_event7 = obj.modforcabutton:addEventListener("onExit",
        function ()
            self.modforcastr.fontColor = "white";
        end);

    obj._e_event8 = obj.image1:addEventListener("onClick",
        function (event)
            sheet.resistencias.forca = tonumber(sheet.resistencias.forca) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.forca = (sheet.resistencias.forca + 1) % 2
            				else 
            					sheet.resistencias.forca = (sheet.resistencias.forca + 1) % 4
            				end
        end);

    obj._e_event9 = obj.dataLink4:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.forca) or 0
            				sheet.resistencias.forcaIcon = pics[counter +1];
        end);

    obj._e_event10 = obj.layout3:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonusforcastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonusforcastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event11 = obj.flpSkillFlowPart1button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart1str);
        end);

    obj._e_event12 = obj.flpSkillFlowPart1button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart1str);
        end);

    obj._e_event13 = obj.flpSkillFlowPart1button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.forca'}, nil, true);
        end);

    obj._e_event14 = obj.flpSkillFlowPart1button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.forca'}, nil, false);
        end);

    obj._e_event15 = obj.flpSkillFlowPart1button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart1button:setFocus();
        end);

    obj._e_event16 = obj.flpSkillFlowPart1button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart1str.fontColor = "white";
        end);

    obj._e_event17 = obj.dataLink5:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonusforcastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonusforcastrAltAtr]
            									local mod2 = sheet.atributos.modforca
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modforca;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.forca == true then
            									sheet.resistencias.forca = 1
            								end
            								temResistencia = sheet.resistencias.forca or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonusforca = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonusforcastr = "+" .. valor;
            								else
            									sheet.resistencias.bonusforcastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonusforca = nil;
            								sheet.resistencias.bonusforcastr = nil;
            							end;
        end);

    obj._e_event18 = obj.image2:addEventListener("onClick",
        function (event)
            sheet.pericias.atletismo = tonumber(sheet.pericias.atletismo) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.atletismo = (sheet.pericias.atletismo + 1) % 2
            				else 
            					sheet.pericias.atletismo = (sheet.pericias.atletismo + 1) % 4
            				end
        end);

    obj._e_event19 = obj.dataLink7:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.atletismo) or 0
            				sheet.pericias.atletismoIcon = pics[counter +1];
        end);

    obj._e_event20 = obj.layout4:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusatletismostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusatletismostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event21 = obj.flpSkillFlowPart2button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart2str);
        end);

    obj._e_event22 = obj.flpSkillFlowPart2button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart2str);
        end);

    obj._e_event23 = obj.flpSkillFlowPart2button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.atletismo'}, nil, true);
        end);

    obj._e_event24 = obj.flpSkillFlowPart2button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.atletismo'}, nil, false);
        end);

    obj._e_event25 = obj.flpSkillFlowPart2button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart2button:setFocus();
        end);

    obj._e_event26 = obj.flpSkillFlowPart2button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart2str.fontColor = "white";
        end);

    obj._e_event27 = obj.dataLink8:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusatletismostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusatletismostrAltAtr]
            									local mod2 = sheet.atributos.modforca
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modforca;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.atletismo == true then
            									sheet.pericias.atletismo = 1
            								end
            								temPericia = sheet.pericias.atletismo or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusatletismo	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusatletismostr = "+" .. valor;
            								else
            									sheet.pericias.bonusatletismostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusatletismo = nil;
            								sheet.pericias.bonusatletismostr = nil;
            							end;
        end);

    obj._e_event28 = obj.dataLink9:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.moddestreza = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.moddestrezastr = "+" .. modificador;
            					else	
            						sheet.atributos.moddestrezastr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.moddestreza = nil;
            					sheet.atributos.moddestrezastr = nil;
            				end;
        end);

    obj._e_event29 = obj.moddestrezabutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.moddestrezastr);
        end);

    obj._e_event30 = obj.moddestrezabutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.moddestrezastr);
        end);

    obj._e_event31 = obj.moddestrezabutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'destreza'}, nil, true);
        end);

    obj._e_event32 = obj.moddestrezabutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'destreza'}, nil, false);
        end);

    obj._e_event33 = obj.moddestrezabutton:addEventListener("onMouseEnter",
        function ()
            self.moddestrezabutton:setFocus();
        end);

    obj._e_event34 = obj.moddestrezabutton:addEventListener("onExit",
        function ()
            self.moddestrezastr.fontColor = "white";
        end);

    obj._e_event35 = obj.image3:addEventListener("onClick",
        function (event)
            sheet.resistencias.destreza = tonumber(sheet.resistencias.destreza) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.destreza = (sheet.resistencias.destreza + 1) % 2
            				else 
            					sheet.resistencias.destreza = (sheet.resistencias.destreza + 1) % 4
            				end
        end);

    obj._e_event36 = obj.dataLink11:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.destreza) or 0
            				sheet.resistencias.destrezaIcon = pics[counter +1];
        end);

    obj._e_event37 = obj.layout7:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonusdestrezastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonusdestrezastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event38 = obj.flpSkillFlowPart3button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart3str);
        end);

    obj._e_event39 = obj.flpSkillFlowPart3button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart3str);
        end);

    obj._e_event40 = obj.flpSkillFlowPart3button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.destreza'}, nil, true);
        end);

    obj._e_event41 = obj.flpSkillFlowPart3button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.destreza'}, nil, false);
        end);

    obj._e_event42 = obj.flpSkillFlowPart3button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart3button:setFocus();
        end);

    obj._e_event43 = obj.flpSkillFlowPart3button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart3str.fontColor = "white";
        end);

    obj._e_event44 = obj.dataLink12:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonusdestrezastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonusdestrezastrAltAtr]
            									local mod2 = sheet.atributos.moddestreza
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.moddestreza;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.destreza == true then
            									sheet.resistencias.destreza = 1
            								end
            								temResistencia = sheet.resistencias.destreza or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonusdestreza = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonusdestrezastr = "+" .. valor;
            								else
            									sheet.resistencias.bonusdestrezastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonusdestreza = nil;
            								sheet.resistencias.bonusdestrezastr = nil;
            							end;
        end);

    obj._e_event45 = obj.image4:addEventListener("onClick",
        function (event)
            sheet.pericias.acrobacia = tonumber(sheet.pericias.acrobacia) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.acrobacia = (sheet.pericias.acrobacia + 1) % 2
            				else 
            					sheet.pericias.acrobacia = (sheet.pericias.acrobacia + 1) % 4
            				end
        end);

    obj._e_event46 = obj.dataLink14:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.acrobacia) or 0
            				sheet.pericias.acrobaciaIcon = pics[counter +1];
        end);

    obj._e_event47 = obj.layout8:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusacrobaciastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusacrobaciastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event48 = obj.flpSkillFlowPart4button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart4str);
        end);

    obj._e_event49 = obj.flpSkillFlowPart4button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart4str);
        end);

    obj._e_event50 = obj.flpSkillFlowPart4button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.acrobacia'}, nil, true);
        end);

    obj._e_event51 = obj.flpSkillFlowPart4button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.acrobacia'}, nil, false);
        end);

    obj._e_event52 = obj.flpSkillFlowPart4button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart4button:setFocus();
        end);

    obj._e_event53 = obj.flpSkillFlowPart4button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart4str.fontColor = "white";
        end);

    obj._e_event54 = obj.dataLink15:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusacrobaciastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusacrobaciastrAltAtr]
            									local mod2 = sheet.atributos.moddestreza
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.moddestreza;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.acrobacia == true then
            									sheet.pericias.acrobacia = 1
            								end
            								temPericia = sheet.pericias.acrobacia or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusacrobacia	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusacrobaciastr = "+" .. valor;
            								else
            									sheet.pericias.bonusacrobaciastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusacrobacia = nil;
            								sheet.pericias.bonusacrobaciastr = nil;
            							end;
        end);

    obj._e_event55 = obj.image5:addEventListener("onClick",
        function (event)
            sheet.pericias.furtividade = tonumber(sheet.pericias.furtividade) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.furtividade = (sheet.pericias.furtividade + 1) % 2
            				else 
            					sheet.pericias.furtividade = (sheet.pericias.furtividade + 1) % 4
            				end
        end);

    obj._e_event56 = obj.dataLink17:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.furtividade) or 0
            				sheet.pericias.furtividadeIcon = pics[counter +1];
        end);

    obj._e_event57 = obj.layout9:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusfurtividadestrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusfurtividadestrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event58 = obj.flpSkillFlowPart5button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart5str);
        end);

    obj._e_event59 = obj.flpSkillFlowPart5button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart5str);
        end);

    obj._e_event60 = obj.flpSkillFlowPart5button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.furtividade'}, nil, true);
        end);

    obj._e_event61 = obj.flpSkillFlowPart5button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.furtividade'}, nil, false);
        end);

    obj._e_event62 = obj.flpSkillFlowPart5button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart5button:setFocus();
        end);

    obj._e_event63 = obj.flpSkillFlowPart5button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart5str.fontColor = "white";
        end);

    obj._e_event64 = obj.dataLink18:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusfurtividadestrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusfurtividadestrAltAtr]
            									local mod2 = sheet.atributos.moddestreza
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.moddestreza;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.furtividade == true then
            									sheet.pericias.furtividade = 1
            								end
            								temPericia = sheet.pericias.furtividade or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusfurtividade	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusfurtividadestr = "+" .. valor;
            								else
            									sheet.pericias.bonusfurtividadestr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusfurtividade = nil;
            								sheet.pericias.bonusfurtividadestr = nil;
            							end;
        end);

    obj._e_event65 = obj.image6:addEventListener("onClick",
        function (event)
            sheet.pericias.prestidigitacao = tonumber(sheet.pericias.prestidigitacao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.prestidigitacao = (sheet.pericias.prestidigitacao + 1) % 2
            				else 
            					sheet.pericias.prestidigitacao = (sheet.pericias.prestidigitacao + 1) % 4
            				end
        end);

    obj._e_event66 = obj.dataLink20:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.prestidigitacao) or 0
            				sheet.pericias.prestidigitacaoIcon = pics[counter +1];
        end);

    obj._e_event67 = obj.layout10:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusprestidigitacaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusprestidigitacaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event68 = obj.flpSkillFlowPart6button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart6str);
        end);

    obj._e_event69 = obj.flpSkillFlowPart6button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart6str);
        end);

    obj._e_event70 = obj.flpSkillFlowPart6button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.prestidigitacao'}, nil, true);
        end);

    obj._e_event71 = obj.flpSkillFlowPart6button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.prestidigitacao'}, nil, false);
        end);

    obj._e_event72 = obj.flpSkillFlowPart6button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart6button:setFocus();
        end);

    obj._e_event73 = obj.flpSkillFlowPart6button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart6str.fontColor = "white";
        end);

    obj._e_event74 = obj.dataLink21:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusprestidigitacaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusprestidigitacaostrAltAtr]
            									local mod2 = sheet.atributos.moddestreza
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.moddestreza;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.prestidigitacao == true then
            									sheet.pericias.prestidigitacao = 1
            								end
            								temPericia = sheet.pericias.prestidigitacao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusprestidigitacao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusprestidigitacaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusprestidigitacaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusprestidigitacao = nil;
            								sheet.pericias.bonusprestidigitacaostr = nil;
            							end;
        end);

    obj._e_event75 = obj.dataLink22:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.modconstituicao = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.modconstituicaostr = "+" .. modificador;
            					else	
            						sheet.atributos.modconstituicaostr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.modconstituicao = nil;
            					sheet.atributos.modconstituicaostr = nil;
            				end;
        end);

    obj._e_event76 = obj.modconstituicaobutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.modconstituicaostr);
        end);

    obj._e_event77 = obj.modconstituicaobutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.modconstituicaostr);
        end);

    obj._e_event78 = obj.modconstituicaobutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'constituicao'}, nil, true);
        end);

    obj._e_event79 = obj.modconstituicaobutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'constituicao'}, nil, false);
        end);

    obj._e_event80 = obj.modconstituicaobutton:addEventListener("onMouseEnter",
        function ()
            self.modconstituicaobutton:setFocus();
        end);

    obj._e_event81 = obj.modconstituicaobutton:addEventListener("onExit",
        function ()
            self.modconstituicaostr.fontColor = "white";
        end);

    obj._e_event82 = obj.image7:addEventListener("onClick",
        function (event)
            sheet.resistencias.constituicao = tonumber(sheet.resistencias.constituicao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.constituicao = (sheet.resistencias.constituicao + 1) % 2
            				else 
            					sheet.resistencias.constituicao = (sheet.resistencias.constituicao + 1) % 4
            				end
        end);

    obj._e_event83 = obj.dataLink24:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.constituicao) or 0
            				sheet.resistencias.constituicaoIcon = pics[counter +1];
        end);

    obj._e_event84 = obj.layout13:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonusconstituicaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonusconstituicaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event85 = obj.flpSkillFlowPart7button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart7str);
        end);

    obj._e_event86 = obj.flpSkillFlowPart7button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart7str);
        end);

    obj._e_event87 = obj.flpSkillFlowPart7button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.constituicao'}, nil, true);
        end);

    obj._e_event88 = obj.flpSkillFlowPart7button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.constituicao'}, nil, false);
        end);

    obj._e_event89 = obj.flpSkillFlowPart7button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart7button:setFocus();
        end);

    obj._e_event90 = obj.flpSkillFlowPart7button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart7str.fontColor = "white";
        end);

    obj._e_event91 = obj.dataLink25:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonusconstituicaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonusconstituicaostrAltAtr]
            									local mod2 = sheet.atributos.modconstituicao
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modconstituicao;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.constituicao == true then
            									sheet.resistencias.constituicao = 1
            								end
            								temResistencia = sheet.resistencias.constituicao or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonusconstituicao = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonusconstituicaostr = "+" .. valor;
            								else
            									sheet.resistencias.bonusconstituicaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonusconstituicao = nil;
            								sheet.resistencias.bonusconstituicaostr = nil;
            							end;
        end);

    obj._e_event92 = obj.dataLink26:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.modinteligencia = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.modinteligenciastr = "+" .. modificador;
            					else	
            						sheet.atributos.modinteligenciastr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.modinteligencia = nil;
            					sheet.atributos.modinteligenciastr = nil;
            				end;
        end);

    obj._e_event93 = obj.modinteligenciabutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.modinteligenciastr);
        end);

    obj._e_event94 = obj.modinteligenciabutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.modinteligenciastr);
        end);

    obj._e_event95 = obj.modinteligenciabutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'inteligencia'}, nil, true);
        end);

    obj._e_event96 = obj.modinteligenciabutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'inteligencia'}, nil, false);
        end);

    obj._e_event97 = obj.modinteligenciabutton:addEventListener("onMouseEnter",
        function ()
            self.modinteligenciabutton:setFocus();
        end);

    obj._e_event98 = obj.modinteligenciabutton:addEventListener("onExit",
        function ()
            self.modinteligenciastr.fontColor = "white";
        end);

    obj._e_event99 = obj.image8:addEventListener("onClick",
        function (event)
            sheet.resistencias.inteligencia = tonumber(sheet.resistencias.inteligencia) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.inteligencia = (sheet.resistencias.inteligencia + 1) % 2
            				else 
            					sheet.resistencias.inteligencia = (sheet.resistencias.inteligencia + 1) % 4
            				end
        end);

    obj._e_event100 = obj.dataLink28:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.inteligencia) or 0
            				sheet.resistencias.inteligenciaIcon = pics[counter +1];
        end);

    obj._e_event101 = obj.layout16:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonusinteligenciastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonusinteligenciastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event102 = obj.flpSkillFlowPart8button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart8str);
        end);

    obj._e_event103 = obj.flpSkillFlowPart8button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart8str);
        end);

    obj._e_event104 = obj.flpSkillFlowPart8button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.inteligencia'}, nil, true);
        end);

    obj._e_event105 = obj.flpSkillFlowPart8button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.inteligencia'}, nil, false);
        end);

    obj._e_event106 = obj.flpSkillFlowPart8button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart8button:setFocus();
        end);

    obj._e_event107 = obj.flpSkillFlowPart8button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart8str.fontColor = "white";
        end);

    obj._e_event108 = obj.dataLink29:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonusinteligenciastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonusinteligenciastrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.inteligencia == true then
            									sheet.resistencias.inteligencia = 1
            								end
            								temResistencia = sheet.resistencias.inteligencia or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonusinteligencia = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonusinteligenciastr = "+" .. valor;
            								else
            									sheet.resistencias.bonusinteligenciastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonusinteligencia = nil;
            								sheet.resistencias.bonusinteligenciastr = nil;
            							end;
        end);

    obj._e_event109 = obj.image9:addEventListener("onClick",
        function (event)
            sheet.pericias.arcanismo = tonumber(sheet.pericias.arcanismo) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.arcanismo = (sheet.pericias.arcanismo + 1) % 2
            				else 
            					sheet.pericias.arcanismo = (sheet.pericias.arcanismo + 1) % 4
            				end
        end);

    obj._e_event110 = obj.dataLink31:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.arcanismo) or 0
            				sheet.pericias.arcanismoIcon = pics[counter +1];
        end);

    obj._e_event111 = obj.layout17:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusarcanismostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusarcanismostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event112 = obj.flpSkillFlowPart9button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart9str);
        end);

    obj._e_event113 = obj.flpSkillFlowPart9button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart9str);
        end);

    obj._e_event114 = obj.flpSkillFlowPart9button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.arcanismo'}, nil, true);
        end);

    obj._e_event115 = obj.flpSkillFlowPart9button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.arcanismo'}, nil, false);
        end);

    obj._e_event116 = obj.flpSkillFlowPart9button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart9button:setFocus();
        end);

    obj._e_event117 = obj.flpSkillFlowPart9button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart9str.fontColor = "white";
        end);

    obj._e_event118 = obj.dataLink32:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusarcanismostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusarcanismostrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.arcanismo == true then
            									sheet.pericias.arcanismo = 1
            								end
            								temPericia = sheet.pericias.arcanismo or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusarcanismo	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusarcanismostr = "+" .. valor;
            								else
            									sheet.pericias.bonusarcanismostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusarcanismo = nil;
            								sheet.pericias.bonusarcanismostr = nil;
            							end;
        end);

    obj._e_event119 = obj.image10:addEventListener("onClick",
        function (event)
            sheet.pericias.historia = tonumber(sheet.pericias.historia) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.historia = (sheet.pericias.historia + 1) % 2
            				else 
            					sheet.pericias.historia = (sheet.pericias.historia + 1) % 4
            				end
        end);

    obj._e_event120 = obj.dataLink34:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.historia) or 0
            				sheet.pericias.historiaIcon = pics[counter +1];
        end);

    obj._e_event121 = obj.layout18:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonushistoriastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonushistoriastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event122 = obj.flpSkillFlowPart10button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart10str);
        end);

    obj._e_event123 = obj.flpSkillFlowPart10button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart10str);
        end);

    obj._e_event124 = obj.flpSkillFlowPart10button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.historia'}, nil, true);
        end);

    obj._e_event125 = obj.flpSkillFlowPart10button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.historia'}, nil, false);
        end);

    obj._e_event126 = obj.flpSkillFlowPart10button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart10button:setFocus();
        end);

    obj._e_event127 = obj.flpSkillFlowPart10button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart10str.fontColor = "white";
        end);

    obj._e_event128 = obj.dataLink35:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonushistoriastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonushistoriastrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.historia == true then
            									sheet.pericias.historia = 1
            								end
            								temPericia = sheet.pericias.historia or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonushistoria	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonushistoriastr = "+" .. valor;
            								else
            									sheet.pericias.bonushistoriastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonushistoria = nil;
            								sheet.pericias.bonushistoriastr = nil;
            							end;
        end);

    obj._e_event129 = obj.image11:addEventListener("onClick",
        function (event)
            sheet.pericias.investigacao = tonumber(sheet.pericias.investigacao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.investigacao = (sheet.pericias.investigacao + 1) % 2
            				else 
            					sheet.pericias.investigacao = (sheet.pericias.investigacao + 1) % 4
            				end
        end);

    obj._e_event130 = obj.dataLink37:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.investigacao) or 0
            				sheet.pericias.investigacaoIcon = pics[counter +1];
        end);

    obj._e_event131 = obj.layout19:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusinvestigacaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusinvestigacaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event132 = obj.flpSkillFlowPart11button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart11str);
        end);

    obj._e_event133 = obj.flpSkillFlowPart11button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart11str);
        end);

    obj._e_event134 = obj.flpSkillFlowPart11button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.investigacao'}, nil, true);
        end);

    obj._e_event135 = obj.flpSkillFlowPart11button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.investigacao'}, nil, false);
        end);

    obj._e_event136 = obj.flpSkillFlowPart11button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart11button:setFocus();
        end);

    obj._e_event137 = obj.flpSkillFlowPart11button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart11str.fontColor = "white";
        end);

    obj._e_event138 = obj.dataLink38:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusinvestigacaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusinvestigacaostrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.investigacao == true then
            									sheet.pericias.investigacao = 1
            								end
            								temPericia = sheet.pericias.investigacao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusinvestigacao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusinvestigacaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusinvestigacaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusinvestigacao = nil;
            								sheet.pericias.bonusinvestigacaostr = nil;
            							end;
        end);

    obj._e_event139 = obj.image12:addEventListener("onClick",
        function (event)
            sheet.pericias.natureza = tonumber(sheet.pericias.natureza) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.natureza = (sheet.pericias.natureza + 1) % 2
            				else 
            					sheet.pericias.natureza = (sheet.pericias.natureza + 1) % 4
            				end
        end);

    obj._e_event140 = obj.dataLink40:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.natureza) or 0
            				sheet.pericias.naturezaIcon = pics[counter +1];
        end);

    obj._e_event141 = obj.layout20:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusnaturezastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusnaturezastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event142 = obj.flpSkillFlowPart12button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart12str);
        end);

    obj._e_event143 = obj.flpSkillFlowPart12button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart12str);
        end);

    obj._e_event144 = obj.flpSkillFlowPart12button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.natureza'}, nil, true);
        end);

    obj._e_event145 = obj.flpSkillFlowPart12button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.natureza'}, nil, false);
        end);

    obj._e_event146 = obj.flpSkillFlowPart12button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart12button:setFocus();
        end);

    obj._e_event147 = obj.flpSkillFlowPart12button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart12str.fontColor = "white";
        end);

    obj._e_event148 = obj.dataLink41:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusnaturezastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusnaturezastrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.natureza == true then
            									sheet.pericias.natureza = 1
            								end
            								temPericia = sheet.pericias.natureza or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusnatureza	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusnaturezastr = "+" .. valor;
            								else
            									sheet.pericias.bonusnaturezastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusnatureza = nil;
            								sheet.pericias.bonusnaturezastr = nil;
            							end;
        end);

    obj._e_event149 = obj.image13:addEventListener("onClick",
        function (event)
            sheet.pericias.religiao = tonumber(sheet.pericias.religiao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.religiao = (sheet.pericias.religiao + 1) % 2
            				else 
            					sheet.pericias.religiao = (sheet.pericias.religiao + 1) % 4
            				end
        end);

    obj._e_event150 = obj.dataLink43:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.religiao) or 0
            				sheet.pericias.religiaoIcon = pics[counter +1];
        end);

    obj._e_event151 = obj.layout21:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusreligiaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusreligiaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event152 = obj.flpSkillFlowPart13button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart13str);
        end);

    obj._e_event153 = obj.flpSkillFlowPart13button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart13str);
        end);

    obj._e_event154 = obj.flpSkillFlowPart13button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.religiao'}, nil, true);
        end);

    obj._e_event155 = obj.flpSkillFlowPart13button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.religiao'}, nil, false);
        end);

    obj._e_event156 = obj.flpSkillFlowPart13button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart13button:setFocus();
        end);

    obj._e_event157 = obj.flpSkillFlowPart13button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart13str.fontColor = "white";
        end);

    obj._e_event158 = obj.dataLink44:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusreligiaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusreligiaostrAltAtr]
            									local mod2 = sheet.atributos.modinteligencia
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modinteligencia;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.religiao == true then
            									sheet.pericias.religiao = 1
            								end
            								temPericia = sheet.pericias.religiao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusreligiao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusreligiaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusreligiaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusreligiao = nil;
            								sheet.pericias.bonusreligiaostr = nil;
            							end;
        end);

    obj._e_event159 = obj.dataLink45:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.modsabedoria = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.modsabedoriastr = "+" .. modificador;
            					else	
            						sheet.atributos.modsabedoriastr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.modsabedoria = nil;
            					sheet.atributos.modsabedoriastr = nil;
            				end;
        end);

    obj._e_event160 = obj.modsabedoriabutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.modsabedoriastr);
        end);

    obj._e_event161 = obj.modsabedoriabutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.modsabedoriastr);
        end);

    obj._e_event162 = obj.modsabedoriabutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'sabedoria'}, nil, true);
        end);

    obj._e_event163 = obj.modsabedoriabutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'sabedoria'}, nil, false);
        end);

    obj._e_event164 = obj.modsabedoriabutton:addEventListener("onMouseEnter",
        function ()
            self.modsabedoriabutton:setFocus();
        end);

    obj._e_event165 = obj.modsabedoriabutton:addEventListener("onExit",
        function ()
            self.modsabedoriastr.fontColor = "white";
        end);

    obj._e_event166 = obj.image14:addEventListener("onClick",
        function (event)
            sheet.resistencias.sabedoria = tonumber(sheet.resistencias.sabedoria) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.sabedoria = (sheet.resistencias.sabedoria + 1) % 2
            				else 
            					sheet.resistencias.sabedoria = (sheet.resistencias.sabedoria + 1) % 4
            				end
        end);

    obj._e_event167 = obj.dataLink47:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.sabedoria) or 0
            				sheet.resistencias.sabedoriaIcon = pics[counter +1];
        end);

    obj._e_event168 = obj.layout24:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonussabedoriastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonussabedoriastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event169 = obj.flpSkillFlowPart14button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart14str);
        end);

    obj._e_event170 = obj.flpSkillFlowPart14button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart14str);
        end);

    obj._e_event171 = obj.flpSkillFlowPart14button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.sabedoria'}, nil, true);
        end);

    obj._e_event172 = obj.flpSkillFlowPart14button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.sabedoria'}, nil, false);
        end);

    obj._e_event173 = obj.flpSkillFlowPart14button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart14button:setFocus();
        end);

    obj._e_event174 = obj.flpSkillFlowPart14button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart14str.fontColor = "white";
        end);

    obj._e_event175 = obj.dataLink48:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonussabedoriastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonussabedoriastrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.sabedoria == true then
            									sheet.resistencias.sabedoria = 1
            								end
            								temResistencia = sheet.resistencias.sabedoria or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonussabedoria = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonussabedoriastr = "+" .. valor;
            								else
            									sheet.resistencias.bonussabedoriastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonussabedoria = nil;
            								sheet.resistencias.bonussabedoriastr = nil;
            							end;
        end);

    obj._e_event176 = obj.image15:addEventListener("onClick",
        function (event)
            sheet.pericias.adestrarAnimais = tonumber(sheet.pericias.adestrarAnimais) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.adestrarAnimais = (sheet.pericias.adestrarAnimais + 1) % 2
            				else 
            					sheet.pericias.adestrarAnimais = (sheet.pericias.adestrarAnimais + 1) % 4
            				end
        end);

    obj._e_event177 = obj.dataLink50:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.adestrarAnimais) or 0
            				sheet.pericias.adestrarAnimaisIcon = pics[counter +1];
        end);

    obj._e_event178 = obj.layout25:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusadestrarAnimaisstrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusadestrarAnimaisstrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event179 = obj.flpSkillFlowPart15button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart15str);
        end);

    obj._e_event180 = obj.flpSkillFlowPart15button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart15str);
        end);

    obj._e_event181 = obj.flpSkillFlowPart15button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.adestrarAnimais'}, nil, true);
        end);

    obj._e_event182 = obj.flpSkillFlowPart15button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.adestrarAnimais'}, nil, false);
        end);

    obj._e_event183 = obj.flpSkillFlowPart15button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart15button:setFocus();
        end);

    obj._e_event184 = obj.flpSkillFlowPart15button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart15str.fontColor = "white";
        end);

    obj._e_event185 = obj.dataLink51:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusadestrarAnimaisstrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusadestrarAnimaisstrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.adestrarAnimais == true then
            									sheet.pericias.adestrarAnimais = 1
            								end
            								temPericia = sheet.pericias.adestrarAnimais or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusadestrarAnimais	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusadestrarAnimaisstr = "+" .. valor;
            								else
            									sheet.pericias.bonusadestrarAnimaisstr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusadestrarAnimais = nil;
            								sheet.pericias.bonusadestrarAnimaisstr = nil;
            							end;
        end);

    obj._e_event186 = obj.image16:addEventListener("onClick",
        function (event)
            sheet.pericias.intuicao = tonumber(sheet.pericias.intuicao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.intuicao = (sheet.pericias.intuicao + 1) % 2
            				else 
            					sheet.pericias.intuicao = (sheet.pericias.intuicao + 1) % 4
            				end
        end);

    obj._e_event187 = obj.dataLink53:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.intuicao) or 0
            				sheet.pericias.intuicaoIcon = pics[counter +1];
        end);

    obj._e_event188 = obj.layout26:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusintuicaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusintuicaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event189 = obj.flpSkillFlowPart16button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart16str);
        end);

    obj._e_event190 = obj.flpSkillFlowPart16button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart16str);
        end);

    obj._e_event191 = obj.flpSkillFlowPart16button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.intuicao'}, nil, true);
        end);

    obj._e_event192 = obj.flpSkillFlowPart16button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.intuicao'}, nil, false);
        end);

    obj._e_event193 = obj.flpSkillFlowPart16button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart16button:setFocus();
        end);

    obj._e_event194 = obj.flpSkillFlowPart16button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart16str.fontColor = "white";
        end);

    obj._e_event195 = obj.dataLink54:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusintuicaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusintuicaostrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.intuicao == true then
            									sheet.pericias.intuicao = 1
            								end
            								temPericia = sheet.pericias.intuicao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusintuicao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusintuicaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusintuicaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusintuicao = nil;
            								sheet.pericias.bonusintuicaostr = nil;
            							end;
        end);

    obj._e_event196 = obj.image17:addEventListener("onClick",
        function (event)
            sheet.pericias.medicina = tonumber(sheet.pericias.medicina) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.medicina = (sheet.pericias.medicina + 1) % 2
            				else 
            					sheet.pericias.medicina = (sheet.pericias.medicina + 1) % 4
            				end
        end);

    obj._e_event197 = obj.dataLink56:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.medicina) or 0
            				sheet.pericias.medicinaIcon = pics[counter +1];
        end);

    obj._e_event198 = obj.layout27:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusmedicinastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusmedicinastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event199 = obj.flpSkillFlowPart17button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart17str);
        end);

    obj._e_event200 = obj.flpSkillFlowPart17button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart17str);
        end);

    obj._e_event201 = obj.flpSkillFlowPart17button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.medicina'}, nil, true);
        end);

    obj._e_event202 = obj.flpSkillFlowPart17button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.medicina'}, nil, false);
        end);

    obj._e_event203 = obj.flpSkillFlowPart17button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart17button:setFocus();
        end);

    obj._e_event204 = obj.flpSkillFlowPart17button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart17str.fontColor = "white";
        end);

    obj._e_event205 = obj.dataLink57:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusmedicinastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusmedicinastrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.medicina == true then
            									sheet.pericias.medicina = 1
            								end
            								temPericia = sheet.pericias.medicina or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusmedicina	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusmedicinastr = "+" .. valor;
            								else
            									sheet.pericias.bonusmedicinastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusmedicina = nil;
            								sheet.pericias.bonusmedicinastr = nil;
            							end;
        end);

    obj._e_event206 = obj.image18:addEventListener("onClick",
        function (event)
            sheet.pericias.percepcao = tonumber(sheet.pericias.percepcao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.percepcao = (sheet.pericias.percepcao + 1) % 2
            				else 
            					sheet.pericias.percepcao = (sheet.pericias.percepcao + 1) % 4
            				end
        end);

    obj._e_event207 = obj.dataLink59:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.percepcao) or 0
            				sheet.pericias.percepcaoIcon = pics[counter +1];
        end);

    obj._e_event208 = obj.layout28:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonuspercepcaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonuspercepcaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event209 = obj.flpSkillFlowPart18button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart18str);
        end);

    obj._e_event210 = obj.flpSkillFlowPart18button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart18str);
        end);

    obj._e_event211 = obj.flpSkillFlowPart18button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.percepcao'}, nil, true);
        end);

    obj._e_event212 = obj.flpSkillFlowPart18button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.percepcao'}, nil, false);
        end);

    obj._e_event213 = obj.flpSkillFlowPart18button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart18button:setFocus();
        end);

    obj._e_event214 = obj.flpSkillFlowPart18button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart18str.fontColor = "white";
        end);

    obj._e_event215 = obj.dataLink60:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonuspercepcaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonuspercepcaostrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.percepcao == true then
            									sheet.pericias.percepcao = 1
            								end
            								temPericia = sheet.pericias.percepcao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonuspercepcao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonuspercepcaostr = "+" .. valor;
            								else
            									sheet.pericias.bonuspercepcaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonuspercepcao = nil;
            								sheet.pericias.bonuspercepcaostr = nil;
            							end;
        end);

    obj._e_event216 = obj.image19:addEventListener("onClick",
        function (event)
            sheet.pericias.sobrevivencia = tonumber(sheet.pericias.sobrevivencia) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.sobrevivencia = (sheet.pericias.sobrevivencia + 1) % 2
            				else 
            					sheet.pericias.sobrevivencia = (sheet.pericias.sobrevivencia + 1) % 4
            				end
        end);

    obj._e_event217 = obj.dataLink62:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.sobrevivencia) or 0
            				sheet.pericias.sobrevivenciaIcon = pics[counter +1];
        end);

    obj._e_event218 = obj.layout29:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonussobrevivenciastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonussobrevivenciastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event219 = obj.flpSkillFlowPart19button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart19str);
        end);

    obj._e_event220 = obj.flpSkillFlowPart19button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart19str);
        end);

    obj._e_event221 = obj.flpSkillFlowPart19button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.sobrevivencia'}, nil, true);
        end);

    obj._e_event222 = obj.flpSkillFlowPart19button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.sobrevivencia'}, nil, false);
        end);

    obj._e_event223 = obj.flpSkillFlowPart19button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart19button:setFocus();
        end);

    obj._e_event224 = obj.flpSkillFlowPart19button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart19str.fontColor = "white";
        end);

    obj._e_event225 = obj.dataLink63:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonussobrevivenciastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonussobrevivenciastrAltAtr]
            									local mod2 = sheet.atributos.modsabedoria
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modsabedoria;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.sobrevivencia == true then
            									sheet.pericias.sobrevivencia = 1
            								end
            								temPericia = sheet.pericias.sobrevivencia or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonussobrevivencia	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonussobrevivenciastr = "+" .. valor;
            								else
            									sheet.pericias.bonussobrevivenciastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonussobrevivencia = nil;
            								sheet.pericias.bonussobrevivenciastr = nil;
            							end;
        end);

    obj._e_event226 = obj.dataLink64:addEventListener("onChange",
        function (field, oldValue, newValue)
            local numAsStr = tostring(newValue);
            				local numero;
            				
            				if numAsStr ~= "" then
            					numero = tonumber(newValue);
            				else
            					numero = nil;
            				end;
            
            				if type(sheet.atributos) ~= 'table' then
            					sheet.atributos = {};
            				end;				
            				
            				if type(numero) == 'number' then
            					local modificador = math.floor(numero / 2) - 5;								
            					sheet.atributos.modcarisma = modificador;	
            				
            					if modificador >= 0 then
            						sheet.atributos.modcarismastr = "+" .. modificador;
            					else	
            						sheet.atributos.modcarismastr = "-" .. math.abs(modificador);
            					end;	
            				else
            					sheet.atributos.modcarisma = nil;
            					sheet.atributos.modcarismastr = nil;
            				end;
        end);

    obj._e_event227 = obj.modcarismabutton:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.modcarismastr);
        end);

    obj._e_event228 = obj.modcarismabutton:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.modcarismastr);
        end);

    obj._e_event229 = obj.modcarismabutton:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'carisma'}, nil, true);
        end);

    obj._e_event230 = obj.modcarismabutton:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'attr', field = 'carisma'}, nil, false);
        end);

    obj._e_event231 = obj.modcarismabutton:addEventListener("onMouseEnter",
        function ()
            self.modcarismabutton:setFocus();
        end);

    obj._e_event232 = obj.modcarismabutton:addEventListener("onExit",
        function ()
            self.modcarismastr.fontColor = "white";
        end);

    obj._e_event233 = obj.image20:addEventListener("onClick",
        function (event)
            sheet.resistencias.carisma = tonumber(sheet.resistencias.carisma) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("true" == "true") then
            					sheet.resistencias.carisma = (sheet.resistencias.carisma + 1) % 2
            				else 
            					sheet.resistencias.carisma = (sheet.resistencias.carisma + 1) % 4
            				end
        end);

    obj._e_event234 = obj.dataLink66:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("true" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.resistencias.carisma) or 0
            				sheet.resistencias.carismaIcon = pics[counter +1];
        end);

    obj._e_event235 = obj.layout32:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.resistencias.bonuscarismastrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.resistencias.bonuscarismastrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event236 = obj.flpSkillFlowPart20button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart20str);
        end);

    obj._e_event237 = obj.flpSkillFlowPart20button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart20str);
        end);

    obj._e_event238 = obj.flpSkillFlowPart20button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.carisma'}, nil, true);
        end);

    obj._e_event239 = obj.flpSkillFlowPart20button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'resistencias.carisma'}, nil, false);
        end);

    obj._e_event240 = obj.flpSkillFlowPart20button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart20button:setFocus();
        end);

    obj._e_event241 = obj.flpSkillFlowPart20button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart20str.fontColor = "white";
        end);

    obj._e_event242 = obj.dataLink67:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temResistencia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.resistencias.bonuscarismastrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.resistencias.bonuscarismastrAltAtr]
            									local mod2 = sheet.atributos.modcarisma
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modcarisma;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.resistencias ~= nil then
            								if sheet.resistencias.carisma == true then
            									sheet.resistencias.carisma = 1
            								end
            								temResistencia = sheet.resistencias.carisma or 0;
            							else
            								temResistencia = 0;
            								sheet.resistencias = {};
            							end;
            													
            							if modificador ~= nil then
            								local valor;
            							
            								if temResistencia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusResistencias) or 0)					
            								
            								valor = math.tointeger(valor);
            								
            								sheet.resistencias.bonuscarisma = valor;
            								
            								if valor >= 0 then
            									sheet.resistencias.bonuscarismastr = "+" .. valor;
            								else
            									sheet.resistencias.bonuscarismastr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.resistencias.bonuscarisma = nil;
            								sheet.resistencias.bonuscarismastr = nil;
            							end;
        end);

    obj._e_event243 = obj.image21:addEventListener("onClick",
        function (event)
            sheet.pericias.atuacao = tonumber(sheet.pericias.atuacao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.atuacao = (sheet.pericias.atuacao + 1) % 2
            				else 
            					sheet.pericias.atuacao = (sheet.pericias.atuacao + 1) % 4
            				end
        end);

    obj._e_event244 = obj.dataLink69:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.atuacao) or 0
            				sheet.pericias.atuacaoIcon = pics[counter +1];
        end);

    obj._e_event245 = obj.layout33:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusatuacaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusatuacaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event246 = obj.flpSkillFlowPart21button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart21str);
        end);

    obj._e_event247 = obj.flpSkillFlowPart21button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart21str);
        end);

    obj._e_event248 = obj.flpSkillFlowPart21button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.atuacao'}, nil, true);
        end);

    obj._e_event249 = obj.flpSkillFlowPart21button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.atuacao'}, nil, false);
        end);

    obj._e_event250 = obj.flpSkillFlowPart21button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart21button:setFocus();
        end);

    obj._e_event251 = obj.flpSkillFlowPart21button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart21str.fontColor = "white";
        end);

    obj._e_event252 = obj.dataLink70:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusatuacaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusatuacaostrAltAtr]
            									local mod2 = sheet.atributos.modcarisma
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modcarisma;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.atuacao == true then
            									sheet.pericias.atuacao = 1
            								end
            								temPericia = sheet.pericias.atuacao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusatuacao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusatuacaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusatuacaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusatuacao = nil;
            								sheet.pericias.bonusatuacaostr = nil;
            							end;
        end);

    obj._e_event253 = obj.image22:addEventListener("onClick",
        function (event)
            sheet.pericias.enganacao = tonumber(sheet.pericias.enganacao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.enganacao = (sheet.pericias.enganacao + 1) % 2
            				else 
            					sheet.pericias.enganacao = (sheet.pericias.enganacao + 1) % 4
            				end
        end);

    obj._e_event254 = obj.dataLink72:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.enganacao) or 0
            				sheet.pericias.enganacaoIcon = pics[counter +1];
        end);

    obj._e_event255 = obj.layout34:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusenganacaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusenganacaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event256 = obj.flpSkillFlowPart22button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart22str);
        end);

    obj._e_event257 = obj.flpSkillFlowPart22button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart22str);
        end);

    obj._e_event258 = obj.flpSkillFlowPart22button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.enganacao'}, nil, true);
        end);

    obj._e_event259 = obj.flpSkillFlowPart22button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.enganacao'}, nil, false);
        end);

    obj._e_event260 = obj.flpSkillFlowPart22button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart22button:setFocus();
        end);

    obj._e_event261 = obj.flpSkillFlowPart22button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart22str.fontColor = "white";
        end);

    obj._e_event262 = obj.dataLink73:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusenganacaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusenganacaostrAltAtr]
            									local mod2 = sheet.atributos.modcarisma
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modcarisma;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.enganacao == true then
            									sheet.pericias.enganacao = 1
            								end
            								temPericia = sheet.pericias.enganacao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusenganacao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusenganacaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusenganacaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusenganacao = nil;
            								sheet.pericias.bonusenganacaostr = nil;
            							end;
        end);

    obj._e_event263 = obj.image23:addEventListener("onClick",
        function (event)
            sheet.pericias.intimidacao = tonumber(sheet.pericias.intimidacao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.intimidacao = (sheet.pericias.intimidacao + 1) % 2
            				else 
            					sheet.pericias.intimidacao = (sheet.pericias.intimidacao + 1) % 4
            				end
        end);

    obj._e_event264 = obj.dataLink75:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.intimidacao) or 0
            				sheet.pericias.intimidacaoIcon = pics[counter +1];
        end);

    obj._e_event265 = obj.layout35:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonusintimidacaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonusintimidacaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event266 = obj.flpSkillFlowPart23button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart23str);
        end);

    obj._e_event267 = obj.flpSkillFlowPart23button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart23str);
        end);

    obj._e_event268 = obj.flpSkillFlowPart23button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.intimidacao'}, nil, true);
        end);

    obj._e_event269 = obj.flpSkillFlowPart23button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.intimidacao'}, nil, false);
        end);

    obj._e_event270 = obj.flpSkillFlowPart23button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart23button:setFocus();
        end);

    obj._e_event271 = obj.flpSkillFlowPart23button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart23str.fontColor = "white";
        end);

    obj._e_event272 = obj.dataLink76:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonusintimidacaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonusintimidacaostrAltAtr]
            									local mod2 = sheet.atributos.modcarisma
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modcarisma;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.intimidacao == true then
            									sheet.pericias.intimidacao = 1
            								end
            								temPericia = sheet.pericias.intimidacao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonusintimidacao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonusintimidacaostr = "+" .. valor;
            								else
            									sheet.pericias.bonusintimidacaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonusintimidacao = nil;
            								sheet.pericias.bonusintimidacaostr = nil;
            							end;
        end);

    obj._e_event273 = obj.image24:addEventListener("onClick",
        function (event)
            sheet.pericias.persuasao = tonumber(sheet.pericias.persuasao) or 0
            
            				-- Contador que vai de 0 a 1/3 e reseta ao passar de 1/3
            				if ("" == "true") then
            					sheet.pericias.persuasao = (sheet.pericias.persuasao + 1) % 2
            				else 
            					sheet.pericias.persuasao = (sheet.pericias.persuasao + 1) % 4
            				end
        end);

    obj._e_event274 = obj.dataLink78:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet == nil then return end
            				local pics
            
            				if ("" == "true") then
            					pics = {"http://blob.firecast.com.br/blobs/RBKNDVWO_2605563/checkbox2_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/OLODVDPF_2605569/checkbox2_checked.png"}
            				else
            					pics = {"http://blob.firecast.com.br/blobs/RWKSJIFU_781555/checkbox1_unchecked.png", 
            							"http://blob.firecast.com.br/blobs/MQFHLDSL_144272.png",
            							"http://blob.firecast.com.br/blobs/NLIQSGPU_2605567/checkbox1_double_checked.png",
            							"http://blob.firecast.com.br/blobs/HARRKEHM_2605564/checkbox1_half_checked.png"}
            				end;
            
            				local counter = tonumber(sheet.pericias.persuasao) or 0
            				sheet.pericias.persuasaoIcon = pics[counter +1];
        end);

    obj._e_event275 = obj.layout36:addEventListener("onClick",
        function (event)
            Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("Dnd5e.messages.atrCaptionOpt1"), LANG("Dnd5e.messages.atrCaptionOpt2")},
            		               function(selected, selectedIndex, selectedText)
            		                	if selected then
            		                		if selectedIndex==1 then
            		                			Dialogs.choose(LANG("Dnd5e.messages.atrCaption"), {LANG("DnD5e.spells.resistance.str"),LANG("DnD5e.spells.resistance.dex"),LANG("DnD5e.spells.resistance.con"),LANG("DnD5e.spells.resistance.int"),LANG("DnD5e.spells.resistance.wis"),LANG("DnD5e.spells.resistance.cha"),"-"},
            						               function(selected, selectedIndex, selectedText)
            						                	if selected then
            						                		local atr = {"forca","destreza","constituicao","inteligencia","sabedoria","carisma",nil}
            						                		sheet.pericias.bonuspersuasaostrAltAtr = atr[selectedIndex]
            						                	end
            						               end)
            		                		elseif selectedIndex==2 then
            		                			Dialogs.inputQuery(LANG("Dnd5e.messages.atrCaptionOpt2"), "", "1",
            								        function (valorPreenchido)
            								            sheet.pericias.bonuspersuasaostrMinRoll = tonumber(valorPreenchido)
            								        end)
            		                		end
            		                	end
            		               end,1)
        end);

    obj._e_event276 = obj.flpSkillFlowPart24button:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.flpSkillFlowPart24str);
        end);

    obj._e_event277 = obj.flpSkillFlowPart24button:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.flpSkillFlowPart24str);
        end);

    obj._e_event278 = obj.flpSkillFlowPart24button:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.persuasao'}, nil, true);
        end);

    obj._e_event279 = obj.flpSkillFlowPart24button:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaPericia, { tipo = 'per', field = 'pericias.persuasao'}, nil, false);
        end);

    obj._e_event280 = obj.flpSkillFlowPart24button:addEventListener("onMouseEnter",
        function ()
            self.flpSkillFlowPart24button:setFocus();
        end);

    obj._e_event281 = obj.flpSkillFlowPart24button:addEventListener("onExit",
        function ()
            self.flpSkillFlowPart24str.fontColor = "white";
        end);

    obj._e_event282 = obj.dataLink79:addEventListener("onChange",
        function (field, oldValue, newValue)
            local modificador;
            							local temPericia;
            									
            							if sheet.atributos ~= nil then
            								if sheet.pericias.bonuspersuasaostrAltAtr ~= nil then
            									local mod1 = sheet.atributos["mod"..sheet.pericias.bonuspersuasaostrAltAtr]
            									local mod2 = sheet.atributos.modcarisma
            
            									modificador = math.max(mod1, mod2)
            
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								else
            									modificador = sheet.atributos.modcarisma;
            									
            									if modificador ~= nil then
            										modificador = tonumber(modificador);
            									end;
            								end
            							else
            								modificador = nil;
            							end;
            							
            							if sheet.pericias ~= nil then
            								if sheet.pericias.persuasao == true then
            									sheet.pericias.persuasao = 1
            								end
            								temPericia = sheet.pericias.persuasao or 0;
            							else
            								temPericia = 0;
            								sheet.pericias = {};
            							end;
            													
            							
            							if modificador ~= nil then
            								local valor;
            							
            								if temPericia == 1 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)
            								elseif temPericia == 2 then
            									valor = modificador	+ (tonumber(sheet.bonusProficiencia) or 0)*2
            								elseif temPericia == 3 then
            									valor = modificador	+ math.floor((tonumber(sheet.bonusProficiencia) or 0)/2)
            								else
            									valor = modificador;
            								end;
            
            								valor = valor + (tonumber(sheet.bonusHabilidades) or 0)			
            								
            								valor = math.tointeger(valor);
            								
            								sheet.pericias.bonuspersuasao	= valor;
            								
            								if valor >= 0 then
            									sheet.pericias.bonuspersuasaostr = "+" .. valor;
            								else
            									sheet.pericias.bonuspersuasaostr = "-" .. math.abs(valor);
            								end;
            							else
            								sheet.pericias.bonuspersuasao = nil;
            								sheet.pericias.bonuspersuasaostr = nil;
            							end;
        end);

    obj._e_event283 = obj.initiativeBut:addEventListener("onKeyDown",
        function (event)
            common.keyDown(sheet, event, self.initiativeVal);
        end);

    obj._e_event284 = obj.initiativeBut:addEventListener("onKeyUp",
        function (event)
            common.keyUp(sheet, event, self.initiativeVal);
        end);

    obj._e_event285 = obj.initiativeBut:addEventListener("onClick",
        function (event)
            common.onClick(sheet, common.rolaIniciativa, nil, nil, true);
        end);

    obj._e_event286 = obj.initiativeBut:addEventListener("onMenu",
        function (x, y, event)
            common.onClick(sheet, common.rolaIniciativa, nil, nil, false);
        end);

    obj._e_event287 = obj.initiativeBut:addEventListener("onMouseEnter",
        function ()
            self.initiativeBut:setFocus();
        end);

    obj._e_event288 = obj.initiativeBut:addEventListener("onExit",
        function ()
            self.initiativeVal.fontColor = "white";
        end);

    obj._e_event289 = obj.button1:addEventListener("onClick",
        function (event)
            Dialogs.inputQuery("Dano", "Digite o dano", "",
                                                        function (valorPreenchido)
                                                            local dano = math.abs(tonumber(valorPreenchido) or 0)
                                                            local pvTemp = tonumber(sheet.PVTemporario) or 0
                                                            local pv = tonumber(sheet.PV) or 0
            
                                                            if dano > pvTemp then
                                                                dano = dano - pvTemp
                                                                sheet.PVTemporario = 0
                                                                pv = pv - dano
                                                                sheet.PV = pv
                                                            else
                                                                pvTemp = pvTemp - dano
                                                                sheet.PVTemporario = pvTemp
                                                            end
                                                        end);
        end);

    obj._e_event290 = obj.button2:addEventListener("onClick",
        function (event)
            local cur = tonumber(sheet.mobResLendAtual) or 0;
                                            cur = math.max(0, cur - 1);
                                            sheet.mobResLendAtual = cur;
        end);

    obj._e_event291 = obj.button3:addEventListener("onClick",
        function (event)
            local cur = tonumber(sheet.mobResLendAtual) or 0;
                                            local maxv = tonumber(sheet.mobResLendMax) or 3;
                                            cur = math.min(maxv, cur + 1);
                                            sheet.mobResLendAtual = cur;
        end);

    obj._e_event292 = obj.button4:addEventListener("onClick",
        function (event)
            local maxv = tonumber(sheet.mobResLendMax) or 3;
                                            sheet.mobResLendAtual = maxv;
        end);

    obj._e_event293 = obj.button5:addEventListener("onClick",
        function (event)
            local cur = tonumber(sheet.mobResLendAtual) or 0;
                                            sheet.mobResLendAtual = math.max(0, cur - 1);
        end);

    obj._e_event294 = obj.rclEquips:addEventListener("onSelect",
        function ()
            local node = self.rclEquips.selectedNode;
            							self.dataEquipAttackDetails.node = node;
            							self.dataEquipAttackDetails.enabled = (node ~= nil);
            
            							if self.rclEquips.lastSelectedForm ~= nil then self.rclEquips.lastSelectedForm.editName:setEnabled(false); end;
            							if self.rclEquips.selectedForm ~= nil then self.rclEquips.selectedForm.editName:setEnabled(true); end;
            							self.rclEquips.lastSelectedForm = self.rclEquips.selectedForm;
        end);

    obj._e_event295 = obj.button6:addEventListener("onClick",
        function (event)
            self.rclEquips.selectedNode = self.rclEquips:append(); self.rclEquips.selectedForm.editName:setFocus();
        end);

    obj._e_event296 = obj.dataEquipAttackDetails:addEventListener("onNodeReady",
        function ()
            self.imgEquipAttackImg:setVisible(false);
            								self.cbOptAtaqueMunicao:setItems(common.getNomeContadores(sheet, {""}));
        end);

    obj._e_event297 = obj.dataEquipAttackDetails:addEventListener("onNodeUnready",
        function ()
            self.imgEquipAttackImg:setVisible(true);
        end);

    obj._e_event298 = obj.rclProps:addEventListener("onItemRemoved",
        function (node, form)
            local equip = self.dataEquipAttackDetails.node;
            									if equip ~= nil then
            										if equip.tabPropriedades == nil then equip.tabPropriedades = {}; end;
            										equip.tabPropriedades[node.texto] = nil;
            
            										equip.propriedades = common.concat(equip.tabPropriedades, ", ");
            									end;
        end);

    obj._e_event299 = obj.button7:addEventListener("onClick",
        function (event)
            local equip = self.dataEquipAttackDetails.node;
            								if equip ~= nil then
            									if equip.tabPropriedades == nil then equip.tabPropriedades = {}; end;
            
            									local other = LANG("DnD5e.tabControl.tab.other")
            
            									local choices = {};
            									for prop,_ in pairs(common.armas_propriedades) do if not equip.tabPropriedades[prop] then table.insert(choices, prop); end; end;
            									table.sort(choices)
            									table.insert(choices, other)
            
            									Dialogs.choose(LANG("DnD5e.tab.equipament.selProp"), choices,
            										function(selected, selectedIndex, selectedText)
            											if(selected) then
            												if selectedText == other then
            													Dialogs.inputQuery(LANG("DnD5e.tab.equipament.textCaption"), LANG("DnD5e.tab.equipament.textPrompt"), "" , function(text) 
            														Dialogs.inputQuery(LANG("DnD5e.tab.equipament.hintCaption"), LANG("DnD5e.tab.equipament.hintPrompt"), "" , function(hint)
            																local node = self.rclProps:append()
            																node.texto = text
            																node.hint = hint
            															end)
            														end)
            												else
            													local node = self.rclProps:append()
            													node.texto = selectedText;
            													node.hint = common.armas_propriedades[selectedText];
            			
            													equip.tabPropriedades[selectedText] = true;
            													equip.propriedades = common.concat(equip.tabPropriedades, ", ");
            												end
            											end;
            										end
            									)
            								end;
        end);

    obj._e_event300 = obj.dataLink82:addEventListener("onChange",
        function (field, oldValue, newValue)
            local equip = self.dataEquipAttackDetails.node;
            								if equip ~= nil and equip.propriedades ~= nil then
            									if equip.tabPropriedades == nil then equip.tabPropriedades = {}; end;
            
            									if self.rclProps ~= nil and common.concat(equip.tabPropriedades) == "" then
            										for propriedade in string.gmatch((equip.propriedades or ""), "[^,%s]+") do
            											if common.armas_propriedades[propriedade] ~= nil then
            												equip.tabPropriedades[propriedade] = true;
            												local node = self.rclProps:append();
            												node.texto = propriedade;
            												node.hint = common.armas_propriedades[propriedade];
            											end;
            										end;
            									end;
            									equip.propriedades = common.concat(equip.tabPropriedades, ", ");
            								end;
        end);

    obj._e_event301 = obj.dataLink83:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet and sheet.contadoresMudaram then
            							self.cbOptAtaqueMunicao:setItems(common.getNomeContadores(sheet, {""}));
            						end;
        end);

    obj._e_event302 = obj.btnApagar:addEventListener("onClick",
        function (event)
            common.askForDelete(self.sheet);
        end);

    obj._e_event303 = obj.rclOptsAttack:addEventListener("onItemAdded",
        function (node, form)
            form.cbOptAtaqueMunicao:setItems(common.getNomeContadores(sheet, {""}));
        end);

    obj._e_event304 = obj.button8:addEventListener("onClick",
        function (event)
            self.rclOptsAttack:append();
        end);

    obj._e_event305 = obj.dataLink84:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet ~= nil and self ~= nil and sheet.contadoresMudaram then
            										local equip = self.dataEquipAttackDetails.node;
            										if equip ~= nil then
            											local optsAttack = NDB.getChildNodes(equip.optsAttack);
            											for i=1,#optsAttack,1 do
            												optsAttack[i].contadoresMudaram = true;
            												optsAttack[i].contadoresMudaram = false;
            											end;
            										end;
            									end;
        end);

    obj._e_event306 = obj.rclMobAcoes:addEventListener("onSelect",
        function ()
            _bindAcaoSelecionada();
        end);

    obj._e_event307 = obj.rclMobAcoes:addEventListener("onItemAdded",
        function (node, form)
            if node ~= nil and (node.texto == nil or node.texto == "") then
            								node.texto = "Nova ação";
            								node.usoTipo = node.usoTipo or "Livre";
            								node.rechargeMin = node.rechargeMin or "5";
            								node.custoLendario = node.custoLendario or "1";
            							end
        end);

    obj._e_event308 = obj.button9:addEventListener("onClick",
        function (event)
            _appendAndSelect(self.rclMobAcoes);
        end);

    obj._e_event309 = obj.button10:addEventListener("onClick",
        function (event)
            if self.rclMobAcoes.selectedNode ~= nil then NDB.deleteNode(self.rclMobAcoes.selectedNode); self.dsbMobAcao.node = nil; self.dsbMobAcao.enabled = false; end
        end);

    obj._e_event310 = obj.button11:addEventListener("onClick",
        function (event)
            local src = self.rclMobAcoes.selectedNode;
            								if src ~= nil then
            									local dst = self.rclMobAcoes:append();
            									NDB.copy(src, dst);
            									self.rclMobAcoes.selectedNode = dst;
            								end
        end);

    obj._e_event311 = obj.dsbMobAcao:addEventListener("onNodeReady",
        function ()
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event312 = obj.dataLink85:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event313 = obj.button12:addEventListener("onClick",
        function (event)
            _rollRechargeForSelectedAction();
        end);

    obj._e_event314 = obj.button13:addEventListener("onClick",
        function (event)
            _usarCargaAcaoSelecionada();
        end);

    obj._e_event315 = obj.button14:addEventListener("onClick",
        function (event)
            _resetCargasAcaoSelecionada();
        end);

    obj._e_event316 = obj.comboBox5:addEventListener("onChange",
        function ()
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event317 = obj.button15:addEventListener("onClick",
        function (event)
            _usarAcaoSelecionada();
        end);

    obj._e_event318 = obj.dataLink87:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event319 = obj.dataLink88:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event320 = obj.dataLink89:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event321 = obj.dataLink90:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event322 = obj.dataLink91:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event323 = obj.dataLink92:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event324 = obj.dataLink93:addEventListener("onChange",
        function (field, oldValue, newValue)
            _recalcCDAcaoSelecionada();
        end);

    obj._e_event325 = obj.button16:addEventListener("onClick",
        function (event)
            local cur = tonumber(sheet.mobLendariasAtual) or 0; sheet.mobLendariasAtual = math.max(0, cur - 1);
        end);

    obj._e_event326 = obj.button17:addEventListener("onClick",
        function (event)
            local cur = tonumber(sheet.mobLendariasAtual) or 0; local maxv = tonumber(sheet.mobLendariasMax) or 99; sheet.mobLendariasAtual = math.min(maxv, cur + 1);
        end);

    obj._e_event327 = obj.button18:addEventListener("onClick",
        function (event)
            _usarCustoLendarioDaSelecionada();
        end);

    obj._e_event328 = obj.button19:addEventListener("onClick",
        function (event)
            _resetLendarias();
        end);

    obj._e_event329 = obj.dataLink95:addEventListener("onChange",
        function (field, oldValue, newValue)
            if sheet ~= nil and (sheet.mobLendariasAtual == nil or sheet.mobLendariasAtual == "") then sheet.mobLendariasAtual = sheet.mobLendariasMax or "3"; end
        end);

    obj._e_event330 = obj.labupperGridMagicBox1:addEventListener("onResize",
        function ()
            self.upperGridMagicBox1._RecalcSize();
        end);

    obj._e_event331 = obj.labupperGridMagicBox2:addEventListener("onResize",
        function ()
            self.upperGridMagicBox2._RecalcSize();
        end);

    obj._e_event332 = obj.labupperGridMagicBox3:addEventListener("onResize",
        function ()
            self.upperGridMagicBox3._RecalcSize();
        end);

    obj._e_event333 = obj.dataLink96:addEventListener("onChange",
        function (field, oldValue, newValue)
            local hab, modHab, bonusProficiencia;
            					if sheet.magias == nil then sheet.magias = {}; end;
            					if sheet.atributos == nil then sheet.atributos = {}; end;
            					hab = sheet.magias.habilidadeDeConjuracao;
            					if hab == "for" then modHab = tonumber(sheet.atributos.modForca);
            					elseif hab == "des" then modHab = tonumber(sheet.atributos.modDestreza);
            					elseif hab == "con" then modHab = tonumber(sheet.atributos.modConstituicao);
            					elseif hab == "int" then modHab = tonumber(sheet.atributos.modInteligencia);
            					elseif hab == "sab" then modHab = tonumber(sheet.atributos.modSabedoria);
            					elseif hab == "car" then modHab = tonumber(sheet.atributos.modCarisma);
            					end;
            					bonusProficiencia = tonumber(sheet.bonusProficiencia) or 0;
            					if modHab ~= nil then
            						sheet.magias.cdDaMagia = 8 + modHab + bonusProficiencia;
            						local atk = modHab + bonusProficiencia;
            						if atk >= 0 then sheet.magias.bonusAtaqueSTR = "+" .. atk; else sheet.magias.bonusAtaqueSTR = tostring(atk); end;
            					else
            						sheet.magias.cdDaMagia = nil;
            						sheet.magias.bonusAtaqueSTR = nil;
            					end;
        end);

    obj._e_event334 = obj.rclflwMagicRecordListSpc1:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc1._recalcHeight();
        end);

    obj._e_event335 = obj.rclflwMagicRecordListSpc1:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event336 = obj.btnNovoflwMagicRecordListSpc1:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc1:append();
        end);

    obj._e_event337 = obj.rclflwMagicRecordListSpc2:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc2._recalcHeight();
        end);

    obj._e_event338 = obj.rclflwMagicRecordListSpc2:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event339 = obj.btnNovoflwMagicRecordListSpc2:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc2:append();
        end);

    obj._e_event340 = obj.rclflwMagicRecordListSpc3:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc3._recalcHeight();
        end);

    obj._e_event341 = obj.rclflwMagicRecordListSpc3:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event342 = obj.btnNovoflwMagicRecordListSpc3:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc3:append();
        end);

    obj._e_event343 = obj.rclflwMagicRecordListSpc4:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc4._recalcHeight();
        end);

    obj._e_event344 = obj.rclflwMagicRecordListSpc4:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event345 = obj.btnNovoflwMagicRecordListSpc4:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc4:append();
        end);

    obj._e_event346 = obj.rclflwMagicRecordListSpc5:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc5._recalcHeight();
        end);

    obj._e_event347 = obj.rclflwMagicRecordListSpc5:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event348 = obj.btnNovoflwMagicRecordListSpc5:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc5:append();
        end);

    obj._e_event349 = obj.rclflwMagicRecordListSpc6:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc6._recalcHeight();
        end);

    obj._e_event350 = obj.rclflwMagicRecordListSpc6:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event351 = obj.btnNovoflwMagicRecordListSpc6:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc6:append();
        end);

    obj._e_event352 = obj.rclflwMagicRecordListSpc7:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc7._recalcHeight();
        end);

    obj._e_event353 = obj.rclflwMagicRecordListSpc7:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event354 = obj.btnNovoflwMagicRecordListSpc7:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc7:append();
        end);

    obj._e_event355 = obj.rclflwMagicRecordListSpc8:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc8._recalcHeight();
        end);

    obj._e_event356 = obj.rclflwMagicRecordListSpc8:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event357 = obj.btnNovoflwMagicRecordListSpc8:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc8:append();
        end);

    obj._e_event358 = obj.rclflwMagicRecordListSpc9:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc9._recalcHeight();
        end);

    obj._e_event359 = obj.rclflwMagicRecordListSpc9:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event360 = obj.btnNovoflwMagicRecordListSpc9:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc9:append();
        end);

    obj._e_event361 = obj.rclflwMagicRecordListSpc10:addEventListener("onResize",
        function ()
            self.flwMagicRecordListSpc10._recalcHeight();
        end);

    obj._e_event362 = obj.rclflwMagicRecordListSpc10:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event363 = obj.btnNovoflwMagicRecordListSpc10:addEventListener("onClick",
        function (event)
            self.rclflwMagicRecordListSpc10:append();
        end);

    obj._e_event364 = obj.labupperGridMagicBox4:addEventListener("onResize",
        function ()
            self.upperGridMagicBox4._RecalcSize();
        end);

    obj._e_event365 = obj.labupperGridMagicBox5:addEventListener("onResize",
        function ()
            self.upperGridMagicBox5._RecalcSize();
        end);

    obj._e_event366 = obj.labupperGridMagicBox6:addEventListener("onResize",
        function ()
            self.upperGridMagicBox6._RecalcSize();
        end);

    obj._e_event367 = obj.dataLink115:addEventListener("onChange",
        function (field, oldValue, newValue)
            local hab, modHab, bonusProficiencia;
            					if sheet.magiasInatas == nil then sheet.magiasInatas = {}; end;
            					if sheet.atributos == nil then sheet.atributos = {}; end;
            					hab = sheet.magiasInatas.habilidadeDeConjuracao;
            					if hab == "for" then modHab = tonumber(sheet.atributos.modForca);
            					elseif hab == "des" then modHab = tonumber(sheet.atributos.modDestreza);
            					elseif hab == "con" then modHab = tonumber(sheet.atributos.modConstituicao);
            					elseif hab == "int" then modHab = tonumber(sheet.atributos.modInteligencia);
            					elseif hab == "sab" then modHab = tonumber(sheet.atributos.modSabedoria);
            					elseif hab == "car" then modHab = tonumber(sheet.atributos.modCarisma);
            					end;
            					bonusProficiencia = tonumber(sheet.bonusProficiencia) or 0;
            					if modHab ~= nil then
            						sheet.magiasInatas.cdDaMagia = 8 + modHab + bonusProficiencia;
            						local atk = modHab + bonusProficiencia;
            						if atk >= 0 then sheet.magiasInatas.bonusAtaqueSTR = "+" .. atk; else sheet.magiasInatas.bonusAtaqueSTR = tostring(atk); end;
            					else
            						sheet.magiasInatas.cdDaMagia = nil;
            						sheet.magiasInatas.bonusAtaqueSTR = nil;
            					end;
        end);

    obj._e_event368 = obj.rclflwInnateUsage1:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event369 = obj.button20:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage1:append();
        end);

    obj._e_event370 = obj.rclflwInnateUsage2:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event371 = obj.button21:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage2:append();
        end);

    obj._e_event372 = obj.rclflwInnateUsage3:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event373 = obj.button22:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage3:append();
        end);

    obj._e_event374 = obj.rclflwInnateUsage4:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event375 = obj.button23:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage4:append();
        end);

    obj._e_event376 = obj.rclflwInnateUsage5:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event377 = obj.button24:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage5:append();
        end);

    obj._e_event378 = obj.rclflwInnateUsage6:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.nome or '', nodeB.nome or '');
        end);

    obj._e_event379 = obj.button25:addEventListener("onClick",
        function (event)
            self.rclflwInnateUsage6:append();
        end);

    obj._e_event380 = obj.button26:addEventListener("onClick",
        function (event)
            self.rclContadores:append()
        end);

    obj._e_event381 = obj.rclContadores:addEventListener("onCompare",
        function (nodeA, nodeB)
            return Utils.compareStringPtBr(nodeA.name, nodeB.name);
        end);

    obj._e_event382 = obj.rclContadores:addEventListener("onItemAdded",
        function (node, form)
            if sheet ~= nil then
            					sheet.contadoresMudaram = true;
            					sheet.contadoresMudaram = false;
            				end;
        end);

    obj._e_event383 = obj.rclContadores:addEventListener("onItemRemoved",
        function (node, form)
            if sheet ~= nil then
            					sheet.contadoresMudaram = true;
            					sheet.contadoresMudaram = false;
            				end;
        end);

    obj._e_event384 = obj.dataLink116:addEventListener("onChange",
        function (field, oldValue, newValue)
            local contadores = NDB.getChildNodes(sheet.contadores);
            			for i=1,#contadores,1 do
            				contadores[i].descansoLongo = sheet.descansoLongo;
            				contadores[i].descansoCurto = sheet.descansoCurto;
            			end;
        end);

    obj._e_event385 = obj.checkBox2:addEventListener("onChange",
        function ()
            if sheet then
            							self.anotacoesFancy:setVisible(sheet.outros.anotacoes_melhorado);
            							self.anotacoesOld:setVisible(not (sheet.outros.anotacoes_melhorado));
            						end;
        end);

    obj._e_event386 = obj.button27:addEventListener("onClick",
        function (event)
            local xml = NDB.exportXML(sheet);
            
            					local export = {};
            					Utils.binaryEncode(export, "utf8", xml);
            
            					local stream = Utils.newMemoryStream();
            					stream:write(export);
            
            					Dialogs.saveFile(LANG("Dnd5e.other.save"), stream, "sheet.xml", "application/xml",
            						function()
            							stream:close();
            							showMessage(LANG("Dnd5e.other.exported"));
            						end);
        end);

    obj._e_event387 = obj.button28:addEventListener("onClick",
        function (event)
            Dialogs.openFile(LANG("Dnd5e.other.import"), "application/xml", false, 
            						function(arquivos)
            							local arq = arquivos[1];
            
            							local import = {};
            							arq.stream:read(import, arq.stream.size);
            
            							local xml = Utils.binaryDecode(import, "utf8");
            
            							NDB.importXML(sheet, xml);
            						end);
        end);

    obj._e_event388 = obj.button29:addEventListener("onClick",
        function (event)
            local nodes = NDB.getChildNodes(sheet.contadores); 
            		            for i=1, #nodes, 1 do
            		            	-- only change short rest counters
            		            	local resetVal = nodes[i].selectedResetVal
            		                if nodes[i].selectedResetTime == "Descanso Curto" then
            
            		                	if resetVal == "Completa" then
            		                		nodes[i].valCur = nodes[i].valMax
            		                	elseif resetVal == "Recupera Metade (⌃)" then
            		                		nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + math.ceil(nodes[i].valMax/2));
            		                	elseif resetVal == "Recupera Metade (⌄)" then
            		                		nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + math.floor(nodes[i].valMax/2));
            		                	elseif resetVal == "Muda em" or resetVal == "Muda para" then
            
            								if not (resetVal == "Muda em" and nodes[i].valCur == nodes[i].valMax) then
            									local rolagem = Firecast.interpretarRolagem(common.interpreta(nodes[i], nodes[i].selectedResetVal2));
            									if not rolagem.possuiAlgumDado then
            										rolagem = Firecast.interpretarRolagem("1d1-1"):concatenar(rolagem);
            										rolagem:rolarLocalmente();
            										if resetVal == "Muda em" then
            											nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + rolagem.resultado);
            										else
            											nodes[i].valCur = rolagem.resultado;
            										end;
            									else
            										common.getMesa(nodes[i]).activeChat:rolarDados(rolagem, nodes[i].name, function(arolagem)
            											if resetVal == "Muda em" then
            												nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + arolagem.resultado);
            											else
            												nodes[i].valCur = arolagem.resultado;
            											end;
            										end);
            									end;
            								end;
            		                	end
            		                end
            		            end
        end);

    obj._e_event389 = obj.button30:addEventListener("onClick",
        function (event)
            local nodes = NDB.getChildNodes(sheet.contadores); 
            		            for i=1, #nodes, 1 do
            		            	-- only change short rest counters
            		            	local resetVal = nodes[i].selectedResetVal
            		                if nodes[i].selectedResetTime == "Descanso Longo" then
            
            		                	if resetVal == "Completa" then
            		                		nodes[i].valCur = nodes[i].valMax
            		                	elseif resetVal == "Recupera Metade (⌃)" then
            		                		nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + math.ceil(nodes[i].valMax/2));
            		                	elseif resetVal == "Recupera Metade (⌄)" then
            		                		nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + math.floor(nodes[i].valMax/2));
            		                	elseif resetVal == "Muda em" or resetVal == "Muda para" then
            
            								if not (resetVal == "Muda em" and nodes[i].valCur == nodes[i].valMax) then
            									local rolagem = Firecast.interpretarRolagem(common.interpreta(nodes[i], nodes[i].selectedResetVal2));
            									if not rolagem.possuiAlgumDado then
            										rolagem = Firecast.interpretarRolagem("1d1-1"):concatenar(rolagem);
            										rolagem:rolarLocalmente();
            										if resetVal == "Muda em" then
            											nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + rolagem.resultado);
            										else
            											nodes[i].valCur = rolagem.resultado;
            										end;
            									else
            										common.getMesa(nodes[i]).activeChat:rolarDados(rolagem, nodes[i].name, function(arolagem)
            											if resetVal == "Muda em" then
            												nodes[i].valCur = math.min(nodes[i].valMax, nodes[i].valCur + arolagem.resultado);
            											else
            												nodes[i].valCur = arolagem.resultado;
            											end;
            										end);
            									end;
            								end;
            		                	end
            		                else
            		                	nodes[i].valCur = nodes[i].valMax
            		                end
            		            end
        end);

    obj._e_event390 = obj.button31:addEventListener("onClick",
        function (event)
            local function txt(v)
            						if v == nil then return "" end;
            						return tostring(v);
            					end;
            
            					local function trim(v)
            						v = txt(v);
            						v = v:gsub("^%s+", ""):gsub("%s+$", "");
            						return v;
            					end;
            
            					local function nonEmpty(v)
            						return trim(v) ~= "";
            					end;
            
            					local function getPath(path)
            						local cur = sheet;
            						for part in string.gmatch(path, "[^%.]+") do
            							if cur == nil then return nil end;
            							cur = cur[part];
            						end;
            						return cur;
            					end;
            
            					local function addLine(t, v)
            						if nonEmpty(v) then t[#t+1] = v end;
            					end;
            
            					local function attrLine(label, field)
            						local raw = tonumber(sheet[field]) or tonumber(getPath("atributos." .. field .. ".total")) or 10;
            						local mod = math.floor((raw - 10) / 2);
            						local modStr = (mod >= 0 and "+" or "") .. tostring(mod);
            						return string.format("%s %d (%s)", label, raw, modStr);
            					end;
            
            					local function joinKV(items)
            						local out = {};
            						for _, it in ipairs(items) do
            							if nonEmpty(it[2]) then
            								out[#out+1] = it[1] .. " " .. trim(it[2]);
            							end;
            						end;
            						return table.concat(out, ", ");
            					end;
            
            					local function exportActionNodes()
            						local lines = {};
            						if sheet.mobAcoesLista == nil then return "" end;
            						local nodes = NDB.getChildNodes(sheet.mobAcoesLista) or {};
            						for i = 1, #nodes, 1 do
            							local n = nodes[i];
            							local nome = trim(n.texto);
            							if nome == "" then nome = "Ação " .. tostring(i) end;
            							local tags = {};
            							if nonEmpty(n.tipoAcao) then tags[#tags+1] = trim(n.tipoAcao) end;
            							if nonEmpty(n.usoTipo) then tags[#tags+1] = trim(n.usoTipo) end;
            							if nonEmpty(n.rechargeMin) then tags[#tags+1] = "Recharge " .. trim(n.rechargeMin) .. "-6" end;
            							local header = "- " .. nome;
            							if #tags > 0 then
            								header = header .. " [" .. table.concat(tags, "; ") .. "]";
            							end;
            							lines[#lines+1] = header;
            							local detalhe = {};
            							if nonEmpty(n.bonusAtaque) then detalhe[#detalhe+1] = "Ataque: " .. trim(n.bonusAtaque) end;
            							if nonEmpty(n.alcance) then detalhe[#detalhe+1] = "Alcance: " .. trim(n.alcance) end;
            							if nonEmpty(n.alvo) then detalhe[#detalhe+1] = "Alvo: " .. trim(n.alvo) end;
            							if nonEmpty(n.dano) then detalhe[#detalhe+1] = "Dano: " .. trim(n.dano) end;
            							if nonEmpty(n.tipoDano) then detalhe[#detalhe+1] = "Tipo: " .. trim(n.tipoDano) end;
            							if nonEmpty(n.cdSave) then detalhe[#detalhe+1] = "CD: " .. trim(n.cdSave) end;
            							if nonEmpty(n.atribSave) then detalhe[#detalhe+1] = "Atrib: " .. trim(n.atribSave) end;
            							if #detalhe > 0 then lines[#lines+1] = "  " .. table.concat(detalhe, " | ") end;
            							if nonEmpty(n.descricao) then lines[#lines+1] = "  " .. trim(n.descricao) end;
            						end;
            						return table.concat(lines, "\n");
            					end;
            
            					local linhas = {};
            					local nome = trim(sheet.nome);
            					if nome == "" then nome = "Mob sem nome" end;
            					linhas[#linhas+1] = string.upper(nome);
            
            					local subtipo = joinKV({
            						{"Tipo:", sheet.classeENivel},
            						{"Alinhamento:", sheet.tendencia}
            					});
            					addLine(linhas, subtipo);
            					linhas[#linhas+1] = "";
            
            					local defBase = joinKV({
            						{"CA:", sheet.CA},
            						{"PV Máx:", sheet.PVMax},
            						{"PV Atual:", sheet.PV},
            						{"PV Temp:", sheet.PVTemporario},
            						{"CR:", sheet.CR},
            						{"PB:", sheet.bonusProficiencia}
            					});
            					addLine(linhas, defBase);
            
            					local hitDice = joinKV({
            						{"Hit Dice:", (nonEmpty(sheet.DadosDeVida) and (txt(sheet.DadosDeVida) .. (nonEmpty(sheet.mobHitDieTipo) and (" " .. txt(sheet.mobHitDieTipo)) or "")) or nil)},
            						{"Restantes:", sheet.DadosDeVidaAtuais}
            					});
            					addLine(linhas, hitDice);
            
            					local speeds = joinKV({
            						{"Walk:", sheet.deslocamento},
            						{"Fly:", sheet.mobMoveFly},
            						{"Burrow:", sheet.mobMoveBurrow},
            						{"Climb:", sheet.mobMoveClimb},
            						{"Swim:", sheet.mobMoveSwim}
            					});
            					if nonEmpty(speeds) then linhas[#linhas+1] = "Movimentações: " .. speeds end;
            
            					local senses = joinKV({
            						{"Blindsight:", sheet.mobSenseBlindsight},
            						{"Darkvision:", sheet.mobSenseDarkvision},
            						{"Tremorsense:", sheet.mobSenseTremorsense},
            						{"Truesight:", sheet.mobSenseTruesight},
            						{"Outros:", sheet.sentidos}
            					});
            					if nonEmpty(senses) then linhas[#linhas+1] = "Sentidos: " .. senses end;
            
            					if nonEmpty(sheet.mobSaves) then linhas[#linhas+1] = "Saves: " .. trim(sheet.mobSaves) end;
            					if nonEmpty(sheet.mobSkills) then linhas[#linhas+1] = "Skills: " .. trim(sheet.mobSkills) end;
            					if nonEmpty(sheet.idiomas) then linhas[#linhas+1] = "Idiomas: " .. trim(sheet.idiomas) end;
            					linhas[#linhas+1] = "";
            
            					linhas[#linhas+1] = "ATRIBUTOS";
            					linhas[#linhas+1] = table.concat({
            						attrLine("FOR", "forca"),
            						attrLine("DES", "destreza"),
            						attrLine("CON", "constituicao"),
            						attrLine("INT", "inteligencia"),
            						attrLine("SAB", "sabedoria"),
            						attrLine("CAR", "carisma")
            					}, " | ");
            					linhas[#linhas+1] = "";
            
            					if nonEmpty(sheet.mobTraitsTexto) then
            						linhas[#linhas+1] = "TRAÇOS";
            						linhas[#linhas+1] = trim(sheet.mobTraitsTexto);
            						linhas[#linhas+1] = "";
            					end;
            
            					if nonEmpty(sheet.mobAtaquesTexto) then
            						linhas[#linhas+1] = "ATTACKS";
            						linhas[#linhas+1] = trim(sheet.mobAtaquesTexto);
            						linhas[#linhas+1] = "";
            					end;
            
            					local acoesLista = exportActionNodes();
            					if nonEmpty(acoesLista) then
            						linhas[#linhas+1] = "AÇÕES (LISTA)";
            						linhas[#linhas+1] = acoesLista;
            						linhas[#linhas+1] = "";
            					end;
            
            					if nonEmpty(sheet.mobAcoesBonusTexto) then
            						linhas[#linhas+1] = "AÇÕES BÔNUS";
            						linhas[#linhas+1] = trim(sheet.mobAcoesBonusTexto);
            						linhas[#linhas+1] = "";
            					end;
            
            					if nonEmpty(sheet.mobReacoesTexto) then
            						linhas[#linhas+1] = "REAÇÕES";
            						linhas[#linhas+1] = trim(sheet.mobReacoesTexto);
            						linhas[#linhas+1] = "";
            					end;
            
            					if nonEmpty(sheet.mobAcoesLendariasTexto) then
            						linhas[#linhas+1] = "AÇÕES LENDÁRIAS";
            						linhas[#linhas+1] = trim(sheet.mobAcoesLendariasTexto);
            						linhas[#linhas+1] = "";
            					end;
            
            					if nonEmpty(sheet.mobEfeitosRegionais) then
            						linhas[#linhas+1] = "EFEITOS REGIONAIS";
            						linhas[#linhas+1] = trim(sheet.mobEfeitosRegionais);
            						linhas[#linhas+1] = "";
            					end;
            
            					local conteudo = table.concat(linhas, "\n");
            					local bytes = {};
            					Utils.binaryEncode(bytes, "utf8", conteudo);
            					local stream = Utils.newMemoryStream();
            					stream:write(bytes);
            
            					Dialogs.saveFile("Salvar Statblock", stream, "mob_statblock.txt", "text/plain",
            						function()
            							stream:close();
            							showMessage("Statblock exportado em TXT. Você pode imprimir/salvar em PDF pelo sistema.");
            						end);
        end);

    obj._e_event391 = obj.button32:addEventListener("onClick",
        function (event)
            local nome = tostring((sheet and sheet.nome) or "Mob sem nome");
            					local resumo = string.upper(nome) .. "\nCR " .. tostring((sheet and sheet.CR) or "") .. " | CA " .. tostring((sheet and sheet.CA) or "") .. " | PV " .. tostring((sheet and sheet.PVMax) or "");
            					if System ~= nil and System.setClipboardText ~= nil then
            						System.setClipboardText(resumo);
            						showMessage("Resumo copiado para a área de transferência.");
            					else
            						showMessage("Clipboard não disponível nesta versão. Use Exportar Statblock (.txt).");
            					end;
        end);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event391);
        __o_rrpgObjs.removeEventListenerById(self._e_event390);
        __o_rrpgObjs.removeEventListenerById(self._e_event389);
        __o_rrpgObjs.removeEventListenerById(self._e_event388);
        __o_rrpgObjs.removeEventListenerById(self._e_event387);
        __o_rrpgObjs.removeEventListenerById(self._e_event386);
        __o_rrpgObjs.removeEventListenerById(self._e_event385);
        __o_rrpgObjs.removeEventListenerById(self._e_event384);
        __o_rrpgObjs.removeEventListenerById(self._e_event383);
        __o_rrpgObjs.removeEventListenerById(self._e_event382);
        __o_rrpgObjs.removeEventListenerById(self._e_event381);
        __o_rrpgObjs.removeEventListenerById(self._e_event380);
        __o_rrpgObjs.removeEventListenerById(self._e_event379);
        __o_rrpgObjs.removeEventListenerById(self._e_event378);
        __o_rrpgObjs.removeEventListenerById(self._e_event377);
        __o_rrpgObjs.removeEventListenerById(self._e_event376);
        __o_rrpgObjs.removeEventListenerById(self._e_event375);
        __o_rrpgObjs.removeEventListenerById(self._e_event374);
        __o_rrpgObjs.removeEventListenerById(self._e_event373);
        __o_rrpgObjs.removeEventListenerById(self._e_event372);
        __o_rrpgObjs.removeEventListenerById(self._e_event371);
        __o_rrpgObjs.removeEventListenerById(self._e_event370);
        __o_rrpgObjs.removeEventListenerById(self._e_event369);
        __o_rrpgObjs.removeEventListenerById(self._e_event368);
        __o_rrpgObjs.removeEventListenerById(self._e_event367);
        __o_rrpgObjs.removeEventListenerById(self._e_event366);
        __o_rrpgObjs.removeEventListenerById(self._e_event365);
        __o_rrpgObjs.removeEventListenerById(self._e_event364);
        __o_rrpgObjs.removeEventListenerById(self._e_event363);
        __o_rrpgObjs.removeEventListenerById(self._e_event362);
        __o_rrpgObjs.removeEventListenerById(self._e_event361);
        __o_rrpgObjs.removeEventListenerById(self._e_event360);
        __o_rrpgObjs.removeEventListenerById(self._e_event359);
        __o_rrpgObjs.removeEventListenerById(self._e_event358);
        __o_rrpgObjs.removeEventListenerById(self._e_event357);
        __o_rrpgObjs.removeEventListenerById(self._e_event356);
        __o_rrpgObjs.removeEventListenerById(self._e_event355);
        __o_rrpgObjs.removeEventListenerById(self._e_event354);
        __o_rrpgObjs.removeEventListenerById(self._e_event353);
        __o_rrpgObjs.removeEventListenerById(self._e_event352);
        __o_rrpgObjs.removeEventListenerById(self._e_event351);
        __o_rrpgObjs.removeEventListenerById(self._e_event350);
        __o_rrpgObjs.removeEventListenerById(self._e_event349);
        __o_rrpgObjs.removeEventListenerById(self._e_event348);
        __o_rrpgObjs.removeEventListenerById(self._e_event347);
        __o_rrpgObjs.removeEventListenerById(self._e_event346);
        __o_rrpgObjs.removeEventListenerById(self._e_event345);
        __o_rrpgObjs.removeEventListenerById(self._e_event344);
        __o_rrpgObjs.removeEventListenerById(self._e_event343);
        __o_rrpgObjs.removeEventListenerById(self._e_event342);
        __o_rrpgObjs.removeEventListenerById(self._e_event341);
        __o_rrpgObjs.removeEventListenerById(self._e_event340);
        __o_rrpgObjs.removeEventListenerById(self._e_event339);
        __o_rrpgObjs.removeEventListenerById(self._e_event338);
        __o_rrpgObjs.removeEventListenerById(self._e_event337);
        __o_rrpgObjs.removeEventListenerById(self._e_event336);
        __o_rrpgObjs.removeEventListenerById(self._e_event335);
        __o_rrpgObjs.removeEventListenerById(self._e_event334);
        __o_rrpgObjs.removeEventListenerById(self._e_event333);
        __o_rrpgObjs.removeEventListenerById(self._e_event332);
        __o_rrpgObjs.removeEventListenerById(self._e_event331);
        __o_rrpgObjs.removeEventListenerById(self._e_event330);
        __o_rrpgObjs.removeEventListenerById(self._e_event329);
        __o_rrpgObjs.removeEventListenerById(self._e_event328);
        __o_rrpgObjs.removeEventListenerById(self._e_event327);
        __o_rrpgObjs.removeEventListenerById(self._e_event326);
        __o_rrpgObjs.removeEventListenerById(self._e_event325);
        __o_rrpgObjs.removeEventListenerById(self._e_event324);
        __o_rrpgObjs.removeEventListenerById(self._e_event323);
        __o_rrpgObjs.removeEventListenerById(self._e_event322);
        __o_rrpgObjs.removeEventListenerById(self._e_event321);
        __o_rrpgObjs.removeEventListenerById(self._e_event320);
        __o_rrpgObjs.removeEventListenerById(self._e_event319);
        __o_rrpgObjs.removeEventListenerById(self._e_event318);
        __o_rrpgObjs.removeEventListenerById(self._e_event317);
        __o_rrpgObjs.removeEventListenerById(self._e_event316);
        __o_rrpgObjs.removeEventListenerById(self._e_event315);
        __o_rrpgObjs.removeEventListenerById(self._e_event314);
        __o_rrpgObjs.removeEventListenerById(self._e_event313);
        __o_rrpgObjs.removeEventListenerById(self._e_event312);
        __o_rrpgObjs.removeEventListenerById(self._e_event311);
        __o_rrpgObjs.removeEventListenerById(self._e_event310);
        __o_rrpgObjs.removeEventListenerById(self._e_event309);
        __o_rrpgObjs.removeEventListenerById(self._e_event308);
        __o_rrpgObjs.removeEventListenerById(self._e_event307);
        __o_rrpgObjs.removeEventListenerById(self._e_event306);
        __o_rrpgObjs.removeEventListenerById(self._e_event305);
        __o_rrpgObjs.removeEventListenerById(self._e_event304);
        __o_rrpgObjs.removeEventListenerById(self._e_event303);
        __o_rrpgObjs.removeEventListenerById(self._e_event302);
        __o_rrpgObjs.removeEventListenerById(self._e_event301);
        __o_rrpgObjs.removeEventListenerById(self._e_event300);
        __o_rrpgObjs.removeEventListenerById(self._e_event299);
        __o_rrpgObjs.removeEventListenerById(self._e_event298);
        __o_rrpgObjs.removeEventListenerById(self._e_event297);
        __o_rrpgObjs.removeEventListenerById(self._e_event296);
        __o_rrpgObjs.removeEventListenerById(self._e_event295);
        __o_rrpgObjs.removeEventListenerById(self._e_event294);
        __o_rrpgObjs.removeEventListenerById(self._e_event293);
        __o_rrpgObjs.removeEventListenerById(self._e_event292);
        __o_rrpgObjs.removeEventListenerById(self._e_event291);
        __o_rrpgObjs.removeEventListenerById(self._e_event290);
        __o_rrpgObjs.removeEventListenerById(self._e_event289);
        __o_rrpgObjs.removeEventListenerById(self._e_event288);
        __o_rrpgObjs.removeEventListenerById(self._e_event287);
        __o_rrpgObjs.removeEventListenerById(self._e_event286);
        __o_rrpgObjs.removeEventListenerById(self._e_event285);
        __o_rrpgObjs.removeEventListenerById(self._e_event284);
        __o_rrpgObjs.removeEventListenerById(self._e_event283);
        __o_rrpgObjs.removeEventListenerById(self._e_event282);
        __o_rrpgObjs.removeEventListenerById(self._e_event281);
        __o_rrpgObjs.removeEventListenerById(self._e_event280);
        __o_rrpgObjs.removeEventListenerById(self._e_event279);
        __o_rrpgObjs.removeEventListenerById(self._e_event278);
        __o_rrpgObjs.removeEventListenerById(self._e_event277);
        __o_rrpgObjs.removeEventListenerById(self._e_event276);
        __o_rrpgObjs.removeEventListenerById(self._e_event275);
        __o_rrpgObjs.removeEventListenerById(self._e_event274);
        __o_rrpgObjs.removeEventListenerById(self._e_event273);
        __o_rrpgObjs.removeEventListenerById(self._e_event272);
        __o_rrpgObjs.removeEventListenerById(self._e_event271);
        __o_rrpgObjs.removeEventListenerById(self._e_event270);
        __o_rrpgObjs.removeEventListenerById(self._e_event269);
        __o_rrpgObjs.removeEventListenerById(self._e_event268);
        __o_rrpgObjs.removeEventListenerById(self._e_event267);
        __o_rrpgObjs.removeEventListenerById(self._e_event266);
        __o_rrpgObjs.removeEventListenerById(self._e_event265);
        __o_rrpgObjs.removeEventListenerById(self._e_event264);
        __o_rrpgObjs.removeEventListenerById(self._e_event263);
        __o_rrpgObjs.removeEventListenerById(self._e_event262);
        __o_rrpgObjs.removeEventListenerById(self._e_event261);
        __o_rrpgObjs.removeEventListenerById(self._e_event260);
        __o_rrpgObjs.removeEventListenerById(self._e_event259);
        __o_rrpgObjs.removeEventListenerById(self._e_event258);
        __o_rrpgObjs.removeEventListenerById(self._e_event257);
        __o_rrpgObjs.removeEventListenerById(self._e_event256);
        __o_rrpgObjs.removeEventListenerById(self._e_event255);
        __o_rrpgObjs.removeEventListenerById(self._e_event254);
        __o_rrpgObjs.removeEventListenerById(self._e_event253);
        __o_rrpgObjs.removeEventListenerById(self._e_event252);
        __o_rrpgObjs.removeEventListenerById(self._e_event251);
        __o_rrpgObjs.removeEventListenerById(self._e_event250);
        __o_rrpgObjs.removeEventListenerById(self._e_event249);
        __o_rrpgObjs.removeEventListenerById(self._e_event248);
        __o_rrpgObjs.removeEventListenerById(self._e_event247);
        __o_rrpgObjs.removeEventListenerById(self._e_event246);
        __o_rrpgObjs.removeEventListenerById(self._e_event245);
        __o_rrpgObjs.removeEventListenerById(self._e_event244);
        __o_rrpgObjs.removeEventListenerById(self._e_event243);
        __o_rrpgObjs.removeEventListenerById(self._e_event242);
        __o_rrpgObjs.removeEventListenerById(self._e_event241);
        __o_rrpgObjs.removeEventListenerById(self._e_event240);
        __o_rrpgObjs.removeEventListenerById(self._e_event239);
        __o_rrpgObjs.removeEventListenerById(self._e_event238);
        __o_rrpgObjs.removeEventListenerById(self._e_event237);
        __o_rrpgObjs.removeEventListenerById(self._e_event236);
        __o_rrpgObjs.removeEventListenerById(self._e_event235);
        __o_rrpgObjs.removeEventListenerById(self._e_event234);
        __o_rrpgObjs.removeEventListenerById(self._e_event233);
        __o_rrpgObjs.removeEventListenerById(self._e_event232);
        __o_rrpgObjs.removeEventListenerById(self._e_event231);
        __o_rrpgObjs.removeEventListenerById(self._e_event230);
        __o_rrpgObjs.removeEventListenerById(self._e_event229);
        __o_rrpgObjs.removeEventListenerById(self._e_event228);
        __o_rrpgObjs.removeEventListenerById(self._e_event227);
        __o_rrpgObjs.removeEventListenerById(self._e_event226);
        __o_rrpgObjs.removeEventListenerById(self._e_event225);
        __o_rrpgObjs.removeEventListenerById(self._e_event224);
        __o_rrpgObjs.removeEventListenerById(self._e_event223);
        __o_rrpgObjs.removeEventListenerById(self._e_event222);
        __o_rrpgObjs.removeEventListenerById(self._e_event221);
        __o_rrpgObjs.removeEventListenerById(self._e_event220);
        __o_rrpgObjs.removeEventListenerById(self._e_event219);
        __o_rrpgObjs.removeEventListenerById(self._e_event218);
        __o_rrpgObjs.removeEventListenerById(self._e_event217);
        __o_rrpgObjs.removeEventListenerById(self._e_event216);
        __o_rrpgObjs.removeEventListenerById(self._e_event215);
        __o_rrpgObjs.removeEventListenerById(self._e_event214);
        __o_rrpgObjs.removeEventListenerById(self._e_event213);
        __o_rrpgObjs.removeEventListenerById(self._e_event212);
        __o_rrpgObjs.removeEventListenerById(self._e_event211);
        __o_rrpgObjs.removeEventListenerById(self._e_event210);
        __o_rrpgObjs.removeEventListenerById(self._e_event209);
        __o_rrpgObjs.removeEventListenerById(self._e_event208);
        __o_rrpgObjs.removeEventListenerById(self._e_event207);
        __o_rrpgObjs.removeEventListenerById(self._e_event206);
        __o_rrpgObjs.removeEventListenerById(self._e_event205);
        __o_rrpgObjs.removeEventListenerById(self._e_event204);
        __o_rrpgObjs.removeEventListenerById(self._e_event203);
        __o_rrpgObjs.removeEventListenerById(self._e_event202);
        __o_rrpgObjs.removeEventListenerById(self._e_event201);
        __o_rrpgObjs.removeEventListenerById(self._e_event200);
        __o_rrpgObjs.removeEventListenerById(self._e_event199);
        __o_rrpgObjs.removeEventListenerById(self._e_event198);
        __o_rrpgObjs.removeEventListenerById(self._e_event197);
        __o_rrpgObjs.removeEventListenerById(self._e_event196);
        __o_rrpgObjs.removeEventListenerById(self._e_event195);
        __o_rrpgObjs.removeEventListenerById(self._e_event194);
        __o_rrpgObjs.removeEventListenerById(self._e_event193);
        __o_rrpgObjs.removeEventListenerById(self._e_event192);
        __o_rrpgObjs.removeEventListenerById(self._e_event191);
        __o_rrpgObjs.removeEventListenerById(self._e_event190);
        __o_rrpgObjs.removeEventListenerById(self._e_event189);
        __o_rrpgObjs.removeEventListenerById(self._e_event188);
        __o_rrpgObjs.removeEventListenerById(self._e_event187);
        __o_rrpgObjs.removeEventListenerById(self._e_event186);
        __o_rrpgObjs.removeEventListenerById(self._e_event185);
        __o_rrpgObjs.removeEventListenerById(self._e_event184);
        __o_rrpgObjs.removeEventListenerById(self._e_event183);
        __o_rrpgObjs.removeEventListenerById(self._e_event182);
        __o_rrpgObjs.removeEventListenerById(self._e_event181);
        __o_rrpgObjs.removeEventListenerById(self._e_event180);
        __o_rrpgObjs.removeEventListenerById(self._e_event179);
        __o_rrpgObjs.removeEventListenerById(self._e_event178);
        __o_rrpgObjs.removeEventListenerById(self._e_event177);
        __o_rrpgObjs.removeEventListenerById(self._e_event176);
        __o_rrpgObjs.removeEventListenerById(self._e_event175);
        __o_rrpgObjs.removeEventListenerById(self._e_event174);
        __o_rrpgObjs.removeEventListenerById(self._e_event173);
        __o_rrpgObjs.removeEventListenerById(self._e_event172);
        __o_rrpgObjs.removeEventListenerById(self._e_event171);
        __o_rrpgObjs.removeEventListenerById(self._e_event170);
        __o_rrpgObjs.removeEventListenerById(self._e_event169);
        __o_rrpgObjs.removeEventListenerById(self._e_event168);
        __o_rrpgObjs.removeEventListenerById(self._e_event167);
        __o_rrpgObjs.removeEventListenerById(self._e_event166);
        __o_rrpgObjs.removeEventListenerById(self._e_event165);
        __o_rrpgObjs.removeEventListenerById(self._e_event164);
        __o_rrpgObjs.removeEventListenerById(self._e_event163);
        __o_rrpgObjs.removeEventListenerById(self._e_event162);
        __o_rrpgObjs.removeEventListenerById(self._e_event161);
        __o_rrpgObjs.removeEventListenerById(self._e_event160);
        __o_rrpgObjs.removeEventListenerById(self._e_event159);
        __o_rrpgObjs.removeEventListenerById(self._e_event158);
        __o_rrpgObjs.removeEventListenerById(self._e_event157);
        __o_rrpgObjs.removeEventListenerById(self._e_event156);
        __o_rrpgObjs.removeEventListenerById(self._e_event155);
        __o_rrpgObjs.removeEventListenerById(self._e_event154);
        __o_rrpgObjs.removeEventListenerById(self._e_event153);
        __o_rrpgObjs.removeEventListenerById(self._e_event152);
        __o_rrpgObjs.removeEventListenerById(self._e_event151);
        __o_rrpgObjs.removeEventListenerById(self._e_event150);
        __o_rrpgObjs.removeEventListenerById(self._e_event149);
        __o_rrpgObjs.removeEventListenerById(self._e_event148);
        __o_rrpgObjs.removeEventListenerById(self._e_event147);
        __o_rrpgObjs.removeEventListenerById(self._e_event146);
        __o_rrpgObjs.removeEventListenerById(self._e_event145);
        __o_rrpgObjs.removeEventListenerById(self._e_event144);
        __o_rrpgObjs.removeEventListenerById(self._e_event143);
        __o_rrpgObjs.removeEventListenerById(self._e_event142);
        __o_rrpgObjs.removeEventListenerById(self._e_event141);
        __o_rrpgObjs.removeEventListenerById(self._e_event140);
        __o_rrpgObjs.removeEventListenerById(self._e_event139);
        __o_rrpgObjs.removeEventListenerById(self._e_event138);
        __o_rrpgObjs.removeEventListenerById(self._e_event137);
        __o_rrpgObjs.removeEventListenerById(self._e_event136);
        __o_rrpgObjs.removeEventListenerById(self._e_event135);
        __o_rrpgObjs.removeEventListenerById(self._e_event134);
        __o_rrpgObjs.removeEventListenerById(self._e_event133);
        __o_rrpgObjs.removeEventListenerById(self._e_event132);
        __o_rrpgObjs.removeEventListenerById(self._e_event131);
        __o_rrpgObjs.removeEventListenerById(self._e_event130);
        __o_rrpgObjs.removeEventListenerById(self._e_event129);
        __o_rrpgObjs.removeEventListenerById(self._e_event128);
        __o_rrpgObjs.removeEventListenerById(self._e_event127);
        __o_rrpgObjs.removeEventListenerById(self._e_event126);
        __o_rrpgObjs.removeEventListenerById(self._e_event125);
        __o_rrpgObjs.removeEventListenerById(self._e_event124);
        __o_rrpgObjs.removeEventListenerById(self._e_event123);
        __o_rrpgObjs.removeEventListenerById(self._e_event122);
        __o_rrpgObjs.removeEventListenerById(self._e_event121);
        __o_rrpgObjs.removeEventListenerById(self._e_event120);
        __o_rrpgObjs.removeEventListenerById(self._e_event119);
        __o_rrpgObjs.removeEventListenerById(self._e_event118);
        __o_rrpgObjs.removeEventListenerById(self._e_event117);
        __o_rrpgObjs.removeEventListenerById(self._e_event116);
        __o_rrpgObjs.removeEventListenerById(self._e_event115);
        __o_rrpgObjs.removeEventListenerById(self._e_event114);
        __o_rrpgObjs.removeEventListenerById(self._e_event113);
        __o_rrpgObjs.removeEventListenerById(self._e_event112);
        __o_rrpgObjs.removeEventListenerById(self._e_event111);
        __o_rrpgObjs.removeEventListenerById(self._e_event110);
        __o_rrpgObjs.removeEventListenerById(self._e_event109);
        __o_rrpgObjs.removeEventListenerById(self._e_event108);
        __o_rrpgObjs.removeEventListenerById(self._e_event107);
        __o_rrpgObjs.removeEventListenerById(self._e_event106);
        __o_rrpgObjs.removeEventListenerById(self._e_event105);
        __o_rrpgObjs.removeEventListenerById(self._e_event104);
        __o_rrpgObjs.removeEventListenerById(self._e_event103);
        __o_rrpgObjs.removeEventListenerById(self._e_event102);
        __o_rrpgObjs.removeEventListenerById(self._e_event101);
        __o_rrpgObjs.removeEventListenerById(self._e_event100);
        __o_rrpgObjs.removeEventListenerById(self._e_event99);
        __o_rrpgObjs.removeEventListenerById(self._e_event98);
        __o_rrpgObjs.removeEventListenerById(self._e_event97);
        __o_rrpgObjs.removeEventListenerById(self._e_event96);
        __o_rrpgObjs.removeEventListenerById(self._e_event95);
        __o_rrpgObjs.removeEventListenerById(self._e_event94);
        __o_rrpgObjs.removeEventListenerById(self._e_event93);
        __o_rrpgObjs.removeEventListenerById(self._e_event92);
        __o_rrpgObjs.removeEventListenerById(self._e_event91);
        __o_rrpgObjs.removeEventListenerById(self._e_event90);
        __o_rrpgObjs.removeEventListenerById(self._e_event89);
        __o_rrpgObjs.removeEventListenerById(self._e_event88);
        __o_rrpgObjs.removeEventListenerById(self._e_event87);
        __o_rrpgObjs.removeEventListenerById(self._e_event86);
        __o_rrpgObjs.removeEventListenerById(self._e_event85);
        __o_rrpgObjs.removeEventListenerById(self._e_event84);
        __o_rrpgObjs.removeEventListenerById(self._e_event83);
        __o_rrpgObjs.removeEventListenerById(self._e_event82);
        __o_rrpgObjs.removeEventListenerById(self._e_event81);
        __o_rrpgObjs.removeEventListenerById(self._e_event80);
        __o_rrpgObjs.removeEventListenerById(self._e_event79);
        __o_rrpgObjs.removeEventListenerById(self._e_event78);
        __o_rrpgObjs.removeEventListenerById(self._e_event77);
        __o_rrpgObjs.removeEventListenerById(self._e_event76);
        __o_rrpgObjs.removeEventListenerById(self._e_event75);
        __o_rrpgObjs.removeEventListenerById(self._e_event74);
        __o_rrpgObjs.removeEventListenerById(self._e_event73);
        __o_rrpgObjs.removeEventListenerById(self._e_event72);
        __o_rrpgObjs.removeEventListenerById(self._e_event71);
        __o_rrpgObjs.removeEventListenerById(self._e_event70);
        __o_rrpgObjs.removeEventListenerById(self._e_event69);
        __o_rrpgObjs.removeEventListenerById(self._e_event68);
        __o_rrpgObjs.removeEventListenerById(self._e_event67);
        __o_rrpgObjs.removeEventListenerById(self._e_event66);
        __o_rrpgObjs.removeEventListenerById(self._e_event65);
        __o_rrpgObjs.removeEventListenerById(self._e_event64);
        __o_rrpgObjs.removeEventListenerById(self._e_event63);
        __o_rrpgObjs.removeEventListenerById(self._e_event62);
        __o_rrpgObjs.removeEventListenerById(self._e_event61);
        __o_rrpgObjs.removeEventListenerById(self._e_event60);
        __o_rrpgObjs.removeEventListenerById(self._e_event59);
        __o_rrpgObjs.removeEventListenerById(self._e_event58);
        __o_rrpgObjs.removeEventListenerById(self._e_event57);
        __o_rrpgObjs.removeEventListenerById(self._e_event56);
        __o_rrpgObjs.removeEventListenerById(self._e_event55);
        __o_rrpgObjs.removeEventListenerById(self._e_event54);
        __o_rrpgObjs.removeEventListenerById(self._e_event53);
        __o_rrpgObjs.removeEventListenerById(self._e_event52);
        __o_rrpgObjs.removeEventListenerById(self._e_event51);
        __o_rrpgObjs.removeEventListenerById(self._e_event50);
        __o_rrpgObjs.removeEventListenerById(self._e_event49);
        __o_rrpgObjs.removeEventListenerById(self._e_event48);
        __o_rrpgObjs.removeEventListenerById(self._e_event47);
        __o_rrpgObjs.removeEventListenerById(self._e_event46);
        __o_rrpgObjs.removeEventListenerById(self._e_event45);
        __o_rrpgObjs.removeEventListenerById(self._e_event44);
        __o_rrpgObjs.removeEventListenerById(self._e_event43);
        __o_rrpgObjs.removeEventListenerById(self._e_event42);
        __o_rrpgObjs.removeEventListenerById(self._e_event41);
        __o_rrpgObjs.removeEventListenerById(self._e_event40);
        __o_rrpgObjs.removeEventListenerById(self._e_event39);
        __o_rrpgObjs.removeEventListenerById(self._e_event38);
        __o_rrpgObjs.removeEventListenerById(self._e_event37);
        __o_rrpgObjs.removeEventListenerById(self._e_event36);
        __o_rrpgObjs.removeEventListenerById(self._e_event35);
        __o_rrpgObjs.removeEventListenerById(self._e_event34);
        __o_rrpgObjs.removeEventListenerById(self._e_event33);
        __o_rrpgObjs.removeEventListenerById(self._e_event32);
        __o_rrpgObjs.removeEventListenerById(self._e_event31);
        __o_rrpgObjs.removeEventListenerById(self._e_event30);
        __o_rrpgObjs.removeEventListenerById(self._e_event29);
        __o_rrpgObjs.removeEventListenerById(self._e_event28);
        __o_rrpgObjs.removeEventListenerById(self._e_event27);
        __o_rrpgObjs.removeEventListenerById(self._e_event26);
        __o_rrpgObjs.removeEventListenerById(self._e_event25);
        __o_rrpgObjs.removeEventListenerById(self._e_event24);
        __o_rrpgObjs.removeEventListenerById(self._e_event23);
        __o_rrpgObjs.removeEventListenerById(self._e_event22);
        __o_rrpgObjs.removeEventListenerById(self._e_event21);
        __o_rrpgObjs.removeEventListenerById(self._e_event20);
        __o_rrpgObjs.removeEventListenerById(self._e_event19);
        __o_rrpgObjs.removeEventListenerById(self._e_event18);
        __o_rrpgObjs.removeEventListenerById(self._e_event17);
        __o_rrpgObjs.removeEventListenerById(self._e_event16);
        __o_rrpgObjs.removeEventListenerById(self._e_event15);
        __o_rrpgObjs.removeEventListenerById(self._e_event14);
        __o_rrpgObjs.removeEventListenerById(self._e_event13);
        __o_rrpgObjs.removeEventListenerById(self._e_event12);
        __o_rrpgObjs.removeEventListenerById(self._e_event11);
        __o_rrpgObjs.removeEventListenerById(self._e_event10);
        __o_rrpgObjs.removeEventListenerById(self._e_event9);
        __o_rrpgObjs.removeEventListenerById(self._e_event8);
        __o_rrpgObjs.removeEventListenerById(self._e_event7);
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

        if self.edit77 ~= nil then self.edit77:destroy(); self.edit77 = nil; end;
        if self.flowPart2 ~= nil then self.flowPart2:destroy(); self.flowPart2 = nil; end;
        if self.edit47 ~= nil then self.edit47:destroy(); self.edit47 = nil; end;
        if self.btnNovoflwMagicRecordListSpc5 ~= nil then self.btnNovoflwMagicRecordListSpc5:destroy(); self.btnNovoflwMagicRecordListSpc5 = nil; end;
        if self.cbOptAtaqueMunicao ~= nil then self.cbOptAtaqueMunicao:destroy(); self.cbOptAtaqueMunicao = nil; end;
        if self.edit49 ~= nil then self.edit49:destroy(); self.edit49 = nil; end;
        if self.flowPart63 ~= nil then self.flowPart63:destroy(); self.flowPart63 = nil; end;
        if self.flpSkillFlowPart7str ~= nil then self.flpSkillFlowPart7str:destroy(); self.flpSkillFlowPart7str = nil; end;
        if self.label67 ~= nil then self.label67:destroy(); self.label67 = nil; end;
        if self.flpSkillFlowPart5str ~= nil then self.flpSkillFlowPart5str:destroy(); self.flpSkillFlowPart5str = nil; end;
        if self.flpSkillFlowPart3str ~= nil then self.flpSkillFlowPart3str:destroy(); self.flpSkillFlowPart3str = nil; end;
        if self.flpSkillFlowPart1str ~= nil then self.flpSkillFlowPart1str:destroy(); self.flpSkillFlowPart1str = nil; end;
        if self.checkBox1 ~= nil then self.checkBox1:destroy(); self.checkBox1 = nil; end;
        if self.dataLink105 ~= nil then self.dataLink105:destroy(); self.dataLink105 = nil; end;
        if self.flpSkillFlowPart1 ~= nil then self.flpSkillFlowPart1:destroy(); self.flpSkillFlowPart1 = nil; end;
        if self.horzLine9 ~= nil then self.horzLine9:destroy(); self.horzLine9 = nil; end;
        if self.comboBox3 ~= nil then self.comboBox3:destroy(); self.comboBox3 = nil; end;
        if self.tab11 ~= nil then self.tab11:destroy(); self.tab11 = nil; end;
        if self.labUpperGridCampo3 ~= nil then self.labUpperGridCampo3:destroy(); self.labUpperGridCampo3 = nil; end;
        if self.horzLine23 ~= nil then self.horzLine23:destroy(); self.horzLine23 = nil; end;
        if self.flowPart69 ~= nil then self.flowPart69:destroy(); self.flowPart69 = nil; end;
        if self.layout59 ~= nil then self.layout59:destroy(); self.layout59 = nil; end;
        if self.label69 ~= nil then self.label69:destroy(); self.label69 = nil; end;
        if self.edit60 ~= nil then self.edit60:destroy(); self.edit60 = nil; end;
        if self.dataLink5 ~= nil then self.dataLink5:destroy(); self.dataLink5 = nil; end;
        if self.frame2 ~= nil then self.frame2:destroy(); self.frame2 = nil; end;
        if self.horzLine3 ~= nil then self.horzLine3:destroy(); self.horzLine3 = nil; end;
        if self.label39 ~= nil then self.label39:destroy(); self.label39 = nil; end;
        if self.layBottomflwMagicRecordListSpc4 ~= nil then self.layBottomflwMagicRecordListSpc4:destroy(); self.layBottomflwMagicRecordListSpc4 = nil; end;
        if self.flpSkillFlowPart14 ~= nil then self.flpSkillFlowPart14:destroy(); self.flpSkillFlowPart14 = nil; end;
        if self.layout57 ~= nil then self.layout57:destroy(); self.layout57 = nil; end;
        if self.layout67 ~= nil then self.layout67:destroy(); self.layout67 = nil; end;
        if self.edit6 ~= nil then self.edit6:destroy(); self.edit6 = nil; end;
        if self.linUpperGridCampo4 ~= nil then self.linUpperGridCampo4:destroy(); self.linUpperGridCampo4 = nil; end;
        if self.dataLink41 ~= nil then self.dataLink41:destroy(); self.dataLink41 = nil; end;
        if self.dataLink51 ~= nil then self.dataLink51:destroy(); self.dataLink51 = nil; end;
        if self.image1 ~= nil then self.image1:destroy(); self.image1 = nil; end;
        if self.button3 ~= nil then self.button3:destroy(); self.button3 = nil; end;
        if self.flowPart17 ~= nil then self.flowPart17:destroy(); self.flowPart17 = nil; end;
        if self.label40 ~= nil then self.label40:destroy(); self.label40 = nil; end;
        if self.button18 ~= nil then self.button18:destroy(); self.button18 = nil; end;
        if self.layout15 ~= nil then self.layout15:destroy(); self.layout15 = nil; end;
        if self.label33 ~= nil then self.label33:destroy(); self.label33 = nil; end;
        if self.flowLineBreak10 ~= nil then self.flowLineBreak10:destroy(); self.flowLineBreak10 = nil; end;
        if self.flwInnateUsage5 ~= nil then self.flwInnateUsage5:destroy(); self.flwInnateUsage5 = nil; end;
        if self.rclflwInnateUsage4 ~= nil then self.rclflwInnateUsage4:destroy(); self.rclflwInnateUsage4 = nil; end;
        if self.flowLayout14 ~= nil then self.flowLayout14:destroy(); self.flowLayout14 = nil; end;
        if self.layout2 ~= nil then self.layout2:destroy(); self.layout2 = nil; end;
        if self.layout42 ~= nil then self.layout42:destroy(); self.layout42 = nil; end;
        if self.dataLink68 ~= nil then self.dataLink68:destroy(); self.dataLink68 = nil; end;
        if self.dataLink90 ~= nil then self.dataLink90:destroy(); self.dataLink90 = nil; end;
        if self.button16 ~= nil then self.button16:destroy(); self.button16 = nil; end;
        if self.button24 ~= nil then self.button24:destroy(); self.button24 = nil; end;
        if self.flpSkillFlowPart18str ~= nil then self.flpSkillFlowPart18str:destroy(); self.flpSkillFlowPart18str = nil; end;
        if self.flowPart32 ~= nil then self.flowPart32:destroy(); self.flowPart32 = nil; end;
        if self.flowPart20 ~= nil then self.flowPart20:destroy(); self.flowPart20 = nil; end;
        if self.label81 ~= nil then self.label81:destroy(); self.label81 = nil; end;
        if self.layout48 ~= nil then self.layout48:destroy(); self.layout48 = nil; end;
        if self.dataLink66 ~= nil then self.dataLink66:destroy(); self.dataLink66 = nil; end;
        if self.dataLink74 ~= nil then self.dataLink74:destroy(); self.dataLink74 = nil; end;
        if self.edit15 ~= nil then self.edit15:destroy(); self.edit15 = nil; end;
        if self.flwMagicRecordListSpc10 ~= nil then self.flwMagicRecordListSpc10:destroy(); self.flwMagicRecordListSpc10 = nil; end;
        if self.dataLink85 ~= nil then self.dataLink85:destroy(); self.dataLink85 = nil; end;
        if self.label28 ~= nil then self.label28:destroy(); self.label28 = nil; end;
        if self.textEditor3 ~= nil then self.textEditor3:destroy(); self.textEditor3 = nil; end;
        if self.dataLink24 ~= nil then self.dataLink24:destroy(); self.dataLink24 = nil; end;
        if self.edit57 ~= nil then self.edit57:destroy(); self.edit57 = nil; end;
        if self.flowPart59 ~= nil then self.flowPart59:destroy(); self.flowPart59 = nil; end;
        if self.label100 ~= nil then self.label100:destroy(); self.label100 = nil; end;
        if self.scrollBox1 ~= nil then self.scrollBox1:destroy(); self.scrollBox1 = nil; end;
        if self.flowLayout23 ~= nil then self.flowLayout23:destroy(); self.flowLayout23 = nil; end;
        if self.rectangle2 ~= nil then self.rectangle2:destroy(); self.rectangle2 = nil; end;
        if self.label50 ~= nil then self.label50:destroy(); self.label50 = nil; end;
        if self.flpSkillFlowPart17str ~= nil then self.flpSkillFlowPart17str:destroy(); self.flpSkillFlowPart17str = nil; end;
        if self.flowLayout33 ~= nil then self.flowLayout33:destroy(); self.flowLayout33 = nil; end;
        if self.flpSkillFlowPart15str ~= nil then self.flpSkillFlowPart15str:destroy(); self.flpSkillFlowPart15str = nil; end;
        if self.flpSkillFlowPart13str ~= nil then self.flpSkillFlowPart13str:destroy(); self.flpSkillFlowPart13str = nil; end;
        if self.dataLink110 ~= nil then self.dataLink110:destroy(); self.dataLink110 = nil; end;
        if self.flpSkillFlowPart11str ~= nil then self.flpSkillFlowPart11str:destroy(); self.flpSkillFlowPart11str = nil; end;
        if self.layout23 ~= nil then self.layout23:destroy(); self.layout23 = nil; end;
        if self.dataLink15 ~= nil then self.dataLink15:destroy(); self.dataLink15 = nil; end;
        if self.flowPart53 ~= nil then self.flowPart53:destroy(); self.flowPart53 = nil; end;
        if self.flowPart43 ~= nil then self.flowPart43:destroy(); self.flowPart43 = nil; end;
        if self.flwNomeMob ~= nil then self.flwNomeMob:destroy(); self.flwNomeMob = nil; end;
        if self.modsabedoriabutton ~= nil then self.modsabedoriabutton:destroy(); self.modsabedoriabutton = nil; end;
        if self.label77 ~= nil then self.label77:destroy(); self.label77 = nil; end;
        if self.edit78 ~= nil then self.edit78:destroy(); self.edit78 = nil; end;
        if self.edtUpperGridCampo5 ~= nil then self.edtUpperGridCampo5:destroy(); self.edtUpperGridCampo5 = nil; end;
        if self.btnNovoflwMagicRecordListSpc6 ~= nil then self.btnNovoflwMagicRecordListSpc6:destroy(); self.btnNovoflwMagicRecordListSpc6 = nil; end;
        if self.flpSkillFlowPart19str ~= nil then self.flpSkillFlowPart19str:destroy(); self.flpSkillFlowPart19str = nil; end;
        if self.layBottomflwMagicRecordListSpc10 ~= nil then self.layBottomflwMagicRecordListSpc10:destroy(); self.layBottomflwMagicRecordListSpc10 = nil; end;
        if self.labupperGridMagicBox5 ~= nil then self.labupperGridMagicBox5:destroy(); self.labupperGridMagicBox5 = nil; end;
        if self.flowLineBreak5 ~= nil then self.flowLineBreak5:destroy(); self.flowLineBreak5 = nil; end;
        if self.UpperGridCampo3 ~= nil then self.UpperGridCampo3:destroy(); self.UpperGridCampo3 = nil; end;
        if self.label97 ~= nil then self.label97:destroy(); self.label97 = nil; end;
        if self.flowPart9 ~= nil then self.flowPart9:destroy(); self.flowPart9 = nil; end;
        if self.flowPart64 ~= nil then self.flowPart64:destroy(); self.flowPart64 = nil; end;
        if self.checkBox2 ~= nil then self.checkBox2:destroy(); self.checkBox2 = nil; end;
        if self.dataLink30 ~= nil then self.dataLink30:destroy(); self.dataLink30 = nil; end;
        if self.edit25 ~= nil then self.edit25:destroy(); self.edit25 = nil; end;
        if self.horzLine24 ~= nil then self.horzLine24:destroy(); self.horzLine24 = nil; end;
        if self.edit63 ~= nil then self.edit63:destroy(); self.edit63 = nil; end;
        if self.layout31 ~= nil then self.layout31:destroy(); self.layout31 = nil; end;
        if self.flowPart18 ~= nil then self.flowPart18:destroy(); self.flowPart18 = nil; end;
        if self.tab9 ~= nil then self.tab9:destroy(); self.tab9 = nil; end;
        if self.flpSkillFlowPart11 ~= nil then self.flpSkillFlowPart11:destroy(); self.flpSkillFlowPart11 = nil; end;
        if self.layout50 ~= nil then self.layout50:destroy(); self.layout50 = nil; end;
        if self.layout62 ~= nil then self.layout62:destroy(); self.layout62 = nil; end;
        if self.edit5 ~= nil then self.edit5:destroy(); self.edit5 = nil; end;
        if self.image15 ~= nil then self.image15:destroy(); self.image15 = nil; end;
        if self.dataLink2 ~= nil then self.dataLink2:destroy(); self.dataLink2 = nil; end;
        if self.image2 ~= nil then self.image2:destroy(); self.image2 = nil; end;
        if self.edit69 ~= nil then self.edit69:destroy(); self.edit69 = nil; end;
        if self.flowPart12 ~= nil then self.flowPart12:destroy(); self.flowPart12 = nil; end;
        if self.flpSkillFlowPart1button ~= nil then self.flpSkillFlowPart1button:destroy(); self.flpSkillFlowPart1button = nil; end;
        if self.label43 ~= nil then self.label43:destroy(); self.label43 = nil; end;
        if self.tab7 ~= nil then self.tab7:destroy(); self.tab7 = nil; end;
        if self.layout16 ~= nil then self.layout16:destroy(); self.layout16 = nil; end;
        if self.label30 ~= nil then self.label30:destroy(); self.label30 = nil; end;
        if self.edit39 ~= nil then self.edit39:destroy(); self.edit39 = nil; end;
        if self.flwMagicRecordListSpc5 ~= nil then self.flwMagicRecordListSpc5:destroy(); self.flwMagicRecordListSpc5 = nil; end;
        if self.rclflwMagicRecordListSpc8 ~= nil then self.rclflwMagicRecordListSpc8:destroy(); self.rclflwMagicRecordListSpc8 = nil; end;
        if self.flowLineBreak13 ~= nil then self.flowLineBreak13:destroy(); self.flowLineBreak13 = nil; end;
        if self.rclflwInnateUsage3 ~= nil then self.rclflwInnateUsage3:destroy(); self.rclflwInnateUsage3 = nil; end;
        if self.image24 ~= nil then self.image24:destroy(); self.image24 = nil; end;
        if self.linUpperGridCampo3 ~= nil then self.linUpperGridCampo3:destroy(); self.linUpperGridCampo3 = nil; end;
        if self.dataLink46 ~= nil then self.dataLink46:destroy(); self.dataLink46 = nil; end;
        if self.dataLink58 ~= nil then self.dataLink58:destroy(); self.dataLink58 = nil; end;
        if self.layout5 ~= nil then self.layout5:destroy(); self.layout5 = nil; end;
        if self.image8 ~= nil then self.image8:destroy(); self.image8 = nil; end;
        if self.button4 ~= nil then self.button4:destroy(); self.button4 = nil; end;
        if self.label49 ~= nil then self.label49:destroy(); self.label49 = nil; end;
        if self.edit18 ~= nil then self.edit18:destroy(); self.edit18 = nil; end;
        if self.button13 ~= nil then self.button13:destroy(); self.button13 = nil; end;
        if self.dataLink95 ~= nil then self.dataLink95:destroy(); self.dataLink95 = nil; end;
        if self.button23 ~= nil then self.button23:destroy(); self.button23 = nil; end;
        if self.edit37 ~= nil then self.edit37:destroy(); self.edit37 = nil; end;
        if self.rclflwMagicRecordListSpc6 ~= nil then self.rclflwMagicRecordListSpc6:destroy(); self.rclflwMagicRecordListSpc6 = nil; end;
        if self.textEditor11 ~= nil then self.textEditor11:destroy(); self.textEditor11 = nil; end;
        if self.label19 ~= nil then self.label19:destroy(); self.label19 = nil; end;
        if self.layPrincipal ~= nil then self.layPrincipal:destroy(); self.layPrincipal = nil; end;
        if self.horzLine10 ~= nil then self.horzLine10:destroy(); self.horzLine10 = nil; end;
        if self.label5 ~= nil then self.label5:destroy(); self.label5 = nil; end;
        if self.flowLayout13 ~= nil then self.flowLayout13:destroy(); self.flowLayout13 = nil; end;
        if self.dataLink61 ~= nil then self.dataLink61:destroy(); self.dataLink61 = nil; end;
        if self.dataLink71 ~= nil then self.dataLink71:destroy(); self.dataLink71 = nil; end;
        if self.edit12 ~= nil then self.edit12:destroy(); self.edit12 = nil; end;
        if self.label17 ~= nil then self.label17:destroy(); self.label17 = nil; end;
        if self.label27 ~= nil then self.label27:destroy(); self.label27 = nil; end;
        if self.dataLink27 ~= nil then self.dataLink27:destroy(); self.dataLink27 = nil; end;
        if self.edit54 ~= nil then self.edit54:destroy(); self.edit54 = nil; end;
        if self.flowPart71 ~= nil then self.flowPart71:destroy(); self.flowPart71 = nil; end;
        if self.scrollBox4 ~= nil then self.scrollBox4:destroy(); self.scrollBox4 = nil; end;
        if self.flowLayout26 ~= nil then self.flowLayout26:destroy(); self.flowLayout26 = nil; end;
        if self.label55 ~= nil then self.label55:destroy(); self.label55 = nil; end;
        if self.flowLayout34 ~= nil then self.flowLayout34:destroy(); self.flowLayout34 = nil; end;
        if self.rectangle7 ~= nil then self.rectangle7:destroy(); self.rectangle7 = nil; end;
        if self.layout26 ~= nil then self.layout26:destroy(); self.layout26 = nil; end;
        if self.panupperGridMagicBox1 ~= nil then self.panupperGridMagicBox1:destroy(); self.panupperGridMagicBox1 = nil; end;
        if self.dataLink82 ~= nil then self.dataLink82:destroy(); self.dataLink82 = nil; end;
        if self.popMagiaInnate ~= nil then self.popMagiaInnate:destroy(); self.popMagiaInnate = nil; end;
        if self.textEditor8 ~= nil then self.textEditor8:destroy(); self.textEditor8 = nil; end;
        if self.flowPart56 ~= nil then self.flowPart56:destroy(); self.flowPart56 = nil; end;
        if self.flowPart40 ~= nil then self.flowPart40:destroy(); self.flowPart40 = nil; end;
        if self.label74 ~= nil then self.label74:destroy(); self.label74 = nil; end;
        if self.modinteligenciastr ~= nil then self.modinteligenciastr:destroy(); self.modinteligenciastr = nil; end;
        if self.edtUpperGridCampo6 ~= nil then self.edtUpperGridCampo6:destroy(); self.edtUpperGridCampo6 = nil; end;
        if self.layout28 ~= nil then self.layout28:destroy(); self.layout28 = nil; end;
        if self.upperGridMagicBox5 ~= nil then self.upperGridMagicBox5:destroy(); self.upperGridMagicBox5 = nil; end;
        if self.flowLineBreak6 ~= nil then self.flowLineBreak6:destroy(); self.flowLineBreak6 = nil; end;
        if self.UpperGridCampo6 ~= nil then self.UpperGridCampo6:destroy(); self.UpperGridCampo6 = nil; end;
        if self.label90 ~= nil then self.label90:destroy(); self.label90 = nil; end;
        if self.edit73 ~= nil then self.edit73:destroy(); self.edit73 = nil; end;
        if self.flowPart6 ~= nil then self.flowPart6:destroy(); self.flowPart6 = nil; end;
        if self.flpSkillFlowPart20button ~= nil then self.flpSkillFlowPart20button:destroy(); self.flpSkillFlowPart20button = nil; end;
        if self.edit43 ~= nil then self.edit43:destroy(); self.edit43 = nil; end;
        if self.btnNovoflwMagicRecordListSpc1 ~= nil then self.btnNovoflwMagicRecordListSpc1:destroy(); self.btnNovoflwMagicRecordListSpc1 = nil; end;
        if self.tabInnateByUse ~= nil then self.tabInnateByUse:destroy(); self.tabInnateByUse = nil; end;
        if self.comboBox10 ~= nil then self.comboBox10:destroy(); self.comboBox10 = nil; end;
        if self.comboBox5 ~= nil then self.comboBox5:destroy(); self.comboBox5 = nil; end;
        if self.layEquipAttackLeft ~= nil then self.layEquipAttackLeft:destroy(); self.layEquipAttackLeft = nil; end;
        if self.dataLink35 ~= nil then self.dataLink35:destroy(); self.dataLink35 = nil; end;
        if self.edit20 ~= nil then self.edit20:destroy(); self.edit20 = nil; end;
        if self.label63 ~= nil then self.label63:destroy(); self.label63 = nil; end;
        if self.edit66 ~= nil then self.edit66:destroy(); self.edit66 = nil; end;
        if self.layout36 ~= nil then self.layout36:destroy(); self.layout36 = nil; end;
        if self.flpSkillFlowPart17button ~= nil then self.flpSkillFlowPart17button:destroy(); self.flpSkillFlowPart17button = nil; end;
        if self.dataLink101 ~= nil then self.dataLink101:destroy(); self.dataLink101 = nil; end;
        if self.flpSkillFlowPart5 ~= nil then self.flpSkillFlowPart5:destroy(); self.flpSkillFlowPart5 = nil; end;
        if self.horzLine5 ~= nil then self.horzLine5:destroy(); self.horzLine5 = nil; end;
        if self.flpSkillFlowPart12 ~= nil then self.flpSkillFlowPart12:destroy(); self.flpSkillFlowPart12 = nil; end;
        if self.flpSkillFlowPart20 ~= nil then self.flpSkillFlowPart20:destroy(); self.flpSkillFlowPart20 = nil; end;
        if self.fraUpperGridFrenteMob ~= nil then self.fraUpperGridFrenteMob:destroy(); self.fraUpperGridFrenteMob = nil; end;
        if self.layout61 ~= nil then self.layout61:destroy(); self.layout61 = nil; end;
        if self.button9 ~= nil then self.button9:destroy(); self.button9 = nil; end;
        if self.image10 ~= nil then self.image10:destroy(); self.image10 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.flowPart11 ~= nil then self.flowPart11:destroy(); self.flowPart11 = nil; end;
        if self.label46 ~= nil then self.label46:destroy(); self.label46 = nil; end;
        if self.flwMagicRecordListSpc6 ~= nil then self.flwMagicRecordListSpc6:destroy(); self.flwMagicRecordListSpc6 = nil; end;
        if self.flowLayout7 ~= nil then self.flowLayout7:destroy(); self.flowLayout7 = nil; end;
        if self.image21 ~= nil then self.image21:destroy(); self.image21 = nil; end;
        if self.dataLink45 ~= nil then self.dataLink45:destroy(); self.dataLink45 = nil; end;
        if self.dataLink55 ~= nil then self.dataLink55:destroy(); self.dataLink55 = nil; end;
        if self.button7 ~= nil then self.button7:destroy(); self.button7 = nil; end;
        if self.layout8 ~= nil then self.layout8:destroy(); self.layout8 = nil; end;
        if self.image5 ~= nil then self.image5:destroy(); self.image5 = nil; end;
        if self.layout11 ~= nil then self.layout11:destroy(); self.layout11 = nil; end;
        if self.label37 ~= nil then self.label37:destroy(); self.label37 = nil; end;
        if self.edit30 ~= nil then self.edit30:destroy(); self.edit30 = nil; end;
        if self.flowPart38 ~= nil then self.flowPart38:destroy(); self.flowPart38 = nil; end;
        if self.flowLayout9 ~= nil then self.flowLayout9:destroy(); self.flowLayout9 = nil; end;
        if self.rclflwMagicRecordListSpc1 ~= nil then self.rclflwMagicRecordListSpc1:destroy(); self.rclflwMagicRecordListSpc1 = nil; end;
        if self.flwInnateUsage1 ~= nil then self.flwInnateUsage1:destroy(); self.flwInnateUsage1 = nil; end;
        if self.horzLine17 ~= nil then self.horzLine17:destroy(); self.horzLine17 = nil; end;
        if self.optAtaqueLegenda ~= nil then self.optAtaqueLegenda:destroy(); self.optAtaqueLegenda = nil; end;
        if self.flowLayout10 ~= nil then self.flowLayout10:destroy(); self.flowLayout10 = nil; end;
        if self.layout46 ~= nil then self.layout46:destroy(); self.layout46 = nil; end;
        if self.dataLink72 ~= nil then self.dataLink72:destroy(); self.dataLink72 = nil; end;
        if self.button28 ~= nil then self.button28:destroy(); self.button28 = nil; end;
        if self.edit82 ~= nil then self.edit82:destroy(); self.edit82 = nil; end;
        if self.flowPart36 ~= nil then self.flowPart36:destroy(); self.flowPart36 = nil; end;
        if self.flowPart24 ~= nil then self.flowPart24:destroy(); self.flowPart24 = nil; end;
        if self.label10 ~= nil then self.label10:destroy(); self.label10 = nil; end;
        if self.label22 ~= nil then self.label22:destroy(); self.label22 = nil; end;
        if self.horzLine19 ~= nil then self.horzLine19:destroy(); self.horzLine19 = nil; end;
        if self.edit59 ~= nil then self.edit59:destroy(); self.edit59 = nil; end;
        if self.label85 ~= nil then self.label85:destroy(); self.label85 = nil; end;
        if self.flowPart74 ~= nil then self.flowPart74:destroy(); self.flowPart74 = nil; end;
        if self.flowLayout29 ~= nil then self.flowLayout29:destroy(); self.flowLayout29 = nil; end;
        if self.label56 ~= nil then self.label56:destroy(); self.label56 = nil; end;
        if self.rectangle4 ~= nil then self.rectangle4:destroy(); self.rectangle4 = nil; end;
        if self.dataLink78 ~= nil then self.dataLink78:destroy(); self.dataLink78 = nil; end;
        if self.layout25 ~= nil then self.layout25:destroy(); self.layout25 = nil; end;
        if self.panupperGridMagicBox6 ~= nil then self.panupperGridMagicBox6:destroy(); self.panupperGridMagicBox6 = nil; end;
        if self.dataLink81 ~= nil then self.dataLink81:destroy(); self.dataLink81 = nil; end;
        if self.textEditor7 ~= nil then self.textEditor7:destroy(); self.textEditor7 = nil; end;
        if self.dataLink20 ~= nil then self.dataLink20:destroy(); self.dataLink20 = nil; end;
        if self.edit53 ~= nil then self.edit53:destroy(); self.edit53 = nil; end;
        if self.flowPart45 ~= nil then self.flowPart45:destroy(); self.flowPart45 = nil; end;
        if self.flowPart55 ~= nil then self.flowPart55:destroy(); self.flowPart55 = nil; end;
        if self.label79 ~= nil then self.label79:destroy(); self.label79 = nil; end;
        if self.label104 ~= nil then self.label104:destroy(); self.label104 = nil; end;
        if self.edtUpperGridCampo3 ~= nil then self.edtUpperGridCampo3:destroy(); self.edtUpperGridCampo3 = nil; end;
        if self.anotacoesFancy ~= nil then self.anotacoesFancy:destroy(); self.anotacoesFancy = nil; end;
        if self.dataLink11 ~= nil then self.dataLink11:destroy(); self.dataLink11 = nil; end;
        if self.imgEquipAttackImg ~= nil then self.imgEquipAttackImg:destroy(); self.imgEquipAttackImg = nil; end;
        if self.label73 ~= nil then self.label73:destroy(); self.label73 = nil; end;
        if self.edit74 ~= nil then self.edit74:destroy(); self.edit74 = nil; end;
        if self.flowPart3 ~= nil then self.flowPart3:destroy(); self.flowPart3 = nil; end;
        if self.edit46 ~= nil then self.edit46:destroy(); self.edit46 = nil; end;
        if self.btnNovoflwMagicRecordListSpc2 ~= nil then self.btnNovoflwMagicRecordListSpc2:destroy(); self.btnNovoflwMagicRecordListSpc2 = nil; end;
        if self.labupperGridMagicBox1 ~= nil then self.labupperGridMagicBox1:destroy(); self.labupperGridMagicBox1 = nil; end;
        if self.flowLineBreak1 ~= nil then self.flowLineBreak1:destroy(); self.flowLineBreak1 = nil; end;
        if self.dataLink36 ~= nil then self.dataLink36:destroy(); self.dataLink36 = nil; end;
        if self.edit23 ~= nil then self.edit23:destroy(); self.edit23 = nil; end;
        if self.layEquipAttackImg ~= nil then self.layEquipAttackImg:destroy(); self.layEquipAttackImg = nil; end;
        if self.edit48 ~= nil then self.edit48:destroy(); self.edit48 = nil; end;
        if self.flowPart60 ~= nil then self.flowPart60:destroy(); self.flowPart60 = nil; end;
        if self.label66 ~= nil then self.label66:destroy(); self.label66 = nil; end;
        if self.dataLink106 ~= nil then self.dataLink106:destroy(); self.dataLink106 = nil; end;
        if self.edit29 ~= nil then self.edit29:destroy(); self.edit29 = nil; end;
        if self.tab10 ~= nil then self.tab10:destroy(); self.tab10 = nil; end;
        if self.labUpperGridCampo4 ~= nil then self.labUpperGridCampo4:destroy(); self.labUpperGridCampo4 = nil; end;
        if self.horzLine20 ~= nil then self.horzLine20:destroy(); self.horzLine20 = nil; end;
        if self.flpSkillFlowPart16str ~= nil then self.flpSkillFlowPart16str:destroy(); self.flpSkillFlowPart16str = nil; end;
        if self.flpSkillFlowPart14str ~= nil then self.flpSkillFlowPart14str:destroy(); self.flpSkillFlowPart14str = nil; end;
        if self.flpSkillFlowPart12str ~= nil then self.flpSkillFlowPart12str:destroy(); self.flpSkillFlowPart12str = nil; end;
        if self.label68 ~= nil then self.label68:destroy(); self.label68 = nil; end;
        if self.flpSkillFlowPart10str ~= nil then self.flpSkillFlowPart10str:destroy(); self.flpSkillFlowPart10str = nil; end;
        if self.image13 ~= nil then self.image13:destroy(); self.image13 = nil; end;
        if self.dataLink4 ~= nil then self.dataLink4:destroy(); self.dataLink4 = nil; end;
        if self.button30 ~= nil then self.button30:destroy(); self.button30 = nil; end;
        if self.dsbMobAcao ~= nil then self.dsbMobAcao:destroy(); self.dsbMobAcao = nil; end;
        if self.dataLink108 ~= nil then self.dataLink108:destroy(); self.dataLink108 = nil; end;
        if self.layBottomflwMagicRecordListSpc7 ~= nil then self.layBottomflwMagicRecordListSpc7:destroy(); self.layBottomflwMagicRecordListSpc7 = nil; end;
        if self.flpSkillFlowPart19button ~= nil then self.flpSkillFlowPart19button:destroy(); self.flpSkillFlowPart19button = nil; end;
        if self.flpSkillFlowPart15 ~= nil then self.flpSkillFlowPart15:destroy(); self.flpSkillFlowPart15 = nil; end;
        if self.fraFrenteLayout ~= nil then self.fraFrenteLayout:destroy(); self.fraFrenteLayout = nil; end;
        if self.layout54 ~= nil then self.layout54:destroy(); self.layout54 = nil; end;
        if self.layout66 ~= nil then self.layout66:destroy(); self.layout66 = nil; end;
        if self.linUpperGridCampo5 ~= nil then self.linUpperGridCampo5:destroy(); self.linUpperGridCampo5 = nil; end;
        if self.dataLink40 ~= nil then self.dataLink40:destroy(); self.dataLink40 = nil; end;
        if self.dataLink52 ~= nil then self.dataLink52:destroy(); self.dataLink52 = nil; end;
        if self.image6 ~= nil then self.image6:destroy(); self.image6 = nil; end;
        if self.button2 ~= nil then self.button2:destroy(); self.button2 = nil; end;
        if self.flowPart16 ~= nil then self.flowPart16:destroy(); self.flowPart16 = nil; end;
        if self.button19 ~= nil then self.button19:destroy(); self.button19 = nil; end;
        if self.layout12 ~= nil then self.layout12:destroy(); self.layout12 = nil; end;
        if self.label34 ~= nil then self.label34:destroy(); self.label34 = nil; end;
        if self.layBottomflwMagicRecordListSpc9 ~= nil then self.layBottomflwMagicRecordListSpc9:destroy(); self.layBottomflwMagicRecordListSpc9 = nil; end;
        if self.flwMagicRecordListSpc1 ~= nil then self.flwMagicRecordListSpc1:destroy(); self.flwMagicRecordListSpc1 = nil; end;
        if self.modinteligenciabutton ~= nil then self.modinteligenciabutton:destroy(); self.modinteligenciabutton = nil; end;
        if self.flpSkillFlowPart16button ~= nil then self.flpSkillFlowPart16button:destroy(); self.flpSkillFlowPart16button = nil; end;
        if self.flwInnateUsage6 ~= nil then self.flwInnateUsage6:destroy(); self.flwInnateUsage6 = nil; end;
        if self.label3 ~= nil then self.label3:destroy(); self.label3 = nil; end;
        if self.flowLayout15 ~= nil then self.flowLayout15:destroy(); self.flowLayout15 = nil; end;
        if self.layout1 ~= nil then self.layout1:destroy(); self.layout1 = nil; end;
        if self.layout41 ~= nil then self.layout41:destroy(); self.layout41 = nil; end;
        if self.dataLink91 ~= nil then self.dataLink91:destroy(); self.dataLink91 = nil; end;
        if self.button17 ~= nil then self.button17:destroy(); self.button17 = nil; end;
        if self.button27 ~= nil then self.button27:destroy(); self.button27 = nil; end;
        if self.edit81 ~= nil then self.edit81:destroy(); self.edit81 = nil; end;
        if self.flowPart31 ~= nil then self.flowPart31:destroy(); self.flowPart31 = nil; end;
        if self.flowPart21 ~= nil then self.flowPart21:destroy(); self.flowPart21 = nil; end;
        if self.flpSkillFlowPart13button ~= nil then self.flpSkillFlowPart13button:destroy(); self.flpSkillFlowPart13button = nil; end;
        if self.label21 ~= nil then self.label21:destroy(); self.label21 = nil; end;
        if self.optAtaquePadrao ~= nil then self.optAtaquePadrao:destroy(); self.optAtaquePadrao = nil; end;
        if self.label80 ~= nil then self.label80:destroy(); self.label80 = nil; end;
        if self.dataLink65 ~= nil then self.dataLink65:destroy(); self.dataLink65 = nil; end;
        if self.dataLink75 ~= nil then self.dataLink75:destroy(); self.dataLink75 = nil; end;
        if self.edit16 ~= nil then self.edit16:destroy(); self.edit16 = nil; end;
        if self.dataLink84 ~= nil then self.dataLink84:destroy(); self.dataLink84 = nil; end;
        if self.labupperGridMagicBox5val ~= nil then self.labupperGridMagicBox5val:destroy(); self.labupperGridMagicBox5val = nil; end;
        if self.textEditor2 ~= nil then self.textEditor2:destroy(); self.textEditor2 = nil; end;
        if self.dataLink23 ~= nil then self.dataLink23:destroy(); self.dataLink23 = nil; end;
        if self.edit50 ~= nil then self.edit50:destroy(); self.edit50 = nil; end;
        if self.flowPart58 ~= nil then self.flowPart58:destroy(); self.flowPart58 = nil; end;
        if self.label101 ~= nil then self.label101:destroy(); self.label101 = nil; end;
        if self.flowLayout22 ~= nil then self.flowLayout22:destroy(); self.flowLayout22 = nil; end;
        if self.flowLayout30 ~= nil then self.flowLayout30:destroy(); self.flowLayout30 = nil; end;
        if self.rectangle3 ~= nil then self.rectangle3:destroy(); self.rectangle3 = nil; end;
        if self.label51 ~= nil then self.label51:destroy(); self.label51 = nil; end;
        if self.layEquipAttackRight ~= nil then self.layEquipAttackRight:destroy(); self.layEquipAttackRight = nil; end;
        if self.dataLink113 ~= nil then self.dataLink113:destroy(); self.dataLink113 = nil; end;
        if self.layout22 ~= nil then self.layout22:destroy(); self.layout22 = nil; end;
        if self.dataLink16 ~= nil then self.dataLink16:destroy(); self.dataLink16 = nil; end;
        if self.flowPart52 ~= nil then self.flowPart52:destroy(); self.flowPart52 = nil; end;
        if self.upperGridMagicBox3 ~= nil then self.upperGridMagicBox3:destroy(); self.upperGridMagicBox3 = nil; end;
        if self.label70 ~= nil then self.label70:destroy(); self.label70 = nil; end;
        if self.edit79 ~= nil then self.edit79:destroy(); self.edit79 = nil; end;
        if self.edit45 ~= nil then self.edit45:destroy(); self.edit45 = nil; end;
        if self.btnNovoflwMagicRecordListSpc7 ~= nil then self.btnNovoflwMagicRecordListSpc7:destroy(); self.btnNovoflwMagicRecordListSpc7 = nil; end;
        if self.dataLink18 ~= nil then self.dataLink18:destroy(); self.dataLink18 = nil; end;
        if self.labupperGridMagicBox6 ~= nil then self.labupperGridMagicBox6:destroy(); self.labupperGridMagicBox6 = nil; end;
        if self.flowLineBreak2 ~= nil then self.flowLineBreak2:destroy(); self.flowLineBreak2 = nil; end;
        if self.UpperGridCampo2 ~= nil then self.UpperGridCampo2:destroy(); self.UpperGridCampo2 = nil; end;
        if self.label94 ~= nil then self.label94:destroy(); self.label94 = nil; end;
        if self.initiativeBut ~= nil then self.initiativeBut:destroy(); self.initiativeBut = nil; end;
        if self.flpSkillFlowPart6button ~= nil then self.flpSkillFlowPart6button:destroy(); self.flpSkillFlowPart6button = nil; end;
        if self.flowPart65 ~= nil then self.flowPart65:destroy(); self.flowPart65 = nil; end;
        if self.label65 ~= nil then self.label65:destroy(); self.label65 = nil; end;
        if self.modforcabutton ~= nil then self.modforcabutton:destroy(); self.modforcabutton = nil; end;
        if self.layout38 ~= nil then self.layout38:destroy(); self.layout38 = nil; end;
        if self.flpSkillFlowPart3 ~= nil then self.flpSkillFlowPart3:destroy(); self.flpSkillFlowPart3 = nil; end;
        if self.comboBox1 ~= nil then self.comboBox1:destroy(); self.comboBox1 = nil; end;
        if self.flowLineBreak8 ~= nil then self.flowLineBreak8:destroy(); self.flowLineBreak8 = nil; end;
        if self.dataLink31 ~= nil then self.dataLink31:destroy(); self.dataLink31 = nil; end;
        if self.edit24 ~= nil then self.edit24:destroy(); self.edit24 = nil; end;
        if self.labUpperGridCampo1 ~= nil then self.labUpperGridCampo1:destroy(); self.labUpperGridCampo1 = nil; end;
        if self.flpSkillFlowPart18 ~= nil then self.flpSkillFlowPart18:destroy(); self.flpSkillFlowPart18 = nil; end;
        if self.horzLine25 ~= nil then self.horzLine25:destroy(); self.horzLine25 = nil; end;
        if self.tab13 ~= nil then self.tab13:destroy(); self.tab13 = nil; end;
        if self.edit62 ~= nil then self.edit62:destroy(); self.edit62 = nil; end;
        if self.layout32 ~= nil then self.layout32:destroy(); self.layout32 = nil; end;
        if self.horzLine1 ~= nil then self.horzLine1:destroy(); self.horzLine1 = nil; end;
        if self.flpSkillFlowPart15button ~= nil then self.flpSkillFlowPart15button:destroy(); self.flpSkillFlowPart15button = nil; end;
        if self.flpSkillFlowPart16 ~= nil then self.flpSkillFlowPart16:destroy(); self.flpSkillFlowPart16 = nil; end;
        if self.flpSkillFlowPart24 ~= nil then self.flpSkillFlowPart24:destroy(); self.flpSkillFlowPart24 = nil; end;
        if self.layout51 ~= nil then self.layout51:destroy(); self.layout51 = nil; end;
        if self.layout65 ~= nil then self.layout65:destroy(); self.layout65 = nil; end;
        if self.edit4 ~= nil then self.edit4:destroy(); self.edit4 = nil; end;
        if self.image14 ~= nil then self.image14:destroy(); self.image14 = nil; end;
        if self.edit68 ~= nil then self.edit68:destroy(); self.edit68 = nil; end;
        if self.image3 ~= nil then self.image3:destroy(); self.image3 = nil; end;
        if self.fraMagiasLayoutInnate ~= nil then self.fraMagiasLayoutInnate:destroy(); self.fraMagiasLayoutInnate = nil; end;
        if self.flowPart15 ~= nil then self.flowPart15:destroy(); self.flowPart15 = nil; end;
        if self.label42 ~= nil then self.label42:destroy(); self.label42 = nil; end;
        if self.tab4 ~= nil then self.tab4:destroy(); self.tab4 = nil; end;
        if self.layout17 ~= nil then self.layout17:destroy(); self.layout17 = nil; end;
        if self.label31 ~= nil then self.label31:destroy(); self.label31 = nil; end;
        if self.flwMagicRecordListSpc2 ~= nil then self.flwMagicRecordListSpc2:destroy(); self.flwMagicRecordListSpc2 = nil; end;
        if self.flpSkillFlowPart22button ~= nil then self.flpSkillFlowPart22button:destroy(); self.flpSkillFlowPart22button = nil; end;
        if self.flowLayout3 ~= nil then self.flowLayout3:destroy(); self.flowLayout3 = nil; end;
        if self.flowLineBreak12 ~= nil then self.flowLineBreak12:destroy(); self.flowLineBreak12 = nil; end;
        if self.rclflwInnateUsage2 ~= nil then self.rclflwInnateUsage2:destroy(); self.rclflwInnateUsage2 = nil; end;
        if self.image25 ~= nil then self.image25:destroy(); self.image25 = nil; end;
        if self.dataLink59 ~= nil then self.dataLink59:destroy(); self.dataLink59 = nil; end;
        if self.layout4 ~= nil then self.layout4:destroy(); self.layout4 = nil; end;
        if self.image9 ~= nil then self.image9:destroy(); self.image9 = nil; end;
        if self.label48 ~= nil then self.label48:destroy(); self.label48 = nil; end;
        if self.edit19 ~= nil then self.edit19:destroy(); self.edit19 = nil; end;
        if self.button10 ~= nil then self.button10:destroy(); self.button10 = nil; end;
        if self.dataLink96 ~= nil then self.dataLink96:destroy(); self.dataLink96 = nil; end;
        if self.button22 ~= nil then self.button22:destroy(); self.button22 = nil; end;
        if self.edit34 ~= nil then self.edit34:destroy(); self.edit34 = nil; end;
        if self.rclflwMagicRecordListSpc5 ~= nil then self.rclflwMagicRecordListSpc5:destroy(); self.rclflwMagicRecordListSpc5 = nil; end;
        if self.flowPart22 ~= nil then self.flowPart22:destroy(); self.flowPart22 = nil; end;
        if self.flwMagicRecordListSpc8 ~= nil then self.flwMagicRecordListSpc8:destroy(); self.flwMagicRecordListSpc8 = nil; end;
        if self.horzLine13 ~= nil then self.horzLine13:destroy(); self.horzLine13 = nil; end;
        if self.label4 ~= nil then self.label4:destroy(); self.label4 = nil; end;
        if self.label83 ~= nil then self.label83:destroy(); self.label83 = nil; end;
        if self.dataLink60 ~= nil then self.dataLink60:destroy(); self.dataLink60 = nil; end;
        if self.dataLink76 ~= nil then self.dataLink76:destroy(); self.dataLink76 = nil; end;
        if self.edit13 ~= nil then self.edit13:destroy(); self.edit13 = nil; end;
        if self.edit86 ~= nil then self.edit86:destroy(); self.edit86 = nil; end;
        if self.flowPart28 ~= nil then self.flowPart28:destroy(); self.flowPart28 = nil; end;
        if self.label14 ~= nil then self.label14:destroy(); self.label14 = nil; end;
        if self.label26 ~= nil then self.label26:destroy(); self.label26 = nil; end;
        if self.textEditor1 ~= nil then self.textEditor1:destroy(); self.textEditor1 = nil; end;
        if self.dataLink26 ~= nil then self.dataLink26:destroy(); self.dataLink26 = nil; end;
        if self.edit55 ~= nil then self.edit55:destroy(); self.edit55 = nil; end;
        if self.flowPart70 ~= nil then self.flowPart70:destroy(); self.flowPart70 = nil; end;
        if self.label102 ~= nil then self.label102:destroy(); self.label102 = nil; end;
        if self.flowLayout25 ~= nil then self.flowLayout25:destroy(); self.flowLayout25 = nil; end;
        if self.flowLayout35 ~= nil then self.flowLayout35:destroy(); self.flowLayout35 = nil; end;
        if self.label52 ~= nil then self.label52:destroy(); self.label52 = nil; end;
        if self.dataLink116 ~= nil then self.dataLink116:destroy(); self.dataLink116 = nil; end;
        if self.layout21 ~= nil then self.layout21:destroy(); self.layout21 = nil; end;
        if self.panupperGridMagicBox2 ~= nil then self.panupperGridMagicBox2:destroy(); self.panupperGridMagicBox2 = nil; end;
        if self.flowPart51 ~= nil then self.flowPart51:destroy(); self.flowPart51 = nil; end;
        if self.flowPart41 ~= nil then self.flowPart41:destroy(); self.flowPart41 = nil; end;
        if self.flpSkillFlowPart21button ~= nil then self.flpSkillFlowPart21button:destroy(); self.flpSkillFlowPart21button = nil; end;
        if self.label75 ~= nil then self.label75:destroy(); self.label75 = nil; end;
        if self.flpSkillFlowPart12button ~= nil then self.flpSkillFlowPart12button:destroy(); self.flpSkillFlowPart12button = nil; end;
        if self.btnNovoflwMagicRecordListSpc8 ~= nil then self.btnNovoflwMagicRecordListSpc8:destroy(); self.btnNovoflwMagicRecordListSpc8 = nil; end;
        if self.rclContadores ~= nil then self.rclContadores:destroy(); self.rclContadores = nil; end;
        if self.modsabedoriastr ~= nil then self.modsabedoriastr:destroy(); self.modsabedoriastr = nil; end;
        if self.upperGridMagicBox4 ~= nil then self.upperGridMagicBox4:destroy(); self.upperGridMagicBox4 = nil; end;
        if self.flowLineBreak7 ~= nil then self.flowLineBreak7:destroy(); self.flowLineBreak7 = nil; end;
        if self.UpperGridCampo5 ~= nil then self.UpperGridCampo5:destroy(); self.UpperGridCampo5 = nil; end;
        if self.label91 ~= nil then self.label91:destroy(); self.label91 = nil; end;
        if self.edit70 ~= nil then self.edit70:destroy(); self.edit70 = nil; end;
        if self.flowPart7 ~= nil then self.flowPart7:destroy(); self.flowPart7 = nil; end;
        if self.modcarismastr ~= nil then self.modcarismastr:destroy(); self.modcarismastr = nil; end;
        if self.edit42 ~= nil then self.edit42:destroy(); self.edit42 = nil; end;
        if self.flowPart66 ~= nil then self.flowPart66:destroy(); self.flowPart66 = nil; end;
        if self.comboBox6 ~= nil then self.comboBox6:destroy(); self.comboBox6 = nil; end;
        if self.dataLink32 ~= nil then self.dataLink32:destroy(); self.dataLink32 = nil; end;
        if self.edit27 ~= nil then self.edit27:destroy(); self.edit27 = nil; end;
        if self.horzLine26 ~= nil then self.horzLine26:destroy(); self.horzLine26 = nil; end;
        if self.label62 ~= nil then self.label62:destroy(); self.label62 = nil; end;
        if self.edit9 ~= nil then self.edit9:destroy(); self.edit9 = nil; end;
        if self.image19 ~= nil then self.image19:destroy(); self.image19 = nil; end;
        if self.layout37 ~= nil then self.layout37:destroy(); self.layout37 = nil; end;
        if self.edit65 ~= nil then self.edit65:destroy(); self.edit65 = nil; end;
        if self.flpSkillFlowPart8button ~= nil then self.flpSkillFlowPart8button:destroy(); self.flpSkillFlowPart8button = nil; end;
        if self.dataLink102 ~= nil then self.dataLink102:destroy(); self.dataLink102 = nil; end;
        if self.flpSkillFlowPart4 ~= nil then self.flpSkillFlowPart4:destroy(); self.flpSkillFlowPart4 = nil; end;
        if self.horzLine6 ~= nil then self.horzLine6:destroy(); self.horzLine6 = nil; end;
        if self.comboBox8 ~= nil then self.comboBox8:destroy(); self.comboBox8 = nil; end;
        if self.dataLink38 ~= nil then self.dataLink38:destroy(); self.dataLink38 = nil; end;
        if self.tab14 ~= nil then self.tab14:destroy(); self.tab14 = nil; end;
        if self.flpSkillFlowPart13 ~= nil then self.flpSkillFlowPart13:destroy(); self.flpSkillFlowPart13 = nil; end;
        if self.flpSkillFlowPart23 ~= nil then self.flpSkillFlowPart23:destroy(); self.flpSkillFlowPart23 = nil; end;
        if self.layout52 ~= nil then self.layout52:destroy(); self.layout52 = nil; end;
        if self.layout60 ~= nil then self.layout60:destroy(); self.layout60 = nil; end;
        if self.edit3 ~= nil then self.edit3:destroy(); self.edit3 = nil; end;
        if self.button8 ~= nil then self.button8:destroy(); self.button8 = nil; end;
        if self.image17 ~= nil then self.image17:destroy(); self.image17 = nil; end;
        if self.labupperGridMagicBox3val ~= nil then self.labupperGridMagicBox3val:destroy(); self.labupperGridMagicBox3val = nil; end;
        if self.flowPart10 ~= nil then self.flowPart10:destroy(); self.flowPart10 = nil; end;
        if self.flpSkillFlowPart7button ~= nil then self.flpSkillFlowPart7button:destroy(); self.flpSkillFlowPart7button = nil; end;
        if self.tab1 ~= nil then self.tab1:destroy(); self.tab1 = nil; end;
        if self.rclEquips ~= nil then self.rclEquips:destroy(); self.rclEquips = nil; end;
        if self.label45 ~= nil then self.label45:destroy(); self.label45 = nil; end;
        if self.layout18 ~= nil then self.layout18:destroy(); self.layout18 = nil; end;
        if self.layBottomflwMagicRecordListSpc3 ~= nil then self.layBottomflwMagicRecordListSpc3:destroy(); self.layBottomflwMagicRecordListSpc3 = nil; end;
        if self.flwMagicRecordListSpc7 ~= nil then self.flwMagicRecordListSpc7:destroy(); self.flwMagicRecordListSpc7 = nil; end;
        if self.fraUpperGridMagiasSpc ~= nil then self.fraUpperGridMagiasSpc:destroy(); self.fraUpperGridMagiasSpc = nil; end;
        if self.flowLayout6 ~= nil then self.flowLayout6:destroy(); self.flowLayout6 = nil; end;
        if self.rclflwInnateUsage1 ~= nil then self.rclflwInnateUsage1:destroy(); self.rclflwInnateUsage1 = nil; end;
        if self.image22 ~= nil then self.image22:destroy(); self.image22 = nil; end;
        if self.label9 ~= nil then self.label9:destroy(); self.label9 = nil; end;
        if self.linUpperGridCampo1 ~= nil then self.linUpperGridCampo1:destroy(); self.linUpperGridCampo1 = nil; end;
        if self.dataLink44 ~= nil then self.dataLink44:destroy(); self.dataLink44 = nil; end;
        if self.dataLink56 ~= nil then self.dataLink56:destroy(); self.dataLink56 = nil; end;
        if self.layout7 ~= nil then self.layout7:destroy(); self.layout7 = nil; end;
        if self.button6 ~= nil then self.button6:destroy(); self.button6 = nil; end;
        if self.flpSkillFlowPart2button ~= nil then self.flpSkillFlowPart2button:destroy(); self.flpSkillFlowPart2button = nil; end;
        if self.button21 ~= nil then self.button21:destroy(); self.button21 = nil; end;
        if self.initiativeVal ~= nil then self.initiativeVal:destroy(); self.initiativeVal = nil; end;
        if self.edit31 ~= nil then self.edit31:destroy(); self.edit31 = nil; end;
        if self.flowLayout8 ~= nil then self.flowLayout8:destroy(); self.flowLayout8 = nil; end;
        if self.flwInnateUsage2 ~= nil then self.flwInnateUsage2:destroy(); self.flwInnateUsage2 = nil; end;
        if self.horzLine16 ~= nil then self.horzLine16:destroy(); self.horzLine16 = nil; end;
        if self.label7 ~= nil then self.label7:destroy(); self.label7 = nil; end;
        if self.flowLayout11 ~= nil then self.flowLayout11:destroy(); self.flowLayout11 = nil; end;
        if self.layout45 ~= nil then self.layout45:destroy(); self.layout45 = nil; end;
        if self.dataLink63 ~= nil then self.dataLink63:destroy(); self.dataLink63 = nil; end;
        if self.edit10 ~= nil then self.edit10:destroy(); self.edit10 = nil; end;
        if self.dataLink73 ~= nil then self.dataLink73:destroy(); self.dataLink73 = nil; end;
        if self.pgcPrincipal ~= nil then self.pgcPrincipal:destroy(); self.pgcPrincipal = nil; end;
        if self.edit85 ~= nil then self.edit85:destroy(); self.edit85 = nil; end;
        if self.fraLayAtributos ~= nil then self.fraLayAtributos:destroy(); self.fraLayAtributos = nil; end;
        if self.fraEquipamentoLayout ~= nil then self.fraEquipamentoLayout:destroy(); self.fraEquipamentoLayout = nil; end;
        if self.flowPart25 ~= nil then self.flowPart25:destroy(); self.flowPart25 = nil; end;
        if self.flowPart35 ~= nil then self.flowPart35:destroy(); self.flowPart35 = nil; end;
        if self.label11 ~= nil then self.label11:destroy(); self.label11 = nil; end;
        if self.moddestrezastr ~= nil then self.moddestrezastr:destroy(); self.moddestrezastr = nil; end;
        if self.horzLine18 ~= nil then self.horzLine18:destroy(); self.horzLine18 = nil; end;
        if self.dataLink29 ~= nil then self.dataLink29:destroy(); self.dataLink29 = nil; end;
        if self.label25 ~= nil then self.label25:destroy(); self.label25 = nil; end;
        if self.rclOptsAttack ~= nil then self.rclOptsAttack:destroy(); self.rclOptsAttack = nil; end;
        if self.label84 ~= nil then self.label84:destroy(); self.label84 = nil; end;
        if self.flowPart73 ~= nil then self.flowPart73:destroy(); self.flowPart73 = nil; end;
        if self.flowLayout28 ~= nil then self.flowLayout28:destroy(); self.flowLayout28 = nil; end;
        if self.flowLayout36 ~= nil then self.flowLayout36:destroy(); self.flowLayout36 = nil; end;
        if self.label57 ~= nil then self.label57:destroy(); self.label57 = nil; end;
        if self.rectangle5 ~= nil then self.rectangle5:destroy(); self.rectangle5 = nil; end;
        if self.dataLink79 ~= nil then self.dataLink79:destroy(); self.dataLink79 = nil; end;
        if self.dataLink115 ~= nil then self.dataLink115:destroy(); self.dataLink115 = nil; end;
        if self.layout24 ~= nil then self.layout24:destroy(); self.layout24 = nil; end;
        if self.dataLink80 ~= nil then self.dataLink80:destroy(); self.dataLink80 = nil; end;
        if self.textEditor6 ~= nil then self.textEditor6:destroy(); self.textEditor6 = nil; end;
        if self.flowPart54 ~= nil then self.flowPart54:destroy(); self.flowPart54 = nil; end;
        if self.flowPart46 ~= nil then self.flowPart46:destroy(); self.flowPart46 = nil; end;
        if self.label105 ~= nil then self.label105:destroy(); self.label105 = nil; end;
        if self.dataLink12 ~= nil then self.dataLink12:destroy(); self.dataLink12 = nil; end;
        if self.flowPart48 ~= nil then self.flowPart48:destroy(); self.flowPart48 = nil; end;
        if self.label92 ~= nil then self.label92:destroy(); self.label92 = nil; end;
        if self.edit75 ~= nil then self.edit75:destroy(); self.edit75 = nil; end;
        if self.flowPart4 ~= nil then self.flowPart4:destroy(); self.flowPart4 = nil; end;
        if self.edit41 ~= nil then self.edit41:destroy(); self.edit41 = nil; end;
        if self.btnNovoflwMagicRecordListSpc3 ~= nil then self.btnNovoflwMagicRecordListSpc3:destroy(); self.btnNovoflwMagicRecordListSpc3 = nil; end;
        if self.flpSkillFlowPart9 ~= nil then self.flpSkillFlowPart9:destroy(); self.flpSkillFlowPart9 = nil; end;
        if self.labupperGridMagicBox2 ~= nil then self.labupperGridMagicBox2:destroy(); self.labupperGridMagicBox2 = nil; end;
        if self.dataLink37 ~= nil then self.dataLink37:destroy(); self.dataLink37 = nil; end;
        if self.edit22 ~= nil then self.edit22:destroy(); self.edit22 = nil; end;
        if self.label98 ~= nil then self.label98:destroy(); self.label98 = nil; end;
        if self.flowPart61 ~= nil then self.flowPart61:destroy(); self.flowPart61 = nil; end;
        if self.btnNovoflwMagicRecordListSpc10 ~= nil then self.btnNovoflwMagicRecordListSpc10:destroy(); self.btnNovoflwMagicRecordListSpc10 = nil; end;
        if self.modconstituicaobutton ~= nil then self.modconstituicaobutton:destroy(); self.modconstituicaobutton = nil; end;
        if self.label61 ~= nil then self.label61:destroy(); self.label61 = nil; end;
        if self.layout34 ~= nil then self.layout34:destroy(); self.layout34 = nil; end;
        if self.flpSkillFlowPart4button ~= nil then self.flpSkillFlowPart4button:destroy(); self.flpSkillFlowPart4button = nil; end;
        if self.dataLink107 ~= nil then self.dataLink107:destroy(); self.dataLink107 = nil; end;
        if self.flpSkillFlowPart7 ~= nil then self.flpSkillFlowPart7:destroy(); self.flpSkillFlowPart7 = nil; end;
        if self.flpSkillFlowPart18button ~= nil then self.flpSkillFlowPart18button:destroy(); self.flpSkillFlowPart18button = nil; end;
        if self.edit28 ~= nil then self.edit28:destroy(); self.edit28 = nil; end;
        if self.labUpperGridCampo5 ~= nil then self.labUpperGridCampo5:destroy(); self.labUpperGridCampo5 = nil; end;
        if self.horzLine21 ~= nil then self.horzLine21:destroy(); self.horzLine21 = nil; end;
        if self.moddestrezabutton ~= nil then self.moddestrezabutton:destroy(); self.moddestrezabutton = nil; end;
        if self.dataLink49 ~= nil then self.dataLink49:destroy(); self.dataLink49 = nil; end;
        if self.image12 ~= nil then self.image12:destroy(); self.image12 = nil; end;
        if self.dataLink7 ~= nil then self.dataLink7:destroy(); self.dataLink7 = nil; end;
        if self.button31 ~= nil then self.button31:destroy(); self.button31 = nil; end;
        if self.dataLink109 ~= nil then self.dataLink109:destroy(); self.dataLink109 = nil; end;
        if self.tab2 ~= nil then self.tab2:destroy(); self.tab2 = nil; end;
        if self.layBottomflwMagicRecordListSpc6 ~= nil then self.layBottomflwMagicRecordListSpc6:destroy(); self.layBottomflwMagicRecordListSpc6 = nil; end;
        if self.flowLayout5 ~= nil then self.flowLayout5:destroy(); self.flowLayout5 = nil; end;
        if self.layout55 ~= nil then self.layout55:destroy(); self.layout55 = nil; end;
        if self.linUpperGridCampo6 ~= nil then self.linUpperGridCampo6:destroy(); self.linUpperGridCampo6 = nil; end;
        if self.dataLink43 ~= nil then self.dataLink43:destroy(); self.dataLink43 = nil; end;
        if self.dataLink9 ~= nil then self.dataLink9:destroy(); self.dataLink9 = nil; end;
        if self.image7 ~= nil then self.image7:destroy(); self.image7 = nil; end;
        if self.dataLink53 ~= nil then self.dataLink53:destroy(); self.dataLink53 = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.dataLink98 ~= nil then self.dataLink98:destroy(); self.dataLink98 = nil; end;
        if self.layout13 ~= nil then self.layout13:destroy(); self.layout13 = nil; end;
        if self.label35 ~= nil then self.label35:destroy(); self.label35 = nil; end;
        if self.layBottomflwMagicRecordListSpc8 ~= nil then self.layBottomflwMagicRecordListSpc8:destroy(); self.layBottomflwMagicRecordListSpc8 = nil; end;
        if self.edit32 ~= nil then self.edit32:destroy(); self.edit32 = nil; end;
        if self.rclflwMagicRecordListSpc3 ~= nil then self.rclflwMagicRecordListSpc3:destroy(); self.rclflwMagicRecordListSpc3 = nil; end;
        if self.rclflwInnateUsage6 ~= nil then self.rclflwInnateUsage6:destroy(); self.rclflwInnateUsage6 = nil; end;
        if self.horzLine15 ~= nil then self.horzLine15:destroy(); self.horzLine15 = nil; end;
        if self.label2 ~= nil then self.label2:destroy(); self.label2 = nil; end;
        if self.flowLayout16 ~= nil then self.flowLayout16:destroy(); self.flowLayout16 = nil; end;
        if self.label89 ~= nil then self.label89:destroy(); self.label89 = nil; end;
        if self.dataEquipAttackDetails ~= nil then self.dataEquipAttackDetails:destroy(); self.dataEquipAttackDetails = nil; end;
        if self.layout40 ~= nil then self.layout40:destroy(); self.layout40 = nil; end;
        if self.button14 ~= nil then self.button14:destroy(); self.button14 = nil; end;
        if self.dataLink92 ~= nil then self.dataLink92:destroy(); self.dataLink92 = nil; end;
        if self.button26 ~= nil then self.button26:destroy(); self.button26 = nil; end;
        if self.edit80 ~= nil then self.edit80:destroy(); self.edit80 = nil; end;
        if self.flowPart30 ~= nil then self.flowPart30:destroy(); self.flowPart30 = nil; end;
        if self.flowPart26 ~= nil then self.flowPart26:destroy(); self.flowPart26 = nil; end;
        if self.label12 ~= nil then self.label12:destroy(); self.label12 = nil; end;
        if self.label20 ~= nil then self.label20:destroy(); self.label20 = nil; end;
        if self.flowLayout18 ~= nil then self.flowLayout18:destroy(); self.flowLayout18 = nil; end;
        if self.label87 ~= nil then self.label87:destroy(); self.label87 = nil; end;
        if self.flowPart76 ~= nil then self.flowPart76:destroy(); self.flowPart76 = nil; end;
        if self.label108 ~= nil then self.label108:destroy(); self.label108 = nil; end;
        if self.label58 ~= nil then self.label58:destroy(); self.label58 = nil; end;
        if self.dataLink64 ~= nil then self.dataLink64:destroy(); self.dataLink64 = nil; end;
        if self.edit17 ~= nil then self.edit17:destroy(); self.edit17 = nil; end;
        if self.panupperGridMagicBox4 ~= nil then self.panupperGridMagicBox4:destroy(); self.panupperGridMagicBox4 = nil; end;
        if self.dataLink87 ~= nil then self.dataLink87:destroy(); self.dataLink87 = nil; end;
        if self.textEditor5 ~= nil then self.textEditor5:destroy(); self.textEditor5 = nil; end;
        if self.dataLink22 ~= nil then self.dataLink22:destroy(); self.dataLink22 = nil; end;
        if self.flpSkillFlowPart3button ~= nil then self.flpSkillFlowPart3button:destroy(); self.flpSkillFlowPart3button = nil; end;
        if self.edit51 ~= nil then self.edit51:destroy(); self.edit51 = nil; end;
        if self.popMagia ~= nil then self.popMagia:destroy(); self.popMagia = nil; end;
        if self.label106 ~= nil then self.label106:destroy(); self.label106 = nil; end;
        if self.scrollBox3 ~= nil then self.scrollBox3:destroy(); self.scrollBox3 = nil; end;
        if self.flowLayout21 ~= nil then self.flowLayout21:destroy(); self.flowLayout21 = nil; end;
        if self.flpSkillFlowPart14button ~= nil then self.flpSkillFlowPart14button:destroy(); self.flpSkillFlowPart14button = nil; end;
        if self.flowLayout31 ~= nil then self.flowLayout31:destroy(); self.flowLayout31 = nil; end;
        if self.dataLink112 ~= nil then self.dataLink112:destroy(); self.dataLink112 = nil; end;
        if self.dataLink17 ~= nil then self.dataLink17:destroy(); self.dataLink17 = nil; end;
        if self.dataLink89 ~= nil then self.dataLink89:destroy(); self.dataLink89 = nil; end;
        if self.upperGridMagicBox2 ~= nil then self.upperGridMagicBox2:destroy(); self.upperGridMagicBox2 = nil; end;
        if self.label71 ~= nil then self.label71:destroy(); self.label71 = nil; end;
        if self.edit76 ~= nil then self.edit76:destroy(); self.edit76 = nil; end;
        if self.flowPart1 ~= nil then self.flowPart1:destroy(); self.flowPart1 = nil; end;
        if self.edit44 ~= nil then self.edit44:destroy(); self.edit44 = nil; end;
        if self.btnNovoflwMagicRecordListSpc4 ~= nil then self.btnNovoflwMagicRecordListSpc4:destroy(); self.btnNovoflwMagicRecordListSpc4 = nil; end;
        if self.dataLink19 ~= nil then self.dataLink19:destroy(); self.dataLink19 = nil; end;
        if self.flowLineBreak3 ~= nil then self.flowLineBreak3:destroy(); self.flowLineBreak3 = nil; end;
        if self.UpperGridCampo1 ~= nil then self.UpperGridCampo1:destroy(); self.UpperGridCampo1 = nil; end;
        if self.label95 ~= nil then self.label95:destroy(); self.label95 = nil; end;
        if self.flowPart62 ~= nil then self.flowPart62:destroy(); self.flowPart62 = nil; end;
        if self.label64 ~= nil then self.label64:destroy(); self.label64 = nil; end;
        if self.layout39 ~= nil then self.layout39:destroy(); self.layout39 = nil; end;
        if self.dataLink104 ~= nil then self.dataLink104:destroy(); self.dataLink104 = nil; end;
        if self.flpSkillFlowPart2 ~= nil then self.flpSkillFlowPart2:destroy(); self.flpSkillFlowPart2 = nil; end;
        if self.horzLine8 ~= nil then self.horzLine8:destroy(); self.horzLine8 = nil; end;
        if self.comboBox2 ~= nil then self.comboBox2:destroy(); self.comboBox2 = nil; end;
        if self.flowLineBreak9 ~= nil then self.flowLineBreak9:destroy(); self.flowLineBreak9 = nil; end;
        if self.tab12 ~= nil then self.tab12:destroy(); self.tab12 = nil; end;
        if self.labUpperGridCampo2 ~= nil then self.labUpperGridCampo2:destroy(); self.labUpperGridCampo2 = nil; end;
        if self.flpSkillFlowPart19 ~= nil then self.flpSkillFlowPart19:destroy(); self.flpSkillFlowPart19 = nil; end;
        if self.horzLine22 ~= nil then self.horzLine22:destroy(); self.horzLine22 = nil; end;
        if self.rclflwMagicRecordListSpc10 ~= nil then self.rclflwMagicRecordListSpc10:destroy(); self.rclflwMagicRecordListSpc10 = nil; end;
        if self.layNomeHolderFrente ~= nil then self.layNomeHolderFrente:destroy(); self.layNomeHolderFrente = nil; end;
        if self.flowPart68 ~= nil then self.flowPart68:destroy(); self.flowPart68 = nil; end;
        if self.layout58 ~= nil then self.layout58:destroy(); self.layout58 = nil; end;
        if self.edit61 ~= nil then self.edit61:destroy(); self.edit61 = nil; end;
        if self.layout33 ~= nil then self.layout33:destroy(); self.layout33 = nil; end;
        if self.frame1 ~= nil then self.frame1:destroy(); self.frame1 = nil; end;
        if self.horzLine2 ~= nil then self.horzLine2:destroy(); self.horzLine2 = nil; end;
        if self.label38 ~= nil then self.label38:destroy(); self.label38 = nil; end;
        if self.layBottomflwMagicRecordListSpc5 ~= nil then self.layBottomflwMagicRecordListSpc5:destroy(); self.layBottomflwMagicRecordListSpc5 = nil; end;
        if self.flpSkillFlowPart17 ~= nil then self.flpSkillFlowPart17:destroy(); self.flpSkillFlowPart17 = nil; end;
        if self.btnApagar ~= nil then self.btnApagar:destroy(); self.btnApagar = nil; end;
        if self.layout56 ~= nil then self.layout56:destroy(); self.layout56 = nil; end;
        if self.layout64 ~= nil then self.layout64:destroy(); self.layout64 = nil; end;
        if self.edit7 ~= nil then self.edit7:destroy(); self.edit7 = nil; end;
        if self.dataLink50 ~= nil then self.dataLink50:destroy(); self.dataLink50 = nil; end;
        if self.flowPart14 ~= nil then self.flowPart14:destroy(); self.flowPart14 = nil; end;
        if self.label41 ~= nil then self.label41:destroy(); self.label41 = nil; end;
        if self.tab5 ~= nil then self.tab5:destroy(); self.tab5 = nil; end;
        if self.layout14 ~= nil then self.layout14:destroy(); self.layout14 = nil; end;
        if self.label32 ~= nil then self.label32:destroy(); self.label32 = nil; end;
        if self.flwMagicRecordListSpc3 ~= nil then self.flwMagicRecordListSpc3:destroy(); self.flwMagicRecordListSpc3 = nil; end;
        if self.flowLineBreak11 ~= nil then self.flowLineBreak11:destroy(); self.flowLineBreak11 = nil; end;
        if self.flowLayout2 ~= nil then self.flowLayout2:destroy(); self.flowLayout2 = nil; end;
        if self.flpSkillFlowPart9str ~= nil then self.flpSkillFlowPart9str:destroy(); self.flpSkillFlowPart9str = nil; end;
        if self.flwInnateUsage4 ~= nil then self.flwInnateUsage4:destroy(); self.flwInnateUsage4 = nil; end;
        if self.rclflwInnateUsage5 ~= nil then self.rclflwInnateUsage5:destroy(); self.rclflwInnateUsage5 = nil; end;
        if self.image26 ~= nil then self.image26:destroy(); self.image26 = nil; end;
        if self.layout3 ~= nil then self.layout3:destroy(); self.layout3 = nil; end;
        if self.layout43 ~= nil then self.layout43:destroy(); self.layout43 = nil; end;
        if self.dataLink69 ~= nil then self.dataLink69:destroy(); self.dataLink69 = nil; end;
        if self.button11 ~= nil then self.button11:destroy(); self.button11 = nil; end;
        if self.dataLink97 ~= nil then self.dataLink97:destroy(); self.dataLink97 = nil; end;
        if self.button25 ~= nil then self.button25:destroy(); self.button25 = nil; end;
        if self.edit35 ~= nil then self.edit35:destroy(); self.edit35 = nil; end;
        if self.flowPart33 ~= nil then self.flowPart33:destroy(); self.flowPart33 = nil; end;
        if self.flowPart23 ~= nil then self.flowPart23:destroy(); self.flowPart23 = nil; end;
        if self.rclflwMagicRecordListSpc4 ~= nil then self.rclflwMagicRecordListSpc4:destroy(); self.rclflwMagicRecordListSpc4 = nil; end;
        if self.flwMagicRecordListSpc9 ~= nil then self.flwMagicRecordListSpc9:destroy(); self.flwMagicRecordListSpc9 = nil; end;
        if self.horzLine12 ~= nil then self.horzLine12:destroy(); self.horzLine12 = nil; end;
        if self.label82 ~= nil then self.label82:destroy(); self.label82 = nil; end;
        if self.layout49 ~= nil then self.layout49:destroy(); self.layout49 = nil; end;
        if self.dataLink67 ~= nil then self.dataLink67:destroy(); self.dataLink67 = nil; end;
        if self.dataLink77 ~= nil then self.dataLink77:destroy(); self.dataLink77 = nil; end;
        if self.edit14 ~= nil then self.edit14:destroy(); self.edit14 = nil; end;
        if self.flpSkillFlowPart6str ~= nil then self.flpSkillFlowPart6str:destroy(); self.flpSkillFlowPart6str = nil; end;
        if self.flpSkillFlowPart4str ~= nil then self.flpSkillFlowPart4str:destroy(); self.flpSkillFlowPart4str = nil; end;
        if self.flowPart29 ~= nil then self.flowPart29:destroy(); self.flowPart29 = nil; end;
        if self.flpSkillFlowPart2str ~= nil then self.flpSkillFlowPart2str:destroy(); self.flpSkillFlowPart2str = nil; end;
        if self.label15 ~= nil then self.label15:destroy(); self.label15 = nil; end;
        if self.label29 ~= nil then self.label29:destroy(); self.label29 = nil; end;
        if self.dataLink25 ~= nil then self.dataLink25:destroy(); self.dataLink25 = nil; end;
        if self.rclMobAcoes ~= nil then self.rclMobAcoes:destroy(); self.rclMobAcoes = nil; end;
        if self.edit56 ~= nil then self.edit56:destroy(); self.edit56 = nil; end;
        if self.label103 ~= nil then self.label103:destroy(); self.label103 = nil; end;
        if self.flowLayout24 ~= nil then self.flowLayout24:destroy(); self.flowLayout24 = nil; end;
        if self.flowLayout32 ~= nil then self.flowLayout32:destroy(); self.flowLayout32 = nil; end;
        if self.rectangle1 ~= nil then self.rectangle1:destroy(); self.rectangle1 = nil; end;
        if self.label53 ~= nil then self.label53:destroy(); self.label53 = nil; end;
        if self.scrollBox6 ~= nil then self.scrollBox6:destroy(); self.scrollBox6 = nil; end;
        if self.edtNomeMob ~= nil then self.edtNomeMob:destroy(); self.edtNomeMob = nil; end;
        if self.dataLink111 ~= nil then self.dataLink111:destroy(); self.dataLink111 = nil; end;
        if self.layout20 ~= nil then self.layout20:destroy(); self.layout20 = nil; end;
        if self.flpSkillFlowPart8str ~= nil then self.flpSkillFlowPart8str:destroy(); self.flpSkillFlowPart8str = nil; end;
        if self.panupperGridMagicBox3 ~= nil then self.panupperGridMagicBox3:destroy(); self.panupperGridMagicBox3 = nil; end;
        if self.dataLink14 ~= nil then self.dataLink14:destroy(); self.dataLink14 = nil; end;
        if self.fraMagiasLayoutSpc ~= nil then self.fraMagiasLayoutSpc:destroy(); self.fraMagiasLayoutSpc = nil; end;
        if self.layEquipPropriedades ~= nil then self.layEquipPropriedades:destroy(); self.layEquipPropriedades = nil; end;
        if self.flowPart42 ~= nil then self.flowPart42:destroy(); self.flowPart42 = nil; end;
        if self.flowPart50 ~= nil then self.flowPart50:destroy(); self.flowPart50 = nil; end;
        if self.label76 ~= nil then self.label76:destroy(); self.label76 = nil; end;
        if self.edtUpperGridCampo4 ~= nil then self.edtUpperGridCampo4:destroy(); self.edtUpperGridCampo4 = nil; end;
        if self.btnNovoflwMagicRecordListSpc9 ~= nil then self.btnNovoflwMagicRecordListSpc9:destroy(); self.btnNovoflwMagicRecordListSpc9 = nil; end;
        if self.fraUpperGridMagiasInnate ~= nil then self.fraUpperGridMagiasInnate:destroy(); self.fraUpperGridMagiasInnate = nil; end;
        if self.labupperGridMagicBox4 ~= nil then self.labupperGridMagicBox4:destroy(); self.labupperGridMagicBox4 = nil; end;
        if self.flowLineBreak4 ~= nil then self.flowLineBreak4:destroy(); self.flowLineBreak4 = nil; end;
        if self.UpperGridCampo4 ~= nil then self.UpperGridCampo4:destroy(); self.UpperGridCampo4 = nil; end;
        if self.label96 ~= nil then self.label96:destroy(); self.label96 = nil; end;
        if self.edit71 ~= nil then self.edit71:destroy(); self.edit71 = nil; end;
        if self.flowPart8 ~= nil then self.flowPart8:destroy(); self.flowPart8 = nil; end;
        if self.flowPart67 ~= nil then self.flowPart67:destroy(); self.flowPart67 = nil; end;
        if self.flpSkillFlowPart9button ~= nil then self.flpSkillFlowPart9button:destroy(); self.flpSkillFlowPart9button = nil; end;
        if self.cmbupperGridMagicBox1 ~= nil then self.cmbupperGridMagicBox1:destroy(); self.cmbupperGridMagicBox1 = nil; end;
        if self.comboBox12 ~= nil then self.comboBox12:destroy(); self.comboBox12 = nil; end;
        if self.comboBox7 ~= nil then self.comboBox7:destroy(); self.comboBox7 = nil; end;
        if self.dataLink33 ~= nil then self.dataLink33:destroy(); self.dataLink33 = nil; end;
        if self.edit26 ~= nil then self.edit26:destroy(); self.edit26 = nil; end;
        if self.modforcastr ~= nil then self.modforcastr:destroy(); self.modforcastr = nil; end;
        if self.edit8 ~= nil then self.edit8:destroy(); self.edit8 = nil; end;
        if self.image18 ~= nil then self.image18:destroy(); self.image18 = nil; end;
        if self.layout30 ~= nil then self.layout30:destroy(); self.layout30 = nil; end;
        if self.flpSkillFlowPart11button ~= nil then self.flpSkillFlowPart11button:destroy(); self.flpSkillFlowPart11button = nil; end;
        if self.flpSkillFlowPart21str ~= nil then self.flpSkillFlowPart21str:destroy(); self.flpSkillFlowPart21str = nil; end;
        if self.edit64 ~= nil then self.edit64:destroy(); self.edit64 = nil; end;
        if self.flowPart19 ~= nil then self.flowPart19:destroy(); self.flowPart19 = nil; end;
        if self.dataLink103 ~= nil then self.dataLink103:destroy(); self.dataLink103 = nil; end;
        if self.tab8 ~= nil then self.tab8:destroy(); self.tab8 = nil; end;
        if self.horzLine7 ~= nil then self.horzLine7:destroy(); self.horzLine7 = nil; end;
        if self.comboBox9 ~= nil then self.comboBox9:destroy(); self.comboBox9 = nil; end;
        if self.dataLink39 ~= nil then self.dataLink39:destroy(); self.dataLink39 = nil; end;
        if self.flpSkillFlowPart10 ~= nil then self.flpSkillFlowPart10:destroy(); self.flpSkillFlowPart10 = nil; end;
        if self.flpSkillFlowPart22 ~= nil then self.flpSkillFlowPart22:destroy(); self.flpSkillFlowPart22 = nil; end;
        if self.flwPartEquipAttack ~= nil then self.flwPartEquipAttack:destroy(); self.flwPartEquipAttack = nil; end;
        if self.layout53 ~= nil then self.layout53:destroy(); self.layout53 = nil; end;
        if self.layout63 ~= nil then self.layout63:destroy(); self.layout63 = nil; end;
        if self.edit2 ~= nil then self.edit2:destroy(); self.edit2 = nil; end;
        if self.image16 ~= nil then self.image16:destroy(); self.image16 = nil; end;
        if self.dataLink3 ~= nil then self.dataLink3:destroy(); self.dataLink3 = nil; end;
        if self.labupperGridMagicBox6val ~= nil then self.labupperGridMagicBox6val:destroy(); self.labupperGridMagicBox6val = nil; end;
        if self.flowPart13 ~= nil then self.flowPart13:destroy(); self.flowPart13 = nil; end;
        if self.label44 ~= nil then self.label44:destroy(); self.label44 = nil; end;
        if self.tab6 ~= nil then self.tab6:destroy(); self.tab6 = nil; end;
        if self.labupperGridMagicBox2val ~= nil then self.labupperGridMagicBox2val:destroy(); self.labupperGridMagicBox2val = nil; end;
        if self.layout19 ~= nil then self.layout19:destroy(); self.layout19 = nil; end;
        if self.layBottomflwMagicRecordListSpc2 ~= nil then self.layBottomflwMagicRecordListSpc2:destroy(); self.layBottomflwMagicRecordListSpc2 = nil; end;
        if self.edit38 ~= nil then self.edit38:destroy(); self.edit38 = nil; end;
        if self.flwMagicRecordListSpc4 ~= nil then self.flwMagicRecordListSpc4:destroy(); self.flwMagicRecordListSpc4 = nil; end;
        if self.flowLayout1 ~= nil then self.flowLayout1:destroy(); self.flowLayout1 = nil; end;
        if self.rclflwMagicRecordListSpc9 ~= nil then self.rclflwMagicRecordListSpc9:destroy(); self.rclflwMagicRecordListSpc9 = nil; end;
        if self.image23 ~= nil then self.image23:destroy(); self.image23 = nil; end;
        if self.label8 ~= nil then self.label8:destroy(); self.label8 = nil; end;
        if self.linUpperGridCampo2 ~= nil then self.linUpperGridCampo2:destroy(); self.linUpperGridCampo2 = nil; end;
        if self.dataLink47 ~= nil then self.dataLink47:destroy(); self.dataLink47 = nil; end;
        if self.dataLink57 ~= nil then self.dataLink57:destroy(); self.dataLink57 = nil; end;
        if self.layout6 ~= nil then self.layout6:destroy(); self.layout6 = nil; end;
        if self.button5 ~= nil then self.button5:destroy(); self.button5 = nil; end;
        if self.button12 ~= nil then self.button12:destroy(); self.button12 = nil; end;
        if self.dataLink94 ~= nil then self.dataLink94:destroy(); self.dataLink94 = nil; end;
        if self.button20 ~= nil then self.button20:destroy(); self.button20 = nil; end;
        if self.flpSkillFlowPart23button ~= nil then self.flpSkillFlowPart23button:destroy(); self.flpSkillFlowPart23button = nil; end;
        if self.edit36 ~= nil then self.edit36:destroy(); self.edit36 = nil; end;
        if self.rclflwMagicRecordListSpc7 ~= nil then self.rclflwMagicRecordListSpc7:destroy(); self.rclflwMagicRecordListSpc7 = nil; end;
        if self.flwInnateUsage3 ~= nil then self.flwInnateUsage3:destroy(); self.flwInnateUsage3 = nil; end;
        if self.textEditor10 ~= nil then self.textEditor10:destroy(); self.textEditor10 = nil; end;
        if self.label18 ~= nil then self.label18:destroy(); self.label18 = nil; end;
        if self.horzLine11 ~= nil then self.horzLine11:destroy(); self.horzLine11 = nil; end;
        if self.label6 ~= nil then self.label6:destroy(); self.label6 = nil; end;
        if self.flowLayout12 ~= nil then self.flowLayout12:destroy(); self.flowLayout12 = nil; end;
        if self.flpSkillFlowPart24str ~= nil then self.flpSkillFlowPart24str:destroy(); self.flpSkillFlowPart24str = nil; end;
        if self.flpSkillFlowPart20str ~= nil then self.flpSkillFlowPart20str:destroy(); self.flpSkillFlowPart20str = nil; end;
        if self.layout44 ~= nil then self.layout44:destroy(); self.layout44 = nil; end;
        if self.dataLink62 ~= nil then self.dataLink62:destroy(); self.dataLink62 = nil; end;
        if self.dataLink70 ~= nil then self.dataLink70:destroy(); self.dataLink70 = nil; end;
        if self.edit11 ~= nil then self.edit11:destroy(); self.edit11 = nil; end;
        if self.edit84 ~= nil then self.edit84:destroy(); self.edit84 = nil; end;
        if self.flowPart34 ~= nil then self.flowPart34:destroy(); self.flowPart34 = nil; end;
        if self.label16 ~= nil then self.label16:destroy(); self.label16 = nil; end;
        if self.label24 ~= nil then self.label24:destroy(); self.label24 = nil; end;
        if self.dataLink28 ~= nil then self.dataLink28:destroy(); self.dataLink28 = nil; end;
        if self.flpSkillFlowPart5button ~= nil then self.flpSkillFlowPart5button:destroy(); self.flpSkillFlowPart5button = nil; end;
        if self.flowPart72 ~= nil then self.flowPart72:destroy(); self.flowPart72 = nil; end;
        if self.flowLayout27 ~= nil then self.flowLayout27:destroy(); self.flowLayout27 = nil; end;
        if self.scrollBox5 ~= nil then self.scrollBox5:destroy(); self.scrollBox5 = nil; end;
        if self.label54 ~= nil then self.label54:destroy(); self.label54 = nil; end;
        if self.rectangle6 ~= nil then self.rectangle6:destroy(); self.rectangle6 = nil; end;
        if self.dataLink114 ~= nil then self.dataLink114:destroy(); self.dataLink114 = nil; end;
        if self.layout27 ~= nil then self.layout27:destroy(); self.layout27 = nil; end;
        if self.dataLink83 ~= nil then self.dataLink83:destroy(); self.dataLink83 = nil; end;
        if self.textEditor9 ~= nil then self.textEditor9:destroy(); self.textEditor9 = nil; end;
        if self.flowPart57 ~= nil then self.flowPart57:destroy(); self.flowPart57 = nil; end;
        if self.flowPart47 ~= nil then self.flowPart47:destroy(); self.flowPart47 = nil; end;
        if self.edtUpperGridCampo1 ~= nil then self.edtUpperGridCampo1:destroy(); self.edtUpperGridCampo1 = nil; end;
        if self.layout29 ~= nil then self.layout29:destroy(); self.layout29 = nil; end;
        if self.dataLink13 ~= nil then self.dataLink13:destroy(); self.dataLink13 = nil; end;
        if self.flowPart49 ~= nil then self.flowPart49:destroy(); self.flowPart49 = nil; end;
        if self.upperGridMagicBox6 ~= nil then self.upperGridMagicBox6:destroy(); self.upperGridMagicBox6 = nil; end;
        if self.label93 ~= nil then self.label93:destroy(); self.label93 = nil; end;
        if self.edit72 ~= nil then self.edit72:destroy(); self.edit72 = nil; end;
        if self.flowPart5 ~= nil then self.flowPart5:destroy(); self.flowPart5 = nil; end;
        if self.rclProps ~= nil then self.rclProps:destroy(); self.rclProps = nil; end;
        if self.edit40 ~= nil then self.edit40:destroy(); self.edit40 = nil; end;
        if self.labNomeMob ~= nil then self.labNomeMob:destroy(); self.labNomeMob = nil; end;
        if self.flpSkillFlowPart8 ~= nil then self.flpSkillFlowPart8:destroy(); self.flpSkillFlowPart8 = nil; end;
        if self.comboBox11 ~= nil then self.comboBox11:destroy(); self.comboBox11 = nil; end;
        if self.cmbupperGridMagicBox4 ~= nil then self.cmbupperGridMagicBox4:destroy(); self.cmbupperGridMagicBox4 = nil; end;
        if self.labupperGridMagicBox3 ~= nil then self.labupperGridMagicBox3:destroy(); self.labupperGridMagicBox3 = nil; end;
        if self.comboBox4 ~= nil then self.comboBox4:destroy(); self.comboBox4 = nil; end;
        if self.dataLink34 ~= nil then self.dataLink34:destroy(); self.dataLink34 = nil; end;
        if self.edit21 ~= nil then self.edit21:destroy(); self.edit21 = nil; end;
        if self.label99 ~= nil then self.label99:destroy(); self.label99 = nil; end;
        if self.label60 ~= nil then self.label60:destroy(); self.label60 = nil; end;
        if self.edit67 ~= nil then self.edit67:destroy(); self.edit67 = nil; end;
        if self.layout35 ~= nil then self.layout35:destroy(); self.layout35 = nil; end;
        if self.dataLink100 ~= nil then self.dataLink100:destroy(); self.dataLink100 = nil; end;
        if self.flpSkillFlowPart6 ~= nil then self.flpSkillFlowPart6:destroy(); self.flpSkillFlowPart6 = nil; end;
        if self.horzLine4 ~= nil then self.horzLine4:destroy(); self.horzLine4 = nil; end;
        if self.modcarismabutton ~= nil then self.modcarismabutton:destroy(); self.modcarismabutton = nil; end;
        if self.labUpperGridCampo6 ~= nil then self.labUpperGridCampo6:destroy(); self.labUpperGridCampo6 = nil; end;
        if self.flpSkillFlowPart21 ~= nil then self.flpSkillFlowPart21:destroy(); self.flpSkillFlowPart21 = nil; end;
        if self.anotacoesOld ~= nil then self.anotacoesOld:destroy(); self.anotacoesOld = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.dataLink48 ~= nil then self.dataLink48:destroy(); self.dataLink48 = nil; end;
        if self.image11 ~= nil then self.image11:destroy(); self.image11 = nil; end;
        if self.dataLink6 ~= nil then self.dataLink6:destroy(); self.dataLink6 = nil; end;
        if self.button32 ~= nil then self.button32:destroy(); self.button32 = nil; end;
        if self.label47 ~= nil then self.label47:destroy(); self.label47 = nil; end;
        if self.tab3 ~= nil then self.tab3:destroy(); self.tab3 = nil; end;
        if self.flpSkillFlowPart24button ~= nil then self.flpSkillFlowPart24button:destroy(); self.flpSkillFlowPart24button = nil; end;
        if self.layBottomflwMagicRecordListSpc1 ~= nil then self.layBottomflwMagicRecordListSpc1:destroy(); self.layBottomflwMagicRecordListSpc1 = nil; end;
        if self.flowLayout4 ~= nil then self.flowLayout4:destroy(); self.flowLayout4 = nil; end;
        if self.image20 ~= nil then self.image20:destroy(); self.image20 = nil; end;
        if self.dataLink42 ~= nil then self.dataLink42:destroy(); self.dataLink42 = nil; end;
        if self.dataLink54 ~= nil then self.dataLink54:destroy(); self.dataLink54 = nil; end;
        if self.dataLink8 ~= nil then self.dataLink8:destroy(); self.dataLink8 = nil; end;
        if self.image4 ~= nil then self.image4:destroy(); self.image4 = nil; end;
        if self.layout9 ~= nil then self.layout9:destroy(); self.layout9 = nil; end;
        if self.dataLink99 ~= nil then self.dataLink99:destroy(); self.dataLink99 = nil; end;
        if self.layout10 ~= nil then self.layout10:destroy(); self.layout10 = nil; end;
        if self.flpSkillFlowPart23str ~= nil then self.flpSkillFlowPart23str:destroy(); self.flpSkillFlowPart23str = nil; end;
        if self.label36 ~= nil then self.label36:destroy(); self.label36 = nil; end;
        if self.edit33 ~= nil then self.edit33:destroy(); self.edit33 = nil; end;
        if self.flowPart39 ~= nil then self.flowPart39:destroy(); self.flowPart39 = nil; end;
        if self.rclflwMagicRecordListSpc2 ~= nil then self.rclflwMagicRecordListSpc2:destroy(); self.rclflwMagicRecordListSpc2 = nil; end;
        if self.flpSkillFlowPart10button ~= nil then self.flpSkillFlowPart10button:destroy(); self.flpSkillFlowPart10button = nil; end;
        if self.horzLine14 ~= nil then self.horzLine14:destroy(); self.horzLine14 = nil; end;
        if self.label1 ~= nil then self.label1:destroy(); self.label1 = nil; end;
        if self.flowLayout17 ~= nil then self.flowLayout17:destroy(); self.flowLayout17 = nil; end;
        if self.label88 ~= nil then self.label88:destroy(); self.label88 = nil; end;
        if self.layout47 ~= nil then self.layout47:destroy(); self.layout47 = nil; end;
        if self.button15 ~= nil then self.button15:destroy(); self.button15 = nil; end;
        if self.dataLink93 ~= nil then self.dataLink93:destroy(); self.dataLink93 = nil; end;
        if self.button29 ~= nil then self.button29:destroy(); self.button29 = nil; end;
        if self.edit83 ~= nil then self.edit83:destroy(); self.edit83 = nil; end;
        if self.flowPart37 ~= nil then self.flowPart37:destroy(); self.flowPart37 = nil; end;
        if self.flowPart27 ~= nil then self.flowPart27:destroy(); self.flowPart27 = nil; end;
        if self.label13 ~= nil then self.label13:destroy(); self.label13 = nil; end;
        if self.label23 ~= nil then self.label23:destroy(); self.label23 = nil; end;
        if self.edit58 ~= nil then self.edit58:destroy(); self.edit58 = nil; end;
        if self.flowLayout19 ~= nil then self.flowLayout19:destroy(); self.flowLayout19 = nil; end;
        if self.label86 ~= nil then self.label86:destroy(); self.label86 = nil; end;
        if self.flowPart75 ~= nil then self.flowPart75:destroy(); self.flowPart75 = nil; end;
        if self.label59 ~= nil then self.label59:destroy(); self.label59 = nil; end;
        if self.panupperGridMagicBox5 ~= nil then self.panupperGridMagicBox5:destroy(); self.panupperGridMagicBox5 = nil; end;
        if self.dataLink86 ~= nil then self.dataLink86:destroy(); self.dataLink86 = nil; end;
        if self.textEditor4 ~= nil then self.textEditor4:destroy(); self.textEditor4 = nil; end;
        if self.dataLink21 ~= nil then self.dataLink21:destroy(); self.dataLink21 = nil; end;
        if self.edit52 ~= nil then self.edit52:destroy(); self.edit52 = nil; end;
        if self.flowPart44 ~= nil then self.flowPart44:destroy(); self.flowPart44 = nil; end;
        if self.label78 ~= nil then self.label78:destroy(); self.label78 = nil; end;
        if self.label107 ~= nil then self.label107:destroy(); self.label107 = nil; end;
        if self.scrollBox2 ~= nil then self.scrollBox2:destroy(); self.scrollBox2 = nil; end;
        if self.edtUpperGridCampo2 ~= nil then self.edtUpperGridCampo2:destroy(); self.edtUpperGridCampo2 = nil; end;
        if self.flowLayout20 ~= nil then self.flowLayout20:destroy(); self.flowLayout20 = nil; end;
        if self.flpSkillFlowPart22str ~= nil then self.flpSkillFlowPart22str:destroy(); self.flpSkillFlowPart22str = nil; end;
        if self.dataLink10 ~= nil then self.dataLink10:destroy(); self.dataLink10 = nil; end;
        if self.dataLink88 ~= nil then self.dataLink88:destroy(); self.dataLink88 = nil; end;
        if self.modconstituicaostr ~= nil then self.modconstituicaostr:destroy(); self.modconstituicaostr = nil; end;
        if self.upperGridMagicBox1 ~= nil then self.upperGridMagicBox1:destroy(); self.upperGridMagicBox1 = nil; end;
        if self.label72 ~= nil then self.label72:destroy(); self.label72 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmDnD5()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmDnD5();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmDnD5 = {
    newEditor = newfrmDnD5, 
    new = newfrmDnD5, 
    name = "frmDnD5", 
    dataType = "br.com.mineBR55.MobDnD5e_S3", 
    formType = "sheetTemplate", 
    formComponentName = "form", 
    cacheMode = "time", 
    title = "Mob DnD 5e", 
    description="Ficha de monstros para DnD 5e"};

frmDnD5 = _frmDnD5;
Firecast.registrarForm(_frmDnD5);
Firecast.registrarDataType(_frmDnD5);

return _frmDnD5;
