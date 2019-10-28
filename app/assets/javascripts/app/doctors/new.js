function initFormValidation() {
    $("#doctor_form").validate({
        errorClass: 'text-danger'
    })
}

function initFormElements() {
    const allowLogin = document.querySelector('#doctor_status');
    const allowLoginSwitch = new Switch(allowLogin, {
        onText: 'Si',
        offText: 'No',
        size: 'small'
    });
}

$(document).on('change', '#doctor_user_id', async function() {
   const value = $(this).val();
   if (value) {
       try {
           const user = await retrieveUser(value);
            fillUserFields(user);
       } catch(e) {
           console.error(e);
       }
   } else {
       clearUserFields();
   }
});

async function retrieveUser(id) {
    return FetchP.get(`/users/${id}`, {}, 'json');
}

function fillUserFields(user) {
    $("#user_first_name").val(user.first_name);
    $("#user_last_name").val(user.last_name);
    $("#user_mother_last_name").val(user.mother_last_name);
}

function clearUserFields() {
    $("#user_first_name").val('');
    $("#user_last_name").val('');
    $("#user_mother_last_name").val('');
}

$(document).ready(function() {
    initFormValidation();
    initFormElements();
});