<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Master_Meal.aspx.cs" Inherits="Academic_Master_Meal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Master Meal</title>
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
                                                <i class="fa fa-bars"></i> Master Meal
                                                <div id="lbltitle" runat="server" style="display: inline-block;">
                                                </div>
                                            </h4>
                                        </div>
                                    </div>
                                    <div class='col-sm-4 col-lg-4'>
                                       
                                        <div class='col-sm-12 form-group-2 ' runat="server" id="ExceptionMsg" style="display: none; font-size: small; color: orangered;"></div>

                                        <div class='box-content'>

                                            <div class='form-group '>
                                                <asp:Label runat="server" ID="Label1" Text="Meal Type" CssClass="FormLable"></asp:Label>
                                                <span class="mandatoryfields">*</span>
                                                <asp:TextBox ID="txtmealtype" runat="server" TabIndex="1" class="form-control"></asp:TextBox>
                                            </div>
 
                                            <center>
                                            <div class='form-actions form-actions-padding-sm form-actions-padding-md form-actions-padding-lg' style='margin-bottom: 0;'>
                                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSave_Click"/>
                                                <asp:Button ID="btnReset" runat="server" CausesValidation="False" CssClass="btn btn-inverse" Text="Reset" OnClick="btnReset_Click"/>
                                            </div>
                                                </center>
                                        </div>
                                    </div>
                                         <div class='col-sm-8 col-lg-8'>

                                        <div class='box-content overflow'>
                                            <div class=''>
                                                <h3>Meal Type :-</h3>
                                            </div>
                                            <div class="grid-scroll">

                                                <div style="height: 400px; overflow-y: auto; border: 1px solid #ccc;">

                                                    <asp:GridView ID="gridview" runat="server" AutoGenerateColumns="false" DataKeyNames="ID"
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

                                                            <asp:TemplateField HeaderText="Meal Type">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox2" runat="server" CausesValidation="false" Text='<%# Bind("MealType") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtn" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Bind("MealType") %>' ForeColor="Black" OnClick="lbtn_Click">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Entry Date" DataField="EntryDate" />
                                                            <asp:BoundField HeaderText="Entry By" DataField="EntryBy" />
                                                            <asp:BoundField HeaderText="Updeted Entry Date" DataField="UpdatedEntryDate" />
                                                            <asp:BoundField HeaderText="Updeted Entry By" DataField="UpdatedEntryBy" />
                                                        </Columns>
                                                    </asp:GridView>
                                   <asp:HiddenField ID="hidden" runat="server" />
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
