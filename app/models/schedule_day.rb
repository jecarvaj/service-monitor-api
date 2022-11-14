class ScheduleDay < ApplicationRecord
  belongs_to :service
  has_many :schedule_blocks, dependent: :destroy

  scope :by_week, ->(week) { where(week: week) }
  scope :five_weeks_from_now, -> { where('date <= ?', 5.weeks.since) }

  after_create :create_schedule_blocks

  WEEK_DAY_NAMES = %w[Lunes Martes Miércoles Jueves Viernes Sábado Domingo].freeze
  MONTH_NAMES = %w[enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre].freeze

  def create_schedule_blocks
    return unless active

    real_end = end_time.zero? ? 24 : end_time
    (begin_time..(real_end - 1)).to_a.each do |hour|
      block = schedule_blocks.build
      block.hour = hour
      block.save
    end
  end

  def block_by_hour(hour)
    schedule_blocks.where(hour: hour).first
  end
end
