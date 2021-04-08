<%@ Page Title="Add Projects" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Projects.aspx.cs" Inherits="LoopsIT.Admin.Add_Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Projects</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="ProjectNameTextBox" placeholder="Project Name" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ProjectNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:RadioButtonList ID="ProjectTypeRadioButtonList" runat="server" CssClass="form-control" RepeatDirection="Horizontal">
                <asp:ListItem>Own</asp:ListItem>
                <asp:ListItem>Out source</asp:ListItem>
                <asp:ListItem>Join</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ProjectTypeRadioButtonList" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:RadioButtonList ID="ProjectStatusRadioButtonList" runat="server" CssClass="form-control" RepeatDirection="Horizontal">
                <asp:ListItem>New</asp:ListItem>
                <asp:ListItem>Ongoing</asp:ListItem>
                <asp:ListItem>Completed</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ProjectStatusRadioButtonList" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="SubmitButton_Click" ValidationGroup="1" />
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="ProjectGridView" runat="server" CssClass="mGrid" AutoGenerateColumns="False" DataKeyNames="ProjectID" DataSourceID="ProjectSQL">
            <Columns>
                <asp:BoundField DataField="ProjectName" HeaderText="Project Name" SortExpression="ProjectName" />
                <asp:BoundField DataField="ProjectType" HeaderText="Project Type" SortExpression="ProjectType" />
                <asp:BoundField DataField="ProjectStatus" HeaderText="Project Status" SortExpression="ProjectStatus" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Project] WHERE [ProjectID] = @ProjectID" InsertCommand="INSERT INTO Project(RegistrationID, ProjectName, ProjectType, ProjectStatus) VALUES (@RegistrationID, @ProjectName, @ProjectType, @ProjectStatus)" SelectCommand="SELECT * FROM [Project]" UpdateCommand="UPDATE Project SET ProjectName = @ProjectName, ProjectType = @ProjectType, ProjectStatus = @ProjectStatus WHERE (ProjectID = @ProjectID)">
            <DeleteParameters>
                <asp:Parameter Name="ProjectID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="ProjectNameTextBox" Name="ProjectName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ProjectTypeRadioButtonList" Name="ProjectType" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="ProjectStatusRadioButtonList" Name="ProjectStatus" PropertyName="SelectedValue" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProjectName" Type="String" />
                <asp:Parameter Name="ProjectType" Type="String" />
                <asp:Parameter Name="ProjectStatus" Type="String" />
                <asp:Parameter Name="ProjectID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
