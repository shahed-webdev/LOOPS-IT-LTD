using System;
using System.Data;
using System.Web.UI;

namespace LoopsIT.Admin.Accounts
{
    public partial class Expense_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ExpnseReorder();
        }

        protected void ExpnseReorder()
        {
            DataView dv = (DataView)ViewExpanseSQL.Select(DataSourceSelectArguments.Empty);
            double reorderedProducts = (double)dv.Table.Rows[0][0];

            if (reorderedProducts > 0)
            {
                ExpnseLabel.Text = "Total Expense: " + reorderedProducts + " Tk";
            }
            else
            {
                ExpnseLabel.Text = "No Expense";
            }
        }
    }
}