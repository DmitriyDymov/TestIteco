<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CallEditUserControl.ascx.cs" Inherits="TestIteco.Forms.Calls.CallEditUserControl" %>



<dx:ASPxPopupControl ID="CallEditPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="callEditPopupControl" HeaderText="Изменение вызова" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ClientSideEvents PopUp="callEditPopupControlOnPopup"></ClientSideEvents>
    <ContentCollection>
        <dx:PopupControlContentControl>
            <dx:ASPxFormLayout runat="server" ID="formLayout">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                <Items>
                    <dx:LayoutGroup ShowCaption="False" Caption="" ColCount="2" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" Paddings-PaddingTop="10">
                        <Items>
                            <dx:LayoutItem Caption="Вызывающий" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="CallSourceButtonEdit" ClientInstanceName="callSourceButtonEdit" NullText="Выберите вызывающий контакт" ReadOnly="True" runat="server">
                                            <Buttons>
                                                <dx:EditButton Text="Выбрать">
                                                </dx:EditButton>
                                            </Buttons>
                                            <ClientSideEvents ButtonClick="callSourceButtonEditOnButtonClick"></ClientSideEvents>
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Вызываемый" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="CallTargetEdit" ClientInstanceName="callTargetButtonEdit" NullText="Выберите вызываемый контакт" ReadOnly="True" runat="server">
                                            <Buttons>
                                                <dx:EditButton Text="Выбрать">
                                                </dx:EditButton>
                                            </Buttons>
                                            <ClientSideEvents ButtonClick="callTargetButtonEditOnButtonClick"></ClientSideEvents>
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Статус звонка" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="CallStatusComboBox" ClientInstanceName="callStatusComboBox" DropDownStyle="DropDownList" Width="160px" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Дата звонка" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxDateEdit runat="server" ID="CallDateDateEdit" ClientInstanceName="callDateDateEdit" EditFormat="DateTime" TimeSectionProperties-Visible="True"  Width="160px">
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Продолжительность, мин." ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxSpinEdit ID="CallDurationSpinEdit" ClientInstanceName="callDurationSpinEdit" NumberType="Integer" MinValue="0" MaxValue="999" Width="160px"  runat="server" Number="0">
                                        </dx:ASPxSpinEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Тема звонка" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="CallSubjectTextBox" ClientInstanceName="callSubjectTextBox" Text="Тема" MaxLength="200">                                           
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Комментарий" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxMemo ID="CallCommentMemo" ClientInstanceName="callCommentMemo" runat="server" Height="100px" Width="100%"></dx:ASPxMemo>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
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
                                        <dx:ASPxButton ID="CallSaveButton" ClientInstanceName="CallSaveButton" runat="server" CssClass="submitButton" Text="Сохранить" AutoPostBack="False" Width="100">
                                            <ClientSideEvents Click="callSaveButtonOnClick"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="CallCancelButton" ClientInstanceName="CallCancelButton" runat="server" CssClass="cancelButton" Text="Отмена" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="callCancelButtonOnClick" />
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

<dx:ASPxCallback ID="CallNewCallback" ClientInstanceName="callNewCallback" OnCallback="CallNewCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="callNewCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
<dx:ASPxCallback ID="CallLoadCallback" ClientInstanceName="callLoadCallback" OnCallback="CallLoadCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="callLoadCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
<dx:ASPxCallback ID="CallSaveCallback" ClientInstanceName="callSaveCallback" OnCallback="CallSaveCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="callSaveCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
