var editCallID = 0;
var editCallSourceContactID = 0;
var editCallTargetContactID = 0;
var editCallAfterSaveFunction;

function editCall(callID) {
    resetCall();
    editCallID = callID;
    showProgressBar();
    callLoadCallback.PerformCallback(callID);
}

function newCall(sourceContact, targetContact) {
    resetCall();
    editCallID = 0;
    editCallSourceContactID = sourceContact;
    editCallTargetContactID = targetContact;

    callEditPopupControl.Show();
    callNewCallback.PerformCallback(editCallSourceContactID + "|" + editCallTargetContactID);
}

function resetCall() {
    editCallSourceContactID = 0;
    editCallTargetContactID = 0;
    callSourceButtonEdit.SetValue("");
    callTargetButtonEdit.SetValue("");
    callStatusComboBox.SetSelectedIndex(0);
    callDateDateEdit.SetValue(new Date());
    callDurationSpinEdit.SetValue(1);
    callSubjectTextBox.SetValue("");
    callCommentMemo.SetValue("");
}

function callNewCallbackOnCallbackComplete(s, e) {
    var p = e.result.split("|");

    callSourceButtonEdit.SetValue(p[0]);
    callTargetButtonEdit.SetValue(p[1]);
}

function callLoadCallbackOnCallbackComplete(s, e) {
    hideProgressBar();

    var p = e.result.split("|");

    editCallSourceContactID = p[0];
    editCallTargetContactID = p[1];
    callSourceButtonEdit.SetValue(p[2]);
    callTargetButtonEdit.SetValue(p[3]);
    callStatusComboBox.GetSelectedIndex(p[4]);
    callDateDateEdit.SetDate(strToDateTime(p[5]));
    callDurationSpinEdit.SetValue(p[6]);
    callSubjectTextBox.SetValue(p[7]);
    callCommentMemo.SetValue(p[8]);

    callEditPopupControl.Show();
}

function callSaveCallbackOnCallbackComplete(s, e) {
    if (e.result === "1") {
        callEditPopupControl.Hide();

        if (editCallAfterSaveFunction !== null) {
            editCallAfterSaveFunction();
        }
    } else {
        alert("При сохранении произошла ошибка");
    }
}

function callSaveButtonOnClick(s, e) {

    var error = false;

    if (editCallSourceContactID === 0) {
        callSourceButtonEdit.SetIsValid(false);
        callSourceButtonEdit.SetErrorText("Выберите вызывающий контакт");
        error = true;
    }

    if (editCallTargetContactID === 0) {
        callTargetButtonEdit.SetIsValid(false);
        callTargetButtonEdit.SetErrorText("Выберите вызываемый контакт");
        error = true;
    }

    if (error === false) {
        callSaveCallback.PerformCallback(
            editCallID +
            "|" +
            editCallSourceContactID +
            "|" +
            editCallTargetContactID +
            "|" +
            callStatusComboBox.GetSelectedIndex() +
            "|" +
            dateTimeToStr(callDateDateEdit.GetDate()) +
            "|" +
            callDurationSpinEdit.GetValue() +
            "|" +
            normalString(callSubjectTextBox.GetValue()) +
            "|" +
            normalString(callCommentMemo.GetValue())
        );
    }
}

function callCancelButtonOnClick(s, e) {
    callEditPopupControl.Hide();
}

function callEditPopupControlOnPopup(s, e) {
    callSourceButtonEdit.SetIsValid(true);
    callTargetButtonEdit.SetIsValid(true);
}

function callSourceButtonEditOnButtonClick(s, e) {
    selectContact(editCallSourceContactSelected, editCallTargetContactID,"Выберите вызывающий контакт");
}

function callTargetButtonEditOnButtonClick(s, e) {
    selectContact(editCallTargetContactSelected, editCallSourceContactID, "Выберите вызываемый контакт");
}

function editCallSourceContactSelected(selectedContactID) {
    editCallSourceContactID = selectedContactID;
    callNewCallback.PerformCallback(editCallSourceContactID + "|" + editCallTargetContactID);
}

function editCallTargetContactSelected(selectedContactID) {
    editCallTargetContactID = selectedContactID;
    callNewCallback.PerformCallback(editCallSourceContactID + "|" + editCallTargetContactID);
}


