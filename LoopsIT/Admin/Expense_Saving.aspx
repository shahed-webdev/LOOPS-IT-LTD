<%@ Page Title="Expense Saving" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Expense_Saving.aspx.cs" Inherits="LoopsIT.Admin.Expense_Saving" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Expense Saving</h3>
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
            <label>Amount<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="AmountTextBox" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Expense Saving Date<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ExpenseSavingDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="ExpenseSavingDateTextBox" runat="server" autocomplete="off" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Expense Saving Reason</label>
            <asp:TextBox ID="SavingForTextBox" runat="server" CssClass="form-control" onfocus="empty()" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Month For</label>
            <asp:TextBox ID="MonthTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" ValidationGroup="A" />
            <asp:SqlDataSource ID="ExpenseSavingSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense_Saving] WHERE [ExpenseSavingID] = @ExpenseSavingID" InsertCommand="INSERT INTO [Expense_Saving] ([RegistrationID], [InstitutionID], [Amount], [ExpenseCategoryID], [SavingFor], [For_Month_Saving], [ExpenseSavingDate]) VALUES (@RegistrationID, @InstitutionID, @Amount, @ExpenseCategoryID, @SavingFor, @For_Month_Saving, @ExpenseSavingDate)" SelectCommand="SELECT * FROM [Expense_Saving]" UpdateCommand="UPDATE [Expense_Saving] SET [RegistrationID] = @RegistrationID, [InstitutionID] = @InstitutionID, [Amount] = @Amount, [ExpenseCategoryID] = @ExpenseCategoryID, [SavingFor] = @SavingFor, [For_Month_Saving] = @For_Month_Saving, [ExpenseSavingDate] = @ExpenseSavingDate, [Insert_Date] = @Insert_Date WHERE [ExpenseSavingID] = @ExpenseSavingID">
                <DeleteParameters>
                    <asp:Parameter Name="ExpenseSavingID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                    <asp:ControlParameter ControlID="AmountTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                    <asp:ControlParameter ControlID="ExCategoryDropDownList" Name="ExpenseCategoryID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="SavingForTextBox" Name="SavingFor" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="MonthTextBox" Name="For_Month_Saving" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="ExpenseSavingDateTextBox" DbType="Date" Name="ExpenseSavingDate" PropertyName="Text" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RegistrationID" Type="Int32" />
                    <asp:Parameter Name="InstitutionID" Type="Int32" />
                    <asp:Parameter Name="Amount" Type="Double" />
                    <asp:Parameter Name="ExpenseCategoryID" Type="Int32" />
                    <asp:Parameter Name="SavingFor" Type="String" />
                    <asp:Parameter Name="For_Month_Saving" Type="String" />
                    <asp:Parameter DbType="Date" Name="ExpenseSavingDate" />
                    <asp:Parameter Name="Insert_Date" Type="DateTime" />
                    <asp:Parameter Name="ExpenseSavingID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="alert alert-success">
        <asp:Label ID="ExpnseSavingLabel" runat="server" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="ViewExpanseSavingSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS TotalExp FROM Expense_Saving"></asp:SqlDataSource>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="ExpenseSavingGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpenseSavingID" DataSourceID="ExpenseSavingSQL" AllowSorting="True" AllowPaging="True" PageSize="30">
            <Columns>
                <asp:BoundField DataField="ExpenseSavingID" HeaderText="ID" SortExpression="ExpenseSavingID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="SavingFor" HeaderText="Saving For" SortExpression="SavingFor" />
                <asp:BoundField DataField="For_Month_Saving" HeaderText="For Month" SortExpression="For_Month_Saving" />
                <asp:BoundField DataField="ExpenseSavingDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Saving Date" SortExpression="ExpenseSavingDate" />
                <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Entry Date" SortExpression="Insert_Date" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
    </div>

    <script type="text/javascript">
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };

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
