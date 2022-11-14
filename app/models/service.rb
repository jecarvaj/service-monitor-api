class Service < ApplicationRecord
  belongs_to :company
  has_many :schedule_days, dependent: :destroy
  has_many :schedule_blocks, through: :schedule_days

  WEEK_DAYS = (0..6).to_a.freeze

  def weeks
    schedule_days.five_weeks_from_now.pluck(:week).uniq.map { |d| { week: d, label: week_label(d) } }
  end

  def days_by_week(week)
    schedule_days.by_week(week)
  end

  def week_label(week)
    days = days_by_week(week)
    "#{format_date(days.first.date)} al #{format_date(days.last.date)}"
  end

  def format_date(date)
    date.strftime('%d-%m-%Y')
  end

  def number_of_weeks
    ((end_date - init_date).to_f / WEEK_DAYS.size).ceil
  end
end
