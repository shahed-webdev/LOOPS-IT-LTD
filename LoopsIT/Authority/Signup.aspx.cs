using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoopsIT.Authority
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void InstitutionCW_CreatedUser(object sender, EventArgs e)
        {
            DropDownList RoleDropDownList = (DropDownList)InstitutionCW.CreateUserStep.ContentTemplateContainer.FindControl("RoleDropDownList");
            Roles.AddUserToRole(InstitutionCW.UserName, RoleDropDownList.SelectedValue);

            RegistrationSQL.InsertParameters["UserName"].DefaultValue = InstitutionCW.UserName;
            RegistrationSQL.InsertParameters["Category"].DefaultValue = RoleDropDownList.SelectedValue;
            RegistrationSQL.Insert();
        }
    }
}