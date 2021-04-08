using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Admin.PaymentCollection
{
    public partial class Invoice_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty( Request.QueryString["InvoiceID"]))
            {
                Response.Redirect("Invoice_List.aspx");

            }
        }
    }
}