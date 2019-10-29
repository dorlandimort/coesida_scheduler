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
        slotDuration: '00:30:00', // 30 minutes
        minTime: '07:00:00',
        maxTime: '21:00:00',
        defaultView: 'timeGridWeek',
        droppable: true,
        eventStartEditable: true,
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
        eventReceive: function(data) {
            submitNewEvent(data.event);
        },
        eventClick: function(data) {
            showUpdateModal(data.event);
        },
        eventDrop: function(data) {
            updateEventTime(data.event);
        },
        events: $("#base_url_json").val()
    });
    calendar.render();
    initDraggables();
    window.calendar = calendar;
}

function initDraggables() {
    const draggables = document.getElementsByClassName('event-draggable');
    for (let draggable of draggables) {
        new FullCalendarInteraction.Draggable(draggable, {
            eventData: function(el) {
                return {
                    title: el.dataset.title,
                    duration: el.dataset.duration,
                    color: el.dataset.color,
                    textColor: el.dataset.textColor,
                    overlap: false,
                    eventTypeId: el.dataset.eventTypeId,
                    create: true
                }
            }
        });
    }
}

function initEventForm() {
    $("#event_form").validate({
        errorClass: 'text-danger'
    });
}

function getEventData() {
    return {
        event: {
            id: $("#event_id").val(),
            title: $("#event_title").val(),
            description: $("#event_description").val(),
            event_type_id: $("#event_event_type_id").val(),
            assigned_to_id: $("#event_assigned_to_id").val()
        }
    };
}

function getDataFromEvent(event) {
    return {
        event: {
            title: event.title,
            starts_at: moment(event.start).format('YYYY-MM-DD HH:mm'),
            ends_at: moment(event.end).format('YYYY-MM-DD HH:mm'),
            event_type_id: event.extendedProps.eventTypeId
        }
    }
}

function refreshCalendar() {
    window.calendar.refetchEvents();
}

function removeMirrorEvent() {
    const event = window.calendar.getEventById('');
    if (event) {
        event.remove();
    }
}

async function showUpdateModal(event) {
    const baseUrl = $("#base_url").val();
    const markup = await FetchP.get(`${baseUrl}/${event.id}/edit`, {}, '');
    $("#event-modal .modal-body").html(markup);
    $("#event-modal").modal('show');
    initEventForm();
}

async function submitNewEvent(event) {
    try {
        freezeUI();
        const url = $("#base_url").val();
        const eventData = getDataFromEvent(event);
        const savedEvent = await FetchP.post(url, eventData, 'json');
        removeMirrorEvent();
        refreshCalendar();
        await showUpdateModal(savedEvent);
    } catch(e) {
        showErrorNotification(e);
    } finally {
        unFreezUI();
    }
}

async function updateEventTime(event) {
    try {
        freezeUI();
        const url = $("#base_url").val();
        const eventData = getDataFromEvent(event);
        await FetchP.put(`${url}/${event.id}`, eventData, 'json');
        refreshCalendar();
    } catch(e) {
        showErrorNotification(e);
    } finally {
        unFreezUI();
    }
}

async function deleteEvent(id) {
    try {
        freezeUI();
        const url = $("#base_url").val();
        await FetchP.delete(`${url}/${id}`, {}, 'json');
        refreshCalendar();
        $("#event-modal").modal('hide');
    } catch(e) {
        console.error(e);
        showErrorNotification(e);
    } finally {
        unFreezUI();
    }
}

$(document).on('submit', '#event_form', async function(e) {
    e.preventDefault();
    if ($(this).valid()) {
        try {
            freezeUI();
            const eventData = getEventData();
            const baseUrl = $("#base_url").val();
            const url = `${baseUrl}/${eventData.event.id}`;
            await FetchP.put(url, eventData, 'json');
            refreshCalendar();
            $("#event-modal").modal('hide');
        } catch(e) {
            console.error(e);
        } finally {
            unFreezUI();
        }
    } else console.log('invalid');
});

$(document).on('click', '#btn-delete-event', function() {
   const id = $(this).data('id');
   bootbox.confirm({
        message: '¿Está seguro de eliminar este elemento? Esta acción no se puede revertir.',
       buttons: {
            confirm: {
                label: 'Si, quiero eliminarlo',
                className: 'btn-danger'
            },
           cancel: {
                label: 'Cancelar',
                className: 'btn-default'
           },
       },
       callback: function(result) {
           if (result) {
               deleteEvent(id);
           }
       }
   });
});

document.addEventListener('DOMContentLoaded', function() {
    initCalendar();
    const ps = new PerfectScrollbar('.am-scroller-aside');
});