class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  scope :agents, -> { where(is_admin: false) }

  has_and_belongs_to_many :schedule_blocks

  before_create :set_color

  COLORS = %w[#D2691E75 #FFFF0075 #00808075 #FFA07A75 #FFEFD575 #B0C4DE75].freeze

  def set_color
    taken_colors = User.agents.pluck(:color).uniq
    color = (COLORS - taken_colors).sample || COLORS.sample
    self.color = color
  end
end
