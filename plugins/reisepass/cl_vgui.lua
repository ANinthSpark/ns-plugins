surface.CreateFont("passFont", {
    font = "TabLarge",
    extended = true,
    weight = 800,
    size = ScrH()/54
})

function reisepassInformationEntry(ply)
    if ply == nil then return end
    local white_col = Color(255, 255, 255, 255)

    --ScrW()/, ScrH()/
    local passEntryFrame = vgui.Create("DFrame")
    passEntryFrame:SetSize(ScrW()/7.5, ScrH()/1.96)
    passEntryFrame:Center()
    passEntryFrame:SetTitle("")
    passEntryFrame:SetDraggable(false)
    passEntryFrame:ShowCloseButton(false)
    passEntryFrame:MakePopup()
    passEntryFrame.Paint = function(self, w, h)
        draw.RoundedBox(14, 0, 0, w, h, Color(30, 30, 30, 255)) --209, 173, 136, 255
        draw.SimpleText("Reisepass Application", "passFont", ScrW()/15.36, ScrH()/216, white_col, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end


    local passEntryLabel1 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel1:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel1:SetPos(ScrW()/32, ScrH()/38.57)
    passEntryLabel1:SetText("Enter Age:")
    passEntryLabel1:SetTextColor(white_col)

    local passEntryWang1 = vgui.Create("DNumberWang", passEntryFrame)
    passEntryWang1:SetPos(ScrW()/32, ScrH()/24)
    passEntryWang1:SetSize(ScrW()/15, ScrH()/36)
    passEntryWang1:SetMin(18)
    passEntryWang1:SetMax(100)
    passEntryWang1:SetValue(passEntryWang1:GetMin())


    local passEntryLabel2 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel2:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel2:SetPos(ScrW()/32, ScrH()/13.01)
    passEntryLabel2:SetText("Enter Height (cm):")
    passEntryLabel2:SetTextColor(white_col)

    local passEntryWang2 = vgui.Create("DNumberWang", passEntryFrame)
    passEntryWang2:SetPos(ScrW()/32, ScrH()/10.8)
    passEntryWang2:SetSize(ScrW()/15, ScrH()/36)
    passEntryWang2:SetMin(120)
    passEntryWang2:SetMax(200)
    passEntryWang2:SetValue(passEntryWang2:GetMin())


    local passEntryLabel3 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel3:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel3:SetPos(ScrW()/32, ScrH()/7.83)
    passEntryLabel3:SetText("Enter Weight (kg):")
    passEntryLabel3:SetTextColor(white_col)

    local passEntryWang3 = vgui.Create("DNumberWang", passEntryFrame)
    passEntryWang3:SetPos(ScrW()/32, ScrH()/6.97)
    passEntryWang3:SetSize(ScrW()/15, ScrH()/36)
    passEntryWang3:SetMin(25)
    passEntryWang3:SetMax(250)
    passEntryWang3:SetValue(passEntryWang3:GetMin())


    local passEntryLabel4 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel4:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel4:SetPos(ScrW()/32, ScrH()/5.59)
    passEntryLabel4:SetText("Enter Religion:")
    passEntryLabel4:SetTextColor(white_col)

    local passEntryCombo1 = vgui.Create("DComboBox", passEntryFrame)
    passEntryCombo1:SetPos(ScrW()/32, ScrH()/5.14)
    passEntryCombo1:SetSize(ScrW()/15, ScrH()/36)
    passEntryCombo1:SetValue("...")
    passEntryCombo1:AddChoice("Christianity")
    passEntryCombo1:AddChoice("Judaism")
    passEntryCombo1:AddChoice("Aethist")
    passEntryCombo1:AddChoice("Islam")
    passEntryCombo1:AddChoice("Hindu")
    passEntryCombo1:AddChoice("Buddhism")


    local passEntryLabel5 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel5:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel5:SetPos(ScrW()/32, ScrH()/4.35)
    passEntryLabel5:SetText("Enter Hair Color:")
    passEntryLabel5:SetTextColor(white_col)

    local passEntryCombo2 = vgui.Create("DComboBox", passEntryFrame)
    passEntryCombo2:SetPos(ScrW()/32, ScrH()/4.08)
    passEntryCombo2:SetSize(ScrW()/15, ScrH()/36)
    passEntryCombo2:SetValue("...")
    passEntryCombo2:AddChoice("Brown")
    passEntryCombo2:AddChoice("Blonde")
    passEntryCombo2:AddChoice("Bald")
    passEntryCombo2:AddChoice("Black")
    passEntryCombo2:AddChoice("Orange")


    local passEntryLabel6 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel6:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel6:SetPos(ScrW()/32, ScrH()/3.56)
    passEntryLabel6:SetText("Enter Eye Color:")
    passEntryLabel6:SetTextColor(white_col)

    local passEntryCombo3 = vgui.Create("DComboBox", passEntryFrame)
    passEntryCombo3:SetPos(ScrW()/32, ScrH()/3.38)
    passEntryCombo3:SetSize(ScrW()/15, ScrH()/36)
    passEntryCombo3:SetValue("...")
    passEntryCombo3:AddChoice("Amber")
    passEntryCombo3:AddChoice("Brown")
    passEntryCombo3:AddChoice("Blue")
    passEntryCombo3:AddChoice("Green")
    passEntryCombo3:AddChoice("Hazel")
    passEntryCombo3:AddChoice("Gray")


    local passEntryLabel7 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel7:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel7:SetPos(ScrW()/32, ScrH()/3.02)
    passEntryLabel7:SetText("Enter Occupation:")
    passEntryLabel7:SetTextColor(white_col)

    local passEntryText1 = vgui.Create("DTextEntry", passEntryFrame)
    passEntryText1:SetPos(ScrW()/32, ScrH()/2.88)
    passEntryText1:SetSize(ScrW()/15, ScrH()/36)
    passEntryText1:SetPlaceholderText("...")


    local passEntryLabel8 = vgui.Create("DLabel", passEntryFrame)
    passEntryLabel8:SetSize(ScrW()/15, ScrH()/72)
    passEntryLabel8:SetPos(ScrW()/32, ScrH()/2.62)
    passEntryLabel8:SetText("Enter Birthplace:")
    passEntryLabel8:SetTextColor(white_col)

    local passEntryText2 = vgui.Create("DTextEntry", passEntryFrame)
    passEntryText2:SetPos(ScrW()/32, ScrH()/2.51)
    passEntryText2:SetSize(ScrW()/15, ScrH()/36)
    passEntryText2:SetPlaceholderText("...")


    local passEntryButton = vgui.Create("DButton", passEntryFrame)
    passEntryButton:SetPos(ScrW()/32, ScrH()/2.14)
    passEntryButton:SetSize(ScrW()/15, ScrH()/36)
    passEntryButton:SetTextColor(Color(255, 255, 255, 255))
    passEntryButton:SetText("Submit Entries")
    passEntryButton.DoClick = function()
        netstream.Start("submitReisepassInfo", ply, {passEntryWang1:GetValue(), passEntryWang2:GetValue(), passEntryWang3:GetValue(), passEntryCombo1:GetValue(), passEntryCombo2:GetValue(), passEntryCombo3:GetValue(), passEntryText1:GetValue(), passEntryText2:GetValue()})
        passEntryFrame:Close()
    end
end

function reisepassMenu(ply, plyReisepassInfo)
    if ply == nil or plyReisepassInfo == nil then return end
    local plyChar = ply:getChar()
    if plyChar == nil then return end

    local passInfoUnits = 
    {
        [2] = " years",
        [3] = " cm",
        [4] = " kg"
    }

    local passMenuFrame = vgui.Create("DFrame")
    passMenuFrame:SetSize(ScrW()/2.26, ScrH()/1.53)
    passMenuFrame:Center()
    passMenuFrame:SetTitle("")
    passMenuFrame:SetDraggable(false)
    passMenuFrame:ShowCloseButton(false)
    passMenuFrame:MakePopup()
    passMenuFrame.Paint = function(self, w, h)
        self:MoveToBack()
    end

    local passMenuImg1 = vgui.Create("DImage", passMenuFrame)
    passMenuImg1:SetPos(0, 0)
    passMenuImg1:SetSize(ScrW()/4.8, ScrH()/1.81)		
    passMenuImg1:Center()
    passMenuImg1:SetImage("rp_documents/reisepass_cover")

    local passMenuImg2 = vgui.Create("DImage", passMenuFrame)
    passMenuImg2:SetPos(0, ScrH()/30.86)
    passMenuImg2:SetSize(0, 0)
    passMenuImg2:SetImage("rp_documents/reisepass_inside")


    local passMenuRightButton = vgui.Create("DButton", passMenuFrame)
    passMenuRightButton:SetPos(ScrW()/4.63, ScrH()/1.65)
    passMenuRightButton:SetSize(ScrW()/15, ScrH()/43.2)
    passMenuRightButton:SetText("-->")
    passMenuRightButton:SetColor(Color(50, 50, 50, 255))
    passMenuRightButton:SetTextColor(Color(255, 255, 255, 255))
    passMenuRightButton.DoClick = function()
        passMenuImg1:SetSize(0, 0)	
        passMenuImg2:SetSize(ScrW()/2.31, ScrH()/1.8)

        for indx, _prop in pairs(reisepass.InfoTable) do
            reisepassMenu_createLabel(passMenuFrame, indx, passInfoUnits, plyChar, plyReisepassInfo)
        end
        reisepassMenu_createModelPanel(passMenuFrame, plyChar)
        reisepassMenu_createModelPanel(passMenuFrame, plyChar)

        LocalPlayer():EmitSound("ambient/materials/shuffle1.wav", 70, 150)
    end

    local passMenuLeftButton = vgui.Create("DButton", passMenuFrame)
    passMenuLeftButton:SetPos(ScrW()/6.69, ScrH()/1.65)
    passMenuLeftButton:SetSize(ScrW()/15, ScrH()/43.2)
    passMenuLeftButton:SetText("Close")
    passMenuLeftButton:SetTextColor(Color(255, 255, 255, 255))
    passMenuLeftButton.DoClick = function()
        passMenuFrame:Close()
        LocalPlayer():EmitSound("ambient/materials/shuffle1.wav", 70, 150)
    end
end

function reisepassMenu_createLabel(frame, labelIndex, passInfoUnits, plyChar, plyReisepassInfo)
    if frame == nil or labelIndex == nil or plyChar == nil or passInfoUnits == nil or plyReisepassInfo == nil then return end

    local passMenuPlyLabel = vgui.Create("DLabel", frame)
    if labelIndex == 1 then
        passMenuPlyLabel:SetSize(ScrW()/5.91, ScrH()/54)
        passMenuPlyLabel:SetPos(ScrW()/3.2, ScrH()/2.04)
    else
        passMenuPlyLabel:SetSize(ScrW()/12.8, ScrH()/54)
        passMenuPlyLabel:SetPos(ScrW()/1.92, ScrH()/4 + (ScrH()/21.6 * labelIndex))
    end
    passMenuPlyLabel:SetText(plyReisepassInfo[labelIndex] ..(passInfoUnits[labelIndex] or ""))
    passMenuPlyLabel:SetFont("passFont")
    passMenuPlyLabel:MakePopup()
    passMenuPlyLabel:SetTextColor(Color(0, 0, 0, 255))
end

function reisepassMenu_createModelPanel(frame, plyChar) 
    if frame == nil or plyChar == nil then return end

    local passMenuPlyIcon_Panel = vgui.Create("DPanel", frame)
    passMenuPlyIcon_Panel:SetSize(ScrW()/9.6, ScrH()/5.4)
    passMenuPlyIcon_Panel:SetPos(ScrW()/3.31, ScrH()/3.79)
    passMenuPlyIcon_Panel:MakePopup()
    passMenuPlyIcon_Panel.Paint = function(self, w, h)
        self:MoveToFront()
    end

    local passMenuPlyIcon = vgui.Create("DModelPanel", passMenuPlyIcon_Panel)
    passMenuPlyIcon:SetSize(ScrW()/11.03, ScrH()/6.17)
    passMenuPlyIcon:SetPos(0, 0)
    passMenuPlyIcon:SetModel(plyChar:getModel())
    passMenuPlyIcon:SetColor(Color(150, 150, 150))
    passMenuPlyIcon:SetAmbientLight(Color(255, 255, 255))

    local headPosition = passMenuPlyIcon.Entity:GetBonePosition(passMenuPlyIcon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
    passMenuPlyIcon:SetLookAt(headPosition)
    passMenuPlyIcon:SetCamPos(headPosition-Vector(-15, 0, 0))
    function passMenuPlyIcon:LayoutEntity(Entity) return end
end