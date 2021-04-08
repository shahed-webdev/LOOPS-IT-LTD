using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class Invoice_Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Income_view();
        }

        protected void Income_view()
        {
            DataView dv = (DataView)View_PayOrderSQL.Select(DataSourceSelectArguments.Empty);
            double Amount = (double)dv.Table.Rows[0][0];

            if (Amount > 0)
            {
                IncomeLabel.Text = "Not Created Invoice : " + Amount + " Tk";
            }
            else
            {
                IncomeLabel.Text = "All Invoice Created";
            }
        }

        protected void InstitutionDropDownList_DataBound(object sender, EventArgs e)
        {
            InstitutionDropDownList.Items.Insert(0, new ListItem("[ Select Institution ]", "%"));
            Income_view();
        }

        protected void CreateButton_Click(object sender, EventArgs e)
        {
            InvoiceSQL.Insert();

            foreach (GridViewRow ROW in IncomeGridView.Rows)
            {
                CheckBox SelectCheckbox = (CheckBox)ROW.FindControl("SelectCheckBox");

                if (SelectCheckbox.Checked)
                {
                    InvoiceSQL.UpdateParameters["InvoiceID"].DefaultValue = ViewState["InvoiceID"].ToString();
                    InvoiceSQL.UpdateParameters["PayOrderID"].DefaultValue = IncomeGridView.DataKeys[ROW.DataItemIndex]["PayOrderID"].ToString();

                    InvoiceSQL.Update();
                }
            }

            IncomeGridView.DataBind();
        }

        protected void InvoiceSQL_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            ViewState["InvoiceID"] = e.Command.Parameters["@InvoiceID"].Value;
        }
    }
}