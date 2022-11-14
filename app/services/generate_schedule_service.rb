class GenerateScheduleService < ApplicationService
  def initialize(service, days_hash)
    @service = service
    @weeks_range = calculate_range
    @week_days = Service::WEEK_DAYS
    @days_hash = days_hash
  end

  def call
    @weeks_range.each do |week|
      create_week_schedule(week)
    end
  end

  def create_week_schedule(week)
    @week_days.each do |day|
      sch_day = ScheduleDay.new
      sch_day.week = week
      sch_day.service = @service
      sch_day.week_day = day
      sch_day.date = calculate_date_by_week(week, day)

      hours = @days_hash[day.to_s] || @days_hash[day.to_s.to_sym]
      if hours.present?
        sch_day.active = true
        (sch_day.begin_time, sch_day.end_time) = hours
      end

      sch_day.save
    end
  end

  private

  def calculate_date_by_week(week, week_day)
    @service.init_date + week_day + ((week - 1) * @week_days.size)
  end

  def calculate_range
    n_weeks = @service.number_of_weeks
    (1..n_weeks).to_a
  end
end
