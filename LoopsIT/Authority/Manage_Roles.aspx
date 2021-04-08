<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Manage_Roles.aspx.cs" Inherits="LoopsIT.Authority.Manage_Roles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Manage-Role.css" rel="stylesheet" />
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<div id="Role-Manage">
<h2>User Role Management</h2>
<asp:Label ID="ActionStatus" runat="server" ForeColor="#CE5300"></asp:Label>

  <h3>Manage Roles By User</h3>

    <table>
        <tr>
            <td>
                Select a User:</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True" DataTextField="UserName" DataValueField="UserName" OnSelectedIndexChanged="UserList_SelectedIndexChanged" CssClass="form-control" />

            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                Select Role(s):
            </td>
        </tr>
        <tr>
            <td>
        <asp:Repeater ID="UsersRoleList" runat="server">
            <ItemTemplate>
                <asp:CheckBox runat="server" ID="RoleCheckBox" AutoPostBack="true" Text='<%# Container.DataItem %>' OnCheckedChanged="RoleCheckBox_CheckChanged" />
                <br />
            </ItemTemplate>
        </asp:Repeater>
            </td>
        </tr>
    </table>



    <h3>Manage Users By Role</h3>

    <table>
        <tr>
            <td>
              Select a Role</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="RoleList" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="RoleList_SelectedIndexChanged" CssClass="form-control">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
   
    <asp:GridView ID="RolesUserList" runat="server" AutoGenerateColumns="False"
            EmptyDataText="No users belong to this role."
            OnRowDeleting="RolesUserList_RowDeleting" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="50%">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Remove" OnClientClick="return confirm('Are you sure you want to remove?')"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Users">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="UserNameLabel" Text='<%# Container.DataItem %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
 
    <table>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>User Name <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserNameToAddToRole" CssClass="EroorStar" ErrorMessage="Enter a User Name" ValidationGroup="U"></asp:RequiredFieldValidator>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="UserNameToAddToRole" runat="server" CssClass="form-control"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="AddUserToRoleButton" runat="server" Text="Add User to Role" OnClick="AddUserToRoleButton_Click" CssClass="Submit-Button" ValidationGroup="U" />


            </td>
        </tr>
        </table>
    
</div>
</asp:Content>
