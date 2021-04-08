using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin
{
    public partial class Income : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Income_view();
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            IncomeSQL.Insert();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void Income_view()
        {
            DataView dv = (DataView)View_IncomeSQL.Select(DataSourceSelectArguments.Empty);
            double Amount = (double)dv.Table.Rows[0][0];
            if (Amount > 0)
            {
               IncomeLabel.Text = "Total Income: " + Amount + " Tk";
            }
            else
            {
               IncomeLabel.Text = "No Income";
            }
        }
    }
}