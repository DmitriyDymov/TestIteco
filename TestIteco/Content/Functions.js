function normalString(source) {
    if (source === null) {
        return "";
    } else {
        return source.replace("|", "").trim();
    }
}

function dateToStr(date) {

    var dateStr = padStr(date.getFullYear()) +
        padStr(1 + date.getMonth()) +
        padStr(date.getDate());
    return dateStr;
}

function dateTimeToStr(date) {
    var dateStr = padStr(date.getFullYear()) +
        "" +
        padStr(1 + date.getMonth()) +
        "" +
        padStr(date.getDate()) +
        "" +
        padStr(date.getHours()) +
        "" +
        padStr(date.getMinutes());
    return dateStr;
}

function strToDateTime(source) {
    var strYear = subStr(source,0, 4);
    var strMonth = subStr(source,4, 2);
    var strDay = subStr(source,6, 2);
    var strHours = subStr(source,8, 2);
    var strMinutes = subStr(source,10, 2);

    var dateStr = strYear + "-" + strMonth + "-" + strDay + "T" + strHours + ":" + strMinutes;

    return new Date(dateStr);
}

function subStr(source, startIndex, count) {
    var res = "";
    for (var i = startIndex; i < startIndex + count; i++) {
        res = res + source[i];
    }

    return res;
}

function padStr(i) {
    return (i < 10) ? "0" + i : "" + i;
}

function showMessage(messageType, messageText, messageTime) {
   
    if (messageType === 2) {
        $("DIV#message-block").attr("style", "background-color: darkred;");
        $("IMG#message-image").attr("src", "/Content/Images/message-warning.svg");
    } else {
        $("DIV#message-block").attr("style", "background-color: #41801d;");
        $("IMG#message-image").attr("src", "/Content/Images/message-info.svg");
    }

    $("SPAN#message-text").text(messageText);

    $("DIV#message-block").fadeIn();
    window.timerId = window.setInterval(hideMessage, messageTime);
}

function hideMessage() {
    window.clearInterval(window.timerId);
    $("DIV#message-block").fadeOut();
}

function avatarUpdate() {
    var $img = $("#HeaderPanel_RightAreaMenu_ITTCNT0_AvatarUrl_0");
    $img.attr("src", $img.attr("src").split("&RND")[0] + "&RND=" + Math.random());
}

function showProgressBar() {
    $("#ProgressBlock").fadeIn();
 
        var elem = document.getElementById("BarBlock");
        var width = 1;
        var id = setInterval(frame, 20);
        function frame() {
            if (width >= 100) {
                clearInterval(id);
       
            } else {
                width++;
                elem.style.width = width + "%";
            }
        }
}

function hideProgressBar() {
    $("#ProgressBlock").fadeOut();
}

function fireClickEvent(element) {
    var evt = new window.MouseEvent("click", {
        view: window,
        bubbles: true,
        cancelable: true
    });

    element.dispatchEvent(evt);
}

function openNewURLInTheSameWindow(targetURL) {
    var a = document.createElement("a");
    a.href = targetURL;
    fireClickEvent(a);
}

function copytext(txt) {
    var $tmp = $("<textarea>");
    $("body").append($tmp);
    $tmp.val(txt).select();
    document.execCommand("copy");
    $tmp.remove();
}