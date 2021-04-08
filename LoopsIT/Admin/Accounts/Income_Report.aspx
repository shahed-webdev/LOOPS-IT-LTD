<%@ Page Title="Income Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Income_Report.aspx.cs" Inherits="LoopsIT.Admin.Accounts.Income_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Income Report</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="IncomeCategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="IncomeCategoryName" DataValueField="IncomeCategoryID" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT CATEGORY ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Income_Category]"></asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="True" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT PROJECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID" OnDataBound="InstitutionDropDownList_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT InstitutionID, RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Website, Address, InstitutionLogo, InstitutionStatus, InsertDate FROM Institution WHERE (ProjectID Like ISNULL(@ProjectID,0))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID" AppendDataBoundItems="True">
                <asp:ListItem Value="%">[ SELECT EMPLOYEE ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FromDateTextBox" placeholder="From Date" runat="server" autocomplete="off" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ToDateTextBox" placeholder="To Date" runat="server" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:TextBox ID="IDTextBox" placeholder="ID" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="AmontTextBox" placeholder="Amount" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Submit" ValidationGroup="A" />
        </div>
    </div>

    <div class="alert alert-success">
        <asp:SqlDataSource ID="View_IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS Amount FROM Income

WHERE        (ISNULL(Income.IncomeCategoryID,'') LIKE @IncomeCategoryID) AND (ISNULL(Income.ProjectID,'') LIKE @ProjectID) AND (ISNULL(Income.InstitutionID,'') LIKE @InstitutionID) AND (ISNULL(Income.CollectedByEmployeeID,'') LIKE @CollectedByEmployeeID) AND 
                         (Income.IncomeDate between  ISNULL(@F_Date,'1-1-1000') and ISNULL(@T_Date,'1-1-3000')) AND
 (Income.IncomeID Like ISNULL(@IncomeID,'%')) AND (ISNULL(Income.Amount,'')  Like ISNULL(@Amount,'%'))"
            UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)" CancelSelectOnNullParameter="False">
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
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="CollectedByEmployeeID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="IDTextBox" Name="IncomeID" PropertyName="Text" />
                <asp:ControlParameter ControlID="AmontTextBox" Name="Amount" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="IncomeFor" />
                <asp:Parameter Name="For_Month_Pay" />
                <asp:Parameter Name="IncomeDate" />
                <asp:Parameter Name="IncomeID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="IncomeLabel" runat="server" Font-Size="Large"></asp:Label>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="IncomeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="IncomeID" DataSourceID="IncomeSQL" AllowSorting="True" PageSize="30">
            <Columns>
                <asp:BoundField DataField="IncomeID" HeaderText="Income ID" ReadOnly="True" SortExpression="IncomeID" InsertVisible="False" />
                <asp:BoundField DataField="IncomeCategoryName" HeaderText="Category" SortExpression="IncomeCategoryName" />
                <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="IncomeFor" HeaderText="Income For" SortExpression="IncomeFor" />
                <asp:BoundField DataField="For_Month_Pay" HeaderText="For Month" SortExpression="For_Month_Pay" />
                <asp:BoundField DataField="IncomeDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="IncomeDate" />
                <asp:BoundField DataField="Collected_By" HeaderText="Collected By" SortExpression="Collected_By" />
                <asp:BoundField DataField="Insert_By" HeaderText="Insert By" SortExpression="Insert_By" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT        Income.IncomeID, Income.IncomeCategoryID, Income.InstitutionID, Income.ProjectID, Income.Amount, Income.IncomeFor, Income.For_Month_Pay, Income.CollectedByEmployeeID, Income.IncomeDate, 
                         Employee.EmployeeName AS Collected_By, Income_Category.IncomeCategoryName, Registration.Name AS Insert_By, Institution.InstitutionName, Project.ProjectName
FROM           Income LEFT OUTER JOIN
                         Registration ON Income.RegistrationID = Registration.RegistrationID LEFT OUTER JOIN
                         Income_Category ON Income.IncomeCategoryID = Income_Category.IncomeCategoryID LEFT OUTER JOIN
                         Institution ON Income.InstitutionID = Institution.InstitutionID LEFT OUTER JOIN
                         Project ON Income.ProjectID = Project.ProjectID LEFT OUTER JOIN
                         Employee ON Income.CollectedByEmployeeID = Employee.EmployeeID
WHERE      
  (ISNULL(Income.IncomeCategoryID,'') LIKE @IncomeCategoryID) AND 
  (ISNULL(Income.ProjectID,'') LIKE @ProjectID) AND 
  (ISNULL(Income.InstitutionID,'') LIKE @InstitutionID) AND 
  (ISNULL(Income.CollectedByEmployeeID,'') LIKE @CollectedByEmployeeID) AND 
  (Income.IncomeDate between  ISNULL(@F_Date,'1-1-1000') and ISNULL(@T_Date,'1-1-3000')) AND
 (Income.IncomeID Like ISNULL(@IncomeID,'%')) AND (ISNULL(Income.Amount,'')  Like ISNULL(@Amount,'%'))"
            UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)" CancelSelectOnNullParameter="False">
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
                <asp:ControlParameter ControlID="EmployeeDropDownList" Name="CollectedByEmployeeID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="F_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="T_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="IDTextBox" Name="IncomeID" PropertyName="Text" />
                <asp:ControlParameter ControlID="AmontTextBox" Name="Amount" PropertyName="Text" />
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
