var editConferenceID;
var editConferenceAfterSaveFunction;

function newConference() {
    resetConference();
    conferenceContactsEdit();
    conferenceEditPopupControl.Show();
}

function editConference(conferenceID) {
    editConferenceID = conferenceID;
    showProgressBar();
    conferenceLoadCallback.PerformCallback(editConferenceID);
}

function resetConference() {
    editConferenceID = 0;
    conferencePlannedDateDateEdit.SetValue(new Date());
    conferenceBeganDateEdit.SetValue(new Date());
    conferenceStatusComboBox.SetSelectedIndex(0);
    conferenceSubjectTextBox.SetValue("");
    conferenceCommentMemo.SetValue("");
}

function conferenceSaveButtonOnClick(s, e) {
    closeConferenceEditAfterSave = true;
    saveConference(() => {});
}

var saveConferenceAfterSavedFunction;

function saveConference(afterSavedFunction) {

    saveConferenceAfterSavedFunction = afterSavedFunction;

    var p = editConferenceID +
        "|" +
        dateTimeToStr(conferencePlannedDateDateEdit.GetDate()) +
        "|" +
        dateTimeToStr(conferenceBeganDateEdit.GetDate()) +
        "|" +
        conferenceStatusComboBox.GetSelectedIndex() +
        "|" +
        conferenceSubjectTextBox.GetValue() +
        "|" +
        conferenceCommentMemo.GetValue();

    conferenceSaveCallback.PerformCallback(p);
}

function conferenceCancelButtonOnClick(s, e) {
    conferenceEditPopupControl.Hide();
}

function conferenceEditPopupControlOnPopup(s, e) {
    conferenceSubjectTextBox.Focus();
}

function conferenceLoadCallbackOnCallbackComplete(s, e) {
    hideProgressBar();
    var p = e.result.split("|");

    conferencePlannedDateDateEdit.SetDate(strToDateTime(p[0]));
    conferenceBeganDateEdit.SetDate(strToDateTime(p[1]));
    conferenceStatusComboBox.SetSelectedIndex(p[2]);
    conferenceSubjectTextBox.SetValue(p[3]);
    conferenceCommentMemo.SetValue(p[4]);
    conferenceContactsEdit();
    
    conferenceEditPopupControl.Show();
    hideProgressBar();
}

var closeConferenceEditAfterSave = true;

function conferenceSaveCallbackOnCallbackComplete(s, e) {
    var p = e.result.split("|");

    if (p[0] === "1") {

        editConferenceID = p[1];

        if (saveConferenceAfterSavedFunction === true) {
            conferenceEditPopupControl.Hide();
        }

        if (editConferenceAfterSaveFunction !== null) {
            editConferenceAfterSaveFunction();
        }

        if (saveConferenceAfterSavedFunction !== null) {
            saveConferenceAfterSavedFunction();
        }
    } else {
        alert("При сохранении произошла ошибка");
    }

    saveConferenceAfterSavedFunction = null;

    if (closeConferenceEditAfterSave) {
        conferenceEditPopupControl.Hide();
    }
}