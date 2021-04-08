<%@ Page Title="Monthly Expense Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Expense_Monthly_Report.aspx.cs" Inherits="LoopsIT.Admin.Accounts.Expense_Monthly_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="alert alert-success">
        <asp:Label ID="ExpnseLabel" runat="server" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="ViewExpanseSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT SUM(Amount) AS Total_Expense FROM Expense"></asp:SqlDataSource>
    </div>

    <div class="panel with-nav-tabs panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a href="#tab1primary" data-toggle="tab">Month Wise Expense</a></li>
                <li><a href="#tab2primary" data-toggle="tab">Category Wise Expense</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div class="tab-pane fade in active" id="tab1primary">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:GridView ID="Expense_Monthly_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Year,Month" DataSourceID="Expense_MonthlySQL" AllowSorting="True">
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Bind("Month") %>'></asp:LinkButton>
                                                    (<asp:Label ID="Label1" runat="server" Text='<%# Bind("Year") %>'></asp:Label>)
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left"/>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Total_Expense" HeaderText="Total" ReadOnly="True" SortExpression="Total_Expense"></asp:BoundField>
                                        </Columns>
                                        <SelectedRowStyle BackColor="#DFF0D8"/>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="Expense_MonthlySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense] WHERE [ExpenseID] = @ExpenseID" InsertCommand="INSERT INTO Expense(RegistrationID, ExpenseCategoryID, ExpenseByEmployeeID, ExpenseFor, Amount, ExpenseDate) VALUES (@RegistrationID, @ExpenseCategoryID, @ExpenseByEmployeeID, @ExpenseFor, @Amount, @ExpenseDate)" SelectCommand="SELECT SUM(Amount) AS Total_Expense, year(ExpenseDate) as [Year], DATENAME(month, ExpenseDate) as [Month]
FROM Expense
group by month(ExpenseDate),DATENAME(month, ExpenseDate),year(ExpenseDate) order by  year(ExpenseDate),  month(ExpenseDate)"
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
                                        <UpdateParameters>
                                            <asp:Parameter Name="ExpenseFor" />
                                            <asp:Parameter Name="Amount" />
                                            <asp:Parameter Name="ExpenseDate" />
                                            <asp:Parameter Name="ExpenseID" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="col-sm-6">
                                    <asp:GridView ID="Expense_Category_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpenseCategoryID" DataSourceID="Expense_CategorySQL" AllowSorting="True">
                                        <Columns>
                                            <asp:BoundField DataField="ExpenseCategoryName" HeaderText="Category" SortExpression="ExpenseCategoryName" />
                                            <asp:BoundField DataField="Total_Expense" HeaderText="Total" ReadOnly="True" SortExpression="Total_Expense" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="Expense_CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense] WHERE [ExpenseID] = @ExpenseID" InsertCommand="INSERT INTO Expense(RegistrationID, ExpenseCategoryID, ExpenseByEmployeeID, ExpenseFor, Amount, ExpenseDate) VALUES (@RegistrationID, @ExpenseCategoryID, @ExpenseByEmployeeID, @ExpenseFor, @Amount, @ExpenseDate)" SelectCommand="SELECT        Expense.ExpenseCategoryID, Expense_Category.ExpenseCategoryName, SUM(Expense.Amount) AS Total_Expense
FROM            Expense INNER JOIN
                         Expense_Category ON Expense.ExpenseCategoryID = Expense_Category.ExpenseCategoryID 
WHERE   (YEAR(Expense.ExpenseDate) LIKE ISNULL(@Year,'%')) AND (DATENAME(month, Expense.ExpenseDate) LIKE ISNULL(@Month,'%'))
GROUP BY Expense.ExpenseCategoryID, Expense_Category.ExpenseCategoryName
   
ORDER BY Total_Expense DESC"
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
                                            <asp:ControlParameter ControlID="Expense_Monthly_GridView" Name="Year" PropertyName="SelectedDataKey[0]" />
                                            <asp:ControlParameter ControlID="Expense_Monthly_GridView" Name="Month" PropertyName="SelectedDataKey[1]" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ExpenseFor" />
                                            <asp:Parameter Name="Amount" />
                                            <asp:Parameter Name="ExpenseDate" />
                                            <asp:Parameter Name="ExpenseID" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="tab-pane fade" id="tab2primary">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="ExCategoryDropDownList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="ExpenseCategoryName" DataValueField="ExpenseCategoryID">
                                        <asp:ListItem Value="0">[ SELECT CATEGORY ]</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Expense_Category]"></asp:SqlDataSource>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <asp:GridView ID="Expense_Category_Monthly_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Expense_Category_MonthlySQL" AllowSorting="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Year" SortExpression="Year">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Month") %>'></asp:Label>
                                                (<asp:Label ID="Label1" runat="server" Text='<%# Bind("Year") %>'></asp:Label>)
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ExpenseCategoryName" HeaderText="Category" SortExpression="ExpenseCategoryName" />
                                        <asp:BoundField DataField="Total_Expense" HeaderText="Total" ReadOnly="True" SortExpression="Total_Expense" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="Expense_Category_MonthlySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense] WHERE [ExpenseID] = @ExpenseID" InsertCommand="INSERT INTO Expense(RegistrationID, ExpenseCategoryID, ExpenseByEmployeeID, ExpenseFor, Amount, ExpenseDate) VALUES (@RegistrationID, @ExpenseCategoryID, @ExpenseByEmployeeID, @ExpenseFor, @Amount, @ExpenseDate)" SelectCommand="SELECT        Expense.ExpenseCategoryID, YEAR(Expense.ExpenseDate) AS Year, DATENAME(month, Expense.ExpenseDate) AS Month, Expense_Category.ExpenseCategoryName, SUM(Expense.Amount) 
                         AS Total_Expense
FROM            Expense INNER JOIN
                         Expense_Category ON Expense.ExpenseCategoryID = Expense_Category.ExpenseCategoryID
GROUP BY Expense.ExpenseCategoryID, MONTH(Expense.ExpenseDate), DATENAME(month, Expense.ExpenseDate), YEAR(Expense.ExpenseDate), Expense_Category.ExpenseCategoryName
HAVING   (Expense.ExpenseCategoryID LIKE ISNULL(@ExpenseCategoryID,'%'))
ORDER BY Year, MONTH(Expense.ExpenseDate), Total_Expense DESC"
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
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="ExpenseFor" />
                                        <asp:Parameter Name="Amount" />
                                        <asp:Parameter Name="ExpenseDate" />
                                        <asp:Parameter Name="ExpenseID" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
