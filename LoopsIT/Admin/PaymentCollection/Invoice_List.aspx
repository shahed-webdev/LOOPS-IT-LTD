<%@ Page Title="Invoice List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Invoice_List.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.Invoice_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   <h3>Invoice List</h3>
   <div class="alert alert-success">Panding Invoice List</div>

   <asp:GridView ID="PendingGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="InvoiceID" DataSourceID="PendingSQL">
      <Columns>
         <asp:CommandField ShowEditButton="True" />
          <asp:BoundField DataField="InvoiceID" HeaderText="Invoice ID" SortExpression="InvoiceID" ReadOnly="True" />
         <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" ReadOnly="True" />
         <asp:TemplateField HeaderText="Invoice For" SortExpression="Invoice_For">
            <EditItemTemplate>
               <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("Invoice_For") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label1" runat="server" Text='<%# Bind("Invoice_For") %>'></asp:Label>
            </ItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Issue Date" SortExpression="IssueDate">
            <EditItemTemplate>
               <asp:TextBox ID="TextBox2" CssClass="form-control DT" runat="server" Text='<%# Bind("IssueDate", "{0:d MMM yyyy}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label2" runat="server" Text='<%# Bind("IssueDate", "{0:d MMM yyyy}") %>'></asp:Label>
            </ItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="End Date" SortExpression="EndDate">
            <EditItemTemplate>
               <asp:TextBox ID="TextBox3" CssClass="form-control DT" runat="server" Text='<%# Bind("EndDate", "{0:d MMM yyyy}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label3" runat="server" Text='<%# Bind("EndDate", "{0:d MMM yyyy}") %>'></asp:Label>
            </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField DataField="TotalAmount" HeaderText="Total" SortExpression="TotalAmount" ReadOnly="True" />
         <asp:TemplateField HeaderText="Discount" SortExpression="Discount">
            <EditItemTemplate>
               <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" Text='<%# Bind("Discount") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label4" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
            </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField DataField="PaidAmount" HeaderText="Paid" SortExpression="PaidAmount" ReadOnly="True" />
         <asp:BoundField DataField="Due" HeaderText="Due" ReadOnly="True" SortExpression="Due" />
         <asp:BoundField DataField="CreateDate" HeaderText="Create Date" SortExpression="CreateDate" DataFormatString="{0:d MMM yyyy}" ReadOnly="True" />
         <asp:BoundField DataField="Created_by" HeaderText="Created by" SortExpression="Created_by" ReadOnly="True" />
         <asp:TemplateField>
            <ItemTemplate>
               <a href='/Admin/PaymentCollection/Invoice_Print.aspx?InvoiceID=<%#Eval("InvoiceID") %>'>Print</a>
            </ItemTemplate>
         </asp:TemplateField>
      </Columns>
   </asp:GridView>
   <asp:SqlDataSource ID="PendingSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT PayOrder_Invoice.InstitutionID, PayOrder_Invoice.InvoiceID, Institution.InstitutionName, PayOrder_Invoice.Invoice_For, PayOrder_Invoice.IssueDate, PayOrder_Invoice.EndDate, PayOrder_Invoice.TotalAmount, PayOrder_Invoice.Discount, PayOrder_Invoice.PaidAmount, PayOrder_Invoice.Due, PayOrder_Invoice.CreateDate, Registration.UserName AS Created_by FROM PayOrder_Invoice INNER JOIN Institution ON PayOrder_Invoice.InstitutionID = Institution.InstitutionID INNER JOIN Registration ON PayOrder_Invoice.RegistrationID = Registration.RegistrationID WHERE (PayOrder_Invoice.Is_Paid = 0)" UpdateCommand="UPDATE PayOrder_Invoice SET Invoice_For = @Invoice_For, Discount = @Discount, IssueDate = @IssueDate, EndDate = @EndDate WHERE (InvoiceID = @InvoiceID)">
      <UpdateParameters>
         <asp:Parameter Name="Invoice_For" />
         <asp:Parameter Name="Discount" />
         <asp:Parameter Name="IssueDate" />
         <asp:Parameter Name="EndDate" />
         <asp:Parameter Name="InvoiceID" />
      </UpdateParameters>
   </asp:SqlDataSource>

   <script type="text/javascript">
       $(function () {
           $(".DT").datepicker({
               format: 'dd M yyyy',
               todayBtn: "linked",
               todayHighlight: true,
               autoclose: true
           });
       });
      function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
   </script>
</asp:Content>
