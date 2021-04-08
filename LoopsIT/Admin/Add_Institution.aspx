<%@ Page Title="Add Institution" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Institution.aspx.cs" Inherits="LoopsIT.Admin.Add_Institution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Institution</h3>

    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>Project <a href="Add_Projects.aspx">Add Projects</a></label>
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID" AppendDataBoundItems="True" AutoPostBack="True">
                <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Institution Name</label>
            <asp:TextBox ID="InstitutionNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Institution Type</label>
            <asp:RadioButtonList ID="InstitutionTypeRadioButtonList" CssClass="form-control" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>Client</asp:ListItem>
                <asp:ListItem>Expected Client</asp:ListItem>
                <asp:ListItem>Prev. Client</asp:ListItem>
            </asp:RadioButtonList>

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
            <label>Postal Code</label>
            <asp:TextBox ID="PostalCodeTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Website</label>
            <asp:TextBox ID="WebsiteTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Institution Status</label>
            <asp:RadioButtonList ID="InstitutionStatusRadioButtonList" CssClass="form-control" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>Gold</asp:ListItem>
                <asp:ListItem>Silver</asp:ListItem>
                <asp:ListItem>General</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="form-group">
            <label>Address</label>
            <asp:TextBox ID="AddressTextBox" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" />
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="table-responsive">
        <asp:GridView ID="InstiturionGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="InstitutionID" DataSourceID="InstitutionSQL">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="InstitutionName" HeaderText="Institution Name" SortExpression="InstitutionName" />
                <asp:BoundField DataField="InstitutionType" HeaderText="Institution Type" SortExpression="InstitutionType" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" SortExpression="PostalCode" />
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />
                <asp:BoundField DataField="InstitutionStatus" HeaderText="Institution Status" SortExpression="InstitutionStatus" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Institution] WHERE [InstitutionID] = @InstitutionID" InsertCommand="INSERT INTO Institution(RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Address, Website, InstitutionStatus) VALUES (@RegistrationID, @ProjectID, @InstitutionName, @InstitutionType, @Phone, @Email, @PostalCode, @Address, @Website, @InstitutionStatus)" SelectCommand="SELECT InstitutionID, RegistrationID, ProjectID, InstitutionName, InstitutionType, Phone, Email, PostalCode, Website, Address, InstitutionLogo, InstitutionStatus, InsertDate FROM Institution WHERE (ProjectID = @ProjectID)" UpdateCommand="UPDATE Institution SET InstitutionName = @InstitutionName, InstitutionType = @InstitutionType, Phone = @Phone, Email = @Email, PostalCode = @PostalCode, Address = @Address, Website = @Website, InstitutionStatus = @InstitutionStatus WHERE (InstitutionID = @InstitutionID)">
            <DeleteParameters>
                <asp:Parameter Name="InstitutionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="InstitutionNameTextBox" Name="InstitutionName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="InstitutionTypeRadioButtonList" Name="InstitutionType" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmailTextBox" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="PostalCodeTextBox" Name="PostalCode" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="AddressTextBox" Name="Address" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="WebsiteTextBox" Name="Website" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="InstitutionStatusRadioButtonList" Name="InstitutionStatus" PropertyName="SelectedValue" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="InstitutionName" Type="String" />
                <asp:Parameter Name="InstitutionType" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="PostalCode" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="Website" Type="String" />
                <asp:Parameter Name="InstitutionStatus" Type="String" />
                <asp:Parameter Name="InstitutionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
