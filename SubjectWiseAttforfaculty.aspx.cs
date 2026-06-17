using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.ReportSource;
using CrystalDecisions.Shared;
using System.IO;
using System.Data;
using NewDAL;
public partial class Attendance_SubjectDailyAttendance : System.Web.UI.Page
{
    DbFunctions objFunc = new DbFunctions();
    DBManager objdb = new DBManager();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UID"] == null)
        {
            Response.Redirect("../error_404_2.html");
        }

        if (Session["InstID"].ToString() == null)
        {
            Response.Redirect("../error_404_2.html");
        }

        if (Session["SesnID"].ToString() == null)
        {
            Response.Redirect("../error_404_2.html");
        }
        if (!IsPostBack)
        {
            try
            {
                if (Context.Request.QueryString["title"] != null)
                {
                    lbltitle.InnerText = Context.Request.QueryString["title"].ToString();
                }
                objFunc.Fill_Alloted_Institutes(ddlInstitute, Context.Request.QueryString["inst_ids"].ToString(), "---Select---");
                ddlInstitute.Items.RemoveAt(0);
                ddlInstitute.SelectedValue = Session["InstID"].ToString();
                objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), "Student Attendance", " Faculty Visit Student Attendance", Convert.ToInt32(Session["instID"].ToString()));
                if (ddlInstitute.Items.Count > 1)
                {
                    divInst.Style.Add("display", "block");
                    ddlInstitute.Focus();           
                }
                else
                {
                    divInst.Style.Add("display", "none");
                    ddlCourse.Focus();
                }
                if (Context.Request.QueryString["PermissionType"] == "A")
                {
                    divFaculty.Style.Add("display", "block");
                    objFunc.FillDropdownlist(ddlFaculty, "EmpName", "FacultyId", "SELECT DISTINCT FacultySubjectChoice.FacultyId,dbo.Employee_Name(Employee_Master.empName, Employee_Master.MiddelName, Employee_Master.lastName)+' ('+ Employee_Master.empCode+')' as EmpName FROM FacultySubjectChoice INNER JOIN Employee_Master ON FacultySubjectChoice.FacultyId = Employee_Master.empId WHERE (FacultySubjectChoice.Approvalstatus = 'Approved') AND (FacultySubjectChoice.SessionID = '" + Session["SesnID"].ToString() + "') AND (Employee_Master.Status = N'Active') order by EmpName", "---Select Faculty---");
                }
                else
                {
                    divFaculty.Style.Add("display", "none");
                }
                ddlInstitute_SelectedIndexChanged(sender, e);
            }
            catch (Exception ex)
            {
                objFunc.MsgBox1(ex.Message, UpdatePanel1);
                return;
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (chkvalue() == "")
            {
                objFunc.MsgBox1("Select Section", UpdatePanel1);
                chkGroup.Focus();
                return;
            }
            if (ddlSubject.SelectedIndex == 0)
            {
                objFunc.MsgBox1("Select Subject", UpdatePanel1);
                ddlSubject.Focus();
                return;
            }

            if (txtdate.Text == "")
            {
                objFunc.MsgBox1("Enter Attendance Date", UpdatePanel1);
                txtdate.Focus();
                return;
            }
           
            if (ddlCategory.SelectedIndex == 0)
            {
                objFunc.MsgBox1("Select Class Type", UpdatePanel1);
                ddlCategory.Focus();
                return;
            }
            if (txtdate.Text != "")
            {
                if (Context.Request.QueryString["PermissionType"] != "A")
                {
                    DateTime selectedDate = DateTime.ParseExact(txtdate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    DateTime currentDate = DateTime.Now.Date;
                    if (selectedDate < currentDate)
                    {
                        objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty want to punced back date  Attendance of Course- " + ddlCourse.SelectedItem.Text + " Specialisation- " + Ddl_Specl.SelectedItem.Text + " Semester- " + Ddl_Semes.SelectedItem.Text + " Subject- " + ddlSubject.SelectedItem.Text + " Date- " + txtdate.Text, Convert.ToInt32(Session["instID"].ToString()));
                        objFunc.MsgBox1("Recording attendance for previous dates is restricted. Kindly choose todays date..!!", UpdatePanel1);
                        txtdate.Text = "";
                        return;
                    }
                }
            }
            if ( Convert.ToDateTime(txtdate.Text.Trim()) > DateTime.Now)
            {
                objFunc.MsgBox1("Attendance date can not be future date..!!", UpdatePanel1);
                txtdate.Focus();
                return;
            }
            DateTime date1 = DateTime.Now;
            DateTime date2 = Convert.ToDateTime(txtdate.Text);
            TimeSpan t1 = date1.Date - date2.Date;
            int NrOfDays = t1.Days;
            if (gvStudent.Rows.Count > 0)
            {
                int Flag = 0;
                if (btnSubmit.Text == "Submit")
                {
                    Flag = 1;
                    if (NrOfDays > int.Parse(hdndays.Value))
                    {
                        if (txtRes.Text.Trim() == "")
                        {
                            objFunc.MsgBox1("Please Enter Reason..!! You are permitted to mark attendance of  previous " + hdndays.Value + " days only, it is mantatory to give reason for late attendance entry..!!", UpdatePanel1);
                            div_reason.Style.Add("display", "block");
                            txtRes.Focus();
                            return;
                        }
                        else
                        {
                            div_reason.Style.Add("display", "none");
                        }
                        for (int k = 0; k < chkclassno.Items.Count; k++)
                        {
                            if (chkclassno.Items[k].Selected == true)
                            {
                                if (optNew.Checked == true)
                                {
                                    string chkExisting = objFunc.Get_details("select DateA from Temp_Student_Attendance where  CourseID='" + ddlCourse.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "' and DateA='" + txtdate.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and BatchId in (" + chkvalue() + ") and SpecID='" + Ddl_Specl.SelectedValue + "' and class1='" + chkclassno.Items[k].Value + "' and Period_type='" + ddlCategory.SelectedValue + "' and Inst_ID=" + ddlInstitute.SelectedValue + " ");

                                    if (chkExisting != "")
                                    {
                                        chkclassno.Items[k].Selected = false;
                                        objFunc.MsgBox1("Can Not Submit Record, Already Submitted Temporarily ...for " + chkclassno.Items[k].Text + " ", UpdatePanel1);
                                        return;
                                    }
                                }
                            }
                        }
                        objFunc.MsgBox("Attendance has been submitted temporary as you are late to mark it on time. it will be activated once approved by heigher authority", this);
                        objFunc.ExecuteDelete("insert into Attendance_Late_log (faculty_id,Attendance_date,Subject_id,entry_date,Reason,Status,InstID) values(" + Session["UID"].ToString() + ",'" + txtdate.Text + "'," + ddlSubject.SelectedValue + ",'" + DateTime.Now + "','" + txtRes.Text + "','Pending'," + ddlInstitute.SelectedValue + ")");
                        Flag = 3;
                    }
                }
                else
                {
                    Flag = 2;
                }
                int i;
                for (int j = 0; j < chkclassno.Items.Count; j++)
                {
                    if (chkclassno.Items[j].Selected == true)
                    {
                        List<AttendenceDM.Period_Attendence> objFill = new List<AttendenceDM.Period_Attendence>();
                        for (i = 0; i <= gvStudent.Rows.Count - 1; i++)
                        {
                            var item = new AttendenceDM.Period_Attendence();
                            item.ID = Int32.Parse(gvStudent.DataKeys[i].Values[2].ToString());
                            item.CourseID = int.Parse(ddlCourse.SelectedValue);
                            item.SpecID = int.Parse(Ddl_Specl.SelectedValue);
                            item.YearID = Int16.Parse(Ddl_Semes.SelectedValue);
                            item.SubjectID = int.Parse(ddlSubject.SelectedValue);
                            item.TopicID = 0;
                            item.SubTopicID = 0;
                            item.Types = "0";
                            item.DateA = Convert.ToDateTime(txtdate.Text);
                            item.BatchID = Int16.Parse(gvStudent.DataKeys[i].Values[1].ToString());
                            CheckBox chkStatus = (CheckBox)gvStudent.Rows[i].FindControl("Chkstatus");
                            if (chkStatus.Checked == true)
                            {
                                item.Absent = 0;
                                item.Present = 1;
                                item.Leave = 0;
                                item.Hday = 0;
                            }
                            else
                            {
                                item.Absent = 1;
                                item.Present = 0;
                                item.Leave = 0;
                                item.Hday = 0;
                            }
                            item.NA = 0;
                            item.StudentID = Int64.Parse(gvStudent.DataKeys[i].Value.ToString());
                            item.Inst_ID = int.Parse(ddlInstitute.SelectedValue);
                            item.SessionID = Session["SesnID"].ToString();
                            item.Class1 = chkclassno.Items[j].Value;
                            item.periodname = "0";
                            item.FacultyID = Int32.Parse(Fid.Value);
                            item.VenueID = 0;
                            item.UName = Session["U_name"].ToString();
                            item.UEDate = DateTime.Now.Date;
                            item.TicketNo = "0";
                            TextBox txtRemark = (TextBox)gvStudent.Rows[i].FindControl("txtRemark");
                            item.Remark = txtRemark.Text;
                            item.WeekID = 0;
                            item.PeriodNo = 0;
                            item.Period_Type = int.Parse(ddlCategory.SelectedValue);
                            item.ForwardTo = 0;
                            item.EnterForm = 4;
                            item.EgroupId = Int16.Parse(gvStudent.DataKeys[i].Values[3].ToString());
                            item.Flag = Flag;
                            objFill.Add(item);
                        }

                        Admin.AdministratorData.AuditDM audit = new Admin.AdministratorData.AuditDM();
                        audit.Action = Flag == 1 || Flag == 3 ? "N" : "U";
                        audit.Entry_Date = Convert.ToString(DateTime.Now.Date.ToString("dd-MMM-yyyy"));
                        audit.Entry_Time = String.Format(DateTime.Now.ToString("hh:mm:ss tt"));
                        audit.Form_Name = lbltitle.InnerText;
                        audit.ID = 0;
                        audit.InstituteID = Int32.Parse(ddlInstitute.SelectedValue);
                        audit.Record_ID = "0";
                        audit.SessionID = Session["sesnid"].ToString();
                        audit.User_ID = Session["U_name"].ToString();
                        AttendenceSVC objInsert = new AttendenceSVC();
                        string result = objInsert.InsertDailyAttRecords(objFill, audit);
                        if (result == "Student attendance saved successfully..!!")
                        {
                            objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty added Attendance of Course- " + ddlCourse.SelectedItem.Text + " Specialisation- " + Ddl_Specl.SelectedItem.Text + " Semester- " + Ddl_Semes.SelectedItem.Text + " Subject- " + ddlSubject.SelectedItem.Text + " Date- " + txtdate.Text + " Student Count- " + txtTotal.Text + " Present- " + txtPresent.Text + " Absent- " + txtAbsent.Text, Convert.ToInt32(Session["instID"].ToString()));
                        }
                        else if (result == "Student attendance updated successfully..!!")
                        {
                            objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty Updated Attendance of Course- " + ddlCourse.SelectedItem.Text + " Specialisation- " + Ddl_Specl.SelectedItem.Text + " Semester- " + Ddl_Semes.SelectedItem.Text + " Subject- " + ddlSubject.SelectedItem.Text + " Date- " + txtdate.Text + " Student Count- " + txtTotal.Text + " Present- " + txtPresent.Text + " Absent- " + txtAbsent.Text, Convert.ToInt32(Session["instID"].ToString()));
                        }
                        objFunc.MsgBox1(result, UpdatePanel1);
                    }
                }

                txtPresent.Text = string.Empty;
                txtAbsent.Text = string.Empty;
                txtTotal.Text = string.Empty;
                txtRes.Text = string.Empty;
                clear();
                gvStudent.DataSource = new Int32[0];
                gvStudent.DataBind();
            }
            else
            {
                objFunc.MsgBox1("Select Student", UpdatePanel1);
                return;
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (chkvalue() == "")
            {
                objFunc.MsgBox1("Select Section", UpdatePanel1);
                chkGroup.Focus();
                return;
            }
            if (ddlSubject.SelectedIndex == 0)
            {
                objFunc.MsgBox1("Select Subject", UpdatePanel1);
                ddlSubject.Focus();
                return;
            }

            if (txtdate.Text == "")
            {
                objFunc.MsgBox1("Enter Attendance Date", UpdatePanel1);
                txtdate.Focus();
                return;
            }
            if (ddlCategory.SelectedIndex == 0)
            {
                objFunc.MsgBox1("Select period Type", UpdatePanel1);
                ddlCategory.Focus();
                return;
            }
            DateTime date1 = DateTime.Now;
            DateTime date2 = Convert.ToDateTime(txtdate.Text);
            TimeSpan t1 = date1.Date - date2.Date;
            int NrOfDays = t1.Days;
            if (gvStudent.Rows.Count > 0)
            {
                int Flag = 4;
                List<AttendenceDM.Period_Attendence> objFill = new List<AttendenceDM.Period_Attendence>();
                for (int j = 0; j < chkclassno.Items.Count; j++)
                {
                    if (chkclassno.Items[j].Selected == true)
                    {
                        foreach (ListItem chkSec in chkGroup.Items)
                        {
                            if (chkSec.Selected == true)
                            {
                                var item = new AttendenceDM.Period_Attendence();
                                item.CourseID = int.Parse(ddlCourse.SelectedValue);
                                item.SpecID = int.Parse(Ddl_Specl.SelectedValue);
                                item.YearID = Int16.Parse(Ddl_Semes.SelectedValue);
                                item.SubjectID = int.Parse(ddlSubject.SelectedValue);
                                item.DateA = Convert.ToDateTime(txtdate.Text);
                                item.BatchID = Int16.Parse(chkSec.Value);
                                item.Inst_ID = int.Parse(ddlInstitute.SelectedValue);
                                item.SessionID = Session["SesnID"].ToString();
                                item.Class1 = chkclassno.Items[j].Value;
                                item.FacultyID = Int32.Parse(Fid.Value);
                                item.Period_Type = int.Parse(ddlCategory.SelectedValue);
                                item.Flag = Flag;
                                objFill.Add(item);
                            }
                        }
                    }
                }

                Admin.AdministratorData.AuditDM audit = new Admin.AdministratorData.AuditDM();
                audit.Action = "D";
                audit.Entry_Date = Convert.ToString(DateTime.Now.Date.ToString("dd-MMM-yyyy"));
                audit.Entry_Time = String.Format(DateTime.Now.ToString("hh:mm:ss tt"));
                audit.Form_Name = lbltitle.InnerText;
                audit.ID = 0;
                audit.InstituteID = Int32.Parse(ddlInstitute.SelectedValue);
                audit.Record_ID = "0";
                audit.SessionID = Session["sesnid"].ToString();
                audit.User_ID = Session["U_name"].ToString();

                AttendenceSVC objInsert = new AttendenceSVC();
                string result = objInsert.DeleteStudntAttendace(objFill, audit);
                objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty Deleted Student Attendance of Course- " + ddlCourse.SelectedItem.Text + " Specialisation- " + Ddl_Specl.SelectedItem.Text + " Semester- " + Ddl_Semes.SelectedItem.Text + " Subject- " + ddlSubject.SelectedItem.Text + " Date- " + txtdate.Text + " Student Count- " + txtTotal.Text + " Present- " + txtPresent.Text + " Absent- " + txtAbsent.Text, Convert.ToInt32(Session["instID"].ToString()));
                
                objFunc.MsgBox1(result, UpdatePanel1);

            }

            txtPresent.Text = string.Empty;
            txtAbsent.Text = string.Empty;
            txtTotal.Text = string.Empty;
            txtRes.Text = string.Empty;
            clear();
            gvStudent.DataSource = new Int32[0];
            gvStudent.DataBind();
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Text = "Submit";
            optEdit.Checked = false;
            optNew.Checked = true;
            clear();
            txtRes.Text = "";
            chkall_group.Checked = false;
            divAttendanceDetail.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    public void clear()
    {
        try
        {
            if (ddlSubject.Items.Count > 0)
            {
                ddlSubject.SelectedIndex = 0;
            }
            divAttendanceDetail.Style.Add("display", "none");
            divlnkbutton.Style.Add("display", "none");
            txtPresent.Text = string.Empty;
            txtAbsent.Text = string.Empty;
            txtTotal.Text = string.Empty;
            txtdate.Text = "";
            for (int i = 0; i < chkGroup.Items.Count; i++)
            {
                if (chkGroup.Items[i].Selected == true)
                    chkGroup.Items[i].Selected = false;
            }
            for (int i = 0; i < chkclassno.Items.Count; i++)
            {
                if (chkclassno.Items[i].Selected == true)
                    chkclassno.Items[i].Selected = false;
            }
            gvStudent.DataSource = new Int32[0];
            gvStudent.DataBind();
            chkall_group.Checked = false;
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void gvStudent_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowIndex == 0)
                {
                    e.Row.Style.Add("height", "40px");
                }
                CheckBox chkStatus = (CheckBox)e.Row.FindControl("Chkstatus");
                chkStatus.Attributes.Add("onclick", "opA(this)");
                if (chkStatus.Checked == true)
                {
                    if (txtPresent.Text == "")
                    {
                        txtPresent.Text = "0";
                    }
                    txtPresent.Text = (Int16.Parse(txtPresent.Text.ToString()) + 1).ToString();
                }
                else
                {
                    if (txtAbsent.Text == "")
                    {
                        txtAbsent.Text = "0";
                    }
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[6].ForeColor = System.Drawing.Color.Red;
                    chkStatus.ForeColor = System.Drawing.Color.Red;
                    chkStatus.Text = "A";
                    txtAbsent.Text = (Int16.Parse(txtAbsent.Text.ToString()) + 1).ToString();
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    //----------------------------------------------------------------------------------------------------------------------------------------------------
    protected void cmdPrint_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = objFunc.FillDataTable("Select * from attendance_PrintNew where courseid='" + ddlCourse.SelectedValue + "' and semesterID='" + Ddl_Semes.SelectedValue + "' and PeriodID='" + ddlCategory.SelectedValue + "' and Subjectid='" + ddlSubject.SelectedValue + "' and EnterFrom='4' and Inst_ID=" + ddlInstitute.SelectedValue + "");
            if (dt.Rows.Count == 0)
            {
                objFunc.MsgBox1("No record found to print.", UpdatePanel1);
                return;
            }
            objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty Exported Report", Convert.ToInt32(Session["instID"].ToString()));
            int Abdent = 0;
            int Present = 0;
            Abdent = (int)dt.Compute("Count(absent)", "Absent=1");
            Present = (int)dt.Compute("Count(Present)", "Present=1");
            ReportDocument rpt1 = new ReportDocument();
            string spath = "";
            spath = Server.MapPath("Report\\AttendanceDaily.rpt");
            rpt1.Load(spath);
            rpt1.SetDataSource(dt);
            ((CrystalDecisions.CrystalReports.Engine.TextObject)rpt1.ReportDefinition.Sections["Section2"].ReportObjects["Text26"]).Text = Abdent.ToString();
            ((CrystalDecisions.CrystalReports.Engine.TextObject)rpt1.ReportDefinition.Sections["Section2"].ReportObjects["Text27"]).Text = Present.ToString();
            ((CrystalDecisions.CrystalReports.Engine.TextObject)rpt1.ReportDefinition.Sections["Section2"].ReportObjects["Text28"]).Text = dt.Rows.Count.ToString();
            ExportOptions exportOpts1 = rpt1.ExportOptions;
            rpt1.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
            rpt1.ExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
            rpt1.ExportOptions.DestinationOptions = new DiskFileDestinationOptions();
            string spath1 = Server.MapPath("Report\\");
            ((DiskFileDestinationOptions)rpt1.ExportOptions.DestinationOptions).DiskFileName = spath1 + "AttendanceDaily.pdf";
            rpt1.Export();
            rpt1.Close();
            rpt1.Dispose();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + "AttendanceDaily.pdf");
            Response.WriteFile(spath1 + "AttendanceDaily.pdf");
            Response.Flush();
            Response.End();
            Response.Close();
            File.Delete(Server.MapPath(spath1 + "\\AttendanceDaily.pdf"));
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            gvStudent.DataSource = null;
            gvStudent.DataBind();
            ddlCourse.SelectedValue = objFunc.Get_details("select distinct CourseId from facultysubjectchoice where SubjectID=" + ddlSubject.SelectedValue + " and FacultyId='" + Fid.Value + "' and sessionid = '" + Session["SesnID"].ToString() + "' and instituteid = '" + ddlInstitute.SelectedValue + "'");
            string subtype = objFunc.Get_details("select SubjectType  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
            string subCatType = objFunc.Get_details("select SubjectCatType  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
            string subCat = objFunc.Get_details("select SubjectCat  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
            if (subtype == "1")
            {
                objFunc.FillDropdownlist(ddlCategory, "Period_Type", "PeriodID", "select Period_Type,PeriodID from Period_Type_Master where status=1", "--select--");
                if (ddlCategory.Items.Count == 2 )
                {
                    ddlCategory.SelectedIndex = 1;
                    ddlCategory.Focus();                   
                }
                div_PeriodType.Style.Add("display", "block");
            }
            else
            {
                objFunc.FillDropdownlist(ddlCategory, "Period_Type", "PeriodID", "select Period_Type,PeriodID from Period_Type_Master where RTRIM(LTRIM(category))='Practical' and status=1", "--select--");
                if (ddlCategory.Items.Count == 2)
                {
                    ddlCategory.SelectedIndex = 1;
                    ddlCategory.Focus();
                }
                div_PeriodType.Style.Add("display", "block");
            }
            //if (subCatType == "Core")
            //{
                objFunc.FillCheckboxlist(chkGroup, "Batch_Name", "Batch_ID", "Select Distinct Batch_ID,Batch_Name from Batch_Master where InstituteID='" + ddlInstitute.SelectedValue + "' and CourseId='" + ddlCourse.SelectedValue + "' and Session='" + Session["SesnID"].ToString() + "'  and Semester='" + Ddl_Semes.SelectedValue + "' and SpecilizationID='" + Ddl_Specl.SelectedValue + "' and Batch_ID in (select Batch_ID from FacultySubjectChoice where FacultyId='" + Fid.Value + "' and SemesterID='" + Ddl_Semes.SelectedValue + "' and SpecilizationID='" + Ddl_Specl.SelectedValue + "' and Subjectid='" + ddlSubject.SelectedValue + "'and Approvalstatus='Approved' ) and InstituteID=" + ddlInstitute.SelectedValue + " order by Batch_ID");
            //}
            //else
            //{
            //    objFunc.FillCheckboxlist(chkGroup, "GroupName", "EgroupId", "select EgroupId,GroupName from ElectivSubGroup_Master where EgroupId in(select distinct EgroupId from ElectiveSubject_Student_Grouping where SubjectId=" + ddlSubject.SelectedValue + " and SubjectCategoryID=" + subCat + " and int_id='" + ddlInstitute.SelectedValue + "' and Course_Id='" + ddlCourse.SelectedValue + "' and Session_id ='" + Session["SesnID"].ToString() + "'  and sem_id='" + Ddl_Semes.SelectedValue + "' and spec_id='" + Ddl_Specl.SelectedValue + "') and Inst_ID=" + ddlInstitute.SelectedValue + "");
            //}
            if (chkGroup.Items.Count <= 0)
            {
                objFunc.MsgBox1("Student Grouping/Sectioning not done yet, first allot group/section..!!", UpdatePanel1);
                return;
            }
            else
            {
                divsection.Style.Add("display", "block");
                chkall_group.Visible = true;
                divfilter.Style.Add("display", "block");
                chkGroup.Focus();
            }
            SetFocus(ddlSubject);

            //i change there 30/11/23
            if (ddlCourse.SelectedIndex > 0 && ddlSubject.SelectedIndex > 0 && Ddl_Semes.SelectedIndex > 0)
            {
                DataTable AttendanceDetails = new DataTable();
                AttendanceDetails = objFunc.FillDataTable("SELECT DISTINCT CONVERT(nvarchar(12), DateA, 106) AS AttDate,DateA,class1 FROM Student_Attendance where facultyID='" + Session["UID"] + "' and CourseID='" + ddlCourse.SelectedValue + "' and SubjectID='" + ddlSubject.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "'  order by DateA,class1 desc ");
                if (AttendanceDetails.Rows.Count > 0)
                {
                    divlnkbutton.Style.Add("display", "block");
                    divAttendanceDetail.Style.Add("display", "block");
                    grdAttendance.DataSource = AttendanceDetails;
                    grdAttendance.DataBind();

                }
                else
                {
                    objFunc.MsgBox("No Attendance found...", this);
                    divlnkbutton.Style.Add("display", "none");
                    divAttendanceDetail.Style.Add("display", "none");
                    grdAttendance.DataSource = null;
                    grdAttendance.DataBind();
                }
            }
            //end
            

        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void optEdit_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            btnDelete.Visible = true;
            btnSubmit.Text = "Update";
            clear();
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void optNew_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            btnDelete.Visible = false;
            btnSubmit.Text = "Submit";
            clear();
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void ddldate_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlSubject.SelectedIndex = 0;
            SetFocus(txtdate);
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            txtAbsent.Text = "0";
            txtPresent.Text = "0";
            CheckBox chk = (CheckBox)gvStudent.HeaderRow.FindControl("chkall");
            if (chk.Checked == true)
            {
                int i;
                for (i = 0; i <= gvStudent.Rows.Count - 1; i++)
                {
                    CheckBox chkk = (CheckBox)gvStudent.Rows[i].FindControl("Chkstatus");
                    chkk.Checked = true;
                }
                txtPresent.Text = i.ToString();
            }
            else
            {
                int i;
                for (i = 0; i <= gvStudent.Rows.Count - 1; i++)
                {
                    CheckBox chkk = (CheckBox)gvStudent.Rows[i].FindControl("Chkstatus");
                    chkk.Checked = false;

                }
                txtAbsent.Text = i.ToString();
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    public string chkvalue()
    {
        string gsflag = "";
        foreach (ListItem grp in chkGroup.Items)
        {
            if (grp.Selected)
            {
                if (gsflag != "")
                {
                    gsflag = gsflag + "," + grp.Value;
                }
                else
                {
                    gsflag = grp.Value;
                }
            }
        }

        return gsflag;
    }

    protected void chkGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtdate.Text == "")
            {
                txtdate.Focus();
                objFunc.MsgBox1("Enter Attendance Date.", UpdatePanel1);
                return;
            }
            
DateTime selectedDate = DateTime.ParseExact(txtdate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture);

            DataTable dtExamName = objFunc.FillDataTable("SELECT TOP 1 ExamName FROM BackPaperScheduling WHERE SemesterId='" + Ddl_Semes.SelectedValue + "' AND CourseId='" + ddlCourse.SelectedValue + "' AND SpecilisationId='" + Ddl_Specl.SelectedValue + "' AND instId='" + ddlInstitute.SelectedValue + "' AND [Date] >= GETDATE() ORDER BY [Date]");

            if (dtExamName.Rows.Count > 0)
            {


                DataTable dtExam = objFunc.FillDataTable("SELECT MIN([Date]) AS ExamStartDate, MAX([Date]) AS ExamEndDate FROM BackPaperScheduling WHERE SemesterId='" + Ddl_Semes.SelectedValue + "' AND CourseId='" + ddlCourse.SelectedValue + "' AND SpecilisationId='" + Ddl_Specl.SelectedValue + "' AND instId='" + ddlInstitute.SelectedValue + "' AND ExamName='" + dtExamName.Rows[0]["ExamName"].ToString() + "'");

                if (dtExam.Rows.Count > 0 &&
                    dtExam.Rows[0]["ExamStartDate"] != DBNull.Value &&
                    dtExam.Rows[0]["ExamEndDate"] != DBNull.Value)
                {
                    DateTime examStartDate;
                    DateTime examEndDate;

                    if (DateTime.TryParse(dtExam.Rows[0]["ExamStartDate"].ToString(), out examStartDate) &&
                        DateTime.TryParse(dtExam.Rows[0]["ExamEndDate"].ToString(), out examEndDate))
                    {
                        DateTime lockDate = examStartDate.AddDays(-2);

                        if (selectedDate >= lockDate && selectedDate <= examEndDate)
                        {
                            objFunc.MsgBox1("Attendance cannot be marked during examination period..!!", UpdatePanel1);
                            btnSubmit.Enabled = false;
                            return;

                        }
                    }
                }
            }

            if (ddlCategory.SelectedIndex == 0)
            {
                ddlCategory.Focus();
                objFunc.MsgBox1("Select Period type.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            if (txtdate.Text == "")
            {
                txtdate.Focus();
                objFunc.MsgBox1("Enter Attendance Date.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            if (chkclassno.SelectedValue == "")
            {
                chkclassno.Focus();
                objFunc.MsgBox1("Please Select Class No.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            foreach (ListItem item in chkGroup.Items)
            {
                if (item.Selected == true)
                {
                    Boolean data = false;
                    string script = "<script language='javascript'>\n";
                    script += "Check();</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "msg", script, false);                  
                    string subCat = objFunc.Get_details("select SubjectCat  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
                    string subCatType = objFunc.Get_details("select SubjectCatType  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
                    List<AttendenceDM.FillStudentForAttendanceDM> objFill = new List<AttendenceDM.FillStudentForAttendanceDM>();
                    AttendenceSVC objSelect = new AttendenceSVC();
                    string value = chkvalue();
                    for (int i = 0; i < chkclassno.Items.Count; i++)
                    {
                        if (chkclassno.Items[i].Selected == true)
                        {
                            if (optNew.Checked == true)
                            {
                                data = false;
                                //if (subCatType == "Core")
                                //{
                                    string chkExisting = objFunc.Get_details("select DateA from Student_Attendance where  CourseID='" + ddlCourse.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "' and DateA='" + txtdate.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and BatchId in (" + chkvalue() + ") and SpecID='" + Ddl_Specl.SelectedValue + "' and class1='" + chkclassno.Items[i].Value + "' and Period_type='" + ddlCategory.SelectedValue + "' and Inst_ID=" + ddlInstitute.SelectedValue + " ");

                                    if (chkExisting != "")
                                    {
                                        chkclassno.Items[i].Selected = false;
                                        objFunc.MsgBox1("Record already exist for " + chkclassno.Items[i].Text + " ", UpdatePanel1);
                                        data = true;
                                    }
                                    else
                                    {
                                        if (ddlfilter.SelectedValue == "0")
                                        {
                                            objFill = objSelect.FillStudentForAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 0, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, Convert.ToInt32(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                        }
                                        else
                                        {
                                            objFill = objSelect.FillStudentForAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 0, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                        }
                                    } 
                                //}
                                //else
                                //{
                                //    string chkExisting = objFunc.Get_details("select DateA from Student_Attendance where  CourseID='" + ddlCourse.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "' and DateA='" + txtdate.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and EGROUPId in (" + chkvalue() + ") and SpecID='" + Ddl_Specl.SelectedValue + "' and class1='" + chkclassno.Items[i].Value + "' and Period_type='" + ddlCategory.SelectedValue + "' and Inst_ID=" + ddlInstitute.SelectedValue + "");

                                //    if (chkExisting != "")
                                //    {
                                //        chkclassno.Items[i].Selected = false;
                                //        objFunc.MsgBox1("Record already exist for " + chkclassno.Items[i].Text + " ", UpdatePanel1);
                                //        data = true;
                                //    }
                                //    else
                                //    {
                                //        objFill = objSelect.FillStudentForElectiveAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 0, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, Convert.ToInt32(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //    }
                                //}
                            }

                            else
                            {
                                //if (subCatType == "Core")
                                //{
                                    objFill = objSelect.FillStudentForAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 1, 1, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue),0, int.Parse(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //}
                                //else
                                //{
                                //    objFill = objSelect.FillStudentForElectiveAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 1, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), 0, Convert.ToInt32(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //}
                                btnSubmit.Text = "Update";
                            }
                        }
                    }
                    if (data == true)
                    {
                        for (int i = 0; i < chkGroup.Items.Count; i++)
                        {
                            if (chkGroup.Items[i].Selected == true)
                                chkGroup.Items[i].Selected = false;
                        }
                    }

                    txtPresent.Text = string.Empty;
                    txtTotal.Text = string.Empty;
                    txtAbsent.Text = string.Empty;
                    gvStudent.DataSource = objFill;
                    gvStudent.DataBind();
                    if (gvStudent.Rows.Count > 0)
                    {
                        div_gvStudent.Style.Add("display", "none");
                        btnSubmit.Enabled = true;
                        txtTotal.Text = gvStudent.Rows.Count.ToString();
                    }
                    else
                    {
                        div_gvStudent.Style.Add("display", "block");
                        btnSubmit.Enabled = false;
                        txtTotal.Text = "0";
                        txtAbsent.Text = "0";
                        txtPresent.Text = "0";
                        objFunc.MsgBox1("Student record not found.", UpdatePanel1);
                        return;
                    }                    
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void chkclassno_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string script = "<script language='javascript'>\n";
            script += "Check();</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "msg", script, false);
            int count = 0;
            if (optNew.Checked != true)
            {
                for (int i = 0; i < chkclassno.Items.Count; i++)
                {
                    if (chkclassno.Items[i].Selected == true)
                    {
                        count++;
                    }
                    if (count > 1)
                    {
                        objFunc.MsgBox1("You can update only one record at a time", UpdatePanel1);
                        chkclassno.Items[i].Selected = false;
                        return;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string script = "<script language='javascript'>\n";
            script += "Check();</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "msg", script, false);
            for (int i = 0; i < chkGroup.Items.Count; i++)
            {
                if (chkGroup.Items[i].Selected == true)
                    chkGroup.Items[i].Selected = false;
            }
            for (int i = 0; i < chkclassno.Items.Count; i++)
            {
                if (chkclassno.Items[i].Selected == true)
                    chkclassno.Items[i].Selected = false;
            }

            gvStudent.DataSource = new Int32[0];
            gvStudent.DataBind();
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void Ddl_Semes_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            objFunc.FillDropdownlist(Ddl_Specl, "shortName", "SpecilisationID", "SELECT shortName, SpecilisationID FROM  dbo.Specilisation where InstituteID='" + ddlInstitute.SelectedValue + "' and SpecilisationID in (select distinct SpecilizationID from FacultySubjectChoice where FacultyId='" + Fid.Value + "' and courseid='" + ddlCourse.SelectedValue + "' and SemesterID='" + Ddl_Semes.SelectedValue + "' and InstituteID='" + ddlInstitute.SelectedValue + "' and SessionID = '" + Session["SesnID"].ToString() + "' and Approvalstatus='Approved')", "--Select--");
            if (Ddl_Specl.Items.Count == 2)
            {
                div_Spl.Style.Add("display", "none");
                Ddl_Specl.SelectedIndex = 1;
                Ddl_Specl_SelectedIndexChanged(sender, e);
            }
            else
            {
                div_Spl.Style.Add("display", "block");
                Ddl_Specl.Focus();
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void Ddl_Specl_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            objFunc.FillDropdownlist(ddlSubject, "subjectName", "SubjectId", "Select distinct case when SubjectCode = '' then SubjectName else  SubjectName +' ( '+SubjectCode+' )' end as SubjectName,Subjectid from subject_vw where InstituteID='" + ddlInstitute.SelectedValue + "'and Courseid='" + ddlCourse.SelectedValue + "'  and SemesterID='" + Ddl_Semes.SelectedValue + "' and SpecilizationID='" + Ddl_Specl.SelectedValue + "' and SessionID='" + Session["SesnID"].ToString() + "' and Active='true' and subjectid in (select subjectid from FacultySubjectChoice where FacultyId='" + Fid.Value + "' and SemesterID='" + Ddl_Semes.SelectedValue + "' and SpecilizationID='" + Ddl_Specl.SelectedValue + "' and InstituteID = " + ddlInstitute.SelectedValue + " and SessionID = '" + Session["SesnID"].ToString() + "' and Approvalstatus='Approved')", "--Select--");
            ddlSubject.Focus();
            if (ddlSubject.Items.Count == 1)
            {
                objFunc.MsgBox1("No subject found for the selected filters..!!", UpdatePanel1);
                return;
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }

    protected void ddlInstitute_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(objFunc.Get_details("Select Org_Type from college where CollegeID = " + ddlInstitute.SelectedValue + "")) == 2)
            {
                div_Spl.Style.Add("display", "none");
                div_Sem.Style.Add("display", "none");
                lbl_ddlCourse.Text = "Class";
            }
            else
            {               
                lbl_ddlCourse.Text = "Course";
            }
            if (Context.Request.QueryString["PermissionType"] == "A")
            {
                string uid = objFunc.Get_details("SELECT UserCreation.emp_Id FROM UserCreation where UserCreation.UserId='" + ddlFaculty.SelectedValue+ "' and   UserCreation.Active='True' and InstituteID=" + ddlInstitute.SelectedValue + "");
                Fid.Value = uid;
            }
            else
            {
                string uid = objFunc.Get_details("SELECT UserCreation.emp_Id FROM UserCreation where UserCreation.UserId='" + Request.QueryString["uid"].ToString() + "' and   UserCreation.Active='True' and InstituteID=" + ddlInstitute.SelectedValue + "");
                Fid.Value = uid;
            }

            //if (Convert.ToInt32(objFunc.Get_details("select count(*) from Policy_Days where policy_Id=1 and instid=" + ddlInstitute.SelectedValue + "")) == 0)
            //{
            //    int TotalDays = 1;
            //    hdndays.Value = TotalDays.ToString();
            //}
            //else
            //{
            //    int TotalDays = Convert.ToInt32(objFunc.Get_details("select After_No_days from Policy_Days where policy_Id=1 and instid=" + ddlInstitute.SelectedValue + ""));
            //    hdndays.Value = TotalDays.ToString();
            //}
            hdndays.Value = "400";
            objFunc.FillDropdownlist(ddlCourse, "coursename", "courseid", "SELECT        Course.CourseId, Course.CourseName+' ('+SchoolMaster.ShortName+')' as CourseName FROM Course INNER JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID  where Course.InstituteID='" + ddlInstitute.SelectedValue + "' and Course.Courseid in (select distinct Courseid from FacultySubjectChoice where FacultyId='" + Fid.Value + "' and Approvalstatus='Approved' and InstituteID='" + ddlInstitute.SelectedValue + "' and sessionID = '" + Session["SesnID"].ToString() + "' )", "--Select--");
            Ddl_Specl.Items.Add("--Select--");
            Ddl_Semes.Items.Add("--Select--");
            ddlSubject.Items.Add("--Select--");
            if (ddlCourse.Items.Count == 2)
            {
                divCourse.Style.Add("display", "none");
                ddlCourse.SelectedIndex = 1;
                ddlCourse_SelectedIndexChanged(sender, e);
                Ddl_Specl.Focus();
            }
            else
            {
                divCourse.Style.Add("display", "block");
                ddlCourse.Focus();
                Ddl_Semes.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string ctype = objFunc.Get_details("select type from Course where courseid='" + ddlCourse.SelectedValue + "'");
            hdnctype.Value = ctype;
            if (ctype == "Both")
            {
                lblY.Text = "Year-Sem";
            }
            else if (ctype == "Year")
            {
                lblY.Text = "Year";
            }
            else if (ctype == "Semester")
            {
                lblY.Text = "Semester";
            }
            else if (ctype == "Trimester")
            {
                lblY.Text = "Year-Trimester";
            }

            objFunc.FillDropdownlist(Ddl_Semes, "yr", "sid", "select cast(Year as nvarchar(10))+'-'+CourseYear as yr,sid from Semester_View where courseid='" + ddlCourse.SelectedValue + "' and inst_id='" + ddlInstitute.SelectedValue + "' and sessionyear='" + Session["SesnID"].ToString() + "' and Active='true' and sid in (select distinct SemesterID from FacultySubjectChoice where FacultyId='" + Fid.Value + "' and Courseid='" + ddlCourse.SelectedValue + "' and InstituteID='" + ddlInstitute.SelectedValue + "' and SessionID='" + Session["SesnID"].ToString() + "'  and Approvalstatus='Approved' ) order by Year ", "--Select--");

            if (Ddl_Semes.Items.Count == 1)
            {
                objFunc.MsgBox1("" + lblY.Text + " not found for selected " + lbl_ddlCourse.Text + " and session.", UpdatePanel1);
                return;
            }
            if (Ddl_Semes.Items.Count == 2)
            {
                div_Sem.Style.Add("display", "none");
                Ddl_Semes.SelectedIndex = 1;
                Ddl_Semes_SelectedIndexChanged(sender, e);
                Ddl_Specl.Focus();
            }
            else
            {
                div_Sem.Style.Add("display", "block");
                Ddl_Semes.Focus();
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void chkall_group_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedIndex == 0)
            {
                ddlCategory.Focus();
                objFunc.MsgBox1("Select Period type.", UpdatePanel1);
                chkall_group.Checked = false;
                return;
            }
            if (txtdate.Text == "")
            {                               
                txtdate.Focus();
                objFunc.MsgBox1("Enter Attendance Date.", UpdatePanel1);
                chkall_group.Checked = false;
                return;
            }
            if(chkclassno.SelectedValue == "")
            {
                chkclassno.Focus();
                objFunc.MsgBox1("Please Select Class No.", UpdatePanel1);
                chkall_group.Checked = false;
                return;
            }
            if (chkall_group.Checked == true)
            {              
                 foreach (System.Web.UI.WebControls.ListItem item in chkGroup.Items)
                {                  
                   item.Selected = true;
                   chkGroup_SelectedIndexChanged(sender, e);
                }
            }
            else
            {
                foreach (System.Web.UI.WebControls.ListItem item in chkGroup.Items)
                {
                    item.Selected = false;
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    //i change there 30/11/23
    protected void lnkhide_Click(object sender, EventArgs e)
    {
        divAttendanceDetail.Style.Add("display", "none");
        divlnkbutton.Style.Add("display", "none");
    }
    //end

    protected void ddlsort_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedIndex == 0)
            {
                ddlCategory.Focus();
                objFunc.MsgBox1("Select Period type.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            if (txtdate.Text == "")
            {
                txtdate.Focus();
                objFunc.MsgBox1("Enter Attendance Date.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            if (chkclassno.SelectedValue == "")
            {
                chkclassno.Focus();
                objFunc.MsgBox1("Please Select Class No.", UpdatePanel1);
                for (int i = 0; i < chkGroup.Items.Count; i++)
                {
                    chkGroup.Items[i].Selected = false;
                }
                return;
            }
            foreach (ListItem item in chkGroup.Items)
            {
                if (item.Selected == true)
                {
                    Boolean data = false;
                    string script = "<script language='javascript'>\n";
                    script += "Check();</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "msg", script, false);
                    string subCat = objFunc.Get_details("select SubjectCat  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
                    string subCatType = objFunc.Get_details("select SubjectCatType  FROM  Subject_Mast where subjectid='" + ddlSubject.SelectedValue + "' and InstituteID=" + ddlInstitute.SelectedValue + "");
                    List<AttendenceDM.FillStudentForAttendanceDM> objFill = new List<AttendenceDM.FillStudentForAttendanceDM>();
                    AttendenceSVC objSelect = new AttendenceSVC();
                    string value = chkvalue();
                    for (int i = 0; i < chkclassno.Items.Count; i++)
                    {
                        if (chkclassno.Items[i].Selected == true)
                        {
                            if (optNew.Checked == true)
                            {
                                data = false;
                                //if (subCatType == "Core")
                                //{
                                string chkExisting = objFunc.Get_details("select DateA from Student_Attendance where  CourseID='" + ddlCourse.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "' and DateA='" + txtdate.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and BatchId in (" + chkvalue() + ") and SpecID='" + Ddl_Specl.SelectedValue + "' and class1='" + chkclassno.Items[i].Value + "' and Period_type='" + ddlCategory.SelectedValue + "' and Inst_ID=" + ddlInstitute.SelectedValue + " ");

                                if (chkExisting != "")
                                {
                                    chkclassno.Items[i].Selected = false;
                                    objFunc.MsgBox1("Record already exist for " + chkclassno.Items[i].Text + " ", UpdatePanel1);
                                    data = true;
                                }
                                else
                                {
                                    if (ddlsort.SelectedValue == "Name")
                                    {
                                        objFill = objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 0, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                    }
                                    if (ddlsort.SelectedValue == "UniversityRollNo")
                                    {
                                        objFill = objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 1, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                    }
                                    if (ddlsort.SelectedValue == "RegNo")
                                    {
                                        objFill = objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 2, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                    }
                                }
                                //}
                                //else
                                //{
                                //    string chkExisting = objFunc.Get_details("select DateA from Student_Attendance where  CourseID='" + ddlCourse.SelectedValue + "' and YearID='" + Ddl_Semes.SelectedValue + "' and DateA='" + txtdate.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and EGROUPId in (" + chkvalue() + ") and SpecID='" + Ddl_Specl.SelectedValue + "' and class1='" + chkclassno.Items[i].Value + "' and Period_type='" + ddlCategory.SelectedValue + "' and Inst_ID=" + ddlInstitute.SelectedValue + "");

                                //    if (chkExisting != "")
                                //    {
                                //        chkclassno.Items[i].Selected = false;
                                //        objFunc.MsgBox1("Record already exist for " + chkclassno.Items[i].Text + " ", UpdatePanel1);
                                //        data = true;
                                //    }
                                //    else
                                //    {
                                //        objFill = objSelect.FillStudentForElectiveAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 0, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), DateTime.Now.Date, value, Int16.Parse(Ddl_Specl.SelectedValue), 0, Convert.ToInt32(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //    }
                                //}
                            }

                            else
                            {
                                //if (subCatType == "Core")
                                //{
                              //  objFill = objSelect.FillStudentForAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 1, 1, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), int.Parse(ddlSubject.SelectedValue), 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //}
                                //else
                                //{
                                //    objFill = objSelect.FillStudentForElectiveAttendanceByBatch(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 1, 0, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), 0, Convert.ToInt32(ddlSubject.SelectedValue), int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                //}
                                if (ddlsort.SelectedValue == "Name")
                                {
                                    objFill = objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 4, 1, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), int.Parse(ddlSubject.SelectedValue), 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                }
                                if (ddlsort.SelectedValue == "UniversityRollNo")
                                {
                                    objFill = objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 5, 1, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), int.Parse(ddlSubject.SelectedValue), 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                }
                                if (ddlsort.SelectedValue == "RegNo")
                                {
                                    objSelect.FillStudentForAttendanceByBatchorder(Int32.Parse(ddlInstitute.SelectedValue), Int16.Parse(ddlCourse.SelectedValue), 6, 1, Int16.Parse(Ddl_Semes.SelectedValue), Session["SesnID"].ToString(), Convert.ToDateTime(txtdate.Text), value, Int16.Parse(Ddl_Specl.SelectedValue), int.Parse(ddlSubject.SelectedValue), 0, int.Parse(ddlCategory.SelectedValue), chkclassno.Items[i].Value);
                                }
                                btnSubmit.Text = "Update";
                            }
                        }
                    }
                    if (data == true)
                    {
                        for (int i = 0; i < chkGroup.Items.Count; i++)
                        {
                            if (chkGroup.Items[i].Selected == true)
                                chkGroup.Items[i].Selected = false;
                        }
                    }

                    txtPresent.Text = string.Empty;
                    txtTotal.Text = string.Empty;
                    txtAbsent.Text = string.Empty;
                    gvStudent.DataSource = objFill;
                    gvStudent.DataBind();
                    if (gvStudent.Rows.Count > 0)
                    {
                        div_gvStudent.Style.Add("display", "none");
                        btnSubmit.Enabled = true;
                        txtTotal.Text = gvStudent.Rows.Count.ToString();
                    }
                    else
                    {
                        div_gvStudent.Style.Add("display", "block");
                        btnSubmit.Enabled = false;
                        txtTotal.Text = "0";
                        txtAbsent.Text = "0";
                        txtPresent.Text = "0";
                        objFunc.MsgBox1("Student record not found.", UpdatePanel1);
                        return;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void ddlfilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        chkall_group.Checked = false;
        foreach (ListItem item in chkGroup.Items)
        {
            item.Selected = false; 
        }
        txtTotal.Text = "";
        txtAbsent.Text = "";
        txtPresent.Text = "";
        gvStudent.DataSource = null;
        gvStudent.DataBind();
    }
    protected void txtdate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (Context.Request.QueryString["PermissionType"] != "A")
            {
                DateTime selectedDate = DateTime.ParseExact(txtdate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
                DateTime currentDate = DateTime.Now.Date;
                if (selectedDate < currentDate)
                {
                    objFunc.FillActivityLog(Convert.ToInt32(Session["UID"]), " Student Attendance", " Faculty want to punced back date  Attendance of Course- " + ddlCourse.SelectedItem.Text + " Specialisation- " + Ddl_Specl.SelectedItem.Text + " Semester- " + Ddl_Semes.SelectedItem.Text + " Subject- " + ddlSubject.SelectedItem.Text + " Date- " + txtdate.Text, Convert.ToInt32(Session["instID"].ToString()));
                    objFunc.MsgBox1("Recording attendance for previous dates is restricted. Kindly choose todays date..!!", UpdatePanel1);
                    txtdate.Text = "";
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            objFunc.MsgBox1(ex.Message, UpdatePanel1);
            return;
        }
    }
    protected void ddlFaculty_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlInstitute_SelectedIndexChanged(sender, e);
    }
}