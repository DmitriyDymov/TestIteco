var editContactID;

var onContactSavedEvent = new Event("OnContactSaved");

function newContact() {
    editContactID = 0;
    showProgressBar();
    contactEditCallbackPanel.PerformCallback(editContactID);
}

function editContact(contactID) {
    editContactID = contactID;
    showProgressBar();
    contactEditCallbackPanel.PerformCallback(editContactID);
}


function contactEditCallbackPanelOnEndCallback(s, e) {
    hideProgressBar();
    contactEditPopupControl.Show();
}

function validationContactSaveCallbackOnCallbackComplete(s, e) {

    var p = e.result.split("|");

    var validationName = p[0];
    var validationEmail = p[1];
    var validationPhone = p[2];

    var validationError = p[0] !== "1" || p[1] !== "1" || p[2] !== "1";

    if (validationError) {

        switch (validationName) {
            case "2":
                contactNameTextBox.SetIsValid(false);
                contactNameTextBox.SetErrorText("Неверное имя. Имя должно сожержать не менее 5 символов");
                break;
            default:
                contactNameTextBox.SetIsValid(true);
                break;
        }

        switch (validationEmail) {
            case "2":
                contactEmailTextBox.SetIsValid(false);
                contactEmailTextBox.SetErrorText("Неверный email");
                break;
            case "3":
                contactEmailTextBox.SetIsValid(false);
                contactEmailTextBox.SetErrorText("Email уже существует");
                break;
            default:
                contactEmailTextBox.SetIsValid(true);
                break;
        }

        switch (validationPhone) {
            case "2":
                contactPhoneTextBox.SetIsValid(false);
                contactPhoneTextBox.SetErrorText("Неверный телефон");
                break;
            case "3":
                contactPhoneTextBox.SetIsValid(false);
                contactPhoneTextBox.SetErrorText("Телефон уже существует");
                break;
            default:
                contactPhoneTextBox.SetIsValid(true);
                break;
        }

        hideProgressBar();

    } else {
        contactSaveCallback.PerformCallback(
            editContactID +
            "|" +
            normalString(contactNameTextBox.GetValue()) +
            "|" +
            normalString(contactAddressTextBox.GetValue()) +
            "|" +
            dateToStr(contactDateOfBirth.GetValue()) +
            "|" +
            normalString(groupNameComboBox.GetValue()) +
            "|" +
            normalString(companyNameComboBox.GetValue()) +
            "|" +
            normalString(contactPositionComboBox.GetValue()) +
            "|" +
            normalString(contactEmailTextBox.GetValue()) +
            "|" +
            normalString(contactPhoneTextBox.GetValue())
        );
    }
}

function contactSaveCallbackOnCallbackComplete(s, e) {
    if (e.result === "1") {
        contactEditPopupControl.Hide();
        document.dispatchEvent(onContactSavedEvent);
    } else {
        alert("Произошла ошибка при сохранении");
    }

    hideProgressBar();
}

function contactSaveButtonOnClick(s, e) {

    if (ASPxClientEdit.ValidateGroup("ContactValidationGroup")) {

        showProgressBar();

        validationContactSaveCallback.PerformCallback(
            editContactID +
            "|" +
            normalString(contactNameTextBox.GetValue()) +
            "|" +
            normalString(contactEmailTextBox.GetValue()) +
            "|" +
            normalString(contactPhoneTextBox.GetValue())
        );
    }
}

function onBtnCancelClick(s, e) {
    contactEditPopupControl.Hide();
}

function contactEditPopupControlOnPopup(s, e) {
    contactNameTextBox.Focus();
    contactNameTextBox.SetIsValid(true);
    contactEmailTextBox.SetIsValid(true);
    contactPhoneTextBox.SetIsValid(true);
}