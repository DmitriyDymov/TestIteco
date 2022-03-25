<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConferenceContactsUserControl.ascx.cs" Inherits="TestIteco.Forms.Conferences.ConferenceContactsUserControl" %>

<div  style="margin-bottom: 10px;">
<dx:ASPxMenu runat="server" ID="ConferenceContactsPageToolbar" ClientInstanceName="conferenceContactsPageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
        <ClientSideEvents ItemClick="conferenceContactsPageToolbarItemClick" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Name="New" Text="Добавить" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Удалить" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/delete.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="ToggleFilterPanel" Text="" GroupName="Filter" Alignment="Right" AdaptivePriority="1">
                <Image Url="/Content/Images/search.svg" UrlChecked="/Content/Images/search-selected.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</div>
<div style="margin-bottom: 10px;">
    <dx:ASPxPanel runat="server" ID="ConferenceContactsFilterPanel" ClientInstanceName="conferenceContactsFilterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="ConferenceContactsSearchButtonEdit" ClientInstanceName="conferenceContactsSearchButtonEdit" ClearButton-DisplayMode="Always" Caption="Поиск" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="conferenceContactsFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</div>

<dx:ASPxGridView runat="server" ID="ConferenceContactsGridView" ClientInstanceName="conferenceContactsGridView"
        KeyFieldName="ContactID" EnablePagingGestures="True" EnableRowsCache="False"
        CssClass="grid-view" Width="100%"
        OnDataBinding="ConferenceContactsGridView_OnDataBinding"
                 OnCustomCallback="ConferenceContactsGridView_OnCustomCallback"
        AutoGenerateColumns="False">
        <Settings ShowGroupPanel="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Auto" />
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="False" AllowEllipsisInText="true" AllowDragDrop="True" />
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <SettingsCookies Enabled="False"></SettingsCookies>
        <SettingsSearchPanel CustomEditorID="ConferenceContactsSearchButtonEdit" />
        <Columns>
            <dx:GridViewDataColumn FieldName="Contact.ContactName" Caption="Имя" Width="200px" SortOrder="Ascending" SortIndex="0">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="Contact.ContactDisplayPhone" Caption="Телефон" Width="180px">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="Contact.ContactEmail" Caption="Email" Width="180px">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="Contact.ContactAddress" Caption="Адрес" Width="280px">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataDateColumn FieldName="Contact.ContactDateOfBirth" Caption="Дата рождения" VisibleIndex="80">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Center" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataColumn FieldName="Contact.GroupDisplayName" Caption="Группа" Width="200px">
                <Settings AllowHeaderFilter="True" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="Contact.CompanyName" Caption="Компания" Width="200px">
                <Settings AllowHeaderFilter="True" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="Contact.ContactPosition" Caption="Должность" Width="200px">
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
        <ClientSideEvents Init="conferenceContactsOnGridViewInit" FocusedRowChanged="conferenceContactsGridViewOnFocusedRowChanged" EndCallback="conferenceContactsOnGridViewEndCallback" />
    </dx:ASPxGridView>
