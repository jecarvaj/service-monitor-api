class ScheduleBlock < ApplicationRecord
  belongs_to :schedule_day
  has_and_belongs_to_many :users
  belongs_to :assigned_agent, class_name: 'User', foreign_key: 'user_id', optional: true
  has_one :service, through: :schedule_day

  before_create :set_label

  def set_label
    init_block = Time.now.change(hour: hour)
    end_block = init_block.advance(hours: 1)
    self.label = "#{init_block.strftime('%H:00')}-#{end_block.strftime('%H:00')}"
  end

  def next
    return nil if hour.zero?

    ScheduleBlock.where(schedule_day_id: schedule_day_id, hour: hour + 1).first
  end

  def previous
    return nil if hour == 1

    ScheduleBlock.where(schedule_day_id: schedule_day_id, hour: hour - 1).first
  end
end
