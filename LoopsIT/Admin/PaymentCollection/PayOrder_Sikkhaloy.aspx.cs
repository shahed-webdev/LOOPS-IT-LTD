using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class Sikkhaloy_PayOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CheckButton_Click(object sender, EventArgs e)
        {
            SikkhaloyGridView.DataBind();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());

            foreach (GridViewRow ROW in SikkhaloyGridView.Rows)
            {
                CheckBox SelectCheckbox = (CheckBox)ROW.FindControl("SelectCheckBox");

                SqlCommand MonthCmd = new SqlCommand("SELECT Institution.InstitutionName FROM  Income_Category INNER JOIN PayOrder ON Income_Category.IncomeCategoryID = PayOrder.IncomeCategoryID INNER JOIN  Institution ON PayOrder.InstitutionID = Institution.InstitutionID WHERE (Income_Category.IncomeCategoryName = N'Service Charge') AND (Institution.InstitutionName = @InstitutionName) AND (PayOrder.Month = FORMAT(@Month_Date, 'MMM yyyy'))", con);
                MonthCmd.Parameters.AddWithValue("@InstitutionName", SikkhaloyGridView.DataKeys[ROW.DataItemIndex]["SchoolName"].ToString());
                MonthCmd.Parameters.AddWithValue("@Month_Date", Convert.ToDateTime(DateTextBox.Text));

                con.Open();
                object Obj_InstitutionID = MonthCmd.ExecuteScalar();
                con.Close();

                if (Obj_InstitutionID != null)
                {
                    SelectCheckbox.Checked = false;
                    ROW.Enabled = false;
                    ROW.CssClass = "Payorder_Done";
                }
                else
                {
                    ROW.Enabled = true;
                    ROW.CssClass = "";
                }
            }
        }

        protected void PayOrderButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());

            bool SentMgsConfirm = false;
            int SentMsgCont = 0;
            int FailedMsgCont = 0;
            string InstitutionID = "";
            string IncomeCategoryID = "";

            foreach (GridViewRow ROW in SikkhaloyGridView.Rows)
            {
                CheckBox SelectCheckbox = (CheckBox)ROW.FindControl("SelectCheckBox");
                if (SelectCheckbox.Checked)
                {
                    SqlCommand MonthCmd = new SqlCommand("SELECT Institution.InstitutionName FROM  Income_Category INNER JOIN PayOrder ON Income_Category.IncomeCategoryID = PayOrder.IncomeCategoryID INNER JOIN  Institution ON PayOrder.InstitutionID = Institution.InstitutionID WHERE (Income_Category.IncomeCategoryName = N'Service Charge') AND (Institution.InstitutionName = @InstitutionName) AND (PayOrder.Month = FORMAT(@Month_Date, 'MMM yyyy'))", con);
                    MonthCmd.Parameters.AddWithValue("@InstitutionName", SikkhaloyGridView.DataKeys[ROW.DataItemIndex]["SchoolName"].ToString());
                    MonthCmd.Parameters.AddWithValue("@Month_Date", Convert.ToDateTime(DateTextBox.Text));

                    SqlCommand InstitutionIDcommand = new SqlCommand("SELECT InstitutionID FROM Institution WHERE (InstitutionName = @InstitutionName)", con);
                    InstitutionIDcommand.Parameters.AddWithValue("@InstitutionName", SikkhaloyGridView.DataKeys[ROW.DataItemIndex]["SchoolName"].ToString());


                    SqlCommand IncomeCategoryID_Cmd = new SqlCommand("SELECT IncomeCategoryID FROM  Income_Category WHERE (IncomeCategoryName = N'Service Charge')", con);

                    con.Open();
                    object Obj_Month = MonthCmd.ExecuteScalar();
                    object Obj_InstitutionID = InstitutionIDcommand.ExecuteScalar();
                    object Obj_IncomeCategoryID = IncomeCategoryID_Cmd.ExecuteScalar();
                    con.Close();

                    if (Obj_Month == null)
                    {
                        if (Obj_InstitutionID != null && Obj_IncomeCategoryID != null)
                        {
                            InstitutionID = Obj_InstitutionID.ToString();
                            IncomeCategoryID = Obj_IncomeCategoryID.ToString();

                            TextBox Total_StudentTextBox = (TextBox)ROW.FindControl("Total_StudentTextBox");
                            Label Per_Student_Rate_Label = (Label)ROW.FindControl("Per_Student_Rate_Label");

                            PayOrderSQL.InsertParameters["IncomeCategoryID"].DefaultValue = IncomeCategoryID;
                            PayOrderSQL.InsertParameters["InstitutionID"].DefaultValue = InstitutionID;
                            PayOrderSQL.InsertParameters["Unit"].DefaultValue = Total_StudentTextBox.Text;
                            PayOrderSQL.InsertParameters["UnitPrice"].DefaultValue = Per_Student_Rate_Label.Text;
                            PayOrderSQL.InsertParameters["Details"].DefaultValue = "Service Charge of " + Total_StudentTextBox.Text + " Students for: " + DateTextBox.Text;
                            PayOrderSQL.Insert();

                            SentMsgCont++;
                            SentMgsConfirm = true;
                            ROW.CssClass = "Payorder_Done";
                        }
                        else
                        {
                            ErrorLabel.Text = "";
                            ROW.CssClass = "Ins_Not_Added";
                            FailedMsgCont++;
                        }
                    }
                    else
                    {
                        ROW.CssClass = "Payorder_Done";
                        SelectCheckbox.Checked = false;
                        ROW.Enabled = false;
                    }
                }
            }

            if (SentMgsConfirm)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Pay order created " + SentMsgCont.ToString() + ".')", true);
            }
        }
    }
}