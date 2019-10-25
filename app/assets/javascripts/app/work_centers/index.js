function initDatatable() {
    $("#work_centers_datatable").dataTable({
        language: datatables_es,
        autoWidth: true,
        pageLength: 50,
        lengthChange: false,
        info: false,
        serverSide: true,
        processing: true,
        pagingType: 'numbers',
        ajax: $("#work_centers_datatable").data('source'),
        order: [[0, 'asc']],
        columns: [
            { data: 'name'},
            { data: 'short_name' },
            { data: 'address' },
            { data: 'status'},
            {
                data: 'id', searchable: false, sortable: false,
                render: function(data, type, row) {
                    if (type === 'display') {
                        data = '<a href="' + row.link + '" class="btn btn-warning btn-xs"><i class="fa fa-edit white"></i> Editar </a>\n';
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