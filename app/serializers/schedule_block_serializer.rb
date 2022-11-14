class ScheduleBlockSerializer < Panko::Serializer
  attributes :id, :hour, :label, :status

  has_many :users, each_serializer: UserSerializer, name: :available_agents
  has_one :assigned_agent, serializer: UserSerializer
end
