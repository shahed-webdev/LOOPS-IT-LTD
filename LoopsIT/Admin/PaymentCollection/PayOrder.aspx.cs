using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class PayOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PayOrderButton_Click(object sender, EventArgs e)
        {

            if (CategoryDropDownList.SelectedItem.Text == "Service Charge")
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());

                SqlCommand MonthCmd = new SqlCommand("SELECT PayOrder.InstitutionID FROM  Income_Category INNER JOIN PayOrder ON Income_Category.IncomeCategoryID = PayOrder.IncomeCategoryID  WHERE (Income_Category.IncomeCategoryName = N'Service Charge') AND (PayOrder.InstitutionID = @InstitutionID) AND (PayOrder.Month = FORMAT(@Month_Date, 'MMM yyyy'))", con);
                MonthCmd.Parameters.AddWithValue("@InstitutionID", InstitutionDropDownList.SelectedValue);
                MonthCmd.Parameters.AddWithValue("@Month_Date", Convert.ToDateTime(UseDateTextBox.Text));

                con.Open();
                object Obj_InstitutionID = MonthCmd.ExecuteScalar();
                con.Close();

                if (Obj_InstitutionID == null)
                {
                    if (MounthCheckBox.Checked)
                    {
                        PayOrderSQL.InsertParameters["Month_Date"].DefaultValue = Convert.ToDateTime(UseDateTextBox.Text).ToString("MMM yyyy");
                    }
                    PayOrderSQL.Insert();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('successfully Created')", true);

                }
                else
                {

                    ErrorLabel.Text = "Sevice Charge already Created for this instution";
                }
            }
            else
            {
                if (MounthCheckBox.Checked)
                {
                    PayOrderSQL.InsertParameters["Month_Date"].DefaultValue = Convert.ToDateTime(UseDateTextBox.Text).ToString("MMM yyyy");
                }
                PayOrderSQL.Insert();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('successfully Created')", true);
            }


        }
    }
}