function initColorPicker() {
    const colorInput = document.getElementById('event_type_color');
    const pickr = Pickr.create({
        el: '.color-picker',
        inline: true,
        theme: 'classic',
        default: colorInput.value,
        components: {
            // Main components
            preview: true,
            hue: true,
            // Input / output Options
            interaction: {
                input: true,
                save: true
            },
        },
        strings: {
            save: 'Seleccionar'
        }
    });

    pickr.on('save', (color) => {
        colorInput.value = color.toHEXA();
    });
}

function initFormValidation() {
    $("#event_type_form").validate({
        errorClass: 'text-danger'
    });
}

function initFormElements() {
    const status = document.querySelector('#event_type_status');
    new Switch(status, {
        onText: 'Si',
        offText: 'No',
        size: 'small'
    });
}

$(document).ready(function() {
   initColorPicker();
   initFormElements();
   initFormValidation();
});