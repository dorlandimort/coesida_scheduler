function initDatatable() {
    $("#receptionists_datatable").dataTable({
        language: datatables_es,
        autoWidth: true,
        pageLength: 50,
        lengthChange: false,
        info: false,
        serverSide: true,
        processing: true,
        pagingType: 'numbers',
        ajax: $("#receptionists_datatable").data('source'),
        order: [[0, 'asc']],
        columns: [
            { data: 'first_name'},
            { data: 'last_name' },
            { data: 'mother_last_name' },
            { data: 'work_center'},
            {
                data: 'id', searchable: false, sortable: false,
                render: function(data, type, row) {
                    if (type === 'display') {
                        data = '<a href="' + row.link + '" class="btn btn-warning btn-xs btn-edit-receptionist"><i class="fa fa-edit white"></i> Editar </a>\n' +
                            '<a href="javascript:void(0);" class="btn btn-danger btn-xs btn-remove-receptionist" data-id="' + row.id +  '"><i class="fa fa-trash white"></i> Eliminar </a>\n';
                    }
                    return data;
                }
            }
        ]
    });
}

$(document).on('click', '.btn-remove-receptionist', async function () {
   const isConfirmed = await askConfirmation();
   if (isConfirmed) {
       try {
           const id = $(this).data('id');
           await FetchP.delete(`/receptionists/${id}`, {}, 'json');
           $("#receptionists_datatable").DataTable().ajax.reload();
       } catch(e) {
           console.error(e);
       }
   }
});

async function askConfirmation() {
    return new Promise((resolve) => {
        bootbox.confirm({
            message: 'Está seguro de que desea eliminar este elemento? Esta acción no puede ser revertida.',
            buttons: {
                confirm: {
                    label: "Si, quiero eliminarlo",
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-default'
                }
            },
            callback: function(result) {
                resolve(result);
            }
        })
    });
}

$(document).ready(function () {
    initDatatable();
});