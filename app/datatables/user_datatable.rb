class UserDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :edit_user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super(params)
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "User.id", cond: :eq },
      email: { source: "User.email" },
      first_name: { source: "User.first_name", cond: :like },
      last_name: { source: "User.last_name" },
      mother_last_name: { source: "User.mother_last_name" },
      role_name: { source: "Role.name" }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        mother_last_name: record.mother_last_name,
        email: record.email,
        role_name: record.roles&.first&.name,
        link: edit_user_path(record)
      }
    end
  end

  def get_raw_records
    User.all.joins(:roles)
  end

end
