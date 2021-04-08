<%@ Page Title="Pay Order" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="PayOrder.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.PayOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   <h3>Pay Order</h3>

   <div class="col-md-6 col-sm-10 well">
      <div class="form-group">
         <label>
            Category <a href="/Admin/Income_Category.aspx">Add New Category</a>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="CategoryDropDownList" CssClass="EroorStar" ErrorMessage="Select Category" InitialValue="0" ValidationGroup="A">*</asp:RequiredFieldValidator>
         </label>
         <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="IncomeCategoryName" DataValueField="IncomeCategoryID" AppendDataBoundItems="True">
            <asp:ListItem Value="0">[ SELECT CATEGORY ]</asp:ListItem>
         </asp:DropDownList>

         <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>"
            SelectCommand="SELECT * FROM [Income_Category]"></asp:SqlDataSource>
      </div>
      <div class="form-group">
         <label>
            Project <a href="/Admin/Add_Projects.aspx">Add Projects</a>
         </label>
         <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="True" AppendDataBoundItems="True">
            <asp:ListItem Value="">[ SELECT ]</asp:ListItem>
         </asp:DropDownList>
         <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>
      </div>
      <div class="form-group">
         <label>
            Institution <a href="/Admin/Add_Institution.aspx">Add Institution</a>
         </label>
         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="InstitutionDropDownList" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>

         <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass=" form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID">
         </asp:DropDownList>
         <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT InstitutionID, RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Website, Address, InstitutionLogo, InstitutionStatus, InsertDate FROM Institution WHERE (ProjectID = ISNULL(@ProjectID,0))">
            <SelectParameters>
               <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
            </SelectParameters>
         </asp:SqlDataSource>
      </div>
      <div class="form-group">
         <label>
            Unit
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UnitTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
         </label>

         <asp:TextBox ID="UnitTextBox" runat="server" CssClass=" form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>

      </div>
      <div class="form-group">
         <label>
            Unit Price
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="UnitPriceTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
         </label>

         <asp:TextBox ID="UnitPriceTextBox" runat="server" CssClass=" form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>

      </div>
      <div class="form-group">
         <label>
            Use Date
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UseDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
         </label>
         <asp:TextBox ID="UseDateTextBox" runat="server" autocomplete="off" CssClass="form-control DT" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>

      </div>
      <div class="form-group">
         <asp:CheckBox ID="MounthCheckBox" runat="server" Text="Monthly Service Charge" />
      </div>
      <div class="form-group">
         <label>
            Details
         </label>
         <asp:TextBox ID="DetailsTextBox" runat="server" CssClass=" form-control" TextMode="MultiLine"></asp:TextBox>

      </div>

      <asp:Button ID="PayOrderButton" runat="server" CssClass="btn btn-primary" OnClick="PayOrderButton_Click" Text="Pay Order" ValidationGroup="A" />
      <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorSummer"></asp:Label>

      <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" InsertCommand="INSERT INTO PayOrder(RegistrationID, IncomeCategoryID, InstitutionID, Unit, UnitPrice, UseDate, Details, Month) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @Unit, @UnitPrice, @UseDate, @Details, @Month_Date)" SelectCommand="SELECT * FROM [PayOrder]">
         <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="UseDateTextBox" DbType="Date" Name="UseDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="CategoryDropDownList" Name="IncomeCategoryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="UnitTextBox" Name="Unit" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="UnitPriceTextBox" Name="UnitPrice" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="DetailsTextBox" Name="Details" PropertyName="Text" />
            <asp:Parameter Name="Month_Date" />
         </InsertParameters>
      </asp:SqlDataSource>
   </div>



   <script type="text/javascript">
       $(function () {
           $(function () {
               $(".DT").datepicker({
                   format: 'dd M yyyy',
                   todayBtn: "linked",
                   todayHighlight: true,
                   autoclose: true
               });
           });
       });
      function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
   </script>
</asp:Content>
