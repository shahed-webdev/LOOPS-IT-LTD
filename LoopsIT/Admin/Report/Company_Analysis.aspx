<%@ Page Title="Company Analysis" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Company_Analysis.aspx.cs" Inherits="LoopsIT.Admin.Report.Company_Analysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/bootstrap-multiselect.css" rel="stylesheet" />
    <style>
        .Date_Head { text-align: center; background: #46567A; margin-bottom: -2px; padding: 10px; color: #e4e4e4; }
        .badge { padding: 2px 5px; font-size: 14px; font-weight: bold; background-color: #2c9000; }
        .list-group-item:first-child { border-top-right-radius: 0; border-top-left-radius: 0; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Company Analysis</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:ListBox ID="Project_ListBox" CssClass="Project form-control" runat="server" SelectionMode="Multiple" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID"></asp:ListBox>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT Project.ProjectID, Project.ProjectName FROM Income INNER JOIN Project ON Income.ProjectID = Project.ProjectID ORDER BY Project.ProjectName"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:ListBox ID="Income_ListBox" CssClass="IncomeCategory form-control" runat="server" SelectionMode="Multiple" DataSourceID="IncomeCatSQL" DataTextField="IncomeCategoryName" DataValueField="IncomeCategoryID"></asp:ListBox>
            <asp:SqlDataSource ID="IncomeCatSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT Income_Category.IncomeCategoryID, Income_Category.IncomeCategoryName FROM Income INNER JOIN Income_Category ON Income.IncomeCategoryID = Income_Category.IncomeCategoryID ORDER BY Income_Category.IncomeCategoryName"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:ListBox ID="Expense_ListBox" CssClass="ExpenseCategory form-control" runat="server" SelectionMode="Multiple" DataSourceID="ExpenseCatSQL" DataTextField="ExpenseCategoryName" DataValueField="ExpenseCategoryID"></asp:ListBox>
            <asp:SqlDataSource ID="ExpenseCatSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT Expense_Category.ExpenseCategoryID, Expense_Category.ExpenseCategoryName FROM Expense INNER JOIN Expense_Category ON Expense.ExpenseCategoryID = Expense_Category.ExpenseCategoryID ORDER BY Expense_Category.ExpenseCategoryName"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FromDate_TextBox" runat="server" placeholder="From Date" CssClass="form-control Datetime"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="Interval_TextBox" onkeypress="return isNumberKey(event)" onpaste="return false" runat="server" placeholder="Month interval" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="Find_Button" runat="server" Text="Find" CssClass="btn btn-default" OnClick="Find_Button_Click" />
        </div>
    </div>

    <div class="row" style="margin-bottom: 30px;">
        <div class="col-md-6">
            <h4>Income</h4>
            <asp:GridView ID="Income_GridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="IncomeSQL">
                <Columns>
                    <asp:TemplateField HeaderText="First Entry Month" SortExpression="First_Entry_Month">
                        <ItemTemplate>
                            <span class="Income_Name"><%# Eval("First_Entry_Month") %></span>
                            <b>(<%# Eval("Institutions") %>)</b>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                        <ItemTemplate>
                            <%# Eval("Amount","{0:#,##0.##}") %>
                            <input class="IncomeAmt" type="hidden" value="<%# Eval("Amount") %>" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="Report_Income_With_Interval" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Interval_TextBox" Name="Interval" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="FromDate_TextBox" DbType="Date" Name="dateFrom" PropertyName="Text" />
                    <asp:Parameter Name="ProjectIDs" Type="String" />
                    <asp:Parameter Name="IncomeCategoryIDs" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="col-md-6">
            <h4>Expense</h4>
            <asp:GridView ID="Expense_GridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="ExpenseSQL">
                <Columns>
                    <asp:TemplateField HeaderText="First Entry Month" SortExpression="First_Entry_Month">
                        <ItemTemplate>
                            <span class="Expense_Name"><%# Eval("First_Entry_Month") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                        <ItemTemplate>
                            <%# Eval("Amount","{0:#,##0.##}") %>
                            <input class="ExpenseAmt" type="hidden" value="<%# Eval("Amount") %>" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="ExpenseSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="Report_Expense_With_Interval" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Interval_TextBox" Name="Interval" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="FromDate_TextBox" DbType="Date" Name="dateFrom" PropertyName="Text" />
                    <asp:Parameter Name="ExpenseCategoryIDs" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    <div class="well">
        <canvas id="lineChart"></canvas>
    </div>

    <div class="row">
        <asp:Repeater ID="Month_Repeater" runat="server" DataSourceID="MonthSQL" OnItemDataBound="Month_Repeater_ItemDataBound">
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
                                <%#Eval("Criteria") %> (<b><%#Eval("Ins") %></b>)
                        <span class="badge badge-primary badge-pill"><%#Eval("Amont","{0:#,##0.##}") %></span>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="DetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="Report_Expense_Income_Interval" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Start_dateLabel" DbType="Date" Name="StartDate" PropertyName="Text" />
                            <asp:ControlParameter ControlID="End_dateLabel" DbType="Date" Name="EndDate" PropertyName="Text" />
                            <asp:Parameter Name="IncomeCategoryIDs" Type="String" />
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

    <script src="/JQ/bootstrap-multiselect.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
    <script>
        $(function () {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });

        var ExpenseCategory = [],
            ExpenseAmount = [],
            Income_Amount = [];

        $('[id*=Expense_GridView] tr').not(':first').each(function () {
            ExpenseCategory.push($(this).find(".Expense_Name").text());
            ExpenseAmount.push($(this).find(".ExpenseAmt").val());
        });

        ExpenseCategory.filter(function (element) {
            var isTrue = true;
            var incomeName = "";
            $('[id*=Income_GridView] tr').not(':first').each(function () {
                incomeName = $(this).find(".Income_Name").text();
                var amount = $(this).find(".IncomeAmt").val();

                if (element === incomeName) {
                    Income_Amount.push(amount);
                    isTrue = false;
                }
            });

            if (isTrue) {
                Income_Amount.push(0);
            }
        });

        var ctxL = document.getElementById("lineChart").getContext('2d');
        var myLineChart = new Chart(ctxL, {
            type: 'line',
            data: {
                labels: ExpenseCategory,
                datasets: [{
                    label: "Income",
                    data: Income_Amount,
                    backgroundColor: ['rgba(0, 137, 132, .3)'],
                    borderColor: ['rgba(0, 10, 130, .7)'],
                    borderWidth: 2
                }, {
                    label: "Expense",
                    data: ExpenseAmount,
                    backgroundColor: ['rgba(105, 0, 132, .3)'],
                    borderColor: ['rgba(200, 99, 132, .7)'],
                    borderWidth: 2
                }]
            },
            options: { responsive: true }
        });


        //Multiselect
        $('.Project').multiselect({
            includeSelectAllOption: true,
            enableFiltering: true,
            includeResetOption: true,
            includeResetDivider: true,
            nonSelectedText: 'All Project'
        });
        $('.IncomeCategory').multiselect({
            includeSelectAllOption: true,
            enableFiltering: true,
            includeResetOption: true,
            includeResetDivider: true,
            nonSelectedText: 'All Income Category'
        });
        $('.ExpenseCategory').multiselect({
            includeSelectAllOption: true,
            enableFiltering: true,
            includeResetOption: true,
            includeResetDivider: true,
            nonSelectedText: 'All Expense Category'
        });


        // provide data in chart labels
        Chart.plugins.register({
            afterDatasetsDraw: function (chart) {
                var ctx = chart.ctx;

                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (!meta.hidden) {
                        meta.data.forEach(function (element, index) {
                            // Draw the text in black, with the specified font
                            ctx.fillStyle = '#000';

                            var fontSize = 14;
                            var fontStyle = 'normal';
                            var fontFamily = 'tahoma';
                            ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

                            // Just naively convert to string for now
                            var dataString = dataset.data[index].toString();

                            // Make sure alignment settings are correct
                            ctx.textAlign = 'center';
                            ctx.textBaseline = 'middle';

                            var padding = 5;
                            var position = element.tooltipPosition();
                            ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding);
                        });
                    }
                });
            }
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
