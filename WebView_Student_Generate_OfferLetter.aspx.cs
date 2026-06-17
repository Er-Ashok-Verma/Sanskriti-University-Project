using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class student_WebView_Student_Generate_OfferLetter : System.Web.UI.Page
{
    DbFunctions objFun = new DbFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Context.Request.QueryString["title"] != null)
            {
                lbltitle.InnerText = Context.Request.QueryString["title"].ToString();
            }

            if (Session["UID"] == null || Session["instID"] == null || Session["SesnID"] == null)
            {
                Response.Redirect("../error_404_2.html");
            }
 
            FillHeader();
        }
    }

    public void FillHeader()
    {
        DataTable ViewDetail = new DataTable();

        ViewDetail = objFun.FillDataTable("SELECT StudentReg.StudentID, StudentReg.StudentName, StudentReg.FatherName, StudentReg.ContactNo, Semester_View.CourseYear AS Semester, StudentStatus.SessionID, StudentStatus.YearID,  StudentFee_Setup_Choice.Fee_setup, Specilisation.SpecilisationName, Course.CourseName, AdmissionType.AdmType FROM StudentStatus INNER JOIN Semester_View ON StudentStatus.SemesterID = Semester_View.SID INNER JOIN StudentReg ON StudentReg.StudentID = StudentStatus.StudentID INNER JOIN Course ON StudentStatus.CourseID = Course.CourseId INNER JOIN AdmissionType ON StudentReg.AdmissionType = AdmissionType.AdmTypeID LEFT OUTER JOIN StudentDiscountApproval ON StudentStatus.StudentID = StudentDiscountApproval.StudentID LEFT OUTER JOIN StudentFee_Setup_Choice ON StudentStatus.StudentID = StudentFee_Setup_Choice.Student_id LEFT OUTER JOIN Specilisation ON StudentReg.Specialization = Specilisation.SpecilisationID WHERE StudentStatus.Status in ('C') AND StudentReg.InstituteID = '" + Session["instID"].ToString() + "'  AND StudentReg.StudentID = '" + Session["UID"] + "'");
        if (ViewDetail.Rows.Count > 0)
        { 
            lblstudentName.Text = ViewDetail.Rows[0]["StudentName"].ToString().ToUpper();
            lblFather.Text =  ViewDetail.Rows[0]["FatherName"].ToString().ToUpper();
            lblMobile.Text = ViewDetail.Rows[0]["ContactNo"].ToString().ToUpper();
            lblAdmissiontype.Text = ViewDetail.Rows[0]["AdmType"].ToString().ToUpper();
            lblCourse.Text = ViewDetail.Rows[0]["CourseName"].ToString().ToUpper();
            lblSpecialisation.Text = ViewDetail.Rows[0]["SpecilisationName"].ToString().ToUpper();
            lblSession.Text = ViewDetail.Rows[0]["SessionID"].ToString().ToUpper();
            //lblScholarship.Text = ViewDetail.Rows[0]["ScholarshipName"].ToString().ToUpper();
            //lblScheme.Text = ViewDetail.Rows[0]["Scheme"].ToString().ToUpper();
            lblYear.Text = ViewDetail.Rows[0]["YearID"].ToString().ToUpper();
            lblSemester.Text = ViewDetail.Rows[0]["Semester"].ToString().ToUpper();
            lblFeeSetupType.Text = ViewDetail.Rows[0]["fee_setup"].ToString().ToUpper();

        }
        else
        {
            objFun.MsgBox1("No record found to display..!!", UpdatePanel1);
            return;
        }
    }
}

    