using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.Report
{
    public partial class Company_Analysis : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string Filter(ListBox LB)
        {
            string ids = "";
            foreach (ListItem item in LB.Items)
            {
                if (item.Selected)
                {
                    ids += item.Value + ",";
                }
            }
            return ids;
        }

        protected void Find_Button_Click(object sender, EventArgs e)
        {
            string ProjectIDs = Filter(Project_ListBox);
            string IncomeCategoryIDs = Filter(Income_ListBox);
            string ExpenseCategoryIDs = Filter(Expense_ListBox);

            IncomeSQL.SelectParameters["ProjectIDs"].DefaultValue = ProjectIDs;
            IncomeSQL.SelectParameters["IncomeCategoryIDs"].DefaultValue = IncomeCategoryIDs;

            ExpenseSQL.SelectParameters["ExpenseCategoryIDs"].DefaultValue = ExpenseCategoryIDs;
        }

        protected void Month_Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var DetailsSQL = e.Item.FindControl("DetailsSQL") as SqlDataSource;
                DetailsSQL.SelectParameters["IncomeCategoryIDs"].DefaultValue = Filter(Income_ListBox);
            }
        }
    }
}