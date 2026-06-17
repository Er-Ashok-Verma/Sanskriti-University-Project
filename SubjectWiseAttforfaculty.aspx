<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubjectWiseAttforfaculty.aspx.cs"  Inherits="Attendance_SubjectDailyAttendance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Flan.Controls" Namespace="Flan.Controls" TagPrefix="cc1" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>   
     <link href="../assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href='../assets/images/meta_icons/favicon.ico' rel='shortcut icon' type='image/x-icon' />
    <link href='../assets/images/meta_icons/apple-touch-icon.png' rel='apple-touch-icon-precomposed' />
    <link href='../assets/images/meta_icons/apple-touch-icon-57x57.png' rel='apple-touch-icon-precomposed' sizes='57x57' />
    <link href='../assets/images/meta_icons/apple-touch-icon-72x72.png' rel='apple-touch-icon-precomposed' sizes='72x72' />
    <link href='../assets/images/meta_icons/apple-touch-icon-114x114.png' rel='apple-touch-icon-precomposed' sizes='114x114' />
    <link href='../assets/images/meta_icons/apple-touch-icon-144x144.png' rel='apple-touch-icon-precomposed' sizes='144x144' />
    <link href="../assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/light-theme.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/demo.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_colorpicker/bootstrap-colorpicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_switch/bootstrap-switch.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/common/bootstrap-wysihtml5.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/light-theme.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <script src="../assets/javascripts/ie/html5shiv.js" type="text/javascript"></script>
    <script src="../assets/javascripts/ie/respond.min.js" type="text/javascript"></script>
    <script src="../js/JScript.js" type="text/javascript"></script>
    <script src="../Scripts/Global.js" type="text/javascript"></script>
    <script language="javascript" src="../datetimepicker.js" type="text/javascript"></script>  

    <script language="javascript" type="text/javascript" >
        function opA(ctrlId) {
            var gvET = document.getElementById('gvStudent');
            var parentid;
            if (navigator.userAgent.indexOf("Mozilla") >= 0) {
                parentid = ctrlId.offsetParent.id;
            }
            if (navigator.userAgent.indexOf("MSIE") >= 0) {
                parentid = ctrlId.parentNode.parentElement.offsetParent.id;
            }           
            var sp = ctrlId.name.split("$");
            var n = sp[1].replace("ctl", '');
            if (document.getElementById(ctrlId.id).checked == false) {
                gvET.rows[parseInt(n - 1)].cells[1].style.color = "red";
                gvET.rows[parseInt(n - 1)].cells[2].style.color = "red";
                gvET.rows[parseInt(n - 1)].cells[3].style.color = "red";
                
            }
            else {
                gvET.rows[parseInt(n - 1)].cells[1].style.color = "black";
                gvET.rows[parseInt(n - 1)].cells[2].style.color = "black";
                gvET.rows[parseInt(n - 1)].cells[3].style.color = "black";
                
            }
            var previous = document.getElementById("txtTotal").value;
            var present = document.getElementById("txtPresent").value;
            var absent = document.getElementById("txtAbsent").value;
        
            if (absent == "NaN" || absent == "") {
                absent = "0";
            }
            if (present == "NaN" || present == "") {
                present = "0";
            }
            if (document.getElementById(ctrlId.id).checked == false) {
                document.getElementById("txtAbsent").value = parseInt(absent) + 1;
                if (present != "0") {
                    document.getElementById("txtPresent").value = parseInt(present) - 1;
                }
            }

            else if (document.getElementById(ctrlId.id).checked == true) {
                if (absent != "0") {
                    document.getElementById("txtAbsent").value = parseInt(absent) - 1;
                }
                document.getElementById("txtPresent").value = parseInt(present) + 1;
            }

        }
    </script>      
      <style type="text/css">
          /*i change there 30/11/23*/
          .DivVerticalScroll3
        {           
            overflow-y: auto;            
            max-height:200px;
            width:100%; 
            margin-bottom:10px;       
        }
         .DivVerticalScroll2
         {           
             overflow-y: auto;            
             max-height:200px;        
         }
     </style>
