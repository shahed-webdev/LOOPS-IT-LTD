<%@ Page Title="Add Employee" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Employee.aspx.cs" Inherits="LoopsIT.Admin.Add_Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Employee</h3>
    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>ID</label>
            <asp:TextBox ID="IDTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Employee Name</label>
            <asp:TextBox ID="EmployeeNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Designation</label>
            <asp:TextBox ID="DesignationTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Employee Type</label>
            <asp:RadioButtonList ID="EmployeeTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="form-control">
                <asp:ListItem>Director</asp:ListItem>
                <asp:ListItem>Permanent</asp:ListItem>
                <asp:ListItem>Temporary</asp:ListItem>
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
            <label>Photo</label>
            <asp:FileUpload ID="ImgFileUpload" runat="server" />
        </div>
        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" />
        </div>
    </div>
    <div class="clearfix"></div>

    <div class="table-responsive">
        <asp:GridView ID="EmployeeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="EmployeeID" DataSourceID="EmployeeSQL">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
                <asp:BoundField DataField="EmployeeType" HeaderText="Employee Type" SortExpression="EmployeeType" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Employee] WHERE [EmployeeID] = @EmployeeID" InsertCommand="INSERT INTO Employee(ID, EmployeeName, EmployeeType, Phone, Email, EmployeeStatus, EmployeeImage, CreateByRegistrationID, Designation) VALUES (@ID, @EmployeeName, @EmployeeType, @Phone, @Email, 'Active', @EmployeeImage, @CreateByRegistrationID, @Designation)" SelectCommand="SELECT * FROM [Employee]" UpdateCommand="UPDATE [Employee] SET [RegistrationID] = @RegistrationID, [CreateByRegistrationID] = @CreateByRegistrationID, [ID] = @ID, [EmployeeName] = @EmployeeName, [EmployeeType] = @EmployeeType, [Phone] = @Phone, [Email] = @Email, [EmployeeStatus] = @EmployeeStatus, [EmployeeImage] = @EmployeeImage, [InsertDate] = @InsertDate WHERE [EmployeeID] = @EmployeeID">
            <DeleteParameters>
                <asp:Parameter Name="EmployeeID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="CreateByRegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="IDTextBox" Name="ID" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmployeeNameTextBox" Name="EmployeeName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmployeeTypeRadioButtonList" Name="EmployeeType" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="EmailTextBox" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ImgFileUpload" Name="EmployeeImage" PropertyName="FileBytes" />
                <asp:ControlParameter ControlID="DesignationTextBox" Name="Designation" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="RegistrationID" Type="Int32" />
                <asp:Parameter Name="CreateByRegistrationID" Type="Int32" />
                <asp:Parameter Name="ID" Type="String" />
                <asp:Parameter Name="EmployeeName" Type="String" />
                <asp:Parameter Name="EmployeeType" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="EmployeeStatus" Type="String" />
                <asp:Parameter Name="EmployeeImage" Type="Object" />
                <asp:Parameter Name="InsertDate" Type="DateTime" />
                <asp:Parameter Name="EmployeeID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
