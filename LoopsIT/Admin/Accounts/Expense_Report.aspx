<%@ Page Title="Expense Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Expense_Report.aspx.cs" Inherits="LoopsIT.Admin.Accounts.Expense_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../JQ/DatePicker/jquery.datepick.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Expense Report</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="ExCategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="ExpenseCategoryName" DataValueField="ExpenseCategoryID" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT CATEGORY ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ExpenseCategoryID, RegistrationID, ExpenseCategoryName, InsertDate FROM Expense_Category ORDER BY ExpenseCategoryName"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ Expense By ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FromDateTextBox" placeholder="From Date" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ToDateTextBox" placeholder="To Date" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ReceiptNoTextBox" placeholder="Receipt No" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="AmontTextBox" placeholder="Amount" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="IDTextBox" placeholder="ID" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Find" ValidationGroup="A" />
        </div>
    </div>

    <div class="alert alert-success">
        <asp:Label ID="ExpnseLabel" runat="server" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="ViewExpanseSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS TotalExp FROM Expense where (Expense.ExpenseCategoryID LIKE @ExpenseCategoryID) AND (ISNULL(Receipt_No,' ') LIKE ISNULL(@ReceiptNo,'%'))  AND (ISNULL(Expense.ExpenseByEmployeeID,'') LIKE @ExpenseByEmployeeID) AND (Amount LIKE  ISNULL(@Amount,'%')) AND (Expense.ExpenseDate between  ISNULL(@F_Date,'1-1-1000') and ISNULL(@T_Date,'1-1-3000')) and (Expense.ExpenseID LIKE ISNULL(@ExpenseID,'%'))">
            <SelectParameters>
                <asp:ControlParameter ControlID="ExCategoryDropDownList" Name="ExpenseCategoryID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="ExpenseByEmployeeID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ReceiptNoTextBox" Name="ReceiptNo" PropertyName="Text" />
                <asp:ControlParameter ControlID="AmontTextBox" Name="Amount" PropertyName="Text" />
                <asp:ControlParameter ControlID="IDTextBox" Name="ExpenseID" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="ExpenseGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpenseID" DataSourceID="ExpenseSQL" AllowSorting="True" AllowPaging="True" PageSize="100">
            <Columns>
                <asp:BoundField DataField="ExpenseID" HeaderText="ID" SortExpression="ExpenseID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="Receipt_No" HeaderText="Receipt No" SortExpression="Receipt_No" />
                <asp:BoundField DataField="ExpenseCategoryName" HeaderText="Category" SortExpression="ExpenseCategoryName" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="Inserted_By" HeaderText="Inserted By" SortExpression="Inserted_By" />
                <asp:BoundField DataField="ExpenseFor" HeaderText="Expense For" SortExpression="ExpenseFor" />
                <asp:BoundField DataField="ExpenseDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="ExpenseDate" />
                <asp:BoundField DataField="Expense_By" HeaderText="Expense By" SortExpression="Expense_By" />
                <asp:BoundField DataField="For_Month_Pay" HeaderText="Month For" SortExpression="For_Month_Pay" />
                <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Entry Date" SortExpression="Insert_Date" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="ExpenseSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense] WHERE [ExpenseID] = @ExpenseID" InsertCommand="INSERT INTO Expense(RegistrationID, ExpenseCategoryID, ExpenseByEmployeeID, ExpenseFor, Amount, ExpenseDate) VALUES (@RegistrationID, @ExpenseCategoryID, @ExpenseByEmployeeID, @ExpenseFor, @Amount, @ExpenseDate)" SelectCommand="SELECT        Expense.ExpenseID, Expense.ExpenseCategoryID, Expense.ExpenseByEmployeeID, Registration.Name AS Inserted_By, Expense_Category.ExpenseCategoryName, Expense.ExpenseFor, Expense.Amount, Expense.Receipt_No, 
                         Expense.ExpenseDate, Employee.EmployeeName AS Expense_By,Expense.For_Month_Pay, Expense.Insert_Date
FROM            Expense INNER JOIN
                         Expense_Category ON Expense.ExpenseCategoryID = Expense_Category.ExpenseCategoryID INNER JOIN
                         Registration ON Expense.RegistrationID = Registration.RegistrationID LEFT OUTER JOIN
                         Employee ON Expense.ExpenseByEmployeeID = Employee.EmployeeID
WHERE  (Expense.ExpenseCategoryID LIKE @ExpenseCategoryID) AND (ISNULL(Expense.Receipt_No,' ') LIKE ISNULL(@ReceiptNo,'%'))  AND (Expense.Amount LIKE  ISNULL(@Amount,'%')) AND
(ISNULL(Expense.ExpenseByEmployeeID,'') LIKE @ExpenseByEmployeeID) AND (Expense.ExpenseDate between  ISNULL(@F_Date,'1-1-1000') and ISNULL(@T_Date,'1-1-3000')) and (Expense.ExpenseID LIKE ISNULL(@ExpenseID,'%'))
ORDER BY Expense.ExpenseDate"
            UpdateCommand="UPDATE Expense SET ExpenseFor = @ExpenseFor, Amount = @Amount, ExpenseDate = @ExpenseDate WHERE (ExpenseID = @ExpenseID)" CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:Parameter Name="ExpenseID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="ExCategoryDropDownList" Name="ExpenseCategoryID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="ExpenseByEmployeeID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ExpenseReasonTextBox" Name="ExpenseFor" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="AmountTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                <asp:ControlParameter ControlID="ExpenseDateTextBox" DbType="Date" Name="ExpenseDate" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ExCategoryDropDownList" Name="ExpenseCategoryID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="ExpenseByEmployeeID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ReceiptNoTextBox" Name="ReceiptNo" PropertyName="Text" />
                <asp:ControlParameter ControlID="AmontTextBox" Name="Amount" PropertyName="Text" />
                <asp:ControlParameter ControlID="IDTextBox" Name="ExpenseID" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ExpenseFor" />
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="ExpenseDate" />
                <asp:Parameter Name="ExpenseID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <script type="text/javascript">
        $(function () {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
