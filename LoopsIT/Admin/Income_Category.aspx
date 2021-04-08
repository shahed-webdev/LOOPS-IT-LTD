<%@ Page Title="Add Income Category" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Income_Category.aspx.cs" Inherits="LoopsIT.Admin.Income_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Income Category</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="MainCategory_DropDownList" CssClass="form-control" runat="server" AppendDataBoundItems="True" DataSourceID="MainCategorySQL" DataTextField="MainCategoryName" DataValueField="MainCategoryID">
                <asp:ListItem Value="">[ SELECT MAIN CATEGORY ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="MainCategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT [MainCategoryID], [MainCategoryName] FROM [Main_Category]"></asp:SqlDataSource>
          
        </div>
        <div class="form-group">
            <asp:TextBox ID="CategoryNameTextBox" runat="server" CssClass="form-control" placeholder="Category Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CategoryNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="ADD"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="AddCategoryButton" runat="server" CssClass="btn btn-primary" OnClick="AddCategoryButton_Click" Text="Add" ValidationGroup="ADD" />
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="CategoryGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="IncomeCategoryID" DataSourceID="CategorySQL" CssClass="mGrid">
            <PagerStyle CssClass="pgr" />
            <Columns>
                <asp:TemplateField HeaderText="Main Category">
                    <EditItemTemplate>
                        <asp:DropDownList DataSourceID="MainCategorySQL" ID="EditMainCategory_DropDownList" SelectedValue='<%# Bind("MainCategoryID") %>' CssClass="form-control" runat="server" DataTextField="MainCategoryName" DataValueField="MainCategoryID" AppendDataBoundItems="True">
                            <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%# Eval("MainCategoryName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IncomeCategoryName") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("IncomeCategoryName") %>'></asp:Label>
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
        <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Income_Category] WHERE [IncomeCategoryID] = @IncomeCategoryID" InsertCommand="INSERT INTO Income_Category(RegistrationID, IncomeCategoryName, MainCategoryID) VALUES (@RegistrationID, @IncomeCategoryName, @MainCategoryID)"
            SelectCommand="SELECT Income_Category.IncomeCategoryID, Income_Category.RegistrationID, Income_Category.IncomeCategoryName, Income_Category.InsertDate, ISNULL(Income_Category.MainCategoryID,0) as MainCategoryID, Main_Category.MainCategoryName FROM Income_Category LEFT OUTER JOIN Main_Category ON Income_Category.MainCategoryID = Main_Category.MainCategoryID" UpdateCommand="UPDATE Income_Category SET IncomeCategoryName = @IncomeCategoryName, MainCategoryID = @MainCategoryID WHERE (IncomeCategoryID = @IncomeCategoryID)">
            <DeleteParameters>
                <asp:Parameter Name="IncomeCategoryID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="CategoryNameTextBox" Name="IncomeCategoryName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="MainCategory_DropDownList" Name="MainCategoryID" PropertyName="SelectedValue" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IncomeCategoryName" Type="String" />
                <asp:Parameter Name="IncomeCategoryID" Type="Int32" />
                <asp:Parameter Name="MainCategoryID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
