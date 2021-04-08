<%@ Page Title="Create Invoice" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Invoice_Create.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.Invoice_Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Create Invoice</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass=" form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="True" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ Select Project ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT Project.ProjectID, Project.ProjectName FROM Project RIGHT OUTER JOIN Institution ON Project.ProjectID = Institution.ProjectID RIGHT OUTER JOIN PayOrder ON Institution.InstitutionID = PayOrder.InstitutionID WHERE (PayOrder.InvoiceID IS NULL)"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID" OnDataBound="InstitutionDropDownList_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT DISTINCT PayOrder.InstitutionID, Institution.InstitutionName FROM PayOrder LEFT OUTER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID WHERE (PayOrder.InvoiceID IS NULL) AND (Institution.ProjectID = @ProjectID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="InstitutionDropDownList" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A" InitialValue="%"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="IssueDateTextBox" placeholder="Issue Date" runat="server" autocomplete="off" CssClass="form-control DT" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
            <asp:RequiredFieldValidator ID="Rf" runat="server" ControlToValidate="IssueDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="EndDateTextBox" runat="server" placeholder="End Date" CssClass="form-control DT" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="EndDateTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="InvoiceForTextBox" placeholder="Invoice For" runat="server" CssClass=" form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="InvoiceForTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="A"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="DiscountTextBox" placeholder="Discount" runat="server" CssClass=" form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" ValidationGroup="A" />
            <asp:SqlDataSource ID="View_PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO [Income] ([RegistrationID], [IncomeCategoryID], [InstitutionID], [ProjectID], [Amount], [IncomeFor], [For_Month_Pay], [CollectedByEmployeeID], [IncomeDate]) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @ProjectID, @Amount, @IncomeFor, @For_Month_Pay, @CollectedByEmployeeID, @IncomeDate)" SelectCommand="SELECT ISNULL(SUM(PayOrder.Amount), 0) AS Amount FROM PayOrder INNER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID WHERE (PayOrder.InvoiceID IS NULL) AND (ISNULL(PayOrder.InstitutionID, '') LIKE @InstitutionID) " UpdateCommand="UPDATE Income SET Amount = @Amount, IncomeFor = @IncomeFor, For_Month_Pay = @For_Month_Pay, IncomeDate = @IncomeDate WHERE (IncomeID = @IncomeID)" CancelSelectOnNullParameter="False">
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
                    <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" />
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
    </div>


    <div class="table-responsive">
        <div class="alert alert-success">
            <asp:Label ID="IncomeLabel" runat="server" Font-Bold="True"></asp:Label>
        </div>

        <asp:GridView ID="IncomeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="PayOrderID" DataSourceID="PayOrderSQL" AllowSorting="True" PageSize="30">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <HeaderTemplate>
                        <asp:CheckBox ID="SelectAllCheckBox" runat="server" Text=" " />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="SelectCheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" />
                <asp:BoundField DataField="IncomeCategoryName" HeaderText="Category" SortExpression="IncomeCategoryName" />
                <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ReadOnly="True" />
                <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
                <asp:BoundField DataField="UseDate" HeaderText="Use Date" SortExpression="UseDate" DataFormatString="{0:d MMM yyy}" />
                <asp:BoundField DataField="Insert_By" HeaderText="Insert By" SortExpression="Insert_By" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT PayOrder.PayOrderID, PayOrder.IncomeCategoryID, PayOrder.InstitutionID, Project.ProjectName, Institution.InstitutionName, Income_Category.IncomeCategoryName, PayOrder.Unit, PayOrder.UnitPrice, PayOrder.Amount, PayOrder.Details, PayOrder.Month, PayOrder.UseDate, Registration.Name AS Insert_By FROM PayOrder LEFT OUTER JOIN Registration ON PayOrder.RegistrationID = Registration.RegistrationID LEFT OUTER JOIN Income_Category ON PayOrder.IncomeCategoryID = Income_Category.IncomeCategoryID LEFT OUTER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID LEFT OUTER JOIN Project ON Institution.ProjectID = Project.ProjectID WHERE (ISNULL(PayOrder.InstitutionID, '') LIKE @InstitutionID) AND (PayOrder.InvoiceID IS NULL)" CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="InvoiceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [IncomeID] = @IncomeID" InsertCommand="INSERT INTO PayOrder_Invoice(RegistrationID, InstitutionID, IssueDate, EndDate, Invoice_For, Discount) VALUES (@RegistrationID, @InstitutionID, @IssueDate, @EndDate, @Invoice_For, @Discount)
SET @InvoiceID = scope_identity()"
            SelectCommand="SELECT PayOrder.PayOrderID, PayOrder.IncomeCategoryID, PayOrder.InstitutionID, Project.ProjectName, Institution.InstitutionName, Income_Category.IncomeCategoryName, PayOrder.Unit, PayOrder.UnitPrice, PayOrder.Amount, PayOrder.Details, PayOrder.Month, PayOrder.UseDate, Registration.Name AS Insert_By FROM PayOrder LEFT OUTER JOIN Registration ON PayOrder.RegistrationID = Registration.RegistrationID LEFT OUTER JOIN Income_Category ON PayOrder.IncomeCategoryID = Income_Category.IncomeCategoryID LEFT OUTER JOIN Institution ON PayOrder.InstitutionID = Institution.InstitutionID LEFT OUTER JOIN Project ON Institution.ProjectID = Project.ProjectID WHERE (ISNULL(PayOrder.InstitutionID, '') LIKE @InstitutionID) AND (PayOrder.InvoiceID IS NULL)" UpdateCommand="UPDATE PayOrder SET InvoiceID = @InvoiceID WHERE (PayOrderID = @PayOrderID)" CancelSelectOnNullParameter="False" OnInserted="InvoiceSQL_Inserted">
            <DeleteParameters>
                <asp:Parameter Name="IncomeID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="IssueDateTextBox" Name="IssueDate" PropertyName="Text" />
                <asp:ControlParameter ControlID="EndDateTextBox" Name="EndDate" PropertyName="Text" />
                <asp:ControlParameter ControlID="InvoiceForTextBox" Name="Invoice_For" PropertyName="Text" />
                <asp:ControlParameter ControlID="DiscountTextBox" Name="Discount" PropertyName="Text" />
                <asp:Parameter Direction="Output" Name="InvoiceID" Size="50" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="InvoiceID" />
                <asp:Parameter Name="PayOrderID" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <%if (IncomeGridView.Rows.Count > 0)
            {%>
        <br />
        <asp:Button ID="CreateButton" runat="server" CssClass="btn btn-primary" Text="Create" ValidationGroup="A" OnClick="CreateButton_Click" />
        <%} %>
    </div>

    <script type="text/javascript">
        $(function () {
            $(".DT").datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            $("[id*=SelectAllCheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });

            $("[id*=SelectCheckBox]").on("click", function () {
                var a = $(this).closest("table"), b = $("[id*=chkHeader]", a);
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=chkRow]", a).length == $("[id*=chkRow]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
            });
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
