function contactsOnGridViewInit(s, e) {
    AddAdjustmentDelegate(contactsAdjustGridView);
    contactsUpdateToolbarButtonsState();

    contactsGridView.ClearFilter();

    editCallAfterSaveFunction = afterSave;

    document.addEventListener("OnContactSaved", e => {
        contactsGridView.Refresh();
        navigationTreeCallbackPanel.PerformCallback();
        showMessage(1, "Контакт сохранен", 1800);
    });
}

function contactsAdjustGridView() {
    contactsGridView.AdjustControl();
}

function contactsGridViewOnFocusedRowChanged(s, e) {
    contactsUpdateToolbarButtonsState();
}

function contactsUpdateToolbarButtonsState() {
    var selectedIndex = contactsGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = contactsGridView.IsDataRow(selectedIndex);
    }

    contactsPageToolbar.GetItemByName("Call").SetEnabled(cmdEnabled);
    contactsPageToolbar.GetItemByName("History").SetEnabled(cmdEnabled);
    contactsPageToolbar.GetItemByName("Edit").SetEnabled(cmdEnabled);
    contactsPageToolbar.GetItemByName("Delete").SetEnabled(cmdEnabled);
}

function contactsOnPageToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ToggleFilterPanel":
            contactsFilterPanel.Toggle();
            break;
        case "Call":
            callSourceContactID = contactsGridView.GetRowKey(contactsGridView.GetFocusedRowIndex());
            selectContact(callContactSelected, callSourceContactID,"Выберите вызываемый контакт");
            break;
        case "History":
            showProgressBar();
            contactHistoryNameLabel.SetText("");
            contactsGridView.GetRowValues(
                contactsGridView.GetFocusedRowIndex(),
                "ContactName",
                setContactHistoryName
            );
            openContactHistory(contactsGridView.GetRowKey(contactsGridView.GetFocusedRowIndex()));
            break;
        case "New":
            newContact();
            break;
        case "Edit":
            editContact(contactsGridView.GetRowKey(contactsGridView.GetFocusedRowIndex()));
            break;
        case "Delete":
            DialogShow("Подтверждение", "Удалить контакт?", "Да", "Нет",
                function () {
                    contactsGridView.PerformCallback("delete|" + contactsGridView.GetRowKey(contactsGridView.GetFocusedRowIndex()));
                    showMessage(1, "Контакт удален", 1800);
                });
            break;
    }
}

function setContactHistoryName(values) {
    contactHistoryNameLabel.SetText(values);
}

function contactsOnFilterPanelExpanded(s, e) {
    adjustPageControls();
    searchButtonEdit.SetFocus();
}

function contactsOnGridViewEndCallback(s, e) {
    contactsGridViewOnFocusedRowChanged(null, null);
}

function navigationTreeViewOnNodeClick(s, e) {

    if (navigationTreeView.GetSelectedNode().index === 0) {
        contactsGridView.ClearFilter();
    } else {

        var groupName = navigationTreeView.GetSelectedNode().GetText();

        var cIndex = groupName.length;
        var cSymbol = 0;

        while (cSymbol !== "(" && cIndex > 0) {
            cSymbol = groupName[cIndex];
            cIndex = cIndex - 1;
        }

        var normalGroupName = groupName.substring(0, cIndex);

        var filterCondition = "[GroupDisplayName] = '" + normalGroupName + "'";
        contactsGridView.ApplyFilter(filterCondition);
    }
}

function callContactSelected(contactID) {
    callTargetContactID = contactID;

    newCall(callSourceContactID, callTargetContactID);
}

var callSourceContactID;
var callTargetContactID;

function afterSave() {
    showMessage(1, "Вызов сохранен", 1600);

    if (contactHistoryPopupControl.GetVisible()) {
        contactHistoryGridView.Refresh();
    }
}

