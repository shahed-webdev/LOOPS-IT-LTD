<%@ Page Title="Add Contacts List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Contacts_List.aspx.cs" Inherits="LoopsIT.Admin.Add_Contacts_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Contacts List</h3>

    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>Project <a href="Add_Projects.aspx">Add Projects</a></label>
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AppendDataBoundItems="True">
                <asp:ListItem>[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Institution</label>
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID" AppendDataBoundItems="True">
                <asp:ListItem>[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Institution]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Contract Name</label>
            <asp:TextBox ID="ContractNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Designation</label>
            <asp:TextBox ID="DesignationTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Phone</label>
            <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Email</label>
            <asp:TextBox ID="EmailTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" />
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="table-responsive">
        <asp:GridView ID="ContactGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ContractID" DataSourceID="ContactSQL">
            <Columns>
                <asp:BoundField DataField="ContractName" HeaderText="Contract Name" SortExpression="ContractName" />
                <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="ContactSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Contract] WHERE [ContractID] = @ContractID" InsertCommand="INSERT INTO Contract(InstitutionID, RegistrationID, ProjectID, ContractName, Designation, Phone, Email) VALUES (@InstitutionID, @RegistrationID, @ProjectID, @ContractName, @Designation, @Phone, @Email)" SelectCommand="SELECT * FROM [Contract]" UpdateCommand="UPDATE [Contract] SET [InstitutionID] = @InstitutionID, [RegistrationID] = @RegistrationID, [ProjectID] = @ProjectID, [ContractName] = @ContractName, [Designation] = @Designation, [Phone] = @Phone, [Email] = @Email, [InsertDate] = @InsertDate WHERE [ContractID] = @ContractID">
            <DeleteParameters>
                <asp:Parameter Name="ContractID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ContractNameTextBox" Name="ContractName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DesignationTextBox" Name="Designation" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmailTextBox" Name="Email" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="InstitutionID" Type="Int32" />
                <asp:Parameter Name="RegistrationID" Type="Int32" />
                <asp:Parameter Name="ProjectID" Type="Int32" />
                <asp:Parameter Name="ContractName" Type="String" />
                <asp:Parameter Name="Designation" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="InsertDate" Type="DateTime" />
                <asp:Parameter Name="ContractID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    
</asp:Content>
