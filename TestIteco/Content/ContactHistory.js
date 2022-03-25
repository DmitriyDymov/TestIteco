function contactHistoryOnGridViewInit(s, e) {
    AddAdjustmentDelegate(contactHistoryAdjustGridView);
    contactHistoryUpdateButtonsState();
}

function contactHistoryAdjustGridView() {
    contactHistoryGridView.AdjustControl();
}

function contactHistoryGridViewOnFocusedRowChanged(s, e) {
    contactHistoryUpdateButtonsState();
}

function contactHistoryUpdateButtonsState() {
    var selectedIndex = contactHistoryGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = contactHistoryGridView.IsDataRow(selectedIndex);
    }

    contactHistoryPageToolbar.GetItemByName("Open").SetEnabled(cmdEnabled);
}

function contactHistoryPageToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ToggleFilterPanel":
            contactHistoryFilterPanel.Toggle();
            break;
        case "Open":
            contactHistoryGridView.GetRowValues(
                contactHistoryGridView.GetFocusedRowIndex(),
                "CallID;ConferenceID",
                openContactHistoryAction
            );
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
                    contactHistoryGridView.PerformCallback("delete|" + editConferenceID + "|" + contactHistoryGridView.GetRowKey(contactHistoryGridView.GetFocusedRowIndex()));
                });
            break;
    }
}

function openContactHistoryAction(values) {
    var callID = values[0];
    var conferenceID = values[1];

    if (callID !== 0) {
        editCall(callID);
    } else {
        editConference(conferenceID);
    }
}

function openContactHistory(contactID) {
    contactHistoryGridView.PerformCallback(contactID);
}


function contactHistoryFilterPanelExpanded(s, e) {
    adjustPageControls();
    contactHistorySearchButtonEdit.SetFocus();
}

function contactHistoryOnGridViewEndCallback(s, e) {
    contactHistoryUpdateButtonsState();
    hideProgressBar();
    contactHistoryPopupControl.Show();
}

function contactHistoryCloseButtonOnClick() {
    contactHistoryPopupControl.Hide();
}

function contactHistoryPopupControlOnPopup(s, e) {
   
}

function editConferenceAfterSaveFunction() {
    contactHistoryGridView.Refresh();
}

