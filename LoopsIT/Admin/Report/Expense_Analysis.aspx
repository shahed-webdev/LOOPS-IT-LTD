<%@ Page Title="Expense Analysis" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Expense_Analysis.aspx.cs" Inherits="LoopsIT.Admin.Report.Expense_Analsis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Date_Head { text-align: center; background: #46567A; margin-bottom: -2px; padding: 10px; color: #e4e4e4; }
        .badge { padding: 2px 5px; font-size: 14px; font-weight: bold; background-color: #2c9000; }
        .list-group-item:first-child { border-top-right-radius: 0; border-top-left-radius: 0; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Expense Analysis</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="FromDate_TextBox" runat="server" placeholder="From Date" CssClass="form-control Datetime"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="Interval_TextBox" onkeypress="return isNumberKey(event)" onpaste="return false" runat="server" placeholder="Month interval" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="Find_Button" runat="server" Text="Find" CssClass="btn btn-default" />
        </div>
    </div>

    <div class="row">
        <asp:Repeater ID="Month_Repeater" runat="server" DataSourceID="MonthSQL">
            <ItemTemplate>
                <div class="col-md-4 col-sm-6">
                    <h4 class="Date_Head">
                         <%#Eval("Start_date","{0:MMM yyyy}") %>
                        -
                        <%#Eval("End_date","{0:MMM yyyy}") %>

                        <asp:Label ID="Start_dateLabel" CssClass="hidden" runat="server" Text='<%#Eval("Start_date") %>'></asp:Label>
                        <asp:Label ID="End_dateLabel" CssClass="hidden" runat="server" Text='<%#Eval("End_date") %>'></asp:Label>
                    </h4>
                    <asp:Repeater ID="Details_Repeater" runat="server" DataSourceID="DetailsSQL">
                        <HeaderTemplate>
                            <ul class="list-group">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <%#Eval("Category") %>
                                <span class="badge badge-primary badge-pill"><%#Eval("Amount","{0:#,##0.##}") %></span>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="DetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT   Main_Category.MainCategoryName AS Category, SUM(Expense.Amount) AS Amount
FROM            Main_Category INNER JOIN
                        Expense_Category ON Main_Category.MainCategoryID = Expense_Category.MainCategoryID INNER JOIN
                        Expense ON Expense_Category.ExpenseCategoryID = Expense.ExpenseCategoryID
WHERE        (Expense.ExpenseDate BETWEEN ISNULL(@StartDate,'1-1-2000') AND ISNULL(@EndDate,'1-1-3000'))
GROUP BY Main_Category.MainCategoryName, Main_Category.SN
ORDER BY Main_Category.SN, Category"
                        CancelSelectOnNullParameter="False">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Start_dateLabel" DbType="Date" Name="StartDate" PropertyName="Text" />
                            <asp:ControlParameter ControlID="End_dateLabel" DbType="Date" Name="EndDate" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:SqlDataSource ID="MonthSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="Report_Month_Interval" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="Interval_TextBox" Name="Interval" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="FromDate_TextBox" DbType="Date" Name="dateFrom" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <script>
    $(function () {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });
    </script>
</asp:Content>
