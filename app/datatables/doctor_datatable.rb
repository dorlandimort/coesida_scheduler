class DoctorDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :edit_doctor_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super(params)
  end

  def view_columns
    @view_columns ||= {
        id: { source: "Doctor.id", cond: :eq },
        first_name: { source: "User.first_name", cond: :like },
        last_name: { source: "User.last_name", cond: :like },
        mother_last_name: { source: "User.mother_last_name", cond: :like },
        cedula: { source: "Doctor.cedula" },
        work_center: { source: "WorkCenter.name" }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        first_name: record.user&.first_name,
        last_name: record.user&.last_name,
        mother_last_name: record.user&.mother_last_name,
        status: record.status,
        cedula: record.cedula,
        work_center: record.work_center&.name,
        link: edit_doctor_path(record)
      }
    end
  end

  def get_raw_records
    Doctor.all.joins(:user, :work_center).order('users.last_name, users.mother_last_name, users.first_name')
  end
end
