<%@ Page Title="Sikkhaloy Pay Order" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="PayOrder_Sikkhaloy.aspx.cs" Inherits="LoopsIT.Admin.PaymentCollection.Sikkhaloy_PayOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Sikkhaloy_Payorder.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Sikkhaloy Payorder</h3>
    <asp:FormView ID="TotalStuFormView" runat="server" DataSourceID="TotalStuSQL" Width="100%">
        <ItemTemplate>
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="db_box Instition">
                        <h4><strong><%#Eval("Total_Instition") %></strong></h4>
                        <span>Total Instition</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="db_box Total_Stu">
                        <h4><strong><%#Eval("Total_Stu","{0:N0}") %></strong></h4>
                        <span>Total Student</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="db_box service_charge">
                        <h4><strong><%#Eval("Monthly_service_charge","{0:N0}") %> TK</strong></h4>
                        <span>Monthly service charge</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="db_box Per_Stu_Avg">
                        <h4><strong><%#Eval("Per_Stu_Avg") %> TK</strong></h4>
                        <span>Per Student Avg</span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="TotalStuSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EduConnectionString %>" SelectCommand="SELECT  Count(*) as Total_Instition, SUM(Total_Student) AS Total_Stu, SUM(Total_Taka) AS Monthly_service_charge, round(SUM(Total_Taka)/SUM(Total_Student),2) as Per_Stu_Avg FROM VW_TotalStudent_Amount_Report where School_SN &lt;&gt; 9"></asp:SqlDataSource>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="DateTextBox" runat="server" placeholder="Use Date" autocomplete="off" CssClass="form-control Datetime" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="DateTextBox" ValidationGroup="1" runat="server" CssClass="EroorStar" ErrorMessage="*"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="CheckButton" runat="server" CssClass="btn btn-primary" OnClick="CheckButton_Click" ValidationGroup="1" Text="Check" />
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="SikkhaloyGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="SikkhaloySQL" DataKeyNames="School_SN,SchoolName">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <HeaderTemplate>
                        <asp:CheckBox ID="SelectAllCheckBox" runat="server" Text=" " />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="SelectCheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="School_SN" HeaderText="SN" SortExpression="School_SN" />
                <asp:BoundField DataField="SchoolName" HeaderText="Institution Name" SortExpression="SchoolName" />
                <asp:BoundField DataField="EducationYear" HeaderText="Session" SortExpression="EducationYear" />
                <asp:TemplateField HeaderText="Total Student" SortExpression="Total_Student">
                    <ItemTemplate>
                        <asp:TextBox ID="Total_StudentTextBox" CssClass="form-control" runat="server" Text='<%#Eval("Total_Student") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Per Student" SortExpression="Per_Student_Rate">
                    <ItemTemplate>
                        <asp:Label ID="Per_Student_Rate_Label" runat="server" Text='<%#Eval("Per_Student_Rate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total" SortExpression="Total_Taka">
                    <ItemTemplate>
                        <asp:Label ID="Total_Taka_Label" runat="server" Text='<%#Eval("Total_Taka") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SikkhaloySQL" runat="server" ConnectionString="<%$ ConnectionStrings:EduConnectionString %>" SelectCommand="SELECT School_SN, EducationYear, SchoolName, Address, Total_Student, Per_Student_Rate, Total_Taka FROM VW_TotalStudent_Amount_Report WHERE (School_SN &lt;&gt; 9) ORDER BY EducationYear DESC"></asp:SqlDataSource>

        <br />
        <asp:Button ID="PayOrderButton" runat="server" CssClass="btn btn-primary" OnClick="PayOrderButton_Click" Text="Pay Order" ValidationGroup="1" />
        <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorSummer"></asp:Label>
        <asp:SqlDataSource ID="PayOrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" InsertCommand="INSERT INTO PayOrder(RegistrationID, IncomeCategoryID, InstitutionID, Unit, UnitPrice, UseDate, Details, Month) VALUES (@RegistrationID, @IncomeCategoryID, @InstitutionID, @Unit, @UnitPrice, @UseDate, @Details, @Month_Date)" SelectCommand="SELECT * FROM [PayOrder]">
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:ControlParameter ControlID="DateTextBox" Name="Month_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="DateTextBox" DbType="Date" Name="UseDate" PropertyName="Text" />
                <asp:Parameter Name="IncomeCategoryID" Type="Int32" />
                <asp:Parameter Name="InstitutionID" Type="Int32" />
                <asp:Parameter Name="Unit" Type="Int32" />
                <asp:Parameter Name="UnitPrice" Type="Double" />
                <asp:Parameter Name="Amount" Type="Double" />
                <asp:Parameter Name="Details" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>


    <script type="text/javascript">
        $(function () {
            $(".Datetime").datepicker({
                format: "mm-yyyy",
                viewMode: "months", 
                minViewMode: "months",
                autoclose: true
            });

            $("[id*=SelectAllCheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });

            $("[id*=SelectCheckBox]").on("click", function () {
                var a = $(this).closest("table"), b = $("[id*=SelectAllCheckBox]", a);
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=SelectCheckBox]", a).length == $("[id*=SelectCheckBox]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
            });
        });
    </script>
</asp:Content>
