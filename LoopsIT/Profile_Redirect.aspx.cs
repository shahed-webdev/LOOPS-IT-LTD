using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT
{
    public partial class Profile_Redirect1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());
            if (!User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                Response.Redirect("~/Default.aspx");
            }


            //for Authority
            if (Roles.IsUserInRole(User.Identity.Name.Trim(), "Authority"))
            {
                Response.Redirect("~/Authority/Auth_Profile.aspx");
            }
            else//for Others
            {

                SqlCommand User_Validity = new SqlCommand("select Validation from Registration where UserName = @UserName", con);
                User_Validity.Parameters.AddWithValue("@UserName", User.Identity.Name);

                con.Open();
                string User_Validation = User_Validity.ExecuteScalar().ToString();
                con.Close();

                if (User_Validation == "Valid")  //Is User Invalid
                {
                    if (Roles.IsUserInRole(User.Identity.Name, "Admin"))
                        Response.Redirect("~/Profile/Admin.aspx");

                    if (Roles.IsUserInRole(User.Identity.Name, "Sub-Admin"))
                        Response.Redirect("~/Profile/Sub_Admin.aspx");
                }
                else
                {
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/Default.aspx");
                }
            }
        }
    }
}