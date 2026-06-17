using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SecurityBPO_SendInApp_Notification : System.Web.UI.Page
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
            chkS.Checked = true;
            chkF.Checked = true;

            objfun.FillActivityLog(Convert.ToInt32(Session["uid"]), "Send InApp Notification", "Visited Send InApp Notification Entry", Convert.ToInt32(Session["instID"].ToString()));
            ddlTypeFilter_SelectedIndexChanged(sender, e);

            objfun.FillDropdownlist(ddlSession, "Session", "Session", "SELECT SessionID, Session FROM Session order by Session", "--Select--");
            objfun.FillDropdownlist(ddlSchool, "SchoolName", "ID", "SELECT ID, SchoolName FROM SchoolMaster", "--Select--");


            objfun.FillDropdownlist(ddlDepartment, "DepartmentName", "DepartmentID", "SELECT DepartmentID, DepartmentName FROM Department", "--Select--");
            objfun.FillDropdownlist(ddlSalaryGrade, "gradeName", "id", "SELECT id, gradeName FROM Payroll_SalGrade", "--Select--");
            objfun.FillDropdownlist(ddlEmployeeType, "EmpType", "Id", "SELECT Id, EmpType FROM EmpType_Master", "--Select--");
            //fillgridStudent();
            //fillgridEmp();
        }

    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlCourse, "CourseName", "CourseId", "SELECT CourseId, CourseName FROM Course where Course.School_ID = '" + ddlSchool.SelectedValue + "'", "--Select--");
    }
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlsem, "CourseYear", "SID", "SELECT DISTINCT  Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS CourseYear, SID FROM Semester_View where Semester_View.CourseID = '" + ddlCourse.SelectedValue + "' and Semester_View.SessionYear ='" + ddlSession.SelectedItem.Text + "'", "--Select--");
        objfun.FillDropdownlist(ddlspeclization, "SpecilisationName", "SpecilisationID", "SELECT Specilisation.SpecilisationID, Specilisation.SpecilisationName FROM Specilisation INNER JOIN Course_spl ON Specilisation.SpecilisationID = Course_spl.SpecilizationID  where Course_spl.Courseid = '" + ddlCourse.SelectedValue + "'", "--Select--");
    }


    void Reset()
    {
        //ddlTypeFilter.SelectedValue = "0";
        ddlSession.SelectedValue = "0";
        ddlSchool.SelectedValue = "0";
        ddlCourse.Items.Clear();
        ddlsem.Items.Clear();
        ddlspeclization.Items.Clear();
        ddlCategory.SelectedValue = "";
        txtTitle.Text = "";
        txtbody.Text = "";
        ddlDepartment.SelectedValue = "0";
        ddlDesignation.Items.Clear();
        ddlSalaryGrade.SelectedValue = "0";
        ddlEmployeeType.SelectedValue = "0";
        ddlCategoryE.SelectedValue = "";
        txttitleE.Text = "";
        txtbodyE.Text = "";
        btSave.Text = "Send Notification";

        //ddlSession.Enabled = false;
        //ddlSchool.Enabled = false;
        //ddlCourse.Enabled = false;
        //ddlsem.Enabled = false;
        //ddlspeclization.Enabled = false;
        //ddlCategory.Enabled = false;
        //ddlCategory.Enabled = false;
        //txtTitle.Enabled = false;
        //txtbody.Enabled = false;
        //ddlDepartment.Enabled = false;
        //ddlDesignation.Enabled = false;
        //ddlSalaryGrade.Enabled = false;
        //ddlEmployeeType.Enabled = false;
        //ddlCategoryE.Enabled = false;
        //txttitleE.Enabled = false;
        //txtbodyE.Enabled = false;




    }

    public void fillgridStudent()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT InAppNotification_Student.ID, InAppNotification_Student.TitleNotification, InAppNotification_Student.BodyNotification, InAppNotification_Student.CategoryName, CONVERT(VARCHAR, InAppNotification_Student.EntryDateTime, 106) AS EntryDate,ISNULL( SchoolMaster.SchoolName,'ALL')AS SchoolName, ISNULL(Specilisation.SpecilisationName,'ALL')AS SpecilisationName, ISNULL(Semester_View.Year + '-' + Semester_View.CourseYear + '  (' + Semester_View.Batch + ')','ALL') AS Semester, ISNULL(Course.CourseName,'ALL') AS CourseName,  InAppNotification_Student.School_ID, InAppNotification_Student.CourseID, InAppNotification_Student.SemesterID, InAppNotification_Student.SpecilisationID, InAppNotification_Student.Status FROM InAppNotification_Student LEFT OUTER JOIN Semester_View ON InAppNotification_Student.SemesterID = Semester_View.SID LEFT OUTER JOIN Course ON InAppNotification_Student.CourseID = Course.CourseId LEFT OUTER JOIN Specilisation ON InAppNotification_Student.SpecilisationID = Specilisation.SpecilisationID LEFT OUTER JOIN SchoolMaster ON InAppNotification_Student.School_ID = SchoolMaster.ID");

        if (dt.Rows.Count > 0)
        {
            gridviewS.DataSource = dt;
            gridviewS.DataBind();

        }
        else
        {
            gridviewS.DataSource = null;
            gridviewS.DataBind();
            return;
        }
    }

    public void fillgridEmp()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT InAppNotification_Emp.ID, InAppNotification_Emp.CategoryName, InAppNotification_Emp.TitleNotification, InAppNotification_Emp.BodyNotification, CONVERT(VARCHAR,InAppNotification_Emp.EntryDateTime,106) AS EntryDate ,ISNULL(Department.DepartmentName,'ALL') AS DepartmentName,  ISNULL(master_Desig.Designation,'ALL') AS Designation, ISNULL(EmpType_Master.EmpType,'ALL') AS EmpType , ISNULL(Payroll_SalGrade.gradeName,'ALL') AS gradeName,  InAppNotification_Emp.DepartmentID, InAppNotification_Emp.DesignationID, InAppNotification_Emp.SalaryGradeID,  InAppNotification_Emp.EmpTypeID, InAppNotification_Emp.EntryDateTime,106,InAppNotification_Emp.Status FROM EmpType_Master RIGHT OUTER JOIN InAppNotification_Emp ON EmpType_Master.Id = InAppNotification_Emp.EmpTypeID LEFT OUTER JOIN Payroll_SalGrade ON InAppNotification_Emp.SalaryGradeID = Payroll_SalGrade.id LEFT OUTER JOIN master_Desig ON InAppNotification_Emp.DesignationID = master_Desig.DesigId LEFT OUTER JOIN Department ON InAppNotification_Emp.DepartmentID = Department.DepartmentID");

        if (dt.Rows.Count > 0)
        {
            gridviewF.DataSource = dt;
            gridviewF.DataBind();

        }
        else
        {
            gridviewF.DataSource = null;
            gridviewF.DataBind();
            return;
        }
    }



    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlDesignation, "Designation", "DesigId", "SELECT master_Desig.DesigId, master_Desig.Designation FROM Child_Desig INNER JOIN master_Desig ON Child_Desig.desigID = master_Desig.DesigId where Child_Desig.deptID = '" + ddlDepartment.SelectedValue + "'", "--Select--");
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (ddlTypeFilter.SelectedValue == "S")
        {


            if (ddlCategory.SelectedValue == "")
            {
                objfun.MsgBox("Please Select Category ", this);
                ddlCategory.ClearSelection();
                return;
            }

            if (txtTitle.Text == "")
            {
                objfun.MsgBox(" Enter Notification Title", this);
                txtTitle.Focus();
                return;
            }
            if (txtbody.Text == "")
            {
                objfun.MsgBox("Enter Notification body", this);
                txtbody.Focus();
                return;
            }
        }

        if (ddlTypeFilter.SelectedValue == "F")
        {

            if (ddlCategoryE.SelectedValue == "")
            {
                objfun.MsgBox("Please Select Category ", this);
                ddlCategoryE.ClearSelection();
                return;
            }

            if (txttitleE.Text == "")
            {
                objfun.MsgBox(" Enter Notification Title", this);
                txttitleE.Focus();
                return;
            }
            if (txtbodyE.Text == "")
            {
                objfun.MsgBox("Enter Notification body", this);
                txtbodyE.Focus();
                return;
            }
        }
        if (ddlTypeFilter.SelectedValue == "S")
        {
            string status = chkS.Checked ? "Active" : "Inactive";

            if (btSave.Text == "Update Stutas")
            {
                int Updatecount = objfun.ExecuteDML("UPDATE InAppNotification_student SET Status='" + status + "' WHERE ID='" + hndstudent.Value + "'");

                if (Updatecount > 0)
                {
                    fillgridStudent();
                    objfun.MsgBox("Status Update Successfully...", this);
                    Reset();
                    return;
                }
            }
            else
            {
                int insert = objfun.ExecuteDML("INSERT INTO InAppNotification_student (Session, School_ID, CourseID, SemesterID, SpecilisationID, CategoryID, TitleNotification, BodyNotification, CategoryName, EntryDateTime, EntryBy, Status) VALUES ('" + ddlSession.SelectedItem.Text + "', '" + ddlSchool.SelectedValue + "', '" + ddlCourse.SelectedValue + "' ,'" + ddlsem.SelectedValue + "','" + ddlspeclization.SelectedValue + "','" + ddlCategory.SelectedValue + "' ,'" + txtTitle.Text + "' , '" + txtbody.Text + "' ,'" + ddlCategory.SelectedItem.Text + "', '" + DateTime.Now + "' ,'" + Session["UID"] + "', '" + status + "')");

                if (insert > 0)
                {
                    objfun.MsgBox("Student Notification Submited Successfully...", this);
                    fillgridStudent();
                    Reset();
                }
            }
        }


        if (ddlTypeFilter.SelectedValue == "F")
        {
            string status = chkF.Checked ? "Active" : "Inactive";

            if (btSave.Text == "Update Stutas")
            {
                int Updatecount = objfun.ExecuteDML("UPDATE InAppNotification_Emp SET Status='" + status + "' WHERE ID='" + hdnEmp.Value + "'");

                if (Updatecount > 0)
                {
                    fillgridEmp();
                    objfun.MsgBox("Status Update Successfully...", this);
                    Reset();
                    return;
                }
            }
            else
            {
                int ins = objfun.ExecuteDML("INSERT INTO InAppNotification_Emp (DepartmentID, DesignationID, SalaryGradeID, EmpTypeID, CategoryID, CategoryName, TitleNotification, BodyNotification, EntryDateTime, EntryBy, Status) VALUES ('" + ddlDepartment.SelectedValue + "', '" + ddlDesignation.SelectedValue + "', '" + ddlSalaryGrade.SelectedValue + "' ,'" + ddlEmployeeType.SelectedValue + "','" + ddlCategoryE.SelectedValue + "','" + ddlCategoryE.SelectedItem.Text + "' ,'" + txttitleE.Text + "' , '" + txtbodyE.Text + "' ,'" + DateTime.Now + "' ,'" + Session["UID"] + "', '" + status + "')");

                if (ins > 0)
                {
                    objfun.MsgBox("Employee Notification Submited Successfully...", this);
                    fillgridEmp();
                    Reset();
                    return;
                }
            }
        }
    }
    protected void ddlTypeFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTypeFilter.SelectedValue == "F")
        {

            fillgridEmp();
            gridviewS.Style.Add("display", "none");
            gridviewF.Style.Add("display", "block");

            student.Style.Add("display", "none");
            employee.Style.Add("display", "block");
        }
        if (ddlTypeFilter.SelectedValue == "S")
        {
            fillgridStudent();
            gridviewF.Style.Add("display", "none");
            gridviewS.Style.Add("display", "block");

            employee.Style.Add("display", "none");
            student.Style.Add("display", "block");

        }


    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset(); 
        
       
    }
     protected void lnkbtneditStudent_Click(object sender, EventArgs e)
   
    {
        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk.NamingContainer;

        string id = gridviewS.DataKeys[row.RowIndex].Values[0].ToString();
        hndstudent.Value = id;

        DataTable dtedit = objfun.FillDataTable("SELECT * FROM InAppNotification_student WHERE ID='" + id + "'");

        if (dtedit.Rows.Count > 0)
        {
                
            ddlSession.SelectedItem.Text= dtedit.Rows[0]["Session"].ToString();
            ddlSchool.SelectedValue = dtedit.Rows[0]["School_ID"].ToString();
            ddlCourse.SelectedValue = dtedit.Rows[0]["CourseID"].ToString();
            ddlsem.SelectedValue = dtedit.Rows[0]["SemesterID"].ToString();
            ddlspeclization.SelectedValue = dtedit.Rows[0]["SpecilisationID"].ToString(); 
            ddlCategory.SelectedValue = dtedit.Rows[0]["CategoryID"].ToString();
            txtTitle.Text = dtedit.Rows[0]["TitleNotification"].ToString();
            txtbody.Text = dtedit.Rows[0]["BodyNotification"].ToString();

            string status = dtedit.Rows[0]["Status"].ToString();
            chkS.Checked = (status == "Active");

            btSave.Text = "Update Stutas";

            //ddlSession.Enabled = false;
            //ddlSchool.Enabled = false;
            //ddlCourse.Enabled = false;
            //ddlsem.Enabled = false;
            //ddlspeclization.Enabled = false;
            //ddlCategory.Enabled = false;
            //txtTitle.Enabled = false;
            //txtbody.Enabled = false;

            objfun.MsgBox("You can update only Status...", this);
        }
    }

     

     protected void lnkbtneditEmp_Click(object sender, EventArgs e)
    {
            LinkButton lnk = (LinkButton)sender;
            GridViewRow row = (GridViewRow)lnk.NamingContainer;

            string id = gridviewF.DataKeys[row.RowIndex].Values[0].ToString();
            hdnEmp.Value = id;

            DataTable dtedit = new DataTable();

            dtedit = objfun.FillDataTable("Select * from  InAppNotification_Emp where ID='" + id + "' ");
            if (dtedit.Rows.Count > 0)
            {
                ddlDepartment.SelectedItem.Text = dtedit.Rows[0]["DepartmentID"].ToString();
                ddlDesignation.SelectedValue = dtedit.Rows[0]["DesignationID"].ToString();
                ddlSalaryGrade.SelectedValue = dtedit.Rows[0]["SalaryGradeID"].ToString();
                ddlEmployeeType.SelectedValue = dtedit.Rows[0]["EmpTypeID"].ToString();
                ddlCategoryE.SelectedValue = dtedit.Rows[0]["CategoryID"].ToString(); 
                 txttitleE.Text = dtedit.Rows[0]["TitleNotification"].ToString();
                 txtbodyE.Text = dtedit.Rows[0]["BodyNotification"].ToString();
            
                 string status = dtedit.Rows[0]["Status"].ToString();
                      chkF.Checked = (status == "Active");
                      btSave.Text = "Update Stutas";

                      //ddlDepartment.Enabled = false;
                      //ddlDesignation.Enabled = false;
                      //ddlSalaryGrade.Enabled = false;
                      //ddlEmployeeType.Enabled = false;
                      //ddlCategoryE.Enabled = false;
                      //txttitleE.Enabled = false;
                      //txttitleE.Enabled = false;

                      objfun.MsgBox("You can update only Status...", this);
                      
            }
        }
    }
