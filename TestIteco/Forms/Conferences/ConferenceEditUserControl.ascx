<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConferenceEditUserControl.ascx.cs" Inherits="TestIteco.Forms.Conferences.ConferenceEditUserControl" %>
<%@ Register Src="~/Forms/Conferences/ConferenceContactsUserControl.ascx" TagPrefix="ucEdit" TagName="ConferenceContactsUserControl" %>



<dx:ASPxPopupControl ID="ConferenceEditPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="conferenceEditPopupControl" HeaderText="Изменение конференции" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ClientSideEvents PopUp="conferenceEditPopupControlOnPopup"></ClientSideEvents>
    <ContentCollection>
        <dx:PopupControlContentControl>
            <dx:ASPxFormLayout runat="server" ID="formLayout">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                <Items>
                    <dx:LayoutGroup ShowCaption="False" Caption="" ColCount="2" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" Paddings-PaddingTop="10">
                        <Items>
                            <dx:LayoutItem Caption="Планируемая дата начала" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxDateEdit runat="server" ID="ConferencePlannedDateDateEdit" ClientInstanceName="conferencePlannedDateDateEdit" EditFormat="DateTime" TimeSectionProperties-Visible="True" Width="160px">
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Фактическая дата начала" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxDateEdit runat="server" ID="ConferenceBeganDateEdit" ClientInstanceName="conferenceBeganDateEdit" EditFormat="DateTime" TimeSectionProperties-Visible="True" Width="160px">
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Статус" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="ConferenceStatusComboBox" ClientInstanceName="conferenceStatusComboBox" DropDownStyle="DropDownList" Width="160px" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Тема" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="ConferenceSubjectTextBox" ClientInstanceName="conferenceSubjectTextBox" Text="Тема" MaxLength="200">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Комментарий" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxMemo ID="ConferenceCommentMemo" ClientInstanceName="conferenceCommentMemo" runat="server" Height="100px" Width="100%"></dx:ASPxMemo>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup ShowCaption="False" Caption="" ColCount="2" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" Paddings-PaddingTop="10">
                        <Items>
                            <dx:LayoutItem Caption="Участники" ColumnSpan="2">
                                <CaptionSettings Location="Top"></CaptionSettings>
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        
                                        <ucEdit:ConferenceContactsUserControl runat="server" id="ConferenceContactsUserControl" />

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
                                        <dx:ASPxButton ID="ConferenceSaveButton" ClientInstanceName="ConferenceSaveButton" runat="server" CssClass="submitButton" Text="Сохранить" AutoPostBack="False" Width="100">
                                            <ClientSideEvents Click="conferenceSaveButtonOnClick"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ConferenceCancelButton" ClientInstanceName="ConferenceCancelButton" runat="server" CssClass="cancelButton" Text="Отмена" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="conferenceCancelButtonOnClick" />
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


<dx:ASPxCallback ID="ConferenceLoadCallback" ClientInstanceName="conferenceLoadCallback" OnCallback="ConferenceLoadCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="conferenceLoadCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
<dx:ASPxCallback ID="ConferenceSaveCallback" ClientInstanceName="conferenceSaveCallback" OnCallback="ConferenceSaveCallback_OnCallback" runat="server">
    <ClientSideEvents CallbackComplete="conferenceSaveCallbackOnCallbackComplete"></ClientSideEvents>
</dx:ASPxCallback>
