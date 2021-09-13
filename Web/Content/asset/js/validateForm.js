$(document).ready(function () {

    $(".rules").keypress(function (e) {
        if (e.keyCode == 13)
            $('#login').click();
    });
    $("#frmRegister").validate({
        onkeyup, onclick: function (element, event) {
            if ($(element).attr('user') == "user") {
                return false;
            }
            else {
                if (event.which === 9 && this.elementValue(element) === "") {
                    return;
                }
                else if (element.name in this.submitted || element === this.lastElement) {
                    this.element(element);
                }
            }
        },
        rules: {
            userrg: {
                required: true,
                remote: {
                    url: '/Login/CheckAlready'
                }
            },
            passrg: {
                required: true,
                minlength: 6
            },
            password_confirmation: {
                required: true,
                equalTo: '#passrg'
            }
        },
        messages: {
            userrg: {
                required: "Bạn chưa nhập tên tài khoản",
                remote: function () {
                    return $.validator.format("Tài khoản {0} đã tồn tại", $("#userrg").val());
                }
            },
            passrg: {
                required: "Bạn chưa nhập mật khẩu",
                minlength: "Mật khẩu quá ngắn",
            },
            password_confirmation: {
                required: "Bạn chưa xác nhận mật khẩu",
                equalTo: "Mật khẩu không giống nhau"
            }
        },
        highlight: function (element) {
            $(element).parent().css("color", "red");
        }
    });
    $('.rules').validate({

        rules: {
            userlg: {
                required: true
            },
            passlg: {
                required: true,
            }

        },
        messages: {
            userlg: {
                required: "Bạn chưa nhập tên tài khoản",
            },
            passlg: {
                required: "Bạn chưa nhập mật khẩu",
            }
        },
        highlight: function (element) {
            $(element).parent().css("color", "red");
        }
    });
});

$('#register').click(function () {
    var user = $('#userrg').val();
    var pass = $('#passrg').val();
    var id = {
        UserName: user,
        Password: pass

    }
    if ($('#frmRegister').valid() == false) {

    }
    else {
        $.ajax({
            url: '/Login/Register',
            data: {
                id: JSON.stringify(id)
            },
            type: 'POST',
            dataType: 'json',
            success: function () {

            }
        });
        $('.log').click();
    }
});
$('#login').click(function (e) {
    e.preventDefault();
    var user = $('#userlg').val();
    var pass = $('#passlg').val();
    var id = {
        UserName: user,
        Password: pass

    }
    if ($('.rules').valid() == false) {
        $('#loginModal .modal-dialog').removeClass('shake');
        if ($('#user').val() == '') {
            $('.errors').removeClass('alert alert - danger').html('');

        }

    }
    else {
        $.ajax({
            url: '/Login/Logins',
            data: {
                id: JSON.stringify(id),
                user: user,
                pass: pass
            },
            type: 'POST',
            dataType: 'json',
            success: function (res) {
                if (res.data == 1) {
                    $('#loginModal .modal-dialog').removeClass('shake');
                    window.location.href = "trang-chu.html";
                }
                else if (res.data == -1) {
                    $('.errors').addClass('alert alert-danger').html("Tài khoản đang bị khóa");
                }
                else {
                    $('.errors').addClass('alert alert-danger').html("Tài khoản hoặc mật khẩu không đúng");
                }
            }
        });
    }

});