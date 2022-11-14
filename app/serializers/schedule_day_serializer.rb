class ScheduleDaySerializer < Panko::Serializer
  attributes :week, :week_day, :active, :label, :date

  has_many :schedule_blocks, each_serializer: ScheduleBlockSerializer

  def label
    "#{ScheduleDay::WEEK_DAY_NAMES[object.week_day]} #{object.date.day}
    de #{ScheduleDay::MONTH_NAMES[object.date.month - 1]}"
  end
end
