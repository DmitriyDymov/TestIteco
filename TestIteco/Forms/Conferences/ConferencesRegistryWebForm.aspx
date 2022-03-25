<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeBehind="ConferencesRegistryWebForm.aspx.cs" Inherits="TestIteco.Forms.Conferences.ConferencesRegistryWebForm" %>

<%@ Register Src="~/Forms/Conferences/ConferenceEditUserControl.ascx" TagPrefix="ucEdit" TagName="ConferenceEditUserControl" %>
<%@ Register Src="~/Forms/Contacts/ContactSelectUserControl.ascx" TagPrefix="ucEdit" TagName="ContactSelectUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content.ashx?Name=GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ConferencesRegistry.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ConferenceEdit.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ConferenceContacts.js") %>'></script>
    <script type="text/javascript" src='<%# ResolveUrl("~/Content.ashx?Name=ContactSelect.js") %>'></script>
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
    <dx:ASPxMenu runat="server" ID="ConferencesPageToolbar" ClientInstanceName="conferencesPageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
        <ClientSideEvents ItemClick="conferencesOnPageToolbarItemClick" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>Конференции</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Новая" Alignment="Right" AdaptivePriority="2">
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
    <dx:ASPxPanel runat="server" ID="ConferencesFilterPanel" ClientInstanceName="conferencesFilterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Поиск" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="conferencesOnFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="ConferencesGridView" ClientInstanceName="conferencesGridView"
        KeyFieldName="ConferenceID" EnablePagingGestures="True" EnableRowsCache="False"
        CssClass="grid-view" Width="100%"
        OnDataBinding="ConferencesGridView_OnDataBinding"
                     OnCustomCallback="ConferencesGridView_OnCustomCallback"
        AutoGenerateColumns="False">
        <Settings ShowGroupPanel="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Auto" />
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="False" AllowEllipsisInText="true" AllowDragDrop="True" />
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <SettingsCookies Enabled="False"></SettingsCookies>
        <SettingsSearchPanel CustomEditorID="SearchButtonEdit" />
        <Columns>

            <dx:GridViewDataDateColumn FieldName="ConferencePlannedDate" Caption="Планируемая дата начала" Width="160px" SortOrder="Descending" SortIndex="0">
                <PropertiesDateEdit DisplayFormatString="{0:MM/dd/yy H:mm}"></PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" />
                <CellStyle HorizontalAlign="Center" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="ConferenceBeganDate" Caption="Фактическая дата начала" Width="160px">
                <PropertiesDateEdit DisplayFormatString="{0:MM/dd/yy H:mm}"></PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" />
                <CellStyle HorizontalAlign="Center" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataColumn FieldName="ConferenceStatus.ConferenceStatusName" Caption="Статус" Width="200px">
                <Settings AllowHeaderFilter="True" />
                <CellStyle HorizontalAlign="Left">
                </CellStyle>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="ConferenceSubject" Caption="Тема" Width="360px">
                <Settings AllowHeaderFilter="False" />
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
        <ClientSideEvents Init="conferencesOnGridViewInit" FocusedRowChanged="conferencesGridViewOnFocusedRowChanged" EndCallback="conferencesOnGridViewEndCallback" />
    </dx:ASPxGridView>
    
    <ucEdit:ConferenceEditUserControl runat="server" ID="ConferenceEditUserControl" />
    
    <ucEdit:ContactSelectUserControl runat="server" id="ContactSelectUserControl" />

</asp:Content>
