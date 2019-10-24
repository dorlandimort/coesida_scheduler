function initDatatable() {
    $("#users_datatable").dataTable({
        language: datatables_es,
        autoWidth: true,
        pageLength: 50,
        lengthChange: false,
        info: false,
        serverSide: true,
        processing: true,
        pagingType: 'numbers',
        ajax: $("#users_datatable").data('source'),
        order: [[0, 'asc']],
        columns: [
            { data: 'first_name'},
            { data: 'last_name' },
            { data: 'mother_last_name' },
            { data: 'email'},
            { data: 'role_name' },
            {
                data: 'id', searchable: false, sortable: false,
                render: function(data, type, row) {
                    if (type === 'display') {
                        data = '<a href="' + row.link + '" class="btn btn-warning btn-xs btn-edit-user"><i class="fa fa-edit white"></i> Editar </a>\n';
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