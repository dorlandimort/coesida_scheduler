function initFormValidation() {
    $("#work_center_form").validate({
        errorClass: 'text-danger'
    });
}

function initFormElements() {
    const el = document.querySelector('#work_center_status');
    const mySwitch = new Switch(el, {
        onText: 'Si',
        offText: 'No',
        size: 'small'
    });
}

$(document).ready(function() {
    initFormValidation();
    initFormElements();
});