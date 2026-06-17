 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendInApp_Notification.aspx.cs" Inherits="SecurityBPO_SendInApp_Notification" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Send InApp Notification</title>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        /* ----- RESET & BASE ----- */
        * {
            box-sizing: border-box;
        }

        body {
            background: #f0f2f5;
            padding: 24px 20px;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
        }

        /* ----- MAIN CARD STYLES ----- */
        .main-card {
            border-radius: 20px;
            overflow: hidden;
            border: none;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            background: #fff;
        }

        .card-header {
            padding: 1rem 1.5rem;
            border-bottom: none;
        }

        .card-header h4 {
            font-weight: 600;
            letter-spacing: -0.2px;
            margin: 0;
        }

        /* ----- FILTER CARD / TOOLBAR ----- */
        .filter-card {
            border: none;
            border-radius: 18px;
            background: #ffffff;
            margin-bottom: 1.8rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .filter-card .card-header {
            background: #f8fafd !important;
            border-bottom: 1px solid #eef2f6;
            padding: 0.9rem 1.2rem;
        }

        .filter-card .card-header h5 {
            font-weight: 600;
            font-size: 1rem;
            color: #1a2c3e;
            margin: 0;
        }

        /* form labels */
        .form-label {
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.4rem;
            color: #2c3e50;
        }

        .mandatoryfields {
            color: #dc3545;
            font-weight: 700;
            margin-left: 2px;
        }

        /* action checkboxes */
        .action-check {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #f8fafc;
            padding: 8px 15px;
            border-radius: 40px;
            margin-top: 1.2rem;
            width: fit-content;
        }

        .action-check label {
            font-weight: 600;
            margin: 0;
            font-size: 0.85rem;
            color: #1e4668;
        }

        /* buttons */
        .btn-gradient-save {
            background: linear-gradient(105deg, #1e3c72 0%, #2b3b4c 100%);
            border: none;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.2s;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .btn-gradient-save:hover {
            transform: translateY(-2px);
            background: linear-gradient(105deg, #143256 0%, #1f2e3b 100%);
            box-shadow: 0 10px 18px rgba(0, 0, 0, 0.1);
        }

        .btn-reset {
            background: #fff1f0;
            border: 1px solid #f0cdc9;
            color: #b13e3e;
            font-weight: 600;
            border-radius: 20px;
            transition: all 0.2s;
            padding:10px;
        }

        .btn-reset:hover {
            background: #ffe1de;
            border-color: #d99e96;
            color: #8b2c2c;
        }

        /* ----- GRID CONTAINERS (modern & responsive) ----- */
        .grid-wrapper {
            margin-top: 32px;
            border-radius: 20px;
            background: white;
            border: 1px solid #eef2f9;
            overflow: hidden;
            box-shadow: 0 5px 14px rgba(0, 0, 0, 0.02);
        }

        .grid-inner {
            overflow-x: auto;
            overflow-y: auto;
            max-height: 520px;
            scroll-behavior: smooth;
            
        }

        /* Base table styles */
        .modern-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
            min-width: 1000px;
        }

        .modern-table th {
            background: #f1f5f9;
            color: #1e2f3e;
            font-weight: 700;
            font-size: 0.75rem;
            padding: 14px 12px;
            border-bottom: 2px solid #e2e8f0;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.3px;

        }

        .modern-table td {
            padding: 12px 12px;
            border-bottom: 1px solid #edf2f7;
            color: #1f2a3e;
            vertical-align: middle;
        }

        .modern-table tbody tr:hover td {
            background-color: #fafcff;
        }

        /* Specific column widths for employee grid */
        .grid-employee .modern-table th:nth-child(1), 
        .grid-employee .modern-table td:nth-child(1) { width: 60px; }
        .grid-employee .modern-table th:nth-child(2), 
        .grid-employee .modern-table td:nth-child(2) { width: 14%; }
        .grid-employee .modern-table th:nth-child(3), 
        .grid-employee .modern-table td:nth-child(3) { width: 12%; }
        .grid-employee .modern-table th:nth-child(4), 
        .grid-employee .modern-table td:nth-child(4) { width: 10%; }
        .grid-employee .modern-table th:nth-child(5), 
        .grid-employee .modern-table td:nth-child(5) { width: 12%; }
        .grid-employee .modern-table th:nth-child(6), 
        .grid-employee .modern-table td:nth-child(6) { width: 12%; }
        .grid-employee .modern-table th:nth-child(7), 
        .grid-employee .modern-table td:nth-child(7) { width: 15%; }
        .grid-employee .modern-table th:nth-child(8), 
        .grid-employee .modern-table td:nth-child(8) { width: 18%; }
        .grid-employee .modern-table th:nth-child(9), 
        .grid-employee .modern-table td:nth-child(9) { width: 12%; }

        /* student grid specific widths */
        .grid-student .modern-table th:nth-child(1),
        .grid-student .modern-table td:nth-child(1) { width: 60px; }
        .grid-student .modern-table th:nth-child(2),
        .grid-student .modern-table td:nth-child(2) { width: 12%; }
        .grid-student .modern-table th:nth-child(3),
        .grid-student .modern-table td:nth-child(3) { width: 12%; }
        .grid-student .modern-table th:nth-child(4),
        .grid-student .modern-table td:nth-child(4) { width: 10%; }
        .grid-student .modern-table th:nth-child(5),
        .grid-student .modern-table td:nth-child(5) { width: 12%; }
        .grid-student .modern-table th:nth-child(6),
        .grid-student .modern-table td:nth-child(6) { width: 12%; }
        .grid-student .modern-table th:nth-child(7),
        .grid-student .modern-table td:nth-child(7) { width: 14%; }
        .grid-student .modern-table th:nth-child(8),
        .grid-student .modern-table td:nth-child(8) { width: 18%; }
        .grid-student .modern-table th:nth-child(9),
        .grid-student .modern-table td:nth-child(9) { width: 10%; }

        .empty-data-row td {
            text-align: center;
            padding: 48px 20px !important;
            background: #fefcf5;
            color: #7c8b9c;
            font-style: italic;
            font-size: 0.9rem;
        }

        /* badge style */
        .badge-category {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 700;
            text-align: center;
            white-space: nowrap;
        }

        .badge-fee { background: #e3f2fd; color: #0b5e7e; }
        .badge-register { background: #e8f5e9; color: #1e6f2f; }
        .badge-exam { background: #fff3e0; color: #c45c00; }
        .badge-transport { background: #ede7f6; color: #4a2c8a; }
        .badge-hostel { background: #fce4ec; color: #b33b5c; }
        .badge-other { background: #eceff3; color: #3a4a5c; }
        .badge-circular { background: #e0f2f1; color: #006653; }

        /* responsive fixes */
        @media (max-width: 992px) {
            .modern-table {
                font-size: 0.75rem;
            }
            .modern-table th, .modern-table td {
                padding: 10px 8px;
            }
        }
    </style>

    <script type="text/javascript">
        function togglePanels() {
            var ddlType = document.getElementById('<%= ddlTypeFilter.ClientID %>');
            var studentPanel = document.getElementById('<%= student.ClientID %>');
            var employeePanel = document.getElementById('<%= employee.ClientID %>');

            if (ddlType && studentPanel && employeePanel) {
                var selectedValue = ddlType.value;
                if (selectedValue === 'S') {
                    studentPanel.style.display = 'flex';
                    employeePanel.style.display = 'none';
                } else if (selectedValue === 'F') {
                    studentPanel.style.display = 'none';
                    employeePanel.style.display = 'flex';
                } else {
                    studentPanel.style.display = 'none';
                    employeePanel.style.display = 'none';
                }
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            togglePanels();
            setupTypeChangeHandler();
        });

        function setupTypeChangeHandler() {
            var ddlType = document.getElementById('<%= ddlTypeFilter.ClientID %>');
            if (ddlType) {
                ddlType.removeEventListener('change', togglePanels);
                ddlType.addEventListener('change', togglePanels);
            }
        }

        if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (prm) {
                prm.add_endRequest(function () {
                    togglePanels();
                    setupTypeChangeHandler();
                });
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid px-lg-4 px-md-3">

            <div class="card main-card">

                <div class="card-header bg-primary text-white" style="background: linear-gradient(115deg, #173e64 0%, #1f4970 100%) !important;">
                    <h4 class="mb-0"><i class="fas fa-bell mr-2"></i> Send InApp Notification</h4>
                </div>

                <div class="card-body p-4">

                    <!-- Filter Card -->
                    <div class="card filter-card">
                        <div class="card-header">
                            <h5 class="mb-0"> Filters</h5>
                        </div>
                        <div class="card-body">

                            <div class="row mb-4">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Type <span class="mandatoryfields">*</span></label>
                                    <asp:DropDownList ID="ddlTypeFilter" runat="server" 
                                        OnSelectedIndexChanged="ddlTypeFilter_SelectedIndexChanged"
                                        AutoPostBack="True" CssClass="form-control">
                                        <asp:ListItem Value="S"> Student</asp:ListItem>
                                        <asp:ListItem Value="F"> Employee</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2 mb-3">
                                    <label class="form-label d-block">&nbsp;</label>
                                    <asp:Button ID="btSave" runat="server" Text=" Send Notification" 
                                        CssClass="btn btn-success btn-gradient-save" OnClick="btSave_Click" />
                                </div>
                                <div class="col-md-2 mb-3">
                                    <label class="form-label d-block">&nbsp;</label>
                                    <asp:Button ID="btnreset" runat="server" Text="⟳ Reset Filters"  padding="40px"
                                        CssClass="btn btn-reset" OnClick="btnreset_Click" />
                                </div>
                            </div>

                            <!-- Dynamic Panels Row -->
                            <div class="row">
                                <!-- Student Panel -->
                                <div id="student" runat="server" style="display: none; flex-wrap: wrap; width: 100%; gap: 0;">
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Session</label>
                                        <asp:DropDownList ID="ddlSession" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">School</label>
                                        <asp:DropDownList ID="ddlSchool" runat="server" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Course</label>
                                        <asp:DropDownList ID="ddlCourse" runat="server" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Semester</label>
                                        <asp:DropDownList ID="ddlsem" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Specialization</label>
                                        <asp:DropDownList ID="ddlspeclization" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Category <span class="mandatoryfields">*</span></label>
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Category --" Value="" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Fee" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Register" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Exam" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Transport" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Hostel" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="6"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Title <span class="mandatoryfields">*</span></label>
                                        <asp:TextBox ID="txtTitle" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="e.g., Exam Fee Reminder"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Body <span class="mandatoryfields">*</span></label>
                                        <asp:TextBox ID="txtbody" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Write notification content..."></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <div class="action-check">
                                            <asp:CheckBox ID="chkS" runat="server" Checked="true" />
                                            <label>Action</label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Employee Panel -->
                                <div id="employee" runat="server" style="display: none; flex-wrap: wrap; width: 100%;">
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Department</label>
                                        <asp:DropDownList ID="ddlDepartment" runat="server" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Designation</label>
                                        <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Salary Grade</label>
                                        <asp:DropDownList ID="ddlSalaryGrade" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Employee Type</label>
                                        <asp:DropDownList ID="ddlEmployeeType" runat="server" CssClass="form-control" AutoPostBack="True"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Category <span class="mandatoryfields">*</span></label>
                                        <asp:DropDownList ID="ddlCategoryE" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Category --" Value="" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Circular" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Title <span class="mandatoryfields">*</span></label>
                                        <asp:TextBox ID="txttitleE" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Title e.g., Holiday Circular"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Body <span class="mandatoryfields">*</span></label>
                                        <asp:TextBox ID="txtbodyE" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Notification details..."></asp:TextBox>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="action-check">
                                            <asp:CheckBox ID="chkF" runat="server" Checked="true" />
                                            <label>Action</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Student Grid Section -->
                    <div class="grid-wrapper grid-student">
                        <div class="grid-inner">
                            <asp:GridView ID="gridviewS" runat="server" AutoGenerateColumns="false"
                                CssClass="modern-table" BorderWidth="0" GridLines="None"  DataKeyNames="ID"
                                EmptyDataText=" No student notifications found."
                                EmptyDataRowStyle-CssClass="empty-data-row">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate><span class="font-weight-bold"><%# Container.DataItemIndex + 1 %></span></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="School" DataField="SchoolName" />
                                    <asp:BoundField HeaderText="Course" DataField="CourseName" />
                                    <asp:BoundField HeaderText="Semester" DataField="Semester" />
                                    <asp:BoundField HeaderText="Specialization" DataField="SpecilisationName" />
                                    <asp:BoundField HeaderText="Category" DataField="CategoryName" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="Title" DataField="TitleNotification" />
                                    <asp:BoundField HeaderText="Body" DataField="BodyNotification" />
                                    <asp:BoundField HeaderText="Entry Date" DataField="EntryDate" DataFormatString="{0:dd MMM yyyy}" />
                                    <asp:BoundField HeaderText="Status" DataField="Status" />
                                     <asp:TemplateField HeaderText="Update Status" ShowHeader="False">
                                     <ItemTemplate >
                                        <asp:LinkButton ID="lnkbtneditStudent" runat="server" ForeColor="Green"  OnClick="lnkbtneditStudent_Click"  CausesValidation="False"
                                            CommandName="Select" Text ="Edit" ToolTip="Edit" Style="margin-right: 20px;"></asp:LinkButton>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:HiddenField ID="hndstudent" runat="server" />
                        </div>
                    </div>

                    <!-- Employee Grid Section -->
                    <div class="grid-wrapper grid-employee mt-4">
                        <div class="grid-inner">
                            <asp:GridView ID="gridviewF" runat="server" AutoGenerateColumns="false" DataKeyNames="ID"
                                CssClass="modern-table" BorderWidth="0" GridLines="None"
                                EmptyDataText="No employee notifications available."
                                EmptyDataRowStyle-CssClass="empty-data-row">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate><span class="font-weight-bold"><%# Container.DataItemIndex + 1 %></span></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Department" DataField="DepartmentName" />
                                    <asp:BoundField HeaderText="Designation" DataField="Designation" />
                                    <asp:BoundField HeaderText="Grade" DataField="gradeName" />
                                    <asp:BoundField HeaderText="Emp Type" DataField="EmpType" />
                                    <asp:BoundField HeaderText="Category" DataField="CategoryName" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="Title" DataField="TitleNotification" />
                                    <asp:BoundField HeaderText="Body" DataField="BodyNotification" />
                                    <asp:BoundField HeaderText="Entry Date" DataField="EntryDate" DataFormatString="{0:dd MMM yyyy}" />
                                    <asp:BoundField HeaderText="Status" DataField="Status" />
                                      <asp:TemplateField HeaderText="Update Status" ShowHeader="False">
                                     <ItemTemplate >
                                        <asp:LinkButton ID="lnkbtneditEmp" runat="server" ForeColor="Green"  OnClick="lnkbtneditEmp_Click" CausesValidation="False"
                                            CommandName="Select" Text="Edit" ToolTip="Edit" Style="margin-right: 20px;"></asp:LinkButton>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            <asp:HiddenField ID="hdnEmp" runat="server" />
                        </div>
                    </div>

                </div> <!-- end card-body -->
            </div> <!-- end main-card -->
        </div> <!-- end container -->
    </form>

    <script runat="server">
        // Helper methods for category badges (UI only, backend logic untouched)
        protected string GetCategoryBadge(string categoryName)
        {
            if (string.IsNullOrEmpty(categoryName)) return "<span class='badge-category badge-other'>Other</span>";

            switch (categoryName.ToLower())
            {
                case "fee": return "<span class='badge-category badge-fee'>Fee</span>";
                case "register": return "<span class='badge-category badge-register'>Register</span>";
                case "exam": return "<span class='badge-category badge-exam'>Exam</span>";
                case "transport": return "<span class='badge-category badge-transport'>Transport</span>";
                case "hostel": return "<span class='badge-category badge-hostel'>Hostel</span>";
                default: return "<span class='badge-category badge-other'>" + categoryName + "</span>";
            }
        }

        protected string GetEmployeeCategoryBadge(string categoryName)
        {
            if (string.IsNullOrEmpty(categoryName)) return "<span class='badge-category badge-other'>Other</span>";

            if (categoryName.ToLower() == "circular")
                return "<span class='badge-category badge-circular'>Circular</span>";
            else
                return "<span class='badge-category badge-other'>" + categoryName + "</span>";
        }
    </script>
</body>
</html>