<%@ Page Title="Add Expense" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Expense.aspx.cs" Inherits="LoopsIT.Admin.Expense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Expense</h3>
    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>
                <asp:LinkButton ID="AddnewLinkButton" runat="server" PostBackUrl="~/Admin/Add_Expense_Category.aspx">Add New Category</asp:LinkButton>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ExCategoryDropDownList" CssClass="EroorSummer" ErrorMessage="Select Category" InitialValue="0" ValidationGroup="A">*</asp:RequiredFieldValidator>
            </label>

            <asp:DropDownList ID="ExCategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="ExpenseCategoryName" DataValueField="ExpenseCategoryID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT CATEGORY ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ExpenseCategoryID, RegistrationID, ExpenseCategoryName, InsertDate FROM Expense_Category ORDER BY ExpenseCategoryName"></asp:SqlDataSource>
        </div>

        <div class="form-group">
            <label>Receipt No.</label>
            <asp:TextBox ID="ReceiptTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Amount<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="AmountTextBox" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>
                Expense Date
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ExpenseDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="ExpenseDateTextBox" runat="server" autocomplete="off" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Expense Reason</label>
            <asp:TextBox ID="ExpenseReasonTextBox" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Month For</label>
            <asp:TextBox ID="MonthTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Expense By <a href="Add_Employee.aspx">Add New</a></label>
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" ValidationGroup="A" />
            <asp:SqlDataSource ID="ExpenseSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense] WHERE [ExpenseID] = @ExpenseID" InsertCommand="INSERT INTO Expense(RegistrationID, ExpenseCategoryID, ExpenseByEmployeeID, ExpenseFor, Amount, ExpenseDate, Receipt_No, For_Month_Pay) VALUES (@RegistrationID, @ExpenseCategoryID, @ExpenseByEmployeeID, @ExpenseFor, @Amount, @ExpenseDate, @Receipt_No, @For_Month_Pay)" SelectCommand="SELECT * FROM [Expense]" UpdateCommand="UPDATE Expense SET ExpenseFor = @ExpenseFor, Amount = @Amount, ExpenseDate = @ExpenseDate WHERE (ExpenseID = @ExpenseID)">
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
                    <asp:ControlParameter ControlID="ReceiptTextBox" Name="Receipt_No" PropertyName="Text" />
                    <asp:ControlParameter ControlID="MonthTextBox" Name="For_Month_Pay" PropertyName="Text" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ExpenseFor" />
                    <asp:Parameter Name="Amount" />
                    <asp:Parameter Name="ExpenseDate" />
                    <asp:Parameter Name="ExpenseID" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <div class="clearfix"></div>

    <div class="alert alert-success">
        <asp:Label ID="ExpnseLabel" runat="server" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="ViewExpanseSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS TotalExp FROM Expense"></asp:SqlDataSource>
    </div>

    <asp:GridView ID="ExpenseGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpenseID" DataSourceID="ExpenseSQL" AllowSorting="True" AllowPaging="True" PageSize="30">
        <Columns>
            <asp:BoundField DataField="ExpenseFor" HeaderText="Expense For" SortExpression="ExpenseFor" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
            <asp:BoundField DataField="ExpenseDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Expense Date" SortExpression="ExpenseDate" />
            <asp:BoundField DataField="Receipt_No" HeaderText="Receipt No" SortExpression="Receipt_No" />
            <asp:BoundField DataField="For_Month_Pay" HeaderText="Month For" SortExpression="For_Month_Pay" />
        </Columns>
        <PagerStyle CssClass="pgr" />
    </asp:GridView>


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
