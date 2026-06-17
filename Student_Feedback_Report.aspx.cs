using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report_Student_Feedback_Report : System.Web.UI.Page
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
            if (Context.Request.QueryString["title"] != null)
            {
                lbltitle.InnerText = Context.Request.QueryString["title"].ToString();
            }
            objfun.FillDropdownlist(ddlCourse, "CourseName", "CourseId", " SELECT DISTINCT Course.CourseName, Course.CourseId FROM StudentFeedback_TextRatings INNER JOIN Course ON StudentFeedback_TextRatings.CourseID = Course.CourseId ORDER BY CourseName ASC", "--Select--");
            //objfun.FillDropdownlist(ddlSubject, "SubjectName", "SubjectID", "SELECT DISTINCT Subject_Mast.SubjectName, Subject_Mast.SubjectID FROM StudentFeedback_TextRatings INNER JOIN Subject_Mast ON StudentFeedback_TextRatings.SubjectID = Subject_Mast.SubjectID", "--Select--");
            //objfun.FillDropdownlist(ddlSubjectType, "SubjectTypeText", "SubjectType", "SELECT DISTINCT SubjectType, CASE WHEN SubjectType = 1 THEN 'Theory' WHEN SubjectType = 2 THEN 'Practical' END AS SubjectTypeText FROM StudentFeedback_TextRatings", "--Select--");
            
           // fillgrid();
        } 
    }

    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlsem, "CourseYear", "SID", "SELECT DISTINCT   Semester_View.Year +'-'+Semester_View.CourseYear+''+ '('+Semester_View.Batch+')' AS CourseYear, Semester_View.SID FROM StudentFeedback_TextRatings INNER JOIN Semester_View ON StudentFeedback_TextRatings.SemesterID = Semester_View.SID  WHERE Semester_View.CourseID = '" + ddlCourse.SelectedValue + "'", "---Select---");
        objfun.FillDropdownlist(ddlSpecialization, "SpecilisationName", "SpecilisationID", "SELECT DISTINCT Specilisation.SpecilisationName, Specilisation.SpecilisationID FROM StudentFeedback_TextRatings INNER JOIN Specilisation ON StudentFeedback_TextRatings.SpecializationID = Specilisation.SpecilisationID WHERE StudentFeedback_TextRatings.CourseID = '" + ddlCourse.SelectedValue + "'", "--Select--");
        objfun.FillDropdownlist(ddlSubjectType, "SubjectTypeText", "SubjectType", "SELECT DISTINCT SubjectType, CASE WHEN SubjectType = 1 THEN 'Theory' WHEN SubjectType = 2 THEN 'Practical' END AS SubjectTypeText FROM StudentFeedback_TextRatings WHERE CourseID = '" + ddlCourse.SelectedValue + "'", "--Select--");
    }

    protected void ddlSubjectType_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlSubject, "SubjectName", "SubjectID", "SELECT DISTINCT Subject_Mast.SubjectName, Subject_Mast.SubjectID FROM StudentFeedback_TextRatings INNER JOIN Subject_Mast ON StudentFeedback_TextRatings.SubjectID = Subject_Mast.SubjectID WHERE Subject_Mast.SubjectType = '" + ddlSubjectType.SelectedValue + "' AND StudentFeedback_TextRatings.CourseID = '" + ddlCourse.SelectedValue + "'", "--Select--");
    }

    
    protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
    { 
        objfun.FillDropdownlist(ddlTeacher, "EmployeeName", "empid", "SELECT DISTINCT Dbo.Employee_Name(Employee_Master.empName,Employee_Master.MiddelName,Employee_Master.lastName+' ('+Employee_Master.empCode+')') AS EmployeeName,Employee_Master.empId FROM StudentFeedback_TextRatings INNER JOIN Employee_Master ON StudentFeedback_TextRatings.TeacherID=Employee_Master.empId WHERE StudentFeedback_TextRatings.SubjectID='" + ddlSubject.SelectedValue + "'", "--Select--"); 
    }

    public void Reset()
    {
        ddlCourse.SelectedValue = "0";
        ddlsem.SelectedValue = "0";
        ddlSubject.SelectedValue = "0";
        ddlSubjectType.SelectedValue = "0";
        ddlTeacher.SelectedValue = "0";
        ddlSpecialization.SelectedValue = "0";

        
    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT RegisterNo, StudentName, FatherName, Rating1, Rating2, Rating3, Rating4, Rating5, Rating6, Rating7, Rating8, CASE WHEN ISNULL(Suggestion1,'') = '' THEN 'N/A' ELSE Suggestion1 END AS Suggestion1,CASE WHEN ISNULL(Suggestion2,'') = '' THEN 'N/A' ELSE Suggestion2 END AS Suggestion2, CASE WHEN ISNULL(Suggestion3,'') = '' THEN 'N/A' ELSE Suggestion3 END AS Suggestion3, CASE WHEN ISNULL(Suggestion4,'') = '' THEN 'N/A' ELSE Suggestion4 END AS Suggestion4, CASE WHEN ISNULL(Suggestion5,'') = '' THEN 'N/A' ELSE Suggestion5 END AS Suggestion5, CONVERT(VARCHAR, StudentFeedback_TextRatings.CreatedDate, 106) AS CreatedDate FROM StudentFeedback_TextRatings " + Condition() + "");

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
        string Where = "";

        if (ddlCourse.SelectedValue != "" && ddlCourse.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.CourseID='" + (ddlCourse.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.CourseID='" + (ddlCourse.SelectedValue) + "'";
            }
        }

        if (ddlsem.SelectedValue != "" && ddlsem.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.SemesterID='" + (ddlsem.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.SemesterID='" + (ddlsem.SelectedValue) + "'";
            }
        }

        if (ddlSpecialization.SelectedValue != "" && ddlSpecialization.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.SpecializationID='" + (ddlSpecialization.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.SpecializationID='" + (ddlSpecialization.SelectedValue) + "'";
            }
        }

        if (ddlSubject.SelectedValue != "" && ddlSubject.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.SubjectID='" + (ddlSubject.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.SubjectID='" + (ddlSubject.SelectedValue) + "'";
            }
        }

        if (ddlSubjectType.SelectedValue != "" && ddlSubjectType.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.SubjectType='" + (ddlSubjectType.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.SubjectType='" + (ddlSubjectType.SelectedValue) + "'";
            }
        }

        if (ddlTeacher.SelectedValue != "" && ddlTeacher.SelectedValue != "0")
        {

            if (Where == "")
            {
                Where = "StudentFeedback_TextRatings.TeacherID='" + (ddlTeacher.SelectedValue) + "'";
            }
            else
            {
                Where = Where + " and StudentFeedback_TextRatings.TeacherID='" + (ddlTeacher.SelectedValue) + "'";
            }
        }
        
        if (Where != "")
        {
            Where = "where " + Where;
        }
        else
        {
            Where = "";
        }
        return Where;

    }
    protected void btnview_Click(object sender, EventArgs e)
    {
         
        fillgrid();
    }

   
}