$(document).ready(function () {
    $('.lockChar').on("keypress", function () {
        return event.charCode >= 48 && event.charCode <= 57
    })
    $('.sizeinput').on("keypress", function () {
        return event.charCode >= 48 && event.charCode <= 57
    })
    $('#gmail').click(function () {
        $('#email_error').text("");  
        document.getElementById("btnSendcontac").disabled = false;
    })
})
function validateEmail(value) {
    if (value.trim() !== '') {
        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        if (testEmail.test(value) == false) {
            $('#email_error').text("Email không hợp lệ");
            document.getElementById("btnSendcontac").disabled = true;
        } else {
            document.getElementById("btnSendcontac").disabled = false;
        } 
    }
}
function sendContactSuccess(res) {
    alert(res.Message);
}
function checkFullName(fullname) {
    if (fullname.trim() !== '') {
        $('#errorFullName').text("");
    } else {
        $('#errorFullName').text("Vui lòng nhập họ tên");
    }
}
function checkAddress(address) {
    if (address.trim() === '') {
        $('#errorAddress').text("Vui lòng nhập địa chỉ");
    } else {
        $('#errorAddress').text("");
    }
}
function checkPhone(phone) {
    if (phone.trim() === '') {
        $('#errorPhone').text("Vui lòng nhập số điện thoại");
    }
    else if (phone.length > 11) {
        $('#errorPhone').text("Số điện thoại không đúng");
        $('#btnOrder').prop('disabled', true);
    }
    else if (phone.slice(0, 1) != 0) {
        $('#errorPhone').text("Số điện thoại không đúng định dạng");
        $('#btnOrder').prop('disabled', true);
    }
    else {
        $('#errorPhone').text("");
        $('#btnOrder').prop('disabled', false);
    }
}
function addCommas(nStr) {
    nStr += '';
    var comma = /,/g;
    nStr = nStr.replace(comma, '');
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}