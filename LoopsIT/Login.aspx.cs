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
    public partial class Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && Session["RegistrationID"] != null) //Is user loged in, user not able to run login page redirect to profile page
            {
                Response.Redirect("~/Profile_Redirect.aspx");
            }
        }

        protected void CustomerLogin_LoginError(object sender, EventArgs e)
        {
            MembershipUser usrInfo = Membership.GetUser(CustomerLogin.UserName.Trim());
            if (usrInfo != null)
            {
                if (usrInfo.IsLockedOut)
                {
                    CustomerLogin.FailureText = "Your account has been locked out because of too many invalid login attempts. Please contact the administrator to have your account unlocked.";
                }
                else if (!usrInfo.IsApproved)
                {
                    CustomerLogin.FailureText = "Your account has not been approved. You cannot login until an administrator has approved your account.";
                }
            }
            else
            {
                CustomerLogin.FailureText = "Your login attempt was not successful.";
            }
        }

        protected void CustomerLogin_LoggedIn(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());

            SqlCommand RegistrationIDcmd = new SqlCommand("select RegistrationID from Registration where UserName = @UserName", con);
            RegistrationIDcmd.Parameters.AddWithValue("@UserName", CustomerLogin.UserName.Trim());

            con.Open();
            Session["RegistrationID"] = RegistrationIDcmd.ExecuteScalar().ToString();
            con.Close();
        }
    }
}