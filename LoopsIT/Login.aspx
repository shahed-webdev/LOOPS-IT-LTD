<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LoopsIT.Login1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Loops IT</title>
   <link rel="icon" type="image/png" href="Home/img/favicon.png" sizes="16x16" />
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

   <link href="CSS/Login.css" rel="stylesheet" />
   <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
   <form id="form1" runat="server">

      <div class="navbar-inverse">
         <div class="navbar-inner">
            <div class="container">
               <!-- Responsive navbar -->
               <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></a>

               <h1 class="brand"><a href="Default.aspx">Loops IT</a></h1>

               <!-- navigation -->
               <nav class="pull-right nav-collapse collapse">
                  <ul id="menu-main" class="nav">
                     <li><a title="team" href="#about">About</a></li>
                     <li><a title="services" href="#services">Services</a></li>
                     <li><a title="works" href="#works">Works</a></li>
                     <li><a title="blog" href="#blog">Blog</a></li>
                     <li><a title="contact" href="#contact">Contact</a></li>
                  </ul>
               </nav>
            </div>
         </div>
      </div>

      <asp:Login ID="CustomerLogin" runat="server" OnLoginError="CustomerLogin_LoginError" OnLoggedIn="CustomerLogin_LoggedIn" DestinationPageUrl="~/Profile_Redirect.aspx" Width="100%">
         <LayoutTemplate>
            <div class="container">
               <div class="card card-container">
                  <h2 class='login_title text-center'>Login</h2>
                  <hr />
                  <div class="form-signin">
                     <p class="input_title">
                        User name
                     <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ForeColor="#CC0000" ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                     </p>
                     <asp:TextBox ID="UserName" runat="server" class="login_box" placeholder="username"></asp:TextBox>


                     <p class="input_title">
                        Password
                     <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ForeColor="Red" ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                     </p>
                     <asp:TextBox ID="Password" runat="server" class="login_box" placeholder="******" TextMode="Password"></asp:TextBox>


                     <div style="color: #FF3300">
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                     </div>

                     <asp:Button ID="LoginButton" runat="server" CommandName="Login" class="btn btn-lg btn-primary" Text="Log In" ValidationGroup="Login1" />
                  </div>
               </div>
            </div>
         </LayoutTemplate>
      </asp:Login>

      <asp:Label ID="InvalidErrorLabel" runat="server" ForeColor="Red"></asp:Label>

      <script src="Home/js/jquery.js"></script>
      <script src="bootstrap/js/bootstrap.min.js"></script>
   </form>
</body>
</html>
