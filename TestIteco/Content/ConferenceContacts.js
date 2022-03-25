function conferenceContactsOnGridViewInit(s, e) {
    AddAdjustmentDelegate(conferenceContactsAdjustGridView);
    conferenceContactsUpdateButtonsState();
}

function conferenceContactsAdjustGridView() {
    conferenceContactsGridView.AdjustControl();
}

function conferenceContactsGridViewOnFocusedRowChanged(s, e) {
    conferenceContactsUpdateButtonsState();
}

function conferenceContactsUpdateButtonsState() {
    var selectedIndex = conferenceContactsGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = conferenceContactsGridView.IsDataRow(selectedIndex);
    }
    
    conferenceContactsPageToolbar.GetItemByName("Delete").SetEnabled(cmdEnabled);
}

function conferenceContactsPageToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ToggleFilterPanel":
            conferenceContactsFilterPanel.Toggle();
            break;
        case "New":
            if (editConferenceID === 0) {
                DialogShow("Подтверждение сохранения",
                    "Перед добавлением участников необходимо сохранить конференцию",
                    "Сохранить",
                    "Отмена",
                    function () {
                        closeConferenceEditAfterSave = false;
                        saveConference(newConferenceContact);
                    });
            } else {
                newConferenceContact();
            }
            break;
        case "Delete":
            DialogShow("Подтверждение", "Удалить участника?", "Да", "Нет",
                function () {
                    conferenceContactsGridView.PerformCallback("delete|" + editConferenceID + "|" + conferenceContactsGridView.GetRowKey(conferenceContactsGridView.GetFocusedRowIndex()));
                });
            break;
    }
}

function newConferenceContact() {
    selectContact(conferenceContactNewContact, 0, "Выберите участника");
}

function conferenceContactNewContact(contactID) {
    conferenceContactsGridView.PerformCallback("save|" + editConferenceID + "|" + contactID);
}

function conferenceContactsFilterPanelExpanded(s, e) {
    adjustPageControls();
    conferenceContactsSearchButtonEdit.SetFocus();
}

function conferenceContactsOnGridViewEndCallback(s, e) {
    conferenceContactsUpdateButtonsState();
}

function conferenceContactsEdit() {
    conferenceContactsGridView.PerformCallback("load|" + editConferenceID);
}

