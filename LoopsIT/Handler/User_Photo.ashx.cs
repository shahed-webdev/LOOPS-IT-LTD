using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

namespace LoopsIT.Handler
{
    /// <summary>
    /// Summary description for User_Photo
    /// </summary>
    public class User_Photo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoopsITConnectionString"].ToString());
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT Image from Registration where RegistrationID =" + context.Request.QueryString["Img"] + "", con);
            SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            if (reader.Read())
            {
                if (reader.GetValue(0) != DBNull.Value)
                    context.Response.BinaryWrite((Byte[])reader.GetValue(0));
                else
                    context.Response.BinaryWrite(File.ReadAllBytes(context.Server.MapPath("~/CSS/Image/Defualt_image.png")));
            }
            else
                context.Response.BinaryWrite(File.ReadAllBytes(context.Server.MapPath("~/CSS/Image/Defualt_image.png")));

            reader.Close();
            context.Response.End();
            con.Close();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}