<%@ Page Title="SMS Payorder" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="PayOrder_SMS.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.SMS_Recharge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>SMS Payorder</h3>

    <div class="table-responsive">
        <div class="alert alert-success">Sikkhaloy.com</div>
        <asp:GridView ID="SikkhaloySMS_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SMS_Recharge_RecordID,SchoolName,RechargeSMS,PerSMS_Price,Date" DataSourceID="SikkhaloySMS_SQL">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <HeaderTemplate>
                        <asp:CheckBox ID="Edu_CheckBox" runat="server" Text=" " />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="EduSelectCheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SchoolName" HeaderText="Institution" SortExpression="SchoolName" />
                <asp:BoundField DataField="RechargeSMS" HeaderText="Recharge SMS" SortExpression="RechargeSMS" />
                <asp:BoundField DataField="PerSMS_Price" HeaderText="SMS Price" SortExpression="PerSMS_Price" />
                <asp:BoundField DataField="Total_Price" HeaderText="Total Price" ReadOnly="True" SortExpression="Total_Price" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d MMM yyyy}" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SikkhaloySMS_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:EduConnectionString %>" SelectCommand="SELECT SMS_Recharge_Record.SMS_Recharge_RecordID, SchoolInfo.SchoolName, SMS_Recharge_Record.RechargeSMS, SMS_Recharge_Record.PerSMS_Price, SMS_Recharge_Record.Total_Price, SMS_Recharge_Record.Date FROM SMS_Recharge_Record INNER JOIN SchoolInfo ON SMS_Recharge_Record.SchoolID = SchoolInfo.SchoolID WHERE (SMS_Recharge_Record.Is_Paid = 0) AND (SMS_Recharge_Record.Total_Price &lt;&gt; 0) ORDER BY SMS_Recharge_Record.SchoolID, SMS_Recharge_Record.Date" UpdateCommand="UPDATE [SMS_Recharge_Record] SET  [Is_Paid] = 1 WHERE [SMS_Recharge_RecordID] = @SMS_Recharge_RecordID">
            <UpdateParameters>
                <asp:Parameter Name="SMS_Recharge_RecordID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <br />
    <div class="table-responsive">
        <div class="alert alert-success">Tailorbd.com</div>
        <asp:GridView ID="TailorSMS_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SMS_Recharge_RecordID,InstitutionName,RechargeSMS,PerSMS_Price,Date" DataSourceID="TailorSMS_SQL">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <HeaderTemplate>
                        <asp:CheckBox ID="SelectAllCheckBox" runat="server" Text=" " />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="SelectCheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="InstitutionName" HeaderText="Institution" SortExpression="InstitutionName" />
                <asp:BoundField DataField="RechargeSMS" HeaderText="Recharge SMS" SortExpression="RechargeSMS" />
                <asp:BoundField DataField="PerSMS_Price" HeaderText="SMS Price" SortExpression="PerSMS_Price" />
                <asp:BoundField DataField="Total_Price" HeaderText="Total Price" ReadOnly="True" SortExpression="Total_Price" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d MMM yyyy}" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="TailorSMS_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:TailorbdConnectionString %>" SelectCommand="SELECT SMS_Recharge_Record.SMS_Recharge_RecordID, Institution.InstitutionName, SMS_Recharge_Record.RechargeSMS, SMS_Recharge_Record.PerSMS_Price, SMS_Recharge_Record.Total_Price, SMS_Recharge_Record.Date FROM SMS_Recharge_Record INNER JOIN Institution ON SMS_Recharge_Record.InstitutionID = Institution.InstitutionID WHERE (SMS_Recharge_Record.Is_Paid = 0) AND (SMS_Recharge_Record.Total_Price &lt;&gt; 0) ORDER BY SMS_Recharge_Record.InstitutionID, SMS_Recharge_Record.Date" UpdateCommand="UPDATE [SMS_Recharge_Record] SET [Is_Paid] = @Is_Paid WHERE [SMS_Recharge_RecordID] = @SMS_Recharge_RecordID">
            <UpdateParameters>
                <asp:Parameter Name="Is_Paid" Type="Boolean" />
                <asp:Parameter Name="SMS_Recharge_RecordID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <br />
    <asp:Button ID="PayOrderButton" runat="server" CssClass="btn btn-primary" OnClick="PayOrderButton_Click" Text="Pay Order" />
    <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorStar"></asp:Label>
    <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" InsertCommand="INSERT INTO PayOrder(RegistrationID, IncomeCategoryID, InstitutionID, Unit, UnitPrice, UseDate, Details) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @Unit, @UnitPrice, @UseDate, @Details)" SelectCommand="SELECT * FROM [PayOrder]">
        <InsertParameters>
            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
            <asp:Parameter Name="IncomeCategoryID" Type="Int32" />
            <asp:Parameter Name="InstitutionID" Type="Int32" />
            <asp:Parameter Name="Unit" Type="Int32" />
            <asp:Parameter Name="UnitPrice" Type="Double" />
            <asp:Parameter Name="Amount" Type="Double" />
            <asp:Parameter DbType="Date" Name="UseDate" />
            <asp:Parameter Name="Details" />
        </InsertParameters>
    </asp:SqlDataSource>



    <script type="text/javascript">
        $(function () {
            //Sikkhaloy
            $("[id*=Edu_CheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });
            $("[id*=EduSingle_CheckBox]").on("click", function () {
                var a = $(this).closest("table"), b = $("[id*=Edu_CheckBox]", a);
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=EduSingle_CheckBox]", a).length == $("[id*=EduSingle_CheckBox]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
            });

            //SMS
            $("[id*=SelectAllCheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).attr("checked", false), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });

            $("[id*=SelectCheckBox]").on("click", function () {
                var a = $(this).closest("table"), b = $("[id*=SelectAllCheckBox]", a);
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=SelectCheckBox]", a).length == $("[id*=SelectCheckBox]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
            });
        });
    </script>
</asp:Content>
