class ServiceSerializer < Panko::Serializer
  attributes :id, :name, :weeks

  def weeks
    object.weeks
  end

  def name
    "#{object.company.name} - #{object.name}"
  end
end
