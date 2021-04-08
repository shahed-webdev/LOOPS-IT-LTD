<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="LoopsIT.Authority.Signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Signup</h3>

    <asp:CreateUserWizard ID="InstitutionCW" runat="server" LoginCreatedUser="False" OnCreatedUser="InstitutionCW_CreatedUser">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td align="right">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" CssClass="EroorText" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" CssClass="EroorText" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" CssClass="EroorText" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" CssClass="EroorText" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Question" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question" CssClass="EroorText" ErrorMessage="Security question is required." ToolTip="Security question is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Answer" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer" CssClass="EroorText" ErrorMessage="Security answer is required." ToolTip="Security answer is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                           <td align="right">Role</td>
                           <td>
                              <asp:DropDownList ID="RoleDropDownList" runat="server" Width="287px" CssClass="form-control">
                                 <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                                 <asp:ListItem>Authority</asp:ListItem>
                                 <asp:ListItem>Admin</asp:ListItem>
                                 <asp:ListItem>Sub-Admin</asp:ListItem>
                              </asp:DropDownList>
                              <asp:RequiredFieldValidator ID="RoleRequired" runat="server" ControlToValidate="RoleDropDownList" CssClass="EroorText" ErrorMessage="Security answer is required." InitialValue="0" ToolTip="Security answer is required." ValidationGroup="InstitutionCW">!</asp:RequiredFieldValidator>
                           </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" CssClass="EroorText" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="InstitutionCW"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color:Red;">
                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <CustomNavigationTemplate>
                    <table border="0" cellspacing="5" style="width:100%;height:100%;">
                        <tr align="right">
                            <td align="right" colspan="0">
                                <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" CssClass="Submit-Button" Text="Create User" ValidationGroup="InstitutionCW" />
                            </td>
                        </tr>
                    </table>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>

            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td align="center">Congratulation!</td>
                        </tr>
                        <tr>
                            <td>Your account has been successfully created.</td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btn-primary" runat="server" CausesValidation="False" CommandName="Continue" CssClass="Submit-Button" Text="Continue" ValidationGroup="InstitutionCW" PostBackUrl="~/Authority/Auth_Profile.aspx" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous"  Visible="false"/>
            <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" Text="Finish" Visible="false"/>
        </FinishNavigationTemplate>
        <StepNavigationTemplate>
           <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous" />
           <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next" />
        </StepNavigationTemplate>
    </asp:CreateUserWizard>
    <asp:SqlDataSource ID="RegistrationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:LoopsITConnectionString %>" InsertCommand="INSERT INTO Registration(UserName, Validation, Category) VALUES (@UserName, 'Valid', @Category)" ProviderName="<%$ ConnectionStrings:LoopsITConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Registration]">
       <InsertParameters>
          <asp:Parameter DefaultValue="" Name="UserName" Type="String" />
          <asp:Parameter Name="Category" />
       </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
