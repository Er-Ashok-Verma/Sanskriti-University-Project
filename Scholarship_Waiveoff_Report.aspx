<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Scholarship_Waiveoff_Report.aspx.cs" Inherits="Fee_Scholarship_Waiveoff_Report" %>

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

    <script type="text/javascript">
        function SelectAllSession(source) {
            var checkBoxList = document.getElementById('<%= chkSession.ClientID %>');
            var checkBoxes = checkBoxList.getElementsByTagName("input");

            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == "checkbox") {
                    checkBoxes[i].checked = source.checked;
                }
            }
        }
    </script>


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
                                            <h4 style="color: #fff"><i class="fa fa-bars"> Scholarship Report</i>
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
                                                        <asp:Label ID="lblCourse" runat="server" CssClass="FormLable" Font-Bold="true" Text="Course"></asp:Label><br />
                                                        <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="True" class="form-control" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div2" runat="server">
                                                        <asp:Label ID="lblSem" runat="server" CssClass="FormLable" Font-Bold="true" Text="Semester"></asp:Label><br />
                                                        <asp:DropDownList ID="ddlsem" runat="server" class="form-control" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class='col-sm-3 col-lg-2'>
                                                    <div class='form-group' id="div3" runat="server">
                                                        <asp:Label ID="lblScheme" runat="server" CssClass="FormLable" Font-Bold="true" Text="Scholarship Scheme"></asp:Label><br />
                                                        <asp:DropDownList ID="ddlScheme" runat="server" class="form-control" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class='col-sm-3 col-lg-2'>

                                                    <div class='form-group' id="div_session" runat="server">
                                                        <asp:Label ID="Label1" runat="server" CssClass="FormLable" Font-Bold="true" Text="Session"></asp:Label>
                                                        <asp:CheckBox ID="chkAllSession" runat="server" CssClass="form-control" Text="Select All" AutoPostBack="true"
                                                            OnCheckedChanged="chkAllSession_CheckedChanged" />
                                                        <div class="DivVerticalScroll2">
                                                            <asp:CheckBoxList ID="chkSession" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="chkSession_SelectedIndexChanged"
                                                                RepeatDirection="Vertical">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class='col-sm-3 col-lg-2'>


                                                    <div class='form-group' id="div4" runat="server">
                                                        <asp:Label ID="Label2" runat="server" CssClass="FormLable" Font-Bold="true" Text="Admission Session"></asp:Label>
                                                        <asp:CheckBox ID="chkAllSession1" runat="server" CssClass="form-control" Text="Select All" AutoPostBack="true"
                                                            OnCheckedChanged="chkAllSession1_CheckedChanged" />


                                                        <div class="DivVerticalScroll2">
                                                            <asp:CheckBoxList ID="chkSession1" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="chkSession1_SelectedIndexChanged"
                                                                RepeatDirection="Vertical">
                                                            </asp:CheckBoxList>
                                                        </div>
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

                                                            <asp:BoundField HeaderText="RegNo" DataField="RegNo" />
                                                            <asp:BoundField HeaderText="Student Name" DataField="StudentName" />
                                                            <asp:BoundField HeaderText="Course Name" DataField="CourseName" />
                                                            <asp:BoundField HeaderText="Specilisation Name" DataField="SpecilisationName" />
                                                            <asp:BoundField HeaderText="Semester" DataField="Semester" />
                                                            <asp:BoundField HeaderText="Scheme" DataField="scheme" />
                                                            <asp:BoundField HeaderText="Fee Head Name" DataField="FeeHeadName" />
                                                            <asp:BoundField HeaderText="Amount" DataField="DiscountAmt" />
                                                            <asp:BoundField HeaderText="Scholarship Session" DataField="SessionID" />
                                                            <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" />
                                                            <asp:BoundField HeaderText="Entry Date" DataField="RegDate" />
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:HiddenField ID="hdnsession" runat="server" />
                                                    <asp:HiddenField ID="hdnadmissionsession" runat="server" />
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
                            title: 'Scholarship Reports',
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                            titleAttr: 'PDF',
                            title: 'Scholarship Reports',
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print" style="color:#007"></i> ',
                            titleAttr: 'Print',
                            title: 'Scholarship Reports',
                        },
                    ],
                });
            });
        }
    </script>
</body>
</html>
