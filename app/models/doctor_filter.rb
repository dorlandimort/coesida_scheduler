class DoctorFilter

  def self.build_select_data(work_centers_ids)
    work_centers = WorkCenter.includes(:doctors).where(id: work_centers_ids).order(:name)
    work_centers.map do |work_center|
      {
          type: 'optgroup',
          label: work_center.name,
          children: work_center.doctors.map do |doctor|
            {
                text: doctor.user.full_name,
                value: doctor.user.id,
                selected: true
            }
          end
      }
    end
  end
end