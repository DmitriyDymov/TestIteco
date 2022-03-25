function conferencesOnGridViewInit(s, e) {
    AddAdjustmentDelegate(conferencesAdjustGridView);
    conferencesUpdateToolbarButtonsState();

    editConferenceAfterSaveFunction = afterSavedFunction;

    conferencesGridView.ClearFilter();
}

function conferencesAdjustGridView() {
    conferencesGridView.AdjustControl();
}

function conferencesGridViewOnFocusedRowChanged(s, e) {
    conferencesUpdateToolbarButtonsState();
}

function conferencesUpdateToolbarButtonsState() {
    var selectedIndex = conferencesGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = conferencesGridView.IsDataRow(selectedIndex);
    }

    conferencesPageToolbar.GetItemByName("Edit").SetEnabled(cmdEnabled);
    conferencesPageToolbar.GetItemByName("Delete").SetEnabled(cmdEnabled);
}

function conferencesOnPageToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ToggleFilterPanel":
            conferencesFilterPanel.Toggle();
            break;
        case "New":
            newConference();
            break;
        case "Edit":
            editConference(conferencesGridView.GetRowKey(conferencesGridView.GetFocusedRowIndex()));
            break;
        case "Delete":
            DialogShow("Подтверждение", "Удалить конференцию?", "Да", "Нет",
                function () {
                    conferencesGridView.PerformCallback("delete|" + conferencesGridView.GetRowKey(conferencesGridView.GetFocusedRowIndex()));
                    showMessage(1, "Контакт удален", 1800);
                });
            break;
    }
}

function conferencesOnFilterPanelExpanded(s, e) {
    adjustPageControls();
    searchButtonEdit.SetFocus();
}

function conferencesOnGridViewEndCallback(s, e) {
    conferencesGridViewOnFocusedRowChanged(null, null);
}

function navigationTreeViewOnNodeClick(s, e) {

    if (navigationTreeView.GetSelectedNode().index === 0) {
        conferencesGridView.ClearFilter();
    } else {

        var groupName = navigationTreeView.GetSelectedNode().GetText();

        var cIndex = groupName.length;
        var cSymbol = 0;

        while (cSymbol !== "(" && cIndex > 0) {
            cSymbol = groupName[cIndex];
            cIndex = cIndex - 1;
        }

        var normalGroupName = groupName.substring(0, cIndex);

        var filterCondition = "[ConferenceStatus.ConferenceStatusName] = '" + normalGroupName + "'";
        conferencesGridView.ApplyFilter(filterCondition);
    }
}

function afterSavedFunction(conferenceID) {
    conferencesGridView.Refresh();
    navigationTreeCallbackPanel.PerformCallback();
}


