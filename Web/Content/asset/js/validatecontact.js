$(document).ready(function () {
    $("#basicForm").validate({
        rules:
        {
            FullName:
            {
                required: true
            },
            Phone:
            {
                required: true,
                maxlength: 14
            },
            Title:
            {
                required: true
            },
            Contents:
            {
                required: true
            }
        },
        messages:
        {
            FullName:
            {
                required: "Vui lòng nhập họ tên"
            },
            Phone:
            {
                required: "Vui lòng nhập số điện thoại"
            },
            Title:
            {
                required: "Vui lòng nhập tiêu đề"
            },
            Contents:
            {
                required: "Vui lòng nhập nội dung"
            }
        }
    });
    let contactContent = $('#contactContent').val();
    var lstdata = JSON.parse(contactContent);
    for (var i = 0; i < lstdata.length; i++) {
        $("#" + lstdata[i].Key).html(lstdata[i].Value);
    }
    $('#Email').click(function () {
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