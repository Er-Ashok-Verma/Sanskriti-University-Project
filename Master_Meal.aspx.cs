using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Academic_Master_Meal : System.Web.UI.Page
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
            fillgrid();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtmealtype.Text == "")
        {
            objfun.MsgBox("Please Enter Meal Type ", this);
            txtmealtype.Focus();
            return;
        }

        if (btnSave.Text == "Submit")
        {

            string mealtype = objfun.Get_details("select MealType from mealType where mealType='" + txtmealtype.Text + "'");

            int count = Convert.ToInt32(objfun.Get_details("select count(*) from mealType where MealType='" + txtmealtype.Text + "'"));

            if (count > 0)
            {

                objfun.MsgBox("This Enter Meal alredy assign. ", this);
                txtmealtype.Text = "";
                return;
            }
            int insert = objfun.ExecuteDML("INSERT INTO mealType (MealType, Entryby, EntryDate) VALUES ('" + txtmealtype.Text + "', '" + Session["UID"] + "', '" + DateTime.Now + "')");

            if (insert > 0)
            {
                objfun.MsgBox("Meal Submited Successfully...", this);
                fillgrid();
                Reset();
                return;
            }
        }

        else
        {
            if (btnSave.Text == "Update")
            {

                string mealtype = objfun.Get_details("select MealType from mealType where MealType='" + txtmealtype.Text + "'");

                int mobcount = Convert.ToInt32(objfun.Get_details("select count(*) from mealType where MealType='" + txtmealtype.Text + "'"));

                if (mobcount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("This Enter Meal alredy assign. ", this);
                    txtmealtype.Text = "";
                    return;
                }

                int Updatecount = objfun.ExecuteDML("UPDATE mealType SET MealType = '" + txtmealtype.Text + "', UpdatedEntryBy ='" + Session["UID"] + "',UpdatedEntryDate='" + DateTime.Now + "'  WHERE ID='" + hidden.Value + "'");
                if (Updatecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("Enter Meal Update Successfully...", this);
                    Reset();
                    return;
                }
            }

        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    public void Reset()
    {
        txtmealtype.Text = "";
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT MealType.ID, MealType.MealType, ISNULL(CONVERT(VARCHAR, MealType.EntryDate, 106), 'N/A') AS EntryDate, ISNULL(CONVERT(VARCHAR, MealType.UpdatedEntryDate, 106), 'N/A') AS UpdatedEntryDate,  Employee_Master.empName + ' ' + Employee_Master.MiddelName + ' ' + Employee_Master.lastName AS EntryBy,  ISNULL(Employee_Master_1.empName + ' ' + Employee_Master_1.MiddelName + ' ' + Employee_Master_1.lastName, 'N/A') AS UpdatedEntryBy FROM Employee_Master INNER JOIN  MealType ON Employee_Master.empId = MealType.EntryBy LEFT OUTER JOIN  Employee_Master AS Employee_Master_1 ON MealType.UpdatedEntryBy = Employee_Master_1.empId");
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
    protected void lbtn_Click(object sender, EventArgs e)
    {

        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk.NamingContainer;

        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hidden.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("select * from mealType where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {

            txtmealtype.Text = dtedit.Rows[0]["MealType"].ToString();
            btnSave.Text = "Update";
        }
    }
}