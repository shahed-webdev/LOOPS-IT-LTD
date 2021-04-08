<%@ Page Title="Add Main Category" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Main_Category.aspx.cs" Inherits="LoopsIT.Admin.Accounts.Add_Main_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Main Category</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="CategoryTextBox" placeholder="Category Name" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="CategoryTextBox" ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" CssClass="EroorStar" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="SNTextBox" placeholder="SN" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="Add_Button" runat="server" Text="Add" CssClass="btn btn-primary" ValidationGroup="1" OnClick="Add_Button_Click" />
        </div>
    </div>

    <asp:GridView ID="Ctegory_GridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="MainCategoryID" DataSourceID="CategorySQL" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="SN" HeaderText="SN" SortExpression="SN" />
            <asp:BoundField DataField="MainCategoryName" HeaderText="Category Name" SortExpression="MainCategoryName" />
            <asp:CommandField ShowEditButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Main_Category] WHERE [MainCategoryID] = @MainCategoryID" InsertCommand="INSERT INTO [Main_Category] ([RegistrationID], [MainCategoryName], [SN]) VALUES (@RegistrationID, @MainCategoryName, @SN)" SelectCommand="SELECT * FROM [Main_Category] ORDER BY SN" UpdateCommand="UPDATE Main_Category SET MainCategoryName = @MainCategoryName, SN = @SN WHERE (MainCategoryID = @MainCategoryID)">
        <DeleteParameters>
            <asp:Parameter Name="MainCategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="CategoryTextBox" Name="MainCategoryName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="SNTextBox" Name="SN" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MainCategoryName" Type="String" />
            <asp:Parameter Name="SN" Type="Int32" />
            <asp:Parameter Name="MainCategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
