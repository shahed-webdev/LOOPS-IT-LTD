<%@ Page Title="Add Income" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Income.aspx.cs" Inherits="LoopsIT.Admin.Income" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../JQ/DatePicker/jquery.datepick.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Income</h3>
    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>
                <asp:LinkButton ID="AddnewLinkButton" runat="server" PostBackUrl="~/Admin/Income_Category.aspx">Add New Category</asp:LinkButton>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="IncomeCategoryDropDownList" CssClass="EroorStar" ErrorMessage="Select Category" InitialValue="0" ValidationGroup="A">*</asp:RequiredFieldValidator>
            </label>
            <asp:DropDownList ID="IncomeCategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="IncomeCategoryName" DataValueField="IncomeCategoryID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT CATEGORY ]</asp:ListItem>
            </asp:DropDownList>

            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Income_Category]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Project <a href="Add_Projects.aspx">Add Projects</a></label>
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="True" AppendDataBoundItems="True">
                <asp:ListItem Value="">[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Institution <a href="Add_Institution.aspx">Add Institution</a></label>
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT InstitutionID, RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Website, Address, InstitutionLogo, InstitutionStatus, InsertDate FROM Institution WHERE (ProjectID = ISNULL(@ProjectID,0))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Amount<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="AmountTextBox" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>For Month Pay</label>
            <asp:TextBox ID="For_Month_PayTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Income Date<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="IncomeDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="IncomeDateTextBox" runat="server" autocomplete="off" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Income For</label>
            <asp:TextBox ID="IncomeForTextBox" runat="server" CssClass="form-control" onfocus="empty()" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Collected By <a href="Add_Employee.aspx">Add New</a></label>
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" ValidationGroup="A" />
            <asp:SqlDataSource ID="IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT IncomeID, RegistrationID, IncomeCategoryID, InstitutionID, ProjectID, Amount, IncomeFor, For_Month_Pay, CollectedByEmployeeID, IncomeDate, Insert_Date FROM Income ORDER BY IncomeDate" UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)">
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
                <UpdateParameters>
                    <asp:Parameter Name="Amount" />
                    <asp:Parameter Name="IncomeFor" />
                    <asp:Parameter Name="For_Month_Pay" />
                    <asp:Parameter Name="IncomeDate" />
                    <asp:Parameter Name="IncomeID" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    <div class="clearfix"></div>

    <div class="alert alert-success">
        <asp:SqlDataSource ID="View_IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS Amount FROM Income" UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)">
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
            <UpdateParameters>
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="IncomeFor" />
                <asp:Parameter Name="For_Month_Pay" />
                <asp:Parameter Name="IncomeDate" />
                <asp:Parameter Name="IncomeID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="IncomeLabel" Font-Size="Large" runat="server"></asp:Label>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="IncomeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="IncomeID" DataSourceID="IncomeSQL" AllowSorting="True" AllowPaging="True" PageSize="30">
            <Columns>
                <asp:BoundField DataField="IncomeID" HeaderText="ID" ReadOnly="True" SortExpression="IncomeID" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="IncomeFor" HeaderText="Income For" SortExpression="IncomeFor" />
                <asp:BoundField DataField="For_Month_Pay" HeaderText="For Month Pay" SortExpression="For_Month_Pay" />
                <asp:BoundField DataField="IncomeDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Income Date" SortExpression="IncomeDate" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
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
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
