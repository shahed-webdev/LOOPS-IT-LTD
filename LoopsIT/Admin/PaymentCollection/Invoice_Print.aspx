<%@ Page Title="Print" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Invoice_Print.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.Invoice_Print" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link href="CSS/Invoice_Print.css" rel="stylesheet" />
   <style>
      font-face { margin-top:20px;}
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   <asp:FormView ID="InvoiceFormView" runat="server" DataSourceID="InvoiceSQL" Width="100%">
      <ItemTemplate>
         <div class="container" id="In-Print">
            <div class="row">
               <div class="col-md-6 col-sm-6">
                  <h2>Loops IT</h2>
                  <p>
                     House # 328, Shohid Biplob Shoroni, East Nakhal Para, Tejgaon,
                  cross-streets of shopno super shop, Dhaka 1215
                  </p>
               </div>
               <div class="col-md-6 col-sm-6 text-right">
                  <h2>INVOICE</h2>
                  <h4>#INVOICE NO. <%#Request.QueryString["InvoiceID"] %></h4>
                  <p>
                     Issue Date:<%#Eval("IssueDate","{0:d MMM yyyy}") %><br />
                     End Date:<%#Eval("EndDate","{0:d MMM yyyy}") %>
                  </p>
               </div>
            </div>

            <div class="row Topspace1">
               <div class="col-md-6 col-sm-6">
                  <h4>Bill To:</h4>
                  <h5>
                     <asp:Label ID="InstitutionNameLabel" runat="server" Text='<%# Bind("InstitutionName") %>' /></h5>
                  <p>
                     <asp:Label ID="AddressLabel" runat="server" Text='<%# Bind("Address") %>' />
                  </p>
                  <p>
                     <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                  </p>

               </div>
               <div class="col-md-6 col-sm-6 text-right">
                  <h4><asp:Label ID="Invoice_ForLabel" runat="server" Text='<%# Bind("Invoice_For") %>' /></h4>
               </div>
            </div>

            <asp:GridView ID="PayOrderGridView" runat="server" AutoGenerateColumns="False" DataSourceID="PayOrderSQL" CssClass="mGrid">
               <Columns>
                  <asp:BoundField DataField="UseDate" HeaderText="UseDate" SortExpression="UseDate" DataFormatString="{0:d MMM yyyy}" />
                  <asp:BoundField DataField="IncomeCategoryName" HeaderText="Name" SortExpression="IncomeCategoryName" />
                  <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                  <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
                  <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                  <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" />
                  <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" SortExpression="Amount" DataFormatString="{0:N0}" />
               </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT PayOrder.Details, PayOrder.Month, PayOrder.Unit, PayOrder.UnitPrice, PayOrder.Amount, PayOrder.UseDate, Income_Category.IncomeCategoryName FROM PayOrder INNER JOIN Income_Category ON PayOrder.IncomeCategoryID = Income_Category.IncomeCategoryID WHERE (PayOrder.InvoiceID = @InvoiceID)">
               <SelectParameters>
                  <asp:QueryStringParameter Name="InvoiceID" QueryStringField="InvoiceID" />
               </SelectParameters>
            </asp:SqlDataSource>

            <div class="text-right Topspace2">
               Total Amount:
         <asp:Label ID="TotalAmountLabel" runat="server" Text='<%# Bind("TotalAmount") %>' />
               <br />
               Discount:
         <asp:Label ID="DiscountLabel" runat="server" Text='<%# Bind("Discount") %>' />
               <br />
               Paid Amount:
         <asp:Label ID="PaidAmountLabel" runat="server" Text='<%# Bind("PaidAmount") %>' />
               <br />
               Due:
         <asp:Label ID="DueLabel" runat="server" Text='<%# Bind("Due") %>' />

            </div>
         </div>
      </ItemTemplate>
   </asp:FormView>
   <asp:SqlDataSource ID="InvoiceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT Institution.InstitutionName, PayOrder_Invoice.Invoice_For, PayOrder_Invoice.EndDate, PayOrder_Invoice.IssueDate, PayOrder_Invoice.TotalAmount, PayOrder_Invoice.Discount, PayOrder_Invoice.PaidAmount, PayOrder_Invoice.Due, Institution.Address, Institution.Email, Institution.Phone FROM PayOrder_Invoice INNER JOIN Institution ON PayOrder_Invoice.InstitutionID = Institution.InstitutionID WHERE (PayOrder_Invoice.InvoiceID = @InvoiceID)">
      <SelectParameters>
         <asp:QueryStringParameter Name="InvoiceID" QueryStringField="InvoiceID" />
      </SelectParameters>
   </asp:SqlDataSource>
</asp:Content>
