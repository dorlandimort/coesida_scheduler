function initDatatable() {
    $("#event_types_datatable").dataTable({
        language: datatables_es,
        autoWidth: true,
        pageLength: 50,
        lengthChange: false,
        info: false,
        serverSide: true,
        processing: true,
        pagingType: 'numbers',
        ajax: $("#event_types_datatable").data('source'),
        order: [[0, 'asc']],
        columns: [
            { data: 'name'},
            { data: 'description'},
            {
                data: 'color',
                render: function(data, type, row) {
                    if (type === 'display') {
                        data = '<button class="btn btn-default btn-sm" style="background-color: ' + row.color + ';">&nbsp;&nbsp;&nbsp;</button>'
                    }
                    return data;
                }
            },
            {
                data: 'id', searchable: false, sortable: false,
                render: function(data, type, row) {
                    if (type === 'display') {
                        data = '<a href="' + row.link + '" class="btn btn-warning btn-xs btn-edit-event-type" data-id="' + row.id + '"><i class="fa fa-edit white"></i> Editar </a>\n';
                    }
                    return data;
                }
            }
        ]
    });
}

$(document).ready(function () {
    initDatatable();
});