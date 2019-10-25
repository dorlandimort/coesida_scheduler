class WorkCenterDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :edit_work_center_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super(params)
  end

  def view_columns
    @view_columns ||= {
      id: { source: "WorkCenter.id", cond: :eq },
      name: { source: "WorkCenter.name" },
      short_name: { source: "WorkCenter.short_name" },
      address: { source: "WorkCenter.address" },
      status: { source: "WorkCenter.status" }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        short_name: record.short_name,
        address: record.address,
        status: record.status_text,
        link: edit_work_center_path(record)
      }
    end
  end

  def get_raw_records
    WorkCenter.all
  end

end
