<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DialogUserControl.ascx.cs" Inherits="TestIteco.Functions.DialogUserControl" %>

<dx:ASPxPopupControl ID="DialogPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="dialogPopupControl" HeaderText="Edit Employee" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <div style="margin: 20px;">
                <dx:ASPxLabel ID="DialogMessageLabel" ClientInstanceName="dialogMessageLabel" runat="server" Text=""></dx:ASPxLabel>
            </div>
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
                                        <dx:ASPxButton ID="DialogSubmitButton" ClientInstanceName="dialogSubmitButton" runat="server" CssClass="submitButton" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="DialogSubmitButtonClick" />
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="DialogCancelButton" ClientInstanceName="dialogCancelButton" runat="server" CssClass="cancelButton" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="DialogCancelButtonClick" />
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