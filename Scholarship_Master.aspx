<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Scholarship_Master.aspx.cs" Inherits="Academic_Scholarship_Master" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">   
<head runat="server">
    <title>Scholarship Master</title>
     <link href="../assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/light-theme.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/demo.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

   
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <section id=''>
                    <div class=''>
                        <div id='Div1'>
                            <div class='col-sm-12 col-lg-12'>
                                <div class='box'>
                                    <div class='box-header blue-background'>
                                        <div class='title'>
                                            <h4>
                                                <i class="fa fa-bars"></i> Scholarship Master
                                                <div id="lbltitle" runat="server" style="display: inline-block;">
                                                </div>
                                            </h4>
                                        </div>
                                    </div>
                                    
                                        <%--  ............... Exception Error Msg..............--%>
                                        <div class='col-sm-12 form-group-2 ' runat="server" id="ExceptionMsg" style="display: none; font-size: small; color: orangered;"></div>

                                        <div class='box-content'>
                                            <div class='col-sm-4 col-lg-4'>

                                            <div class='form-group '>

                                                <asp:Label runat="server" ID="Label1" Text="Course Name" CssClass="FormLable"></asp:Label>
                                                <asp:DropDownList ID="ddlCourseName" runat="server" class="form-control" >
                                                </asp:DropDownList>
                                            </div>
                                                 </div>
                                             <div class='col-sm-4 col-lg-4'>
                                            <div class='form-group '>
                                                <asp:Label runat="server" ID="Label2" Text="Scholarship Name" CssClass="FormLable"></asp:Label>
                                                <span class="mandatoryfields">*</span>
                                                <asp:TextBox ID="txtScholarshipName" runat="server" TabIndex="1" class="form-control"></asp:TextBox>
                                            </div>
                                                  </div>
                                            <div class='col-sm-4 col-lg-4'>
                                            <div class='form-group '>
                                                <asp:Label runat="server" ID="Label3" Text="Scholarship Code" CssClass="FormLable"></asp:Label>
                                                <span class="mandatoryfields">*</span>
                                                <asp:TextBox ID="txtScholarshipCode" runat="server" TabIndex="1" class="form-control"></asp:TextBox>
                                            </div>
                                                 </div>

                                            <center >
                                            <div class='form-actions form-actions-padding-sm form-actions-padding-md form-actions-padding-lg' style="margin-top:7%">
                                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSave_Click" />
                                                <asp:Button ID="btnReset" runat="server" CausesValidation="False" CssClass="btn btn-inverse" Text="Reset" OnClick="btnReset_Click" />
                                                   </div>
                                                </center>
                                        </div>
                                     

                                    <div class='col-sm-12 col-lg-12'>

                                        <div class='box-content overflow'">
                                            <div class=''>
                                                <h3>Scholarship Master :-</h3>
                                            </div>
                                            <div class="grid-scroll">

                                                <div style="height: 400px;  overflow-y: auto; border: 1px solid #ccc;">

                                                    <asp:GridView ID="gridview" runat="server" AutoGenerateColumns="false" DataKeyNames="id"
                                                        class="scrollable-area table table-bordered table-striped"
                                                        PageSize="15">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S/N">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:BoundField HeaderText="Course Name" DataField="CourseName" />
                                                            <asp:BoundField HeaderText="Scholarship Name" DataField="scholarship_name" />
                                                            <asp:BoundField HeaderText="Scholarship Code" DataField="scholarship_code" />
                                                        </Columns>
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
