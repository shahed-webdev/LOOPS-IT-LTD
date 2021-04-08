<%@ Page Title="" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="LoopsIT.Profile.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Admin.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <asp:FormView ID="Summery_FormView" runat="server" DataSourceID="Account_SQL" Width="100%">
        <ItemTemplate>
            <div class="row">
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box investment">
                        <h4><strong><%#Eval("Investment","{0:N0}") %> TK</strong></h4>
                        <span>Capital & investment</span>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box Expense">
                        <h4><strong><%#Eval("Expense","{0:N}") %> TK</strong></h4>
                        <span>Expense</span>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box Revenue">
                        <h4><strong><%#Eval("Revenue","{0:N}") %> TK</strong></h4>
                        <span>Revenue</span>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box Balance">
                        <h4><strong><%#Eval("Balance","{0:N}") %> TK</strong></h4>
                        <span>Balance</span>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box Savings">
                        <h4><strong><%#Eval("Expense_Saving","{0:N}") %> TK</strong></h4>
                        <span>Savings</span>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <div class="db_box Net">
                        <h4><strong><%#Eval("NET","{0:N}") %> TK</strong></h4>
                        <span>Net</span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="Account_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT T.Investment,T.Expense,T.Revenue,(Revenue + Investment) - Expense as Balance,T.Expense_Saving ,(Revenue + Investment) - (Expense + Expense_Saving) as NET FROM(SELECT (SELECT ISNULL(SUM(Amount),0)  FROM Investment)AS Investment,(SELECT ISNULL(SUM(Amount),0) FROM Income)AS Revenue,(SELECT ISNULL(SUM(Amount),0)  FROM Expense)AS Expense, (SELECT ISNULL(SUM(Amount),0)  FROM Expense_Saving)AS Expense_Saving) as T"></asp:SqlDataSource>

    <asp:GridView ID="MonthlyAccont_GridView" runat="server" DataKeyNames="Year,NET" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Monthly_AccountSQL" AllowSorting="True" OnRowDataBound="MonthlyAccont_GridView_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
            <asp:BoundField DataField="Total_Expense" DataFormatString="{0:N}" HeaderText="Expense" SortExpression="Total_Expense" />
            <asp:BoundField DataField="Total_Income" DataFormatString="{0:N}" HeaderText="Income" SortExpression="Total_Income" />
            <asp:BoundField DataField="NET" DataFormatString="{0:N}" HeaderText="NET" ReadOnly="True" SortExpression="NET" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="Monthly_AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT VW_Monthly_Expense.Year, VW_Monthly_Expense.Month, VW_Monthly_Expense.Total_Expense, VW_Monthly_Income.Total_Income, ISNULL(VW_Monthly_Income.Total_Income, 0) - ISNULL(VW_Monthly_Expense.Total_Expense, 0) AS NET
FROM VW_Monthly_Expense LEFT OUTER JOIN VW_Monthly_Income ON VW_Monthly_Expense.Year = VW_Monthly_Income.Year AND VW_Monthly_Expense.MonthNo = VW_Monthly_Income.MonthNo ORDER BY VW_Monthly_Expense.Year desc"></asp:SqlDataSource>

</asp:Content>
