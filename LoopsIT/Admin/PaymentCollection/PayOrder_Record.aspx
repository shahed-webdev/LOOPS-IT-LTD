<%@ Page Title="Pay Order Record" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="PayOrder_Record.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.PayOrder_Record" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Pay Order Record</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="IncomeCategoryDropDownList" runat="server" CssClass=" form-control" DataSourceID="CategorySQL" DataTextField="IncomeCategoryName" DataValueField="IncomeCategoryID" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT CATEGORY ]</asp:ListItem>
            </asp:DropDownList>

            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>"
                SelectCommand="SELECT DISTINCT Income_Category.IncomeCategoryID, Income_Category.IncomeCategoryName FROM Income_Category INNER JOIN PayOrder ON Income_Category.IncomeCategoryID = PayOrder.IncomeCategoryID"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass=" form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="True" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT PROJECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT Project.ProjectID, Project.ProjectName FROM Project INNER JOIN Institution ON Project.ProjectID = Institution.ProjectID INNER JOIN PayOrder ON Institution.InstitutionID = PayOrder.InstitutionID"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID" OnDataBound="InstitutionDropDownList_DataBound">
                <asp:ListItem Value="%">[ SELECT INSTITUTION ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT InstitutionID, RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Website, Address, InstitutionLogo, InstitutionStatus, InsertDate FROM Institution WHERE (ProjectID Like ISNULL(@ProjectID,0))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FromDateTextBox" Placeholder="From Date" runat="server" autocomplete="off" CssClass="form-control DT" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ToDateTextBox" Placeholder="To Date" runat="server" CssClass="form-control DT" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Find" ValidationGroup="A" OnClick="SubmitButton_Click" />
        </div>
    </div>

    <asp:SqlDataSource ID="View_PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT ISNULL(SUM(PayOrder.Amount), 0) AS Amount FROM PayOrder INNER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID WHERE (ISNULL(PayOrder.IncomeCategoryID, '') LIKE @IncomeCategoryID) AND (ISNULL(PayOrder.InstitutionID, '') LIKE @InstitutionID) AND (ISNULL(Institution.ProjectID, '') LIKE @ProjectID)" UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)" CancelSelectOnNullParameter="False">
        <DeleteParameters>
            <asp:Parameter Name="IncomeID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="IncomeCategoryDropDownList" Name="IncomeCategoryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="AmountTextBox" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="IncomeForTextBox" Name="IncomeFor" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="For_Month_PayTextBox" Name="For_Month_Pay" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="EmployeeDropDownList" Name="CollectedByEmployeeID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="IncomeDateTextBox" DbType="Date" Name="IncomeDate" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="IncomeCategoryDropDownList" Name="IncomeCategoryID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
            <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="IncomeFor" />
            <asp:Parameter Name="For_Month_Pay" />
            <asp:Parameter Name="IncomeDate" />
            <asp:Parameter Name="IncomeID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="table-responsive">
        <div class="alert alert-info">
            <asp:Label ID="IncomeLabel" runat="server" Font-Bold="True"></asp:Label>
        </div>

        <asp:GridView ID="IncomeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="PayOrderID" DataSourceID="PayOrderSQL" AllowSorting="True" PageSize="30">
            <Columns>
                <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" />
                <asp:BoundField DataField="IncomeCategoryName" HeaderText="Category" SortExpression="IncomeCategoryName" />
                <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ReadOnly="True" />
                <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
                <asp:BoundField DataField="UseDate" HeaderText="Use Date" SortExpression="UseDate" />
                <asp:BoundField DataField="Insert_By" HeaderText="Insert By" SortExpression="Insert_By" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT PayOrder.PayOrderID, PayOrder.IncomeCategoryID, PayOrder.InstitutionID, Project.ProjectName, Institution.InstitutionName, Income_Category.IncomeCategoryName, PayOrder.Unit, PayOrder.UnitPrice, PayOrder.Amount, PayOrder.Details, PayOrder.Month, PayOrder.UseDate, Registration.Name AS Insert_By FROM PayOrder LEFT OUTER JOIN Registration ON PayOrder.RegistrationID = Registration.RegistrationID LEFT OUTER JOIN Income_Category ON PayOrder.IncomeCategoryID = Income_Category.IncomeCategoryID LEFT OUTER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID LEFT OUTER JOIN Project ON Institution.ProjectID = Project.ProjectID WHERE (ISNULL(PayOrder.IncomeCategoryID, '') LIKE @IncomeCategoryID) AND (ISNULL(Project.ProjectID, '') LIKE @ProjectID) AND (ISNULL(PayOrder.InstitutionID, '') LIKE @InstitutionID) AND (PayOrder.UseDate BETWEEN ISNULL(@F_Date, '1-1-1000') AND ISNULL(@T_Date, '1-1-3000')) " UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)" CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:Parameter Name="IncomeID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="IncomeCategoryDropDownList" Name="IncomeCategoryID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="AmountTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                <asp:ControlParameter ControlID="IncomeForTextBox" Name="IncomeFor" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="For_Month_PayTextBox" Name="For_Month_Pay" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="CollectedByEmployeeID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="IncomeDateTextBox" DbType="Date" Name="IncomeDate" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="IncomeCategoryDropDownList" Name="IncomeCategoryID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="IncomeFor" />
                <asp:Parameter Name="For_Month_Pay" />
                <asp:Parameter Name="IncomeDate" />
                <asp:Parameter Name="IncomeID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>


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
