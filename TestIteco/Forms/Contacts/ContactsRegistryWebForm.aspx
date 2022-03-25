<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeBehind="ContactsRegistryWebForm.aspx.cs" Inherits="TestIteco.Forms.Contacts.ContactsRegistryWebForm" %>

<%@ Register Src="~/Forms/Contacts/ContactEditUserControl.ascx" TagPrefix="ucEdit" TagName="ContactEditUserControl" %>
<%@ Register Src="~/Forms/Contacts/ContactSelectUserControl.ascx" TagPrefix="ucEdit" TagName="ContactSelectUserControl" %>
<%@ Register Src="~/Forms/Calls/CallEditUserControl.ascx" TagPrefix="ucEdit" TagName="CallEditUserControl" %>
<%@ Register Src="~/Forms/Contacts/ContactHistoryUserControl.ascx" TagPrefix="ucEdit" TagName="ContactHistoryUserControl" %>
<%@ Register Src="~/Forms/Conferences/ConferenceEditUserControl.ascx" TagPrefix="ucEdit" TagName="ConferenceEditUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content.ashx?Name=GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ContactRegistry.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ContactEdit.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ContactSelect.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=CallEdit.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ContactHistory.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ConferenceEdit.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ConferenceContacts.js") %>'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
    <dx:ASPxCallbackPanel ID="NavigationTreeCallbackPanel" ClientInstanceName="navigationTreeCallbackPanel" runat="server" Width="100%" OnCallback="NavigationTreeCallbackPanel_OnCallback">
        <PanelCollection>
            <dx:PanelContent>

                <dx:ASPxTreeView ID="NavigationTreeView" ClientInstanceName="navigationTreeView" AutoPostBack="False" runat="server" EnableNodeTextWrapping="True" AllowSelectNode="true" Width="100%" SyncSelectionMode="None">
                    <Styles>
                        <Elbow CssClass="tree-view-elbow" />
                        <Node CssClass="tree-view-node" HoverStyle-CssClass="hovered" />
                    </Styles>
                    <ClientSideEvents NodeClick="navigationTreeViewOnNodeClick"></ClientSideEvents>
                </dx:ASPxTreeView>

            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
    <dx:ASPxMenu runat="server" ID="ContactsPageToolbar" ClientInstanceName="contactsPageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
        <ClientSideEvents ItemClick="contactsOnPageToolbarItemClick" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>Контакты</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="Call" Text="Вызов" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/phone.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="History" Text="История" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/document.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Новый" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Изменить" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/edit.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Удалить" Alignment="Right" AdaptivePriority="2">
                <Image Url="/Content/Images/delete.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="ToggleFilterPanel" Text="" GroupName="Filter" Alignment="Right" AdaptivePriority="1">
                <Image Url="/Content/Images/search.svg" UrlChecked="/Content/Images/search-selected.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
    <dx:ASPxPanel runat="server" ID="ContactsFilterPanel" ClientInstanceName="contactsFilterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Поиск" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="contactsOnFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="ContactsGridView" ClientInstanceName="contactsGridView"
        KeyFieldName="ContactID" EnablePagingGestures="True" EnableRowsCache="False"
        CssClass="grid-view" Width="100%"
        OnDataBinding="ContactsGridView_OnDataBinding"
                     OnCustomCallback="ContactsGridView_OnCustomCallback"
        AutoGenerateColumns="False">
        <Settings ShowGroupPanel="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Auto" />
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="False" AllowEllipsisInText="true" AllowDragDrop="True" />
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <SettingsCookies Enabled="False"></SettingsCookies>
        <SettingsSearchPanel CustomEditorID="SearchButtonEdit" />
        <Columns>
            <dx:GridViewDataColumn FieldName="ContactName" Caption="Имя" Width="200px" SortOrder="Ascending" SortIndex="0">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="ContactDisplayPhone" Caption="Телефон" Width="180px">
                <Settings AllowHeaderFilter="False" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="ContactEmail" Caption="Email" Width="180px">
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
        <ClientSideEvents Init="contactsOnGridViewInit" FocusedRowChanged="contactsGridViewOnFocusedRowChanged" EndCallback="contactsOnGridViewEndCallback" />
    </dx:ASPxGridView>

    <ucEdit:ContactEditUserControl runat="server" ID="ContactEditUserControl" />
    
    <ucEdit:ContactSelectUserControl runat="server" id="ContactSelectUserControl" />
    
    <ucEdit:CallEditUserControl runat="server" id="CallEditUserControl" />
    
    <ucEdit:ContactHistoryUserControl runat="server" id="ContactHistoryUserControl" />
    
    <ucEdit:ConferenceEditUserControl runat="server" ID="ConferenceEditUserControl" />


</asp:Content>