</head>
<body>
    <form id="form1" runat="server">
 <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePageMethods="true">
  </asp:ToolkitScriptManager> 
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
       <section id=''>
        <div class=''>
          <div id=''>
                <div class='col-sm-12 col-lg-12'>
                  <div class='box'>
                    <div class='box-header blue-background'>
                      <div class='title'>
                       <h4>
                       <i class="fa fa-bars"></i>
                        <div id="lbltitle"  runat="server" style="display:inline-block;">
                        </div></h4>                      
                       </div>                     
                    </div>
                     <div class='col-sm-4 col-lg-4'>
                    <div class='box-content'>
                         <div class='form-group'>
                            <asp:RadioButton ID="optNew" runat="server" AutoPostBack="True" Checked="true" 
                            GroupName="a" oncheckedchanged="optNew_CheckedChanged" Text="New" 
                            AccessKey="N" />                         
                        <asp:RadioButton ID="optEdit" runat="server" AutoPostBack="True" GroupName="a" 
                            oncheckedchanged="optEdit_CheckedChanged" Text="Edit/Update" AccessKey="E" 
                            Enabled="true" />
                         </div>



                        <div class='form-group ' runat="server" id="divInst">
                         <label for='inputText'>Institute</label>
                            <span class="mandatoryfields">*</span> 
                         <asp:DropDownList ID="ddlInstitute" runat="server" 
                                 AutoPostBack="true" class="form-control" TabIndex="1" OnSelectedIndexChanged="ddlInstitute_SelectedIndexChanged">
                             </asp:DropDownList>                         
                        </div>

                        <div class='form-group' runat="server" id="divFaculty" style="display:none;">
                        <asp:Label runat="server" ID="Label11" Text="" CssClass="FormLable">Faculty Name</asp:Label>
                          <span class="mandatoryfields">*</span>  
                        <asp:DropDownList ID="ddlFaculty" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFaculty_SelectedIndexChanged"               
                                        TabIndex="1"> </asp:DropDownList>                  
                        </div>

                        <div class='form-group' runat="server" id="divCourse">
                        <asp:Label runat="server" ID="lbl_ddlCourse" Text="" CssClass="FormLable"></asp:Label>
                          <span class="mandatoryfields">*</span>  
                        <asp:DropDownList ID="ddlCourse" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"                
                                        TabIndex="2"> </asp:DropDownList>                  
                        </div>
                                                                       
                        
                        <div class='form-group ' runat="server" id="div_Sem" style="display:none;">
                             <asp:Label ID="lblY" runat="server" Text="Year-Sem" CssClass="FormLable"></asp:Label>
                              <span class="mandatoryfields">*</span>                                
                          <asp:DropDownList ID="Ddl_Semes" runat="server" AutoPostBack="true" 
                                           onselectedindexchanged="Ddl_Semes_SelectedIndexChanged" class="form-control">
                                       </asp:DropDownList>
                         </div>

                        <div class='form-group ' runat="server" id="div_Spl" style="display:none;">
                        <asp:Label ID="lbl_ddlSpl" runat="server" Text="Specialisation" CssClass="FormLable"></asp:Label>
                          <span class="mandatoryfields">*</span>                      
                           <asp:DropDownList ID="Ddl_Specl" runat="server" AutoPostBack="true" 
                                           onselectedindexchanged="Ddl_Specl_SelectedIndexChanged" class="form-control">
                                       </asp:DropDownList>
                         </div>

                        <div class='form-group '>
                        <asp:Label runat="server" ID="lblsubject" Text="Subject" CssClass="FormLable"></asp:Label>
                             <span class="mandatoryfields">*</span> 
                         <asp:DropDownList ID="ddlSubject" runat="server" AutoPostBack="True" 
                                           onselectedindexchanged="ddlSubject_SelectedIndexChanged" TabIndex="5" 
                                          class="form-control">
                                       </asp:DropDownList>
                       </div>
                        <%--i change there 30/11/23--%>
                          <div id="divlnkbutton" runat="server" style="text-align:end;float:right;display:none"> <asp:LinkButton ID="lnkhide" Text="Hide" runat="server" OnClick="lnkhide_Click"></asp:LinkButton></div>   
                        <div id="divAttendanceDetail" runat="server" class="DivVerticalScroll3" style="display:none">
                        <asp:GridView ID="grdAttendance"  runat="server" AutoGenerateColumns="False" 
                                
                                 
                            class="responsive-table scrollable-area table data-table table table-bordered table-striped">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr/N">
                                      
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Subject" HeaderText="Subject Name" />--%>
                                    <asp:BoundField DataField="AttDate" HeaderText="Attendance Date"/>
                                    <asp:BoundField DataField="class1" HeaderText="Class No."/>
                                    
                                </Columns>
                                <%--<HeaderStyle Height="20px" />--%>
                            </asp:GridView> 
                        </div>           
                        <%--end--%>
                        <div class='form-group '>
                        <asp:Label ID="Label5" runat="server" Text="Attendance Date" CssClass="FormLable"></asp:Label>
                         <span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtdate" runat="server" OnClientClick="Validate();" AutoComplete="Off"
                                           TabIndex="4" class="form-control" OnTextChanged="txtdate_TextChanged" AutoPostBack="true" onblur="checkdate1(this,'en-US','dd-MMM-yyyy');" placeholder="DDMMYYYY"></asp:TextBox>
                       <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtdate" format="dd-MMM-yyyy"></asp:CalendarExtender>
                              </div>                        
                           
                        <div class='form-group' runat="server" id="div_PeriodType" style="display:none;">
                        <asp:Label ID="Label1" runat="server" Text="Period Type" CssClass="FormLable"></asp:Label>
                         <span class="mandatoryfields">*</span>                         
                         <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true"
                               TabIndex="6" class="form-control" onselectedindexchanged="ddlCategory_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div> 
                        
                         <div class='form-group '>
                        <asp:Label ID="Label2" runat="server" Text="Class No." CssClass="FormLable"></asp:Label>
                         <span class="mandatoryfields">*</span>                         
                         <asp:CheckBoxList ID="chkclassno" runat="server" class="form-control" 
                                            TabIndex="7" 
                                           RepeatDirection="Horizontal" RepeatColumns="6">                                          
                                           <asp:ListItem  Value="1">1st</asp:ListItem>
                                           <asp:ListItem Value="2"> 2nd</asp:ListItem>
                                           <asp:ListItem Value="3">3rd</asp:ListItem>
                                           <asp:ListItem Value="4">4th</asp:ListItem>
                                           <asp:ListItem Value="5">5th</asp:ListItem>       
                                           <asp:ListItem Value="6">6th</asp:ListItem>
                                           <asp:ListItem Value="7">7th</asp:ListItem>
                                           <asp:ListItem Value="8">8th</asp:ListItem>
                                           <asp:ListItem Value="9">9th</asp:ListItem>
                                           <asp:ListItem Value="10">10th</asp:ListItem>
                                           <asp:ListItem Value="11">11th</asp:ListItem>
                                           <asp:ListItem Value="12">12th</asp:ListItem>                                   
                                           </asp:CheckBoxList>
                        </div>  

                        <div class='form-group ' runat="server" id="divfilter">
                             <asp:Label ID="Label10" runat="server" Text="Filter on the basis of" CssClass="FormLable"></asp:Label>
                              <span class="mandatoryfields">*</span>                                
                          <asp:DropDownList ID="ddlfilter" runat="server" class="form-control" OnSelectedIndexChanged="ddlfilter_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="0" Text="Course Registration" Enabled="true"></asp:ListItem>        
                            <asp:ListItem Value="1" Text="Section Allotment"></asp:ListItem>          
                          </asp:DropDownList>
                         </div>

                        <div class='form-group' runat="server" id="divsection" style="display:none;">
                        <asp:Label ID="Label3" runat="server" Text="Section" CssClass="FormLable"></asp:Label>
                        <span class="mandatoryfields">*</span>
                        <asp:CheckBox ID="chkall_group" runat="server" Visible="false" class="form-control" Text ="Select All" AutoPostBack="true" OnCheckedChanged="chkall_group_CheckedChanged"/> 
                        <div class="DivVerticalScroll2">                         
                        <asp:CheckBoxList ID="chkGroup" 
                                           runat="server" class="form-control" AutoPostBack="True" 
                                           onselectedindexchanged="chkGroup_SelectedIndexChanged" 
                                           RepeatDirection="Vertical" TabIndex="7" >
                                       </asp:CheckBoxList>
                        </div>  
                            </div>
                        <div class='form-group ' runat="server" id="div_reason" style="display:none">
                        <asp:Label ID="Label4" runat="server" Text="Reason of Delay" CssClass="FormLable"></asp:Label>
                         <span class="mandatoryfields">*</span>                         
                           <asp:TextBox ID="txtRes" runat="server" Height="50px" 
                                          OnClientClick="Validate();" TabIndex="4" TextMode="MultiLine" class="form-control"></asp:TextBox>
                        </div>  
                                                    
                      </div> 
                                       
                 </div>               

                 <div class='col-sm-8 col-lg-8'> 
                     <div class='box-content overflow'>  
                       <asp:Button ID="btnSubmit" runat="server" AccessKey="S" 
                                CausesValidation="False" CssClass="btn btn-primary" onclick="btnSubmit_Click" 
                                TabIndex="11" Text="Submit" />
                            <asp:Button ID="Button2" runat="server" AccessKey="R" CausesValidation="False" 
                                CssClass="btn btn-inverse" onclick="btnReset_Click" TabIndex="12" Text="Reset" />
                          <asp:Button ID="btnDelete" runat="server" AccessKey="D" CausesValidation="False" 
                                CssClass="btn btn-danger" OnClick="btnDelete_Click" 
                             OnClientClick="return confirm('Are you sure, want to delete the attendance for the applied filters..!!');" TabIndex="13" Text="Delete" Visible="false"/>                                
                            <asp:Button ID="cmdPrint" runat="server" AccessKey="P" CausesValidation="False" 
                                CssClass="btn btn-success" onclick="cmdPrint_Click" TabIndex="14" Text="Print" 
                                Visible="False" />
                      </div>  

                      <div class='box-content overflow'>                            
                      <table width="100%">
                            <tr>
                                <td>
                                <asp:Label ID="Label6" runat="server" Text="Total"></asp:Label> </td>
                                <td style="border-right-style: solid; border-right-width: 1px; border-right-color: #C0C0C0">
                                    <asp:TextBox ID="txtTotal" runat="server" Enabled="false"
                                        style="max-width:100px;" class="form-control" Font-Bold="true" Font-Size="Medium" ForeColor="#0000ff"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server" Text="Absent"></asp:Label>  </td>
                                <td style="border-right-style: solid; border-right-width: 1px; border-right-color: #C0C0C0">
                                    <asp:TextBox ID="txtAbsent" runat="server" class="form-control" Enabled="false" Font-Bold="true" Font-Size="Medium" ForeColor="Red"  style="max-width:100px;"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label8" runat="server"  Text="Present"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="txtPresent" runat="server" class="form-control" Enabled="false" Font-Bold="true" Font-Size="Medium" ForeColor="Green" style="max-width:100px;"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                      </div>
                                             
                    <div class='box-content overflow'>
                    <div class="row">
                        
                        <div style="width:29%;float:left">
                     <h3>Student List :-</h3>  
                                </div>   
                        <div style="width:50%;float:right;text-align:right;margin-top:-10px"  class="form-control">
                    
                             <asp:Label ID="Label9" runat="server" CssClass="FormLable" Text="Sort by" ></asp:Label>
                                     
                           <asp:DropDownList ID="ddlsort" runat="server" Width="70%" Height="26px" OnSelectedIndexChanged="ddlsort_SelectedIndexChanged" AutoPostBack="true" >
                               <asp:ListItem Value="Name" Text="Name"></asp:ListItem>
                               <asp:ListItem Value="UniversityRollNo" Text="UniversityRollNo"></asp:ListItem>
                              <%-- <asp:ListItem Value="RegNo" Text="Roll No"></asp:ListItem>--%>
                                       </asp:DropDownList>
                                </div>      
                    </div> 
                        <div class="row">
                     <div runat="server" id="div_gvStudent" class="divforNoData" style="display:none;">No record found to display</div>                                            
                    <div class="DivVerticalScroll">
                        <asp:GridView ID="gvStudent" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="StudentID,BatchID,ID,EgroupId" onrowdatabound="gvStudent_RowDataBound" 
                                ShowHeaderWhenEmpty="True" TabIndex="9" class="scrollable-area table table-bordered table-striped">
                                <Columns>
                                    <asp:TemplateField HeaderText="S/N">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
                                    <asp:BoundField DataField="UniversityRollNo" HeaderText="Uni.Roll.No" 
                                        />
                                    <asp:BoundField DataField="Name" HeaderText="Student Name" />
                                    <asp:BoundField DataField="RegNo" HeaderText="Reg. No" Visible="False" />
                                    <asp:BoundField DataField="Batch_Name" HeaderText="Section" />
                                    <asp:TemplateField HeaderText="Status">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkall" runat="server" AutoPostBack="true" Checked="True" 
                                                oncheckedchanged="chkall_CheckedChanged" />
                                           <asp:Label ID="Label2" runat="server" Text="Status"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Chkstatus" runat="server" Checked='<%#bind("Status") %>' 
                                                TabIndex="10" Text="P" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remark" Visible="False">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemark" runat="server" Text="P" Width="120px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle Height="20px" />
                            </asp:GridView> 
                        </div>
                            </div>
                    </div>
                    </div>
                  </div>
                </div>
              </div>
              </div>            
        </section>
            <asp:HiddenField ID="hdndays" runat="server" />           
          <%--  <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />--%>
           <input type="hidden" ID="Hdyear" runat="server" />
           <input type="hidden" ID="Hdsem" runat="server" />
           <input type="hidden" ID="hdnctype" runat="server" />
           <input type="hidden" ID="hdbatchid" runat="server" />
           <input type="hidden" ID="hdID" runat="server" />
           <input type="hidden" ID="Fid" runat="server" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdPrint" />
          <%--  <asp:PostBackTrigger ControlID="txtdate" />--%>
        </Triggers>
    </asp:UpdatePanel>      
     <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="0">
        <ProgressTemplate>
            <div class="ProgressMsg" style="position:fixed;top:300px !important">
                <img src="../images/wait.gif" alt="Wait"  />Please wait...
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <cc1:UpdateProgressOverlayExtender ID="UpdateProgressOverlayExtender3" runat="server"
        CssClass="updateProgress" TargetControlID="UpdateProgress3" OverlayType="Browser" />   
   </form>
   <%-- <!-- Datatables Searching Sorting Paging Start -->

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
     <script type="text/javascript" src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/rowgroup/1.4.1/js/dataTables.rowGroup.min.js"></script>
   


    <link href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css"  rel="stylesheet" type="text/css"/>
    <link href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function pageLoad(sender, args) {
            $(function () {
                $("#gvStudent").prepend($("<thead></thead>").append($("#gvStudent").find("tbody tr:first"))).DataTable({
                    fixedHeader: true,
                    responsive: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    scrollCollapse: true,
                    scrollY: '430px',
                    dom: 'Bfrtip',
                    lengthMenu: [
                        [10, 25, 50, -1],
                        ['10 rows', '25 rows', '50 rows', 'Show all']
                    ],
                    buttons: [
                          'pageLength',
                           {
                               extend: 'excelHtml5',
                               text: '<i class="fa fa-file-excel-o" style="color:green"></i>',
                               titleAttr: 'Excel',
                               title: 'Student Attendance',
                           },
                           {
                               extend: 'pdfHtml5',
                               text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                               titleAttr: 'PDF',
                               title: 'Student Attendance',
                           },
                           {
                               extend: 'print',
                               text: '<i class="fa fa-print" style="color:#007"></i> ',
                               titleAttr: 'Print',
                               title: 'Student Attendance',
                           },
                    ],

                   
                });

            });

        }
    </script>--%>
</body>

</html>

