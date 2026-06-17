<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Students_Eligible_Fine.aspx.cs" Inherits="Fee_Students_Eligible_Fine" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Students Eligible for Fine</title>
    <link href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <%-- Datatable  CSS END--%>



    <link href="../assets/stylesheets/light-theme.css" media="all" rel="stylesheet" type="text/css" />

    <script src="../JQuery/MessageBox_Function.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
    <script src="sweetalert2.min.js"></script>
    <script src="../js/notify.min.js"></script>


    <link href="../assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href='../assets/images/meta_icons/favicon.ico' rel='shortcut icon' type='image/x-icon' />
    <link href='../assets/images/meta_icons/apple-touch-icon.png' rel='apple-touch-icon-precomposed' />
    <link href='../assets/images/meta_icons/apple-touch-icon-57x57.png' rel='apple-touch-icon-precomposed' sizes='57x57' />
    <link href='../assets/images/meta_icons/apple-touch-icon-72x72.png' rel='apple-touch-icon-precomposed' sizes='72x72' />
    <link href='../assets/images/meta_icons/apple-touch-icon-114x114.png' rel='apple-touch-icon-precomposed' sizes='114x114' />
    <link href='../assets/images/meta_icons/apple-touch-icon-144x144.png' rel='apple-touch-icon-precomposed' sizes='144x144' />
    <link href="../assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/demo.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_colorpicker/bootstrap-colorpicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/bootstrap_switch/bootstrap-switch.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../assets/stylesheets/plugins/common/bootstrap-wysihtml5.css" media="all" rel="stylesheet" type="text/css" />

    <link href="../assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    `
    <script src="../assets/javascripts/ie/html5shiv.js" type="text/javascript"></script>
    <script src="../assets/javascripts/ie/respond.min.js" type="text/javascript"></script>
    <script src="../js/JScript.js" type="text/javascript"></script>
    <script src="../Scripts/Global.js" type="text/javascript"></script>
    <script language="javascript" src="../datetimepicker.js" type="text/javascript"></script>
    <script src="../FeeJScript.js" type="text/javascript"></script>
   <%-- <style>
        .scrollable-area {
            display: block;
            max-height: 400px;
            overflow-y: auto;
            overflow-x: auto;
            white-space: nowrap;
        }

        .table th {
            background-color: #2c3e50;
            color: #fff;
            text-align: center;
        }

        .table td {
            text-align: center;
        }

        h2 {
            text-align: center;
            margin-bottom: 10px;
        }

       
    </style>--%>

     <style type="text/css">
        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #ddd;
        }

            .gridview-style th {
                background: #dad9d9c2 !important;
                color: #004a8b !important;
                font-weight: 700;
                padding: 2px;
                border: 1px solid #ddd;
            }

            .gridview-style td {
                padding: 4px;
                border: 1px solid #ddd;
            }

            .gridview-style tr {
                border: 1px solid #ddd;
            }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel" runat="server">

            <ContentTemplate>
                <section id=''>
                    <div class=''>
                        <div class='col-sm-12 col-lg-12'>
                            <div class='box'>
                                <div class='box-header blue-background'>
                                    <div class='title'>
                                        <h4 style="color: #fff"><i class="fa fa-bars"></i>
                                            <div id="lbltitle" runat="server" style="display: inline-block;">
                                            </div>
                                        </h4>
                                    </div>
                                </div>
                                <div class='box-content'>
                                    <div class='col-sm-12 col-lg-12'>

                                        <div class='col-sm-12 form-group-2 ' runat="server" id="ExceptionMsg" style="display: none; font-size: small; color: orangered;"></div>
                                        <div>
                                            <h3 class="Section-Heading"><i class="fa fa-filter"></i>&nbsp;Filters</h3>
                                        </div>

                                        <div class='col-sm-6 col-lg-6'>
                                            <div class='form-group' id="div5" runat="server">
                                                <asp:Label ID="lblSchool" runat="server" CssClass="FormLable" Font-Bold="true" Text="School"></asp:Label> 
                                           
                                                <asp:DropDownList ID="ddlSchool" runat="server" AutoPostBack="True" class="form-control" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class='col-sm-6 col-lg-6'>
                                            <div class='form-group' id="divstu" runat="server">
                                                <asp:Label ID="lblCourse" runat="server" CssClass="FormLable" Font-Bold="true" Text="Course"></asp:Label><br />
                                                <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="True" class="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="text-center topMargin">
                                            <asp:Button ID="btnview" runat="server" CssClass="btn btn-primary"
                                                Text="View" ValidationGroup="btnShow" Onclick="btnview_Click"/>

                                             <asp:Button ID="btnreset" runat="server" CssClass="btn btn-inverse" Text="Reset" OnClick="btnreset_Click" />

                                            <asp:Button ID="btnadd" runat="server" CssClass="btn btn-success" Text="Add" OnClick="btnadd_Click" />

                                            <asp:Button ID="btndelete" runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="btndelete_Click"
                                                OnClientClick="return confirm('Are you sure you want to delete This Record?');" />
                                        </div>

                                    </div>
                                    <br />
                                    <div class='col-sm-12 col-lg-12'>
                                        <div class="row">
                                            <div class='col-sm-6'>
                                                <h3 id="lblfine" runat="server" visible="false">Students Not Eligible for Fine :- </h3>
                                                <div class="scrollable-area">
                                                    <asp:GridView ID="allstudentgridview" runat="server" AutoGenerateColumns="false" class="scrollable-area table table-bordered table-striped" DataKeyNames="StudentID,RegNo">
                                                        <Columns>
                                                            
                                                            <asp:TemplateField HeaderText="Sr.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="RegNo" DataField="RegNo" />
                                                            <asp:BoundField HeaderText="Student Name" DataField="StudentName" />
                                                            <asp:BoundField HeaderText="Course" DataField="CourseName" />
                                                            <asp:BoundField HeaderText="Semester" DataField="Semester" />
                                                            <asp:BoundField HeaderText="Specilisation Name" DataField="SpecilisationName" />
                                                            <asp:BoundField HeaderText="School Name" DataField="SchoolName" />
                                                             <asp:TemplateField HeaderText="Allow">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAdd" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <input type="checkbox" id="chkHeader" runat="server" onclick="javascript: SelectAllCheckboxes(this, 'chkAdd');" />
                                                        </HeaderTemplate>

                                                    </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                            <div class='col-sm-6'>
                                                <h3 id="lbleligiblefine" runat="server" visible="false">Students Eligible for Fine :- </h3>
                                                <div class="scrollable-area">
                                                    <asp:GridView ID="fineStudentgridview" runat="server" AutoGenerateColumns="false" DataKeyNames="StudentID"
                                                        class="scrollable-area table table-bordered table-striped">
                                                        <Columns>
                                                            
                                                            <asp:TemplateField HeaderText="Sr.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="RegNo" DataField="RegNo" />
                                                            <asp:BoundField HeaderText="Student Name" DataField="StudentName" />
                                                            <asp:BoundField HeaderText="Course" DataField="CourseName" />
                                                            <asp:BoundField HeaderText="Semester" DataField="Semester" />
                                                            <asp:BoundField HeaderText="Specilisation Name" DataField="SpecilisationName" />
                                                            <asp:BoundField HeaderText="School Name" DataField="SchoolName" />
                                                            <asp:TemplateField HeaderText="Allow">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkdelete" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <input type="checkbox" id="chkHeader" runat="server" onclick="javascript: SelectAllCheckboxes(this, 'chkdelete');" />
                                                        </HeaderTemplate>
                                                                </asp:TemplateField>

                                                   <%-- </asp:TemplateField>
                                                             <asp:TemplateField HeaderText="Select">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkdelete"  runat="server"/>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>

                                                        </Columns>
                                                    </asp:GridView>
                                                     <asp:HiddenField ID="HiddenField" runat="server" />
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
     <script type="text/javascript" src="../js_admin/jquery/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="../js_admin/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="../bootstrap-dist/js/bootstrap.min.js"></script>
    <script src="../js_admin/bootstrap-daterangepicker/daterangepicker.min.js" type="text/javascript"></script>
    <script src="../js_admin/bootstrap-daterangepicker/moment.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js_admin/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
    <script type="text/javascript" src="../js_admin/jQuery-slimScroll-1.3.0/slimScrollHorizontal.min.js"></script>
    <script type="text/javascript" src="../js_admin/jQuery-BlockUI/jquery.blockUI.min.js"></script>
    <script type="text/javascript" src="../js_admin/jQuery-Cookie/jquery.cookie.min.js"></script>
    <script type="text/javascript" src="../js_admin/script.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            App.setPage("tabs_accordions");  //Set current page
            App.init(); //Initialise plugins and elements
        });
    </script>


    <%-- Datatable JS start--%>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <%-- <script type="text/javascript" src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>--%>
    <%-- <script type="text/javascript" src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>--%>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/rowgroup/1.4.1/js/dataTables.rowGroup.min.js"></script>


    <script type="text/javascript">
        function pageLoad(sender, args) {
            $(function () {
                $("#allstudentgridview").prepend($("<thead></thead>").append($("#allstudentgridview").find("tbody tr:first"))).DataTable({


                    fixedHeader: true,
                    responsive: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    scrollCollapse: true,
                    scrollY: '450px',
                    scrollX: true,
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
                            title: 'Students Not Eligible for Fine Reports',
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                            titleAttr: 'PDF',
                            title: 'Students Not Eligible for Fine Reports',
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print" style="color:#007"></i> ',
                            titleAttr: 'Print',
                            title: 'Students Not Eligible for Fine Reports',
                        },
                    ],
                });
            });

            $(function () {
                $("#fineStudentgridview").prepend($("<thead></thead>").append($("#fineStudentgridview").find("tbody tr:first"))).DataTable({


                    fixedHeader: true,
                    responsive: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    scrollCollapse: true,
                    scrollY: '450px',
                    scrollX: true,
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
                            title: 'Students Eligible for Fine Reports',
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                            titleAttr: 'PDF',
                            title: 'Students Eligible for Fine Reports',
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print" style="color:#007"></i> ',
                            titleAttr: 'Print',
                            title: 'Students Eligible for Fine Reports',
                        },
                    ],
                });
            });
        }
    </script>

   
   
</body>
</html>
