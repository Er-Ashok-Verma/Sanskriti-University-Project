using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Fee_Students_Eligible_Fine : System.Web.UI.Page
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
        if (Context.Request.QueryString["title"] != null)
        {
            lbltitle.InnerText = Context.Request.QueryString["title"].ToString();
        }
        if (!IsPostBack)
        {
            objfun.FillDropdownlist(ddlSchool, "SchoolName", "ID", "SELECT ID, SchoolName + ' (' + ShortName + ')' AS SchoolName FROM SchoolMaster", "--Select--");
            //   objfun.FillDropdownlist(ddlCourse, "CourseName", "CourseId", "SELECT DISTINCT Course.CourseId, Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName " + "FROM Course  INNER JOIN StudentRegDetail ON Course.CourseId = StudentRegDetail.CourseID  LEFT JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID  ORDER BY CourseName", "--Select--");
            //AllStudentfillgrid();
            //FineStudentfillgrid();
        }
    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlCourse, "CourseName", "CourseId", "SELECT DISTINCT Course.CourseId, Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName " + "FROM Course  INNER JOIN StudentRegDetail ON Course.CourseId = StudentRegDetail.CourseID  LEFT JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID WHERE Course.School_ID = '" + ddlSchool.SelectedValue + "'  ORDER BY CourseName", "--Select--");
        fineStudentgridview.DataSource = null;
        fineStudentgridview.DataBind();
        allstudentgridview.DataSource = null;
        allstudentgridview.DataBind();
        lblfine.Visible = false;
        lbleligiblefine.Visible = false;
    }

    public void AllStudentfillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT StudentReg.StudentID,StudentReg.StudentName, Course.CourseName, SchoolMaster.SchoolName, Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester, Specilisation.SpecilisationName, StudentStatus.RegNo FROM SchoolMaster INNER JOIN Course INNER JOIN Semester_View INNER JOIN Specilisation INNER JOIN StudentReg ON Specilisation.SpecilisationID = StudentReg.Specialization ON Semester_View.SID = StudentReg.Sid INNER JOIN StudentStatus ON StudentReg.StudentID = StudentStatus.StudentID ON Course.CourseId = StudentStatus.CourseID ON SchoolMaster.ID = Course.School_ID " + Condition() + " and StudentStatus.Status = 'C' and StudentStatus.StudentID not in (SELECT distinct StudentId FROM StudentFineCalculatetemptable WHERE StudentId IS NOT NULL)");

        if (dt.Rows.Count > 0)
        {
            allstudentgridview.DataSource = dt;
            allstudentgridview.DataBind();
            lblfine.Visible = true;
        }
        else
        {
            allstudentgridview.DataSource = null;
            allstudentgridview.DataBind();
            lblfine.Visible = false;
            objfun.MsgBox("Record not found!", this);
            return;
        }
    }
    public void FineStudentfillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT StudentReg.StudentName, Course.CourseName, SchoolMaster.SchoolName, Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester, Specilisation.SpecilisationName,  StudentFineCalculatetemptable.StudentId, StudentFineCalculatetemptable.RegNo FROM StudentFineCalculatetemptable INNER JOIN Specilisation INNER JOIN StudentReg ON Specilisation.SpecilisationID = StudentReg.Specialization ON StudentFineCalculatetemptable.StudentId = StudentReg.StudentID INNER JOIN StudentStatus ON StudentReg.StudentID = StudentStatus.StudentID INNER JOIN Course INNER JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID ON StudentStatus.CourseID = Course.CourseId INNER JOIN Semester_View ON StudentStatus.SemesterID = Semester_View.SID " + Condition() + " and StudentStatus.Status = 'C'");

        if (dt.Rows.Count > 0)
        {
            fineStudentgridview.DataSource = dt;
            fineStudentgridview.DataBind();
            lbleligiblefine.Visible = true;
        }
        else
        {
            fineStudentgridview.DataSource = null;
            fineStudentgridview.DataBind();
            lbleligiblefine.Visible = false;
            objfun.MsgBox("Record not found!", this);
            return;
        }
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        if (ddlSchool.SelectedValue == "0")
        {
            objfun.MsgBox("Please Select School !", this);
            return;
        }
        AllStudentfillgrid();
        FineStudentfillgrid();

    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    public void Reset()
    {
        ddlSchool.SelectedValue = "0";
        ddlCourse.SelectedValue = "0";
    }
    protected void btndelete_Click(object sender, EventArgs e)
    {
        int count = 0;

        foreach (GridViewRow row in fineStudentgridview.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chkdelete");

            if (chk != null && chk.Checked)
            {
                string StudentId = fineStudentgridview.DataKeys[row.RowIndex].Value.ToString();

                int deletecount = objfun.ExecuteDML("DELETE FROM StudentFineCalculatetemptable WHERE StudentId='" + StudentId + "'");

                if (deletecount > 0)
                {
                    count++;
                }
            }
        }

        if (count > 0)
        {
            AllStudentfillgrid();
            FineStudentfillgrid();
            objfun.MsgBox(count + " Record Deleted Successfully...", this);
        }
        else
        {
            objfun.MsgBox("Please select at least one record...", this);
        }
    }


    protected void btnadd_Click(object sender, EventArgs e)
    {
        int count = 0;

        for (int j = 0; j < allstudentgridview.Rows.Count; j++)
        {
            CheckBox chkallow = (CheckBox)allstudentgridview.Rows[j].FindControl("chkAdd");

            if (chkallow != null && chkallow.Checked)
            {
                string StudentId = allstudentgridview.DataKeys[j].Values[0].ToString();
                string RegNo = allstudentgridview.DataKeys[j].Values[1].ToString();

                int insert = objfun.ExecuteDML("INSERT INTO StudentFineCalculatetemptable (StudentId, RegNo, Entryby, EntryDate) VALUES('" + StudentId + "', '" + RegNo + "', '" + Session["UID"] + "', '" + DateTime.Now + "')");

                if (insert > 0)
                {
                    count++;
                }
            }
        }

        if (count > 0)
        {
            AllStudentfillgrid();
            FineStudentfillgrid();
            objfun.MsgBox(count + " Students successfully added in Fine Record.", this);
        }
    }

    private string Condition()
    {
        string Where = "";
        // School
        if (ddlSchool.SelectedValue != "" && ddlSchool.SelectedValue != "0")
        {
            if (Where == "")
            {
                Where = "SchoolMaster.ID ='" + ddlSchool.SelectedValue + "'";
            }
            else
            {
                Where += " AND SchoolMaster.ID ='" + ddlSchool.SelectedValue + "'";
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

        if (Where != "")
        {
            Where = " WHERE " + Where;
        }

        return Where;
    }
}
            
