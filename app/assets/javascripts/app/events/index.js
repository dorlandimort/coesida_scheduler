window.calendar = null;

function initCalendar() {
    const calendarEl = document.getElementById("calendar");
    const calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: ['interaction', 'dayGrid', 'timeGrid'],
        handleWindowResize: true,
        locale: 'es',
        height: function() {
            return $(window).height() - ($('.am-top-header').height() * 2) - 25;
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
                        'event_types[]': getSelectedEventTypes()
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
}

async function initFilters() {
    return new Promise(resolve => {
        const options = {
            locale: 'es-ES',
            filter: true
        };
        $('#event_types_select').multipleSelect({
            ...options,
            placeholder: 'Filtro por evento'
        });
        $('#work_centers_select').multipleSelect({
            ...options,
            placeholder: 'Filtro por centro de trabajo',
            onAfterCreate: async function() {
                await initDoctorsFilter();
                resolve(true);
            },
            onClick: function () {
                refreshDoctorsSelect();
            }
        });
    });
}

async function initDoctorsFilter() {
    return new Promise(async (resolve) => {
        const doctors = await fetchDoctors();
        $('#doctors_select').multipleSelect({
            locale: 'es-ES',
            filter: true,
            placeholder: 'Filtro por médico',
            data: doctors,
            onAfterCreate: function () {
                resolve(true);
            }
        });
    });
}


async function refreshDoctorsSelect() {
    const doctors = await fetchDoctors();
    $("#doctors_select").multipleSelect('refreshOptions', {
        data: doctors
    });
}

async function fetchDoctors() {
    const selectedWorkCenters = getSelectedWorkCenters();
    const url = `/doctor_filters`;
    return FetchP.get(url, { work_centers: selectedWorkCenters }, 'json');
}

function getSelectedDoctors() {
    return $('#doctors_select').multipleSelect('getSelects', 'value').map((item) => Number(item));
}

function getSelectedWorkCenters() {
    return $('#work_centers_select').multipleSelect('getSelects', 'value').map((item) => Number(item));
}

function getSelectedEventTypes() {
    return $('#event_types_select').multipleSelect('getSelects', 'value').map((item) => Number(item));
}

$(document).on('submit', '#filter_form', function(e) {
    e.preventDefault();
    refreshCalendar();
});

document.addEventListener('DOMContentLoaded', async function() {
    try {
        await initFilters();
        initCalendar();
    } catch(e) {
        console.error(e);
    }
});