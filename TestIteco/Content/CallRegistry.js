function callsOnGridViewInit(s, e) {
    AddAdjustmentDelegate(callsAdjustGridView);
    callsUpdateToolbarButtonsState();

    callsGridView.ClearFilter();

    editCallAfterSaveFunction = afterSave;

    document.addEventListener("OnContactSaved", e => {
        callsGridView.Refresh();
        navigationTreeCallbackPanel.PerformCallback();
        showMessage(1, "Вызов сохранен", 1800);
    });
}

function callsAdjustGridView() {
    callsGridView.AdjustControl();
}

function callsGridViewOnFocusedRowChanged(s, e) {
    callsUpdateToolbarButtonsState();
}

function callsUpdateToolbarButtonsState() {
    var selectedIndex = callsGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = callsGridView.IsDataRow(selectedIndex);
    }

    callsPageToolbar.GetItemByName("Edit").SetEnabled(cmdEnabled);
    callsPageToolbar.GetItemByName("Delete").SetEnabled(cmdEnabled);
}

function callsOnPageToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ToggleFilterPanel":
            callsFilterPanel.Toggle();
            break;
        case "New":
            newCall(0, 0);
            break;
        case "Edit":
            editCall(callsGridView.GetRowKey(callsGridView.GetFocusedRowIndex()));
            break;
        case "Delete":
            DialogShow("Подтверждение", "Удалить вызов?", "Да", "Нет",
                function () {
                    callsGridView.PerformCallback("delete|" + callsGridView.GetRowKey(callsGridView.GetFocusedRowIndex()));
                    showMessage(1, "Вызов удален", 1800);
                });
            break;
    }
}

function callsOnFilterPanelExpanded(s, e) {
    adjustPageControls();
    searchButtonEdit.SetFocus();
}

function callsOnGridViewEndCallback(s, e) {
    callsGridViewOnFocusedRowChanged(null, null);
}

function afterSave() {
    navigationTreeCallbackPanel.PerformCallback();
    callsGridView.Refresh();
}

function navigationTreeViewOnNodeClick(s, e) {

    if (navigationTreeView.GetSelectedNode().index === 0) {
        callsGridView.ClearFilter();
    } else {

        var statusName = navigationTreeView.GetSelectedNode().GetText();

        var cIndex = statusName.length;
        var cSymbol = 0;

        while (cSymbol !== "(" && cIndex > 0) {
            cSymbol = statusName[cIndex];
            cIndex = cIndex - 1;
        }

        var normalStatusName = statusName.substring(0, cIndex);

        var filterCondition = "[CallStatus.CallStatusName] = '" + normalStatusName + "'";
        callsGridView.ApplyFilter(filterCondition);
    }
}