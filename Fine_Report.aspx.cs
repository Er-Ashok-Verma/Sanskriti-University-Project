using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Academic_Fine_Report : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UID"] == null)
        {
            Response.Redirect("../error_404_2.html");
        }

        if (Session["instID"].ToString() == null)
        {
            Response.Redirect("../error_404_2.html");
        }

        if (Session["SesnID"].ToString() == null)
        {
            Response.Redirect("../error_404_2.html");
        }

        if (!IsPostBack)
        {

            objfun.FillCheckboxlist(chkSession, "SessionID", "SessionID", "select distinct SessionID from StudentRegDetail where InstituteID= '" + Session["instID"].ToString() + "' order by SessionID");
            objfun.FillDropdownlist(ddlSchool, "SchoolName", "ID", "SELECT ID, SchoolName + ' (' + ShortName + ')' AS SchoolName FROM SchoolMaster", "--Select--");
            objfun.FillDropdownlist(ddlCourse, "CourseName", "CourseId", "SELECT DISTINCT Course.CourseId, Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName FROM Course INNER JOIN StudentRegDetail ON Course.CourseId = StudentRegDetail.CourseID INNER JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID ORDER BY CourseName", "--Select--");       
            //fillgrid();
        } 
    }
    protected void chkAllSession_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllSession.Checked == true)
            {
                foreach (ListItem item in chkSession.Items)
                {
                    item.Selected = true;
                    chkSession_SelectedIndexChanged(sender, e);
                }
            }
            else
            {
                foreach (System.Web.UI.WebControls.ListItem item in chkSession.Items)
                {
                    item.Selected = false;
                }
            }
            chkAllSession.Focus();
        }

        catch (Exception Ex)
        {
            ExceptionMsg.InnerText = "ERROR MESSAGE-: " + Ex.Message;
            ExceptionMsg.Style.Add("display", "block");

        }
    }
    protected void chkSession_SelectedIndexChanged(object sender, EventArgs e)
    {
         try
        {
            string Session = "";

            foreach (ListItem item in chkSession.Items)
            {
                if (item.Selected)
                {
                    if (item.Value != "")
                    {
                        Session += "'" + item.Value + "'" + ",";
                    }
                }
            }
            Session = Session.TrimEnd(',');
            hiddensession.Value = Session;
        }
        catch (Exception ex)
        {
            ExceptionMsg.InnerText = "ERROR MESSAGE-: " + ex.Message;
            ExceptionMsg.Style.Add("display", "block");
        }
    
    }
    protected void ddlSchool_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlSchool.SelectedValue != "" && ddlSchool.SelectedValue != "0")
        {
            objfun.FillDropdownlist( ddlCourse, "CourseName","CourseId","SELECT DISTINCT Course.CourseId, Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName " + "FROM Course  INNER JOIN StudentRegDetail ON Course.CourseId = StudentRegDetail.CourseID  LEFT JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID WHERE Course.School_ID = '" + ddlSchool.SelectedValue + "'  ORDER BY CourseName", "--Select--" );
        }
    }
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlsem, "Semester", "Sid", " SELECT DISTINCT Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester, StudentRegDetail.Sid FROM Semester_View INNER JOIN StudentRegDetail ON Semester_View.SID = StudentRegDetail.Sid WHERE Semester_View.CourseID = '" + ddlCourse.SelectedValue + "'", "---Select---");
    }

    public void Reset()
    {
        chkAllSession.Checked = false;
        chkSession.ClearSelection();
        ddlSchool.SelectedValue = "0";
        ddlCourse.SelectedValue = "0";
        ddlsem.SelectedValue = "0";
         
        
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    protected void btnview_Click(object sender, EventArgs e)
    {
        if (!chkAllSession.Checked && chkSession.SelectedIndex == -1)
        {
            objfun.MsgBox("Please Select Session !", this);
            return;
        }
        fillgrid();
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT StudentReg.StudentName, StudentReg.RegNo, Course.CourseName, Specilisation.SpecilisationName,  Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester, StudentRegDetail.VoucherNo, StudentRegDetail.Narration, StudentRegDetail.TotalAmount,  StudentRegDetail.PaidAmount, StudentRegDetail.BalanceAmount, StudentRegDetail.StudentDetailID, ISNULL(Employee_Master.empName + ' ' + Employee_Master.MiddelName + ' ' + Employee_Master.lastName, 'N/A') AS EnrtyBy, CONVERT(VARCHAR, StudentReg.RegDate, 106) AS RegDate FROM Employee_Master INNER JOIN Specilisation INNER JOIN StudentReg ON Specilisation.SpecilisationID = StudentReg.Specialization INNER JOIN StudentRegDetail ON StudentReg.StudentID = StudentRegDetail.StudentID ON Employee_Master.empId = StudentRegDetail.EntryBy INNER JOIN StudentStatus ON StudentRegDetail.StudentID = StudentStatus.StudentID INNER JOIN Course ON StudentStatus.CourseID = Course.CourseId INNER JOIN Semester_View ON StudentStatus.SemesterID = Semester_View.SID " + Condition() + " ORDER BY StudentReg.StudentName");

        if (dt.Rows.Count > 0)
        {
            gridview.DataSource = dt;
            gridview.DataBind();

        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
            objfun.MsgBox("Record not found!", this);
            return;
        }
    }

    private string Condition()
    {
        string Where = "StudentRegDetail.FeeID = '22' and StudentStatus.Status='C' ";
        // session
        if (!string.IsNullOrEmpty(hiddensession.Value))
        {
            if (Where == "")
            {
                Where = "StudentRegDetail.SessionID IN (" + hiddensession.Value + ")";
            }
            else
            {
                Where += " AND StudentRegDetail.SessionID IN (" + hiddensession.Value + ")";
            }
        }

        // Course
        if (ddlCourse.SelectedValue != "" && ddlCourse.SelectedValue != "0")
        {
            if (Where == "")
            {
                Where = "StudentStatus.CourseID = '" + ddlCourse.SelectedValue + "'";
            }
            else
            {
                Where += " AND StudentStatus.CourseID = '" + ddlCourse.SelectedValue + "'";
            }
        }

        // Semester
        if (ddlsem.SelectedValue != "" && ddlsem.SelectedValue != "0")
        {
            if (Where == "")
            {
                Where = "StudentStatus.SemetserID = '" + ddlsem.SelectedValue + "'";
            }
            else
            {
                Where += " AND StudentStatus.SemetserID = '" + ddlsem.SelectedValue + "'";
            }
        }

        if (Where != "")
        {
            Where = " WHERE " + Where;
        }

        return Where;
    }
}