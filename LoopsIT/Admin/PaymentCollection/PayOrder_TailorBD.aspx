<%@ Page Title="Tailorbd Payorder" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="PayOrder_TailorBD.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.TailorBD_PayOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link href="/JQ/DatePicker/jquery.datepick.css" rel="stylesheet" />
   <style>
      .Info-bg { background-color: #ffd800; border: 1px solid #ddd; color: #000; font-size: 16px; padding: 10px; text-align: center; }
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   <h3>Tailorbd Payorder</h3>

   <asp:FormView ID="TotalTailorFormView" runat="server" DataSourceID="TotalTailorSQL" Width="100%">
      <ItemTemplate>
         <div class="row">
            <div class="col-md-3">
               <div class="Info-bg">
                  Total Tailor<br />
                  <%#Eval("Total_Tailor") %>
               </div>
            </div>
            <div class="col-md-3">
               <div class="Info-bg">
                  Total Amount<br />
                  <%#Eval("TotalAmount","{0:N0}") %> TK.
               </div>
            </div>
         </div>
      </ItemTemplate>
   </asp:FormView>
   <asp:SqlDataSource ID="TotalTailorSQL" runat="server" ConnectionString="<%$ ConnectionStrings:TailorbdConnectionString %>" SelectCommand="SELECT COUNT(Renew_Amount) Total_Tailor, SUM(Renew_Amount) AS TotalAmount FROM Institution  WHERE (Validation = N'Valid') AND (InstitutionID &lt;&gt; 1005)"></asp:SqlDataSource>

   <br />
   <div class="form-inline">
      <div class="form-group">
         <asp:TextBox ID="DateTextBox" placeholder="Use Date" runat="server" autocomplete="off" CssClass="form-control Datetime" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
      </div>
      <div class="form-group">
         <asp:Button ID="CheckButton" runat="server" CssClass="btn btn-primary" OnClick="CheckButton_Click" Text="Check" />
      </div>
   </div>

   <br />
   <asp:GridView ID="TailorGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="TailorSQL" DataKeyNames="InstitutionName,Renew_Amount">
      <Columns>
         <asp:TemplateField HeaderText="Select">
            <HeaderTemplate>
               <asp:CheckBox ID="SelectAllCheckBox" runat="server" Text=" " />
            </HeaderTemplate>
            <ItemTemplate>
               <asp:CheckBox ID="SelectCheckBox" runat="server" Text=" " />
            </ItemTemplate>
            <ItemStyle Width="50px" />
         </asp:TemplateField>
         <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" />
         <asp:BoundField DataField="Renew_Amount" HeaderText="Renew Amount" SortExpression="Renew_Amount" />
      </Columns>
   </asp:GridView>
   <asp:SqlDataSource ID="TailorSQL" runat="server" ConnectionString="<%$ ConnectionStrings:TailorbdConnectionString %>" SelectCommand="SELECT InstitutionName, Renew_Amount FROM Institution WHERE(Validation = N'Valid') AND (InstitutionID &lt;&gt; 1005)"></asp:SqlDataSource>


   <br />
   <asp:Button ID="PayOrderButton" runat="server" CssClass="btn btn-primary" OnClick="PayOrderButton_Click" Text="Pay Order" />
   <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorSummer"></asp:Label>
   <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" InsertCommand="INSERT INTO PayOrder(RegistrationID, IncomeCategoryID, InstitutionID, Unit, UnitPrice, UseDate, Details, Month) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @Unit, @UnitPrice, @UseDate, @Details, FORMAT(CONVERT(date,@Month_Date), 'MMM yyyy'))" SelectCommand="SELECT * FROM [PayOrder]">
      <InsertParameters>
         <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
         <asp:ControlParameter ControlID="DateTextBox" Name="Month_Date" PropertyName="Text" />
         <asp:ControlParameter ControlID="DateTextBox" DbType="Date" Name="UseDate" PropertyName="Text" />
         <asp:Parameter Name="Unit" Type="Int32" DefaultValue="1" />
         <asp:Parameter Name="IncomeCategoryID" Type="Int32" />
         <asp:Parameter Name="InstitutionID" Type="Int32" />
         <asp:Parameter Name="UnitPrice" Type="Double" />
         <asp:Parameter Name="Amount" Type="Double" />
         <asp:Parameter Name="Details" />
      </InsertParameters>
   </asp:SqlDataSource>


   <script src="../../JQ/DatePicker/jquery.datepick.js"></script>
   <script type="text/javascript">

      $(function () { $(".Datetime").datepick() });

      $("[id*=SelectAllCheckBox]").live("click", function () {
         var a = $(this), b = $(this).closest("table");
         $("input[type=checkbox]", b).each(function () {
            a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
         });
      });
      $("[id*=SelectCheckBox]").live("click", function () {
         var a = $(this).closest("table"), b = $("[id*=chkHeader]", a);
         $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=chkRow]", a).length == $("[id*=chkRow]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
      });
   </script>
</asp:Content>
