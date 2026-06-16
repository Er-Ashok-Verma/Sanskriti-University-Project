using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Examination_ExamForm_filling_status : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

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

            objfun.FillDropdownlist(ddlSemester, "Semester", "SID", "SELECT Semester_View.SID, Semester_View.Year +' '+ Semester_View.CourseYear+' '+ '('+Semester_View.Batch+')' as Semester FROM StudentStatus INNER JOIN Semester_View ON StudentStatus.SemesterID = Semester_View.SID where (StudentStatus.StudentID = '" + Session["UID"] + "')", "--Select Semester--");
            DataFill();
            ddlSemester_SelectedIndexChanged(sender, e);
            fillgrid();

        }
    }

    public void DataFill()
    {
        DataTable Header = new DataTable();

        Header = objfun.FillDataTable("SELECT DISTINCT SchoolMaster.SchoolName, Course.CourseName, Specilisation.SpecilisationName, StudentStatus.StudentID, StudentReg.StudentName, StudentReg.FatherName, StudentStatus.SessionID, Semester_View.CourseYear,  StudentReg.RegNo ,Semester_View.Year FROM Specilisation INNER JOIN Course INNER JOIN StudentStatus INNER JOIN StudentReg ON StudentStatus.StudentID = StudentReg.StudentID ON Course.CourseId = StudentStatus.CourseID INNER JOIN Semester_View ON StudentStatus.SemesterID = Semester_View.SID ON Specilisation.SpecilisationID = StudentReg.Specialization INNER JOIN SchoolMaster ON Course.School_ID = SchoolMaster.ID where (StudentStatus.Status='C') AND (StudentStatus.StudentID = '" + Session["UID"] + "')");
        if (Header.Rows.Count > 0)
        {
            
                lblSchoolName.Text = Header.Rows[0]["SchoolName"].ToString().ToUpper();
                lblSession.Text = Header.Rows[0]["SessionID"].ToString().ToUpper();
                lblRegNumber.Text = Header.Rows[0]["RegNo"].ToString().ToUpper();
                lblStudentName.Text = Header.Rows[0]["StudentName"].ToString().ToUpper();
                lblFatherName.Text = Header.Rows[0]["FatherName"].ToString().ToUpper();
                lblCourseName.Text = Header.Rows[0]["CourseName"].ToString().ToUpper();
                lblSpecialization.Text = Header.Rows[0]["SpecilisationName"].ToString().ToUpper();
                lblYear.Text = Header.Rows[0]["Year"].ToString().ToUpper();
                ddlSemester.SelectedValue = objfun.Get_details("Select SemesterID from StudentStatus where StudentID='" + Session["UID"] + "' and Status='C'");

            }
        }

    public void fillgrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("SELECT DISTINCT ISNULL(ExamForm_LateFeeDetails.TranID,'N/A') AS TranID, ISNULL(StudentStatus.StudentID,'N/A') AS StudentID, ISNULL(CAST(ExamForm_LateFeeDetails.Amount AS NVARCHAR),'N/A') AS Amount, ISNULL(CONVERT(NVARCHAR(12), ExamForm_LateFeeDetails.TranDate, 106),'N/A') AS TranDate, ISNULL(ExamForm_LateFeeDetails.Receipt_No,'N/A') AS Receipt_No, ISNULL(ExamForm_Scheduler.Title_Name,'N/A') AS Title_Name, ISNULL(CONVERT(NVARCHAR(12), Student_FilledSubject_For_Examination.EntryDate, 106),'N/A') AS EntryDate, ISNULL(Student_FilledSubject_For_Examination.RegNo,'N/A') AS RegNo FROM Student_FilledSubject_For_Examination INNER JOIN StudentStatus ON Student_FilledSubject_For_Examination.StudentId = StudentStatus.StudentID INNER JOIN ExamForm_Scheduler ON Student_FilledSubject_For_Examination.FormSchedulerID = ExamForm_Scheduler.id LEFT OUTER JOIN ExamForm_LateFeeDetails ON Student_FilledSubject_For_Examination.StudentId = ExamForm_LateFeeDetails.StudentId AND Student_FilledSubject_For_Examination.SemesterId = ExamForm_LateFeeDetails.SemesterId where (StudentStatus.Status='C')  AND (StudentStatus.StudentID = '" + Session["UID"] + "') and Student_FilledSubject_For_Examination.SemesterId='" + ddlSemester.SelectedValue + "'");
        if (dt.Rows.Count > 0)
        {
            gridview.DataSource = dt;
            gridview.DataBind();
        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
            objfun.MsgBox("Record Not Found", this);

        }
    }
    protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        fillgrid();
    }
}

