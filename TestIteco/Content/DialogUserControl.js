var dialogFunctionSubmit;

function DialogShow(headerText, messageText, buttonSubmitText,buttonCancelText,functionSubmit) {
    dialogPopupControl.SetHeaderText(headerText);
    dialogMessageLabel.SetValue(messageText);
    dialogSubmitButton.SetText(buttonSubmitText);
    dialogCancelButton.SetText(buttonCancelText);
    dialogFunctionSubmit = functionSubmit;
    dialogPopupControl.Show();
}

function DialogCancelButtonClick(s, e) {
    dialogPopupControl.Hide();
}

function DialogSubmitButtonClick(s, e) {
    dialogPopupControl.Hide();
    if (dialogFunctionSubmit !== null) {
        dialogFunctionSubmit();
    } else {
        alert("functionSubmit is null");
    }
}