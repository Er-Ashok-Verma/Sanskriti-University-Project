using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Fee_Scholarship_Waiveoff_Report : System.Web.UI.Page
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
            objfun.FillDropdownlist(ddlCourse,"CourseName","CourseId","SELECT  Course.CourseId,  Course.CourseName + ' (' + SchoolMaster.ShortName + ')' AS CourseName FROM  Course INNER JOIN SchoolMaster ON Course.CourseId = SchoolMaster.ID ORDER BY CourseName ASC", "--Select--");
            objfun.FillDropdownlist(ddlScheme, "scheme", "id", "SELECT 25 AS id, 'N/A' AS scheme UNION ALL SELECT id, scheme FROM Scholarship_Scheme", "--Select--");
            objfun.FillCheckboxlist(chkSession, "SessionID", "SessionID", "select distinct SessionID from StudentDiscountApproval where InstituteID= '" + Session["instID"].ToString() + "' order by SessionID");
            objfun.FillCheckboxlist(chkSession1, "SessionID", "SessionID", "select distinct SessionID from StudentReg where InstituteID= '" + Session["instID"].ToString() + "' order by SessionID");
            fillgrid();
        } 
    }

    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlsem, "Semester", "Sid", "SELECT DISTINCT StudentDiscountApproval.Sid, Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester FROM StudentDiscountApproval INNER JOIN Semester_View ON StudentDiscountApproval.Sid = Semester_View.SID WHERE Semester_View.CourseID = '" + ddlCourse.SelectedValue + "'" , "---Select---");

     } 
    public void Reset()
    {
        ddlCourse.SelectedValue = "0";
        ddlsem.SelectedValue = "0";
        ddlScheme.SelectedValue = "0";
        chkAllSession.Checked = false;
        chkSession.ClearSelection();
        chkAllSession1.Checked = false;
        chkSession1.ClearSelection();
    }


    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }


   protected void btnview_Click(object sender, EventArgs e)
{
    //if (ddlCourse.SelectedValue == "0")
    //{
    //    objfun.MsgBox("Please Select Course !", this);
    //    return;
    //}

    //if (ddlsem.SelectedValue == "0")
    //{
    //    objfun.MsgBox("Please Select Semester !", this);
    //    return;
    //}

    //if (ddlScheme.SelectedValue == "0")
    //{
    //    objfun.MsgBox("Please Select Scheme !", this);
    //    chkSession.ClearSelection();
    //    return;
    //}

    //if (!chkAllSession.Checked && chkSession.SelectedIndex == -1)
    //{
    //    objfun.MsgBox("Please Select Session !", this);
    //    return;
    //}

    
    fillgrid();
}


   private string condition()
   {
       string Where = "";

       if (ddlCourse.SelectedValue != "" && ddlCourse.SelectedValue != "0")
       {

           if (Where == "")
           {
               Where = "StudentDiscountApproval.CourseID='" + (ddlCourse.SelectedValue) + "'";
           }
           else
           {
               Where = Where + " and StudentDiscountApproval.CourseID='" + (ddlCourse.SelectedValue) + "'";
           }
       }

       if (ddlsem.SelectedValue != "" && ddlsem.SelectedValue != "0")
       {

           if (Where == "")
           {
               Where = "Semester_View.SID='" + (ddlsem.SelectedValue) + "'";
           }
           else
           {
               Where = Where + " and Semester_View.SID='" + (ddlsem.SelectedValue) + "'";
           }
       }

       if (ddlScheme.SelectedValue != "" && ddlScheme.SelectedValue != "0")
       {
           if (ddlScheme.SelectedValue == "25")
           {
               if (Where == "")
               {
                   Where = "Scholarship_Scheme.id IS NULL";
               }
               else
               {
                   Where = Where + " and Scholarship_Scheme.id IS NULL";
               }
           }
           else
           {
               if (Where == "")
               {
                   Where = "Scholarship_Scheme.id='" + (ddlScheme.SelectedValue) + "'";
               }
               else
               {
                   Where = Where + " and Scholarship_Scheme.id='" + (ddlScheme.SelectedValue) + "'";
               }
           }
       }


       if (hdnsession.Value != "")
           {
               if (Where == "")
               {
                   Where = " StudentDiscountApproval.SessionID in  (" + hdnsession.Value + ")";
               }
               else
               {
                   Where = Where + " and  StudentDiscountApproval.SessionID in  (" + hdnsession.Value + ")";
               }
           }


           if (hdnadmissionsession.Value != "")
           {
               if (Where == "")
               {
                   Where = " StudentReg.SessionID in  (" + hdnadmissionsession.Value + ")";
               }
               else
               {
                   Where = Where + " and  StudentReg.SessionID in  (" + hdnadmissionsession.Value + ")";
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
 
    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable(" SELECT Specilisation.SpecilisationName, FeeHead.FeeHeadName, ISNULL(Scholarship_Scheme.scheme, 'N/A') AS scheme, StudentReg.StudentID, StudentReg.StudentName, StudentReg.RegNo, StudentDiscountApproval.SessionID, CONVERT(VARCHAR, StudentReg.RegDate, 106) AS RegDate, Semester_View.Year + '-' + Semester_View.CourseYear + ' (' + Semester_View.Batch + ')' AS Semester,  Employee_Master.empName + ' ' + Employee_Master.MiddelName + ' ' + Employee_Master.lastName AS EmployeeName, Course.CourseName + ' (' + SchoolMaster_1.ShortName + ')' AS CourseName,  StudentDiscountApproval.DiscountAmt FROM Semester_View INNER JOIN SchoolMaster AS SchoolMaster_1 INNER JOIN StudentDiscountApproval INNER JOIN Course ON StudentDiscountApproval.CourseID = Course.CourseId INNER JOIN Employee_Master ON StudentDiscountApproval.EntryBy = Employee_Master.empId ON SchoolMaster_1.ID = Course.School_ID INNER JOIN FeeHead ON StudentDiscountApproval.FeeID = FeeHead.FeeHeadId ON Semester_View.SID = StudentDiscountApproval.Sid INNER JOIN Specilisation INNER JOIN StudentReg ON Specilisation.SpecilisationID = StudentReg.Specialization ON StudentDiscountApproval.StudentID = StudentReg.StudentID LEFT OUTER JOIN Scholarship_Scheme ON StudentDiscountApproval.ScholarshipScheme = Scholarship_Scheme.id " + condition() + " ORDER BY StudentReg.StudentName");
        
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


    protected void chkAllSession1_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkAllSession1.Checked == true)
            {
                foreach (ListItem item in chkSession1.Items)
                {
                    item.Selected = true;
                    chkSession1_SelectedIndexChanged(sender, e);
                }
            }
            else
            {
                foreach (System.Web.UI.WebControls.ListItem item in chkSession1.Items)
                {
                    item.Selected = false;
                }
            }
            chkAllSession1.Focus();
        }

        catch (Exception Ex)
        {
            ExceptionMsg.InnerText = "ERROR MESSAGE-: " + Ex.Message;
            ExceptionMsg.Style.Add("display", "block");

        }


    }

    protected void chkSession1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string Session = "";

            foreach (ListItem item in chkSession1.Items)
            {
                if (item.Selected)
                {
                    if (item.Value != " ")
                    {
                        Session += "'" + item.Value + "'" + ",";
                    }
                }

            }
            Session = Session.TrimEnd(',');
            hdnadmissionsession.Value = Session;

        }
        catch (Exception ex)
        {
            ExceptionMsg.InnerText = "ERROR MESSAGE-: " + ex.Message;
            ExceptionMsg.Style.Add("display", "block");

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
                    if (item.Value != " ")
                    {
                        Session += "'" + item.Value + "'" + ",";
                    }
                }

            }
            Session = Session.TrimEnd(',');
            hdnsession.Value = Session;

        }
        catch (Exception ex)
        {
            ExceptionMsg.InnerText = "ERROR MESSAGE-: " + ex.Message;
            ExceptionMsg.Style.Add("display", "block");

        }
    }
}
