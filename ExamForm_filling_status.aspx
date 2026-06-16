<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamForm_filling_status.aspx.cs" Inherits="Examination_ExamForm_filling_status" %>

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
        .grid-scroll {
            width: 100%;
            overflow-x: auto;
        }

        .gridview-style {
            width: 100% !important;
            border-collapse: collapse;
            table-layout: auto;
            font-family: Arial, sans-serif;
        }

            .gridview-style th {
                background: #dad9d9c2 !important;
                color: #004a8b !important;
                font-weight: bold;
                padding: 8px;
                border: 1px solid #ddd;
                text-align: center;
                white-space: nowrap;
            }

            .gridview-style td {
                padding: 8px;
                border: 1px solid #ddd;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
            }

            .gridview-style tbody tr:nth-child(even) {
                background: #f9f9f9;
            }

            .gridview-style tbody tr:hover {
                background: #eef5ff;
            }

        /* DataTable Header Fix */
        table.dataTable thead th,
        table.dataTable thead td {
            border-bottom: 1px solid #ddd !important;
        }

        /* Header & Body Alignment */
        .dataTables_scrollHeadInner,
        .dataTables_scrollHeadInner table {
            width: 100% !important;
        }

        .dataTables_scrollBody table {
            width: 100% !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnableViewState="true" EnablePageMethods="true">
            <Services>
                <asp:ServiceReference Path="~/EducationService.asmx" />
            </Services>
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
                                                <i class="fa fa-bars"></i> Exam Form filling status
                                                <div id="lbltitle" runat="server" style="display: inline-block;">
                                                </div>
                                            </h4>
                                        </div>
                                    </div>

                                    <div class='box-content'>
                                        <div class='row'>

                                            <!-- School Name -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label1" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="School Name :"></asp:Label>

                                                    <asp:Label ID="lblSchoolName" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>


                                            <!-- Session -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label2" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Session :"></asp:Label>

                                                    <asp:Label ID="lblSession" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Registration Number -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label5" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Registration Number :"></asp:Label>

                                                    <asp:Label ID="lblRegNumber" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Student Name -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label4" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Student Name :"></asp:Label>

                                                    <asp:Label ID="lblStudentName" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Father Name -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label6" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Father Name :"></asp:Label>

                                                    <asp:Label ID="lblFatherName" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Course Name -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label8" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Course Name :"></asp:Label>

                                                    <asp:Label ID="lblCourseName" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Specialization -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label3" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Specialization :"></asp:Label>

                                                    <asp:Label ID="lblSpecialization" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Year -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <asp:Label ID="Label9" runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold me-2"
                                                        Text="Year :"></asp:Label>

                                                    <asp:Label ID="lblYear" runat="server"
                                                        CssClass="Label_form"
                                                        Font-Bold="false"></asp:Label>
                                                </div>
                                                <br />
                                            </div>

                                            <!-- Semester -->
                                            <div class="col-12 col-sm-12 col-lg-4 mb-3">

                                                <div style="display: flex; align-items: center; gap: 10px;">

                                                    <asp:Label ID="Label7"
                                                        runat="server" Font-Bold="true"
                                                        CssClass="Label_form text-bold"
                                                        Text="Semester :">
                                                    </asp:Label>

                                                    <asp:DropDownList ID="ddlSemester"
                                                        runat="server"
                                                        CssClass="form-control"
                                                        Style="width: 150px; display: inline-block;"
                                                        AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged">
                                                    </asp:DropDownList>

                                                </div>

                                            </div>

                                        </div>
                                    </div>

                                </div>

                                <br />
                                <br />
                                <div class="grid-scroll">
                                    <div style="overflow-y: auto;">
                                        <asp:GridView ID="gridview" runat="server" AutoGenerateColumns="false" CssClass="gridview-style">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField HeaderText="examname" DataField="Title_Name" />
                                                <asp:BoundField HeaderText="EntryDate" DataField="EntryDate" />
                                                <asp:BoundField HeaderText="TranID" DataField="TranID" />
                                                <asp:BoundField HeaderText="Amount" DataField="Amount" />
                                                <asp:BoundField HeaderText="Receipt_No" DataField="Receipt_No" />
                                                <asp:BoundField HeaderText="TranDate" DataField="TranDate" />

                                            </Columns>
                                        </asp:GridView>

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
        <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
            DisplayAfter="0">
            <ProgressTemplate>
                <div class="ProgressMsg">
                    <img src="../images/wait.gif" alt="Wait" />
                    <br />
                    <br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
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
                            title: 'ExamForm fill Reports',
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o" style="color:red"></i>',
                            titleAttr: 'PDF',
                            title: 'ExamForm fill Reports',
                        },
                        {
                            extend: 'print',
                            text: '<i class="fa fa-print" style="color:#007"></i> ',
                            titleAttr: 'Print',
                            title: 'ExamForm fill Reports',
                        },
                    ],
                });
            });
        }
    </script>
</body>
</html>
