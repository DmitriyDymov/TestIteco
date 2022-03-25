<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactSelectUserControl.ascx.cs" Inherits="TestIteco.Forms.Contacts.ContactSelectUserControl" %>


<dx:ASPxPopupControl ID="ContactSelectPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="contactSelectPopupControl" HeaderText="Выберите кому звонил контакт" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ClientSideEvents PopUp="contactSelectPopupControlOnPopup"></ClientSideEvents>
    <ContentCollection>
        <dx:PopupControlContentControl>

            <div style="margin-bottom: 10px;">
                <dx:ASPxPanel runat="server" ID="ContactsFilterPanel" ClientInstanceName="contactSelectFilterPanel"
                    Collapsible="False" CssClass="filter-panel">
                    <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxButtonEdit runat="server" ID="ContactSelectSearchButtonEdit" ClientInstanceName="contactSelectSearchButtonEdit" ClearButton-DisplayMode="Always" Caption="Поиск" Width="100%" />
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </div>

            <dx:ASPxGridView runat="server" ID="ContactSelectGridView" ClientInstanceName="contactSelectGridView" OnCustomCallback="ContactSelectGridView_OnCustomCallback"
                KeyFieldName="ContactID" EnablePagingGestures="True"
                CssClass="grid-view" Width="100%"
                OnDataBinding="ContactSelectGridView_OnDataBinding"
                AutoGenerateColumns="False">
                <Settings ShowGroupPanel="False" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Auto" />
                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="False" AllowEllipsisInText="true" AllowDragDrop="True" />
                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
                <SettingsSearchPanel CustomEditorID="ContactSelectSearchButtonEdit" />
                <Columns>
                    <dx:GridViewDataColumn FieldName="ContactName" Caption="Имя" Width="200px" SortOrder="Ascending" SortIndex="0">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ContactEmail" Caption="Email" Width="180px">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ContactDisplayPhone" Caption="Телефон" Width="180px">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ContactAddress" Caption="Адрес" Width="280px">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataDateColumn FieldName="ContactDateOfBirth" Caption="Дата рождения" VisibleIndex="80">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Center" />
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn FieldName="GroupDisplayName" Caption="Группа" Width="200px">
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="CompanyName" Caption="Компания" Width="200px">
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ContactPosition" Caption="Должность" Width="200px">
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                </Columns>
                <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto" ShowHeaderFilterButton="true" />
                <SettingsPager PageSize="15" EnableAdaptivity="true">
                    <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
                </SettingsPager>
                <SettingsExport EnableClientSideExportAPI="False" />
                <SettingsPopup>
                    <EditForm>
                        <SettingsAdaptivity MaxWidth="800" Mode="Always" VerticalAlign="WindowCenter" />
                    </EditForm>
                    <HeaderFilter MinHeight="140px"></HeaderFilter>
                </SettingsPopup>
                <Styles>
                    <Cell Wrap="False" />
                    <PagerBottomPanel CssClass="pager" />
                    <FocusedRow CssClass="focused" />
                </Styles>
                <ClientSideEvents Init="contactSelectOnGridViewInit" FocusedRowChanged="contactSelectGridViewOnFocusedRowChanged" EndCallback="contactSelectOnGridViewEndCallback" />
            </dx:ASPxGridView>

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
                                        <dx:ASPxButton ID="ContactSelectSaveButton" ClientInstanceName="contactSelectButton" runat="server" CssClass="submitButton" Text="Выбрать" AutoPostBack="False" Width="100">
                                            <ClientSideEvents Click="contactSelectSaveButtonOnClick"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ContactSelectCancelButton" ClientInstanceName="contactCancelButton" runat="server" CssClass="cancelButton" Text="Отмена" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="contactSelectCancelButtonOnClick" />
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


