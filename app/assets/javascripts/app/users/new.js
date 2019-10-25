function initFormValidation() {
    $("#user_form").validate({
        errorClass: 'text-danger',
        rules: {
            'user[password_confirmation]': {
                required: true,
                equalTo: '#user_password'
            },
            'user[email]': {
                required: true,
                remote: {
                    url: '/users/check_existence',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        email: function () {
                            return $("#user_email").val();
                        },
                        'id': function () {
                            return $("#user_id").val();
                        }
                    }
                }
            },
        }
    })
}

function initFormElements() {
    const el = document.querySelector('#change_password');
    const mySwitch = new Switch(el, {
        onText: 'Si',
        offText: 'No',
        size: 'small',
        onChange: function (checked) {
            if (checked) {
                $("#password_fields").fadeIn();
            } else {
                $("#password_fields").fadeOut();
            }
        }
    });

    const allowLogin = document.querySelector('#user_status');
    const allowLoginSwitch = new Switch(allowLogin, {
        onText: 'Si',
        offText: 'No',
        size: 'small'
    })

}

$(document).ready(function() {
   initFormValidation();
   initFormElements();
});