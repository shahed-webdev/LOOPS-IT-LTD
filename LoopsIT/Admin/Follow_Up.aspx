<%@ Page Title="Follow Up" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Follow_Up.aspx.cs" Inherits="LoopsIT.Admin.Follow_Up" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Follow Up</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="JobDropDownList" runat="server" CssClass="form-control" DataSourceID="JobSQL" DataTextField="JobName" DataValueField="JobID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT JOB ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="JobSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Job]"></asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT EMPLOYEE ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:TextBox ID="DetailsTextBox" placeholder="Details" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="SubmitButton_Click" />
        </div>
    </div>

    <asp:GridView ID="JobGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="JobFollow_upID" DataSourceID="FollowUpSQL">
        <Columns>
            <asp:BoundField DataField="JobName" HeaderText="Job" SortExpression="JobName" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Follow Up By" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Follow_upDetails" HeaderText="Details" SortExpression="Follow_upDetails" />
            <asp:CommandField ShowEditButton="True" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <EmptyDataTemplate>
            No Data
        </EmptyDataTemplate>
    </asp:GridView>

    <asp:SqlDataSource ID="FollowUpSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Job_Follow_up] WHERE [JobFollow_upID] = @JobFollow_upID" InsertCommand="INSERT INTO [Job_Follow_up] ([RegistrationID], [JobID], [Follow_up_By_EmployeeID], [Follow_upDetails]) VALUES (@RegistrationID, @JobID, @Follow_up_By_EmployeeID, @Follow_upDetails)" SelectCommand="SELECT Job_Follow_up.Follow_upDetails, Job_Follow_up.JobFollow_upID, Job.JobName, Employee.EmployeeName FROM Job_Follow_up INNER JOIN Job ON Job_Follow_up.JobID = Job.JobID INNER JOIN Employee ON Job_Follow_up.Follow_up_By_EmployeeID = Employee.EmployeeID" UpdateCommand="UPDATE Job_Follow_up SET Follow_upDetails = @Follow_upDetails WHERE (JobFollow_upID = @JobFollow_upID)">
        <DeleteParameters>
            <asp:Parameter Name="JobFollow_upID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="JobDropDownList" Name="JobID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="EmployeeDropDownList" Name="Follow_up_By_EmployeeID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DetailsTextBox" Name="Follow_upDetails" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Follow_upDetails" />
            <asp:Parameter Name="JobFollow_upID" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
