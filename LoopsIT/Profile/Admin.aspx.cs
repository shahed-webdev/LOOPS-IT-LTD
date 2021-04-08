using System;
using System.Web.UI.WebControls;

namespace LoopsIT.Profile
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void MonthlyAccont_GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Db = MonthlyAccont_GridView.DataKeys[e.Row.DataItemIndex]["Year"].ToString();
                double NET = Convert.ToDouble(MonthlyAccont_GridView.DataKeys[e.Row.DataItemIndex]["NET"]);

                if(NET<0)
                {
                    e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                }
                if (Db == "2015")
                {
                    e.Row.CssClass = "Year1";
                }
                if (Db == "2016")
                {
                    e.Row.CssClass = "Year2";
                }
                if (Db == "2017")
                {
                    e.Row.CssClass = "Year3";
                }
                if (Db == "2018")
                {
                    e.Row.CssClass = "Year4";
                }
                if (Db == "2019")
                {
                    e.Row.CssClass = "Year5";
                }
                if (Db == "2020")
                {
                    e.Row.CssClass = "Year6";
                }
            }
        }
    }
}