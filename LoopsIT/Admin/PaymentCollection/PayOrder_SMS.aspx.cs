using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class SMS_Recharge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PayOrderButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());

            bool SentMgsConfirm = false;
            int SentMsgCont = 0;
            int FailedMsgCont = 0;
            string InstitutionID = "";
            string IncomeCategoryID = "";

            foreach (GridViewRow ROW in SikkhaloySMS_GridView.Rows)
            {
                CheckBox SelectCheckbox = (CheckBox)ROW.FindControl("EduSingle_CheckBox");
                if (SelectCheckbox.Checked)
                {
                    SqlCommand InstitutionIDcommand = new SqlCommand("SELECT InstitutionID FROM Institution WHERE (InstitutionName = @InstitutionName)", con);
                    InstitutionIDcommand.Parameters.AddWithValue("@InstitutionName", SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["SchoolName"].ToString());


                    SqlCommand IncomeCategoryID_Cmd = new SqlCommand("SELECT IncomeCategoryID FROM  Income_Category WHERE (IncomeCategoryName = N'SMS')", con);

                    con.Open();

                    object Obj_InstitutionID = InstitutionIDcommand.ExecuteScalar();
                    object Obj_IncomeCategoryID = IncomeCategoryID_Cmd.ExecuteScalar();

                    con.Close();

                    if (Obj_InstitutionID != null && Obj_IncomeCategoryID != null)
                    {
                        InstitutionID = Obj_InstitutionID.ToString();
                        IncomeCategoryID = Obj_IncomeCategoryID.ToString();


                        PayOrderSQL.InsertParameters["IncomeCategoryID"].DefaultValue = IncomeCategoryID;
                        PayOrderSQL.InsertParameters["InstitutionID"].DefaultValue = InstitutionID;
                        PayOrderSQL.InsertParameters["Unit"].DefaultValue = SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["RechargeSMS"].ToString();
                        PayOrderSQL.InsertParameters["UnitPrice"].DefaultValue = SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["PerSMS_Price"].ToString();
                        PayOrderSQL.InsertParameters["UseDate"].DefaultValue = SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["Date"].ToString();
                        PayOrderSQL.InsertParameters["Details"].DefaultValue = SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["RechargeSMS"].ToString() + " SMS for " + SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["SchoolName"].ToString();
                        PayOrderSQL.Insert();

                        SikkhaloySMS_SQL.UpdateParameters["SMS_Recharge_RecordID"].DefaultValue = SikkhaloySMS_GridView.DataKeys[ROW.DataItemIndex]["SMS_Recharge_RecordID"].ToString();
                        SikkhaloySMS_SQL.Update();

                        SentMsgCont++;
                        SentMgsConfirm = true;
                    }
                    else
                    {
                        ErrorLabel.Text = "";
                        ROW.BackColor = System.Drawing.Color.Red;
                        FailedMsgCont++;
                    }
                }

            }

            foreach (GridViewRow ROW in TailorSMS_GridView.Rows)
            {
                CheckBox SelectCheckbox = (CheckBox)ROW.FindControl("SelectCheckBox");
                if (SelectCheckbox.Checked)
                {
                    SqlCommand InstitutionIDcommand = new SqlCommand("SELECT InstitutionID FROM Institution WHERE (InstitutionName = @InstitutionName)", con);
                    InstitutionIDcommand.Parameters.AddWithValue("@InstitutionName", TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["InstitutionName"].ToString());


                    SqlCommand IncomeCategoryID_Cmd = new SqlCommand("SELECT IncomeCategoryID FROM  Income_Category WHERE (IncomeCategoryName = N'SMS')", con);

                    con.Open();

                    object Obj_InstitutionID = InstitutionIDcommand.ExecuteScalar();
                    object Obj_IncomeCategoryID = IncomeCategoryID_Cmd.ExecuteScalar();

                    con.Close();

                    if (Obj_InstitutionID != null && Obj_IncomeCategoryID != null)
                    {
                        InstitutionID = Obj_InstitutionID.ToString();
                        IncomeCategoryID = Obj_IncomeCategoryID.ToString();


                        PayOrderSQL.InsertParameters["IncomeCategoryID"].DefaultValue = IncomeCategoryID;
                        PayOrderSQL.InsertParameters["InstitutionID"].DefaultValue = InstitutionID;
                        PayOrderSQL.InsertParameters["Unit"].DefaultValue = TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["RechargeSMS"].ToString();
                        PayOrderSQL.InsertParameters["UnitPrice"].DefaultValue = TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["PerSMS_Price"].ToString();
                        PayOrderSQL.InsertParameters["UseDate"].DefaultValue = TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["Date"].ToString();
                        PayOrderSQL.InsertParameters["Details"].DefaultValue = TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["RechargeSMS"].ToString() + " SMS for " + TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["InstitutionName"].ToString();
                        PayOrderSQL.Insert();

                        TailorSMS_SQL.UpdateParameters["SMS_Recharge_RecordID"].DefaultValue = TailorSMS_GridView.DataKeys[ROW.DataItemIndex]["SMS_Recharge_RecordID"].ToString();
                        TailorSMS_SQL.Update();

                        SentMsgCont++;
                        SentMgsConfirm = true;

                    }
                    else
                    {
                        ErrorLabel.Text = "";
                        ROW.BackColor = System.Drawing.Color.Red;
                        FailedMsgCont++;
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