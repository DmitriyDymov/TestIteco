<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactEditUserControl.ascx.cs" Inherits="TestIteco.Forms.Contacts.ContactEditUserControl" %>

<dx:ASPxPopupControl ID="ContactEditPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="contactEditPopupControl" HeaderText="Изменение контакта" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ClientSideEvents PopUp="contactEditPopupControlOnPopup"></ClientSideEvents>
    <ContentCollection>
        <dx:PopupControlContentControl>

            <dx:ASPxCallbackPanel ID="ContactEditCallbackPanel" ClientInstanceName="contactEditCallbackPanel" runat="server" Width="100%" OnCallback="ContactEditCallbackPanel_OnCallback">
                <ClientSideEvents EndCallback="contactEditCallbackPanelOnEndCallback"></ClientSideEvents>
                <PanelCollection>
                    <dx:PanelContent>

                        <dx:ASPxFormLayout runat="server" ID="formLayout">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                            <Items>
                                <dx:LayoutGroup Caption="Контакт" ColCount="2" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" Paddings-PaddingTop="10">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="true" Font-Size="16" CssClass="groupCaption" />
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem Caption="Имя" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox runat="server" ID="ContactNameTextBox" ClientInstanceName="contactNameTextBox" Text="Имя" MaxLength="200">
                                                        <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Введите имя, имя должно сожержать не менее 5 символов" ValidationGroup="ContactValidationGroup" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText"/>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Телефон">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox runat="server" ID="ContactPhoneTextBox" ClientInstanceName="contactPhoneTextBox" Text="Телефон" MaxLength="25">
                                                        <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Введите телефон" ValidationGroup="ContactValidationGroup" ErrorTextPosition="Bottom"/>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Email">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox runat="server" ID="ContactEmailTextBox" ClientInstanceName="contactEmailTextBox" Text="Email" MaxLength="100">
                                                        <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Введите email" ValidationGroup="ContactValidationGroup" ErrorTextPosition="Bottom"/>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Анкета" ColCount="2" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" Paddings-PaddingTop="10">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="true" Font-Size="16" CssClass="groupCaption" />
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem Caption="Адрес">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox runat="server" ID="ContactAddressTextBox" ClientInstanceName="contactAddressTextBox" Text="Адрес" MaxLength="300">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Дата рождения">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxDateEdit runat="server" ID="ContactDateOfBirth" ClientInstanceName="contactDateOfBirth" Date="1948-12-8">
                                                    </dx:ASPxDateEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Группа">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox ID="GroupNameComboBox" ClientInstanceName="groupNameComboBox" runat="server" DropDownStyle="DropDown" ValueType="System.String" MaxLength="200">
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Компания">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox ID="CompanyNameComboBox" ClientInstanceName="companyNameComboBox" runat="server" DropDownStyle="DropDown" ValueType="System.String" MaxLength="200">
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Должность">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox ID="ContactPositionComboBox" ClientInstanceName="contactPositionComboBox" runat="server" DropDownStyle="DropDown" ValueType="System.String" MaxLength="200">
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                        </dx:ASPxFormLayout>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>

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
                                        <dx:ASPxButton ID="ContactSaveButton" ClientInstanceName="contactSaveButton" runat="server" CssClass="submitButton" Text="Сохранить" AutoPostBack="False" Width="100">
                                            <ClientSideEvents Click="contactSaveButtonOnClick"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ContactCancelButton" ClientInstanceName="contactCancelButton" runat="server" CssClass="cancelButton" Text="Отмена" AutoPostBack="false" Width="100" >
                                            <ClientSideEvents Click="onBtnCancelClick" />
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

<dx:ASPxCallback ID="ValidationContactSaveCallback" ClientInstanceName="validationContactSaveCallback" OnCallback="ValidationContactSaveCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="validationContactSaveCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
<dx:ASPxCallback ID="ContactSaveCallback" ClientInstanceName="contactSaveCallback" OnCallback="ContactSaveCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="contactSaveCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
