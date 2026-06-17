<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Student_Feedback_Report.aspx.cs" Inherits="Report_Student_Feedback_Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- Datatable CSS START--%>
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

        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

            <ContentTemplate>
                <section id=''>
                    <div class=''>
                        <div id='Div1'>
                            <div class='col-sm-12 col-lg-12'>
                                <div class='box'>
                                    <div class='box-header blue-background'>
                                        <div class='title'>
                                            <h4 style="color: #fff"><i class="fa fa-bars"> </i>
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
                                            <div class='row'>
                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="divstu" runat="server">
                                                        <asp:Label ID="lblCourse" runat="server" CssClass="FormLable" Font-Bold="true" Text="Course"></asp:Label>
                                                        <asp:DropDownList ID="ddlCourse" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div2" runat="server">
                                                        <asp:Label ID="lblSem" runat="server" CssClass="FormLable" Font-Bold="true" Text="Semester"></asp:Label>
                                                        <asp:DropDownList ID="ddlsem" runat="server" class="form-control" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div3" runat="server">
                                                        <asp:Label ID="lblSpecialization" runat="server" CssClass="FormLable" Font-Bold="true" Text="Specialization"></asp:Label>
                                                        <asp:DropDownList ID="ddlSpecialization" runat="server" class="form-control" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                 <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div5" runat="server">
                                                        <asp:Label ID="lblsubjectType" runat="server" CssClass="FormLable" Font-Bold="true" Text="SubjectType"></asp:Label>
                                                        <asp:DropDownList ID="ddlSubjectType" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSubjectType_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div4" runat="server">
                                                        <asp:Label ID="lblsubject" runat="server" CssClass="FormLable" Font-Bold="true" Text="Subject"></asp:Label>
                                                        <asp:DropDownList ID="ddlSubject" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div6" runat="server">
                                                        <asp:Label ID="lblTeacher" runat="server" CssClass="FormLable" Font-Bold="true" Text="Teacher"></asp:Label>
                                                        <asp:DropDownList ID="ddlTeacher" runat="server" class="form-control" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="text-center topMargin">
                                                <asp:Button ID="btnview" runat="server" CssClass="btn btn-primary" Text="View" ValidationGroup="btnShow" OnClick="btnview_Click" />

                                                <asp:Button ID="btnreset" runat="server" CssClass="btn btn-inverse" Text="Reset" OnClick="btnreset_Click" />
                                            </div>

                                            <div class="grid-scroll">
                                                <div style="overflow-y: auto;">
                                                    <asp:GridView ID="gridview" runat="server" AutoGenerateColumns="false" CssClass="gridview-style">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Sr.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Register No." DataField="RegisterNo" />
                                                            <asp:BoundField HeaderText="Student Name" DataField="StudentName" />
                                                            <asp:BoundField HeaderText="Father Name" DataField="FatherName" />
                                                            <asp:BoundField HeaderText="Rating1" DataField="Rating1" />
                                                            <asp:BoundField HeaderText="Rating2" DataField="Rating2" />
                                                            <asp:BoundField HeaderText="Rating3" DataField="Rating3" />
                                                            <asp:BoundField HeaderText="Rating4" DataField="Rating4" />
                                                            <asp:BoundField HeaderText="Rating5" DataField="Rating5" />
                                                            <asp:BoundField HeaderText="Rating6" DataField="Rating6" />
                                                            <asp:BoundField HeaderText="Rating7" DataField="Rating7" />
                                                            <asp:BoundField HeaderText="Rating8" DataField="Rating8" />
                                                            <asp:BoundField HeaderText="Suggestion1" DataField="Suggestion1" />
                                                            <asp:BoundField HeaderText="Suggestion2" DataField="Suggestion2" />
                                                            <asp:BoundField HeaderText="Suggestion3" DataField="Suggestion3" />
                                                            <asp:BoundField HeaderText="Suggestion4" DataField="Suggestion4" />
                                                            <asp:BoundField HeaderText="Suggestion5" DataField="Suggestion5" />
                                                            <asp:BoundField HeaderText="CreatedDate" DataField="CreatedDate" />

                                                        </Columns>
                                                    </asp:GridView>
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
                $("#gridview").prepend($("<thead></thead>").append($("#gridview").find("tbody tr:first"))).DataTable({


                    fixedHeader: true,
                    responsive: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true,
                    scrollCollapse: true,
                    scrollY: '1200px',
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
                            title: 'Student Feedback Reports',
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                            titleAttr: 'PDF',
                            title: 'Student Feedback Reports',
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print" style="color:#007"></i> ',
                            titleAttr: 'Print',
                            title: 'Student Feedback Reports',
                        },
                    ],
                });
            });
        }
    </script>
</body>
</html>
