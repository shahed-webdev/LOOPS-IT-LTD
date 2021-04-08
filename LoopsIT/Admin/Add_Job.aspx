<%@ Page Title="Add Job" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Job.aspx.cs" Inherits="LoopsIT.Admin.Add_Job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Add Job</h3>

    <div class="col-md-6 col-sm-10 well">
        <div class="form-group">
            <label>Job Category <a href="Job_Category.aspx">Add New</a></label>
            <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="JobCategoryName" DataValueField="JobCategoryID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Job_Category]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Assigned By <a href="Add_Employee.aspx">Add New</a></label>
            <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-control" DataSourceID="EmployeeSQL" DataTextField="EmployeeName" DataValueField="EmployeeID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="EmployeeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Employee]"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <label>Institution  <a href="Add_Institution.aspx">Add New</a></label>
            <asp:DropDownList ID="InstitutionDropDownList" runat="server" CssClass="form-control" DataSourceID="InstitutionSQL" DataTextField="InstitutionName" DataValueField="InstitutionID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Institution]"></asp:SqlDataSource>

        </div>
        <div class="form-group">
            <label>Project  <a href="Add_Projects.aspx">Add New</a></label>
            <asp:DropDownList ID="ProjectDropDownList" runat="server" CssClass="form-control" DataSourceID="ProjectSQL" DataTextField="ProjectName" DataValueField="ProjectID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="ProjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" SelectCommand="SELECT * FROM [Project]"></asp:SqlDataSource>

        </div>
        <div class="form-group">
            <label>Job Name</label>
            <asp:TextBox ID="JobNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Start Date</label>
            <asp:TextBox ID="StartDateTextBox" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>End Date</label>
            <asp:TextBox ID="EndDateTextBox" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Next Concern Date</label>
            <asp:TextBox ID="Next_Concern_DateTextBox" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Progress Percentage</label>
            <asp:TextBox ID="Progress_PercentageTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Finish Date</label>
            <asp:TextBox ID="FinishDateTextBox" runat="server" CssClass="Datetime form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Job Details</label>
            <asp:TextBox ID="JobDetailsTextBox" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="AddButton" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="AddButton_Click" />
        </div>
    </div>

    <div class="clearfix"></div>

    <asp:GridView ID="JobGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="JobID" DataSourceID="JobSQL">
        <Columns>
            <asp:BoundField DataField="JobName" HeaderText="JobName" SortExpression="JobName" />
            <asp:BoundField DataField="StartDate" DataFormatString="{0:d MMM yyyy}" HeaderText="StartDate" SortExpression="StartDate" />
            <asp:BoundField DataField="EndDate" DataFormatString="{0:d MMM yyyy}" HeaderText="EndDate" SortExpression="EndDate" />
            <asp:BoundField DataField="Next_Concern_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Next_Concern_Date" SortExpression="Next_Concern_Date" />
            <asp:BoundField DataField="Progress_Percentage" HeaderText="Progress_Percentage" SortExpression="Progress_Percentage" />
            <asp:BoundField DataField="FinishDate" DataFormatString="{0:d MMM yyyy}" HeaderText="FinishDate" SortExpression="FinishDate" />
            <asp:BoundField DataField="JobDetails" HeaderText="JobDetails" SortExpression="JobDetails" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="JobSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" DeleteCommand="DELETE FROM [Job] WHERE [JobID] = @JobID" InsertCommand="INSERT INTO Job(RegistrationID, JobCategoryID, Assigned_EmployeeID, InstitutionID, ProjectID, JobName, StartDate, EndDate, Next_Concern_Date, Progress_Percentage, FinishDate, JobDetails, JobStatus) VALUES (@RegistrationID, @JobCategoryID, @Assigned_EmployeeID, @InstitutionID, @ProjectID, @JobName, @StartDate, @EndDate, @Next_Concern_Date, @Progress_Percentage, @FinishDate, @JobDetails, N'Active')" SelectCommand="SELECT * FROM [Job]" UpdateCommand="UPDATE [Job] SET [RegistrationID] = @RegistrationID, [JobCategoryID] = @JobCategoryID, [Assigned_EmployeeID] = @Assigned_EmployeeID, [InstitutionID] = @InstitutionID, [ProjectID] = @ProjectID, [JobName] = @JobName, [StartDate] = @StartDate, [EndDate] = @EndDate, [Next_Concern_Date] = @Next_Concern_Date, [Progress_Percentage] = @Progress_Percentage, [FinishDate] = @FinishDate, [JobDetails] = @JobDetails, [JobStatus] = @JobStatus, [InsertDate] = @InsertDate WHERE [JobID] = @JobID">
        <DeleteParameters>
            <asp:Parameter Name="JobID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:ControlParameter ControlID="CategoryDropDownList" Name="JobCategoryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="EmployeeDropDownList" Name="Assigned_EmployeeID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="InstitutionDropDownList" Name="InstitutionID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ProjectDropDownList" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="JobNameTextBox" Name="JobName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="StartDateTextBox" DbType="Date" Name="StartDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="EndDateTextBox" DbType="Date" Name="EndDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="Next_Concern_DateTextBox" DbType="Date" Name="Next_Concern_Date" PropertyName="Text" />
            <asp:ControlParameter ControlID="Progress_PercentageTextBox" Name="Progress_Percentage" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="FinishDateTextBox" DbType="Date" Name="FinishDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="JobDetailsTextBox" Name="JobDetails" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="RegistrationID" Type="Int32" />
            <asp:Parameter Name="JobCategoryID" Type="Int32" />
            <asp:Parameter Name="Assigned_EmployeeID" Type="Int32" />
            <asp:Parameter Name="InstitutionID" Type="Int32" />
            <asp:Parameter Name="ProjectID" Type="Int32" />
            <asp:Parameter Name="JobName" Type="String" />
            <asp:Parameter DbType="Date" Name="StartDate" />
            <asp:Parameter DbType="Date" Name="EndDate" />
            <asp:Parameter DbType="Date" Name="Next_Concern_Date" />
            <asp:Parameter Name="Progress_Percentage" Type="Double" />
            <asp:Parameter DbType="Date" Name="FinishDate" />
            <asp:Parameter Name="JobDetails" Type="String" />
            <asp:Parameter Name="JobStatus" Type="String" />
            <asp:Parameter Name="InsertDate" Type="DateTime" />
            <asp:Parameter Name="JobID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <script type="text/javascript">
        $(function () {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
