<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactHistoryUserControl.ascx.cs" Inherits="TestIteco.Forms.Contacts.ContactHistoryUserControl" %>


<dx:ASPxPopupControl ID="ContactHistoryPopupControl" runat="server" ShowOnPageLoad="False" ClientInstanceName="contactHistoryPopupControl" HeaderText="История" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
    <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
    <ClientSideEvents PopUp="contactHistoryPopupControlOnPopup"></ClientSideEvents>
    <ContentCollection>
        <dx:PopupControlContentControl>

            <div style="margin-bottom: 10px; margin-left: 12px;">
                <dx:ASPxMenu runat="server" ID="ContactHistoryPageToolbar" ClientInstanceName="contactHistoryPageToolbar"
                    ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
                    AllowSelectItem="false" SeparatorWidth="0"
                    Width="100%" CssClass="page-toolbar">
                    <ClientSideEvents ItemClick="contactHistoryPageToolbarItemClick" />
                    <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
                        EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
                    <ItemStyle CssClass="item" VerticalAlign="Middle" />
                    <ItemImage Width="16px" Height="16px" />
                    <Items>
                        <dx:MenuItem Enabled="false">
                            <Template>
                                <dx:ASPxLabel ID="ContactHistoryNameLabel" ClientInstanceName="contactHistoryNameLabel" Width="300px" runat="server" Text=""></dx:ASPxLabel>
                            </Template>
                        </dx:MenuItem>
                        <dx:MenuItem Name="Open" Text="Открыть" Alignment="Right" AdaptivePriority="2">
                            <Image Url="/Content/Images/document.svg" />
                        </dx:MenuItem>
                        <dx:MenuItem Name="ToggleFilterPanel" Text="" GroupName="Filter" Alignment="Right" AdaptivePriority="1">
                            <Image Url="/Content/Images/search.svg" UrlChecked="/Content/Images/search-selected.svg" />
                        </dx:MenuItem>
                    </Items>
                </dx:ASPxMenu>
            </div>
            <div style="margin-bottom: 10px;">
                <dx:ASPxPanel runat="server" ID="ContactHistoryFilterPanel" ClientInstanceName="contactHistoryFilterPanel"
                    Collapsible="true" CssClass="filter-panel">
                    <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxButtonEdit runat="server" ID="ContactHistorySearchButtonEdit" ClientInstanceName="contactHistorySearchButtonEdit" ClearButton-DisplayMode="Always" Caption="Поиск" Width="100%" />
                        </dx:PanelContent>
                    </PanelCollection>
                    <ClientSideEvents Expanded="contactHistoryFilterPanelExpanded" Collapsed="adjustPageControls" />
                </dx:ASPxPanel>
            </div>

            <dx:ASPxGridView runat="server" ID="ContactHistoryGridView" ClientInstanceName="contactHistoryGridView"
                KeyFieldName="ContactID" EnablePagingGestures="True" EnableRowsCache="False"
                CssClass="grid-view" Width="100%"
                OnDataBinding="ContactHistoryGridView_OnDataBinding"
                OnCustomCallback="ContactHistoryGridView_OnCustomCallback"
                AutoGenerateColumns="False">
                <Settings ShowGroupPanel="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Auto" />
                <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="False" AllowEllipsisInText="true" AllowDragDrop="True" />
                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
                <SettingsCookies Enabled="False"></SettingsCookies>
                <SettingsSearchPanel CustomEditorID="ContactHistorySearchButtonEdit" />
                <Columns>

                    <dx:GridViewDataDateColumn FieldName="ActionDate" Caption="Дата" Width="120px" SortOrder="Descending" SortIndex="0">
                        <PropertiesDateEdit DisplayFormatString="{0:MM/dd/yy H:mm}"></PropertiesDateEdit>
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Center" />
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn FieldName="ActionName" Caption="Действие" Width="170px">
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ActionStatus" Caption="Статус" Width="120px">
                        <Settings AllowHeaderFilter="True" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ActionFullDescription" Caption="Описание" Width="380px">
                        <Settings AllowHeaderFilter="False" />
                        <CellStyle HorizontalAlign="Left">
                        </CellStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="CallID" Caption="" Visible="False">
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn FieldName="ConferenceID" Caption="" Visible="False">
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
                <ClientSideEvents Init="contactHistoryOnGridViewInit" FocusedRowChanged="contactHistoryGridViewOnFocusedRowChanged" EndCallback="contactHistoryOnGridViewEndCallback" />
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
                                        <dx:ASPxButton ID="ContactHistoryCloseButton" ClientInstanceName="contactHistoryCloseButton" runat="server" CssClass="cancelButton" Text="Закрыть" AutoPostBack="false" Width="100">
                                            <ClientSideEvents Click="contactHistoryCloseButtonOnClick" />
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
