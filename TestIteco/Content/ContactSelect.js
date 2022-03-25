function contactSelectOnGridViewInit(s, e) {
    AddAdjustmentDelegate(contactSelectAdjustGridView);
    contactSelectUpdateButtonsState();
}

function contactSelectAdjustGridView() {
    contactSelectGridView.AdjustControl();
}

function contactSelectGridViewOnFocusedRowChanged(s, e) {
    contactSelectUpdateButtonsState();
}

function contactSelectUpdateButtonsState() {
    var selectedIndex = contactSelectGridView.GetFocusedRowIndex();

    var cmdEnabled;

    if (selectedIndex === -1) {
        cmdEnabled = false;
    } else {
        cmdEnabled = contactSelectGridView.IsDataRow(selectedIndex);
    }
    contactSelectButton.SetEnabled(cmdEnabled);
}

function contactSelectSaveButtonOnClick(s, e) {
    var contactID = contactSelectGridView.GetRowKey(contactSelectGridView.GetFocusedRowIndex());
    contactSelectPopupControl.Hide();
    contactSelectedFunction(contactID);
}

function contactSelectCancelButtonOnClick(s, e) {
    contactSelectPopupControl.Hide();
}

function contactSelectPopupControlOnPopup(s, e) {
    contactSelectUpdateButtonsState();
    contactSelectSearchButtonEdit.Focus();
}

function selectContact(selectedFunction, currentContactID, title) {
    contactSelectedFunction = selectedFunction;
    contactSelectPopupControl.SetHeaderText(title);
    showProgressBar();
    contactSelectGridView.PerformCallback(currentContactID);
}

function contactSelectOnGridViewEndCallback(s, e) {
    hideProgressBar();
    contactSelectPopupControl.Show();
}

var contactSelectedFunction;