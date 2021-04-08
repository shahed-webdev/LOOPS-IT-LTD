<%@ Page Title="Add Expense Category" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Expense_Category.aspx.cs" Inherits="LoopsIT.Admin.Add_Expense_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <h3>Add Expense Category</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="MainCategory_DropDownList" CssClass="form-control" runat="server" AppendDataBoundItems="True" DataSourceID="MainCategorySQL" DataTextField="MainCategoryName" DataValueField="MainCategoryID">
                <asp:ListItem Value="0">[ SELECT MAIN CATEGORY ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="MainCategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT [MainCategoryID], [MainCategoryName] FROM [Main_Category]"></asp:SqlDataSource>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="MainCategory_DropDownList" InitialValue="0" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="ADD"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="CategoryNameTextBox" placeholder="Category Name" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CategoryNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="ADD"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="AddCategoryButton" runat="server" CssClass="btn btn-primary" OnClick="AddCategoryButton_Click" Text="Add" ValidationGroup="ADD" />
        </div>
    </div>

    <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Expense_Category] WHERE [ExpenseCategoryID] = @ExpenseCategoryID" InsertCommand="INSERT INTO Expense_Category(RegistrationID, ExpenseCategoryName, MainCategoryID) VALUES (@RegistrationID, @ExpenseCategoryName, @MainCategoryID)"
        SelectCommand="SELECT Expense_Category.ExpenseCategoryID, Expense_Category.RegistrationID, Expense_Category.ExpenseCategoryName, Expense_Category.InsertDate, Main_Category.MainCategoryName, ISNULL(Expense_Category.MainCategoryID,0) as MainCategoryID FROM Expense_Category LEFT OUTER JOIN Main_Category ON Expense_Category.MainCategoryID = Main_Category.MainCategoryID ORDER BY Expense_Category.ExpenseCategoryName" UpdateCommand="UPDATE Expense_Category SET ExpenseCategoryName = @ExpenseCategoryName, MainCategoryID = @MainCategoryID WHERE (ExpenseCategoryID = @ExpenseCategoryID)">
        <DeleteParameters>
            <asp:Parameter Name="ExpenseCategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="CategoryNameTextBox" Name="ExpenseCategoryName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="MainCategory_DropDownList" Name="MainCategoryID" PropertyName="SelectedValue" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExpenseCategoryName" Type="String" />
            <asp:Parameter Name="MainCategoryID" />
            <asp:Parameter Name="ExpenseCategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="ExCategoryGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ExpenseCategoryID" DataSourceID="CategorySQL" CssClass="mGrid" AllowSorting="True">
        <PagerStyle CssClass="pgr" />
        <Columns>
            <asp:TemplateField HeaderText="Main Category" SortExpression="MainCategoryName">
                    <EditItemTemplate>
                        <asp:DropDownList DataSourceID="MainCategorySQL" ID="EditMainCategory_DropDownList" SelectedValue='<%# Bind("MainCategoryID") %>' CssClass="form-control" runat="server" DataTextField="MainCategoryName" DataValueField="MainCategoryID" AppendDataBoundItems="True">
                            <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("MainCategoryName") %>
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" SortExpression="ExpenseCategoryName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ExpenseCategoryName") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ExpenseCategoryName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" UpdateText="Save" HeaderText="Edit">
                <ItemStyle Width="60px" />
            </asp:CommandField>
            <asp:TemplateField ShowHeader="False" HeaderText="Delete">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure want to delete?')"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle Width="50px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
