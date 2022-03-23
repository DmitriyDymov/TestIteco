<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogonWebForm.aspx.cs" Inherits="TestIteco.Forms.Users.LogonWebForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="shortcut icon" href='<%# ResolveUrl("~/Content/Images/ERP_Icon.ico") %>' type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/Content.ashx?Name=Content.css" />
    <link rel="stylesheet" type="text/css" href="/Content.ashx?Name=Layout.css" />
    <script type="text/javascript" src="/Content.ashx?Name=Script.js"></script>
    <link rel="stylesheet" type="text/css" href="/Content.ashx?Name=SignInRegister.css" />
    <script type="text/javascript" src="/Content.ashx?Name=LogonWebForm.js"></script>
    <title>Performer</title>
</head>
<body>
    <form id="form1" class="form" runat="server">
        <div class="content">
            <div class="formLayout-verticalAlign">
                <div class="formLayout-container">

                    <table style="width: 200px;">
                        <tr>
                            <td style="width: 40%; text-align: right; padding-left: 20px; padding-top: 20px; padding-bottom: 20px;">
                                <img width="60" height="60" src="/Content/Images/ERP_icon.svg" alt="" />
                            </td>
                            <td style="width: 60%; text-align: left; padding-left: 20px; padding-top: 20px; padding-bottom: 20px;">
                                <span style="font-family: Roboto; font-size: 20px;">Performer
                                </span>
                            </td>
                        </tr>
                    </table>

                    <dx:ASPxTabControl ID="SignInRegisterTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0" ActiveTabIndex="0">
                        <Tabs>
                            <dx:Tab Text="Войти"></dx:Tab>
                        </Tabs>
                    </dx:ASPxTabControl>

                    <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" UseDefaultPaddings="false">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                        <SettingsItemCaptions Location="Top" />
                        <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" />
                        <Items>
                            <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                                <Items>
                                    <dx:LayoutItem Caption="Email">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxTextBox ID="UserNameTextBox" NullText="Введите Ваш email" ClientInstanceName="userNameTextBox" runat="server" Width="100%">
                                                    <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                        <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Введен не верный email" />
                                                        <RequiredField IsRequired="true" ErrorText="Пожалуйста, введите Ваш email" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Init="function(s, e){ s.Focus(); }" />
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem Caption="Пароль">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit ID="PasswordButtonEdit" NullText="Введите Ваш пароль" ClientInstanceName="passwordButtonEdit" runat="server" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                                    <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                                    </ButtonStyle>
                                                    <ButtonTemplate>
                                                        <div></div>
                                                    </ButtonTemplate>
                                                    <Buttons>
                                                        <dx:EditButton>
                                                        </dx:EditButton>
                                                    </Buttons>
                                                    <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                        <RequiredField IsRequired="true" ErrorText="Пожалуйста, введите Ваш пароль" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" />
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="13">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxCheckBox ID="RememberMeCheckBox" runat="server" Text="Запомнить меня" Checked="true"></dx:ASPxCheckBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem ShowCaption="False" Name="GeneralError">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div id="GeneralErrorDiv" runat="server" class="formLayout-generalErrorText">
                                                    <dx:ASPxLabel ClientInstanceName="errorLabel" CssClass="text-error" runat="server" Text=""></dx:ASPxLabel>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                                <Paddings PaddingTop="13" PaddingBottom="13" />
                                <GroupBoxStyle CssClass="formLayout-groupBox" />
                                <Items>
                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButton ID="SignInButton" ClientInstanceName="signInButton" runat="server" Width="200" Text="Войти" AutoPostBack="False">
                                                    <ClientSideEvents Click="signInButtonOnClick" />
                                                </dx:ASPxButton>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>
                </div>
            </div>
        </div>

        <dx:ASPxPopupControl ID="RePassResultPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="rePassResultPopupControl" HeaderText="Применение нового пароля" CloseOnEscape="false" CloseAction="None" ShowFooter="true">
            <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
            <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxLabel ID="RePassLabel" runat="server" Text=""></dx:ASPxLabel>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:ASPxFormLayout>
                </dx:PopupControlContentControl>
            </ContentCollection>
            <FooterTemplate>
                <dx:ASPxFormLayout runat="server" ID="footerFormLayout" Width="100%" CssClass="clearPaddings">
                    <Styles LayoutItem-CssClass="clearPaddings" LayoutGroup-CssClass="clearPaddings" />
                    <Items>
                        <dx:LayoutGroup GroupBoxDecoration="None">
                            <Paddings Padding="0" />
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="buttonsContainer">
                                                <dx:ASPxButton ID="btnCancel" runat="server" CssClass="cancelButton" Text="Закрыть" AutoPostBack="false" Width="100">
                                                    <ClientSideEvents Click="function (s,e) {rePassResultPopupControl.Hide();}" />
                                                </dx:ASPxButton>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
            </FooterTemplate>
        </dx:ASPxPopupControl>

        <dx:ASPxCallback ID="LogonCallback" ClientInstanceName="logonCallback" OnCallback="LogonCallback_OnCallback" runat="server">
            <ClientSideEvents CallbackComplete="logonCallbackOnCallbackComplete" />
        </dx:ASPxCallback>

    </form>
</body>
</html>
