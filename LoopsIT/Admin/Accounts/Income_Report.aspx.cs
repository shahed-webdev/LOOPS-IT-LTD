using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.Accounts
{
    public partial class Income_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Income_view();
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

        protected void InstitutionDropDownList_DataBound(object sender, EventArgs e)
        {
            InstitutionDropDownList.Items.Insert(0, new ListItem("[ SELECT INSTITUTION ]", "%"));
            Income_view();
        }
    }
}