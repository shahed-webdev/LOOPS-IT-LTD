using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin
{
    public partial class Expense_Saving : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ExpnseReorder();
        }


        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            ExpenseSavingSQL.Insert();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void ExpnseReorder()
        {
            DataView dv = (DataView)ViewExpanseSavingSQL.Select(DataSourceSelectArguments.Empty);
            double reorderedProducts = (double)dv.Table.Rows[0][0];
            if (reorderedProducts > 0)
            {
                ExpnseSavingLabel.Text = "Total Expense Saving: " + reorderedProducts + " Tk";
            }
            else
            {
                ExpnseSavingLabel.Text = "No Expense Saving";
            }
        }
    }
}