using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Academic_Scholarship_Master : System.Web.UI.Page
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
            objfun.FillDropdownlist(ddlCourseName, "CourseName", "CourseId", "SELECT  Course.CourseId,  Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName FROM  Course INNER JOIN SchoolMaster ON Course.CourseId = SchoolMaster.ID ORDER BY CourseName ASC", "--Select--");

            fillgrid();
        }
    
    }
 
    protected void btnSave_Click(object sender, EventArgs e)
    {

        if (txtScholarshipName.Text == "")
        {
            objfun.MsgBox("Please Enter Scholarship Name ", this);
            txtScholarshipName.Focus();
            return;
        }

        if (txtScholarshipCode.Text == "")
        {
            objfun.MsgBox("Please Enter Scholarship Code ", this);
            txtScholarshipCode.Focus();
            return;
        }


        if (btnSave.Text == "Submit")
        {
            
            int count = Convert.ToInt32(objfun.Get_details("select count(*) from Scholarship_Master where course_name='" + ddlCourseName.SelectedValue + "' and scholarship_name='" + txtScholarshipName.Text + "' and scholarship_code='" + txtScholarshipCode.Text + "'"));

            if (count > 0)
            {
                objfun.MsgBox("This Scholarship already assigned for this Course.", this);
                fillgrid();
                return;
            }
        }

        string courseName = "0";

        if (ddlCourseName.SelectedIndex > 0)
        {
            courseName = ddlCourseName.SelectedValue;
        }

        int insert = objfun.ExecuteDML("INSERT INTO Scholarship_Master (course_name, scholarship_name, scholarship_code, session, status, institute_id) VALUES ('" + courseName + "', '" + txtScholarshipName.Text + "', '" + txtScholarshipCode.Text + "' , '" + Session["SesnID"] + "' ,'Active', '" + Session["instID"] + "')");
        if (insert > 0)
        {
            objfun.MsgBox("Scholarship Data Submited Successfully...", this);
            fillgrid();
            Reset();
            return;
        }
    }

    public void Reset()
    {
        ddlCourseName.SelectedValue = "0";
        txtScholarshipName.Text = "";
        txtScholarshipCode.Text = "";
        btnSave.Text = "Submit";
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT Scholarship_Master.id, Scholarship_Master.scholarship_name, Scholarship_Master.scholarship_code, ISNULL(Course.CourseName + '(' + SchoolMaster.ShortName + ')','ALL') AS CourseName, Course.CourseId FROM SchoolMaster INNER JOIN Course ON SchoolMaster.ID = Course.School_ID RIGHT OUTER JOIN Scholarship_Master ON Course.CourseId = Scholarship_Master.course_name");
        if (dt.Rows.Count > 0)
        {
            gridview.DataSource = dt;
            gridview.DataBind();

        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
        }
    }
}