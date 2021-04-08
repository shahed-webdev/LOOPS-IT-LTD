<%@ Page Title="Add Job Category" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Job_Category.aspx.cs" Inherits="LoopsIT.Admin.Job_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Job Category</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="CategoryNameTextBox" placeholder="Category Name" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CategoryNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="ADD"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="AddCategoryButton" runat="server" CssClass="btn btn-primary" OnClick="AddCategoryButton_Click" Text="Add" ValidationGroup="ADD" />
        </div>
    </div>

    <asp:GridView ID="CategoryGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="JobCategoryID" DataSourceID="CategorySQL" CssClass="mGrid" AllowPaging="True">
        <PagerStyle CssClass="pgr" />
        <Columns>
            <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("JobCategoryName") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("JobCategoryName") %>'></asp:Label>
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
    <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Job_Category] WHERE [JobCategoryID] = @JobCategoryID" InsertCommand="INSERT INTO Job_Category(RegistrationID, JobCategoryName) VALUES (@RegistrationID, @JobCategoryName)"
        SelectCommand="SELECT * FROM [Job_Category]" UpdateCommand="UPDATE Job_Category SET JobCategoryName = @JobCategoryName WHERE (JobCategoryID = @JobCategoryID)">
        <DeleteParameters>
            <asp:Parameter Name="JobCategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="CategoryNameTextBox" Name="JobCategoryName" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobCategoryName" Type="String" />
            <asp:Parameter Name="JobCategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
