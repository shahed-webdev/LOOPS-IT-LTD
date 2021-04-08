using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.Accounts
{
    public partial class Add_Main_Category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Add_Button_Click(object sender, EventArgs e)
        {
            CategorySQL.Insert();
            CategoryTextBox.Text = "";
            SNTextBox.Text = "";
        }
    }
}