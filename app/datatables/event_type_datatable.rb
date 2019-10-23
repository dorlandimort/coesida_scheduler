class EventTypeDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :edit_event_type_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super(params)
  end

  def view_columns
    @view_columns ||= {
      id: { source: "EventType.id", cond: :eq },
      name: { source: "EventType.name", cond: :like },
      description: { source: "EventType.description", cond: :like },
      color: { source: "EventType.color", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        description: record.description,
        color: record.color,
        link: edit_event_type_path(record)
      }
    end
  end

  def get_raw_records
    EventType.all
  end

end
