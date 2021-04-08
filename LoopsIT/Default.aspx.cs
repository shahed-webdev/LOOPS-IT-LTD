using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT
{
    public partial class Default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            string[] myCookies = Request.Cookies.AllKeys;
            foreach (string cookie in myCookies)
            {
                Response.Cookies[cookie].Expires = DateTime.Now;
            }

            Session.RemoveAll();
        }

        protected void Mail_Button_Click(object sender, EventArgs e)
        {
            string to = "loopsitbd@gmail.com";
            string from = "loopsitbackup@gmail.com";
            string subject = Subject_TextBox.Text;
            string body = Msg_TextBox.Text + " From: " + Mail_TextBox.Text;

            using (MailMessage mm = new MailMessage(from, to))
            {
                mm.Subject = subject;
                mm.Body = body;

                mm.IsBodyHtml = false;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("loopsitbackup@gmail.com", "LI_123456");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent');", true);
            }
        }
    }
}