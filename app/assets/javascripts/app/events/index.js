window.calendar = null;

function initCalendar() {
    const calendarEl = document.getElementById("calendar");
    const calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: ['dayGrid', 'interaction'],
        locale: 'es',
        height: "parent",
        header: {
            left: 'title',
            center: '',
            right: 'today dayGridMonth dayGridWeek dayGridDay prev next'
        },
        dateClick: function(info) {
            calendar.changeView('dayGridDay', info.dateStr);
        },
        events: '/events.json'
    });
    calendar.render();
    window.calendar = calendar;
}

function initEventForm() {
    $("#event_form").validate({
        errorClass: 'text-danger'
    });

    $("#event_starts_at").flatpickr({
        static: true,
        inline: true,
        enableTime: true,
        dateFormat: 'Y-m-d H:i'
    });

    $("#event_ends_at").flatpickr({
        static: true,
        inline: true,
        enableTime: true,
        dateFormat: 'Y-m-d H:i'
    });
}

function getEventData() {
    return {
        event: {
            title: $("#event_title").val(),
            description: $("#event_description").val(),
            event_type_id: $("#event_event_type_id").val(),
            starts_at: $("#event_starts_at").val(),
            ends_at: $("#event_ends_at").val(),
            assigned_to_id: $("#event_assigned_to_id").val()
        }
    };
}

async function submitNewEvent() {
    const url = '/events';
    const eventData = getEventData();
    return FetchP.post(url, eventData, 'json');
}

$(document).on('click', '#btn-new-event', async function() {
    try {
        const url = '/events/new';
        const content = await FetchP.get(url, {}, '');
        $("#event-modal .modal-content .modal-body").html(content);
        $("#event-modal").modal('show');
        initEventForm();
    } catch(e) {
        console.error(e);
    }
});

$(document).on('submit', '#event_form', async function(e) {
    console.log('submit');
    e.preventDefault();
    if ($(this).valid()) {
        console.log('valid');
        try {
            await submitNewEvent();
            window.calendar.refetchEvents();
            $("#event-modal").modal('hide');
        } catch(e) {
            console.error(e);
        }
    } else console.log('invalid');
});

document.addEventListener('DOMContentLoaded', function() {
    initCalendar();
});