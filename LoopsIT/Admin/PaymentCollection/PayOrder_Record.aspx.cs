using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class PayOrder_Record : System.Web.UI.Page
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
                IncomeLabel.Text = "Total : " + Amount + " Tk";
            }
            else
            {
                IncomeLabel.Text = "No Pay Order";
            }
        }

        protected void InstitutionDropDownList_DataBound(object sender, EventArgs e)
        {
            InstitutionDropDownList.Items.Insert(0, new ListItem("[ SELECT ]", "%"));
            Income_view();
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {

        }
    }
}