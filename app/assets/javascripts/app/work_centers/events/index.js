window.calendar = null;

function initCalendar() {
    const calendarEl = document.getElementById("calendar");
    const calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: ['interaction', 'dayGrid', 'timeGrid'],
        handleWindowResize: true,
        locale: 'es',
        height: function() {
            return $(window).height() - ($('.am-top-header').height() * 2) - 125;
        },
        weekends: false,
        allDaySlot: false,
        slotEventOverlap: false,
        eventOverlap: false,
        slotDuration: '00:15:00', // 15 minutes
        minTime: '07:00:00',
        maxTime: '21:00:00',
        defaultView: 'timeGridWeek',
        droppable: false,
        eventStartEditable: false,
        eventLimit: true,
        slotLabelFormat: {
            hour: 'numeric',
            minute: '2-digit',
            omitZeroMinute: false,
            meridiem: 'short'
        },
        header: {
            left: 'title',
            center: '',
            right: 'today dayGridMonth timeGridWeek timeGridDay prev next'
        },
        dateClick: function(info) {
            calendar.changeView('timeGridWeek', info.dateStr);
        },
        eventClick: function(data) {
            showUpdateModal(data.event);
        },
        eventSources: [
            {
                url: $("#base_url_json").val(),
                extraParams: function() {
                    return {
                        'doctors[]': getSelectedDoctors(),
                        'event_types[]': getSelectedEventTypes(),
                        search_text: $("#search_input").val()
                    };
                }
            }
        ]
    });
    calendar.render();
    window.calendar = calendar;
}

function refreshCalendar() {
    window.calendar.refetchEvents();
}

async function showUpdateModal(event) {
    const baseUrl = $("#base_url").val();
    const markup = await FetchP.get(`${baseUrl}/${event.id}`, {}, '');
    $("#event-modal .modal-body").html(markup);
    $("#event-modal").modal('show');
    initEventForm();
}

function initFilters() {
    const options = {
        locale: 'es-ES',
        filter: true
    };
    $('#doctors_select').multipleSelect({
        ...options,
        placeholder: 'Filtro por médico'
    });
    $('#event_types_select').multipleSelect({
        ...options,
        placeholder: 'Filtro por evento'
    });
}

function getSelectedDoctors() {
    return $('#doctors_select').multipleSelect('getSelects', 'value').map((item) => Number(item));
}

function getSelectedEventTypes() {
    return $('#event_types_select').multipleSelect('getSelects', 'value').map((item) => Number(item));
}

$(document).on('submit', '#filter_form', function(e) {
   e.preventDefault();
   refreshCalendar();
});

document.addEventListener('DOMContentLoaded', function() {
    initFilters();
    initCalendar();
});