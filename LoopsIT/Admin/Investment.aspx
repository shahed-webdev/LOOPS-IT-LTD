<%@ Page Title="Investment" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Investment.aspx.cs" Inherits="LoopsIT.Admin.Investment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Investment</h3>
    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>
                Amount
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="AmountTextBox" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Investment Date
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="InvestmentDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="InvestmentDateTextBox" runat="server" autocomplete="off" CssClass="Datetime form-control" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Investment Reason</label>
            <asp:TextBox ID="InvestmentForTextBox" runat="server" CssClass="form-control" onfocus="empty()" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Investor</label>
            <asp:TextBox ID="InvestorTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" ValidationGroup="A" />
            <asp:SqlDataSource ID="InvestmentSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Investment] WHERE [InvestmentID] = @InvestmentID" InsertCommand="INSERT INTO [Investment] ([RegistrationID], [InstitutionID], [Amount], [InvestmentFor], [Investor], [InvestmentDate]) VALUES (@RegistrationID, @InstitutionID, @Amount, @InvestmentFor, @Investor, @InvestmentDate)" SelectCommand="SELECT * FROM [Investment]" UpdateCommand="UPDATE [Investment] SET [RegistrationID] = @RegistrationID, [InstitutionID] = @InstitutionID, [Amount] = @Amount, [InvestmentFor] = @InvestmentFor, [Investor] = @Investor, [InvestmetnDate] = @InvestmetnDate, [Insert_Date] = @Insert_Date WHERE [InvestmentID] = @InvestmentID">
                <DeleteParameters>
                    <asp:Parameter Name="InvestmentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                    <asp:ControlParameter ControlID="AmountTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                    <asp:ControlParameter ControlID="InvestmentForTextBox" Name="InvestmentFor" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="InvestorTextBox" Name="Investor" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="InvestmentDateTextBox" Name="InvestmentDate" PropertyName="Text" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RegistrationID" Type="Int32" />
                    <asp:Parameter Name="InstitutionID" Type="Int32" />
                    <asp:Parameter Name="Amount" Type="Double" />
                    <asp:Parameter Name="InvestmentFor" Type="String" />
                    <asp:Parameter Name="Investor" Type="String" />
                    <asp:Parameter Name="InvestmetnDate" DbType="Date" />
                    <asp:Parameter Name="Insert_Date" Type="DateTime" />
                    <asp:Parameter Name="InvestmentID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="alert alert-success">
        <asp:Label ID="ExpnseSavingLabel" runat="server" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="ViewInvestmentSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT ISNULL(SUM(Amount), 0) AS TotalExp FROM Investment"></asp:SqlDataSource>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="ExpenseSavingGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="InvestmentID" DataSourceID="InvestmentSQL" AllowSorting="True" AllowPaging="True" PageSize="30">
            <Columns>
                <asp:BoundField DataField="InvestmentID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="InvestmentID" />
                <asp:BoundField DataField="Investor" HeaderText="Investor" SortExpression="Investor" />
                <asp:BoundField DataField="InvestmentFor" HeaderText="Reason" SortExpression="InvestmentFor" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="InvestmentDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Investment Date" SortExpression="InvestmentDate" />
                <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Entry Date" SortExpression="Insert_Date" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
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
