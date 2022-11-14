class UserSerializer < Panko::Serializer
  attributes :id, :email, :name, :color, :is_admin

  def name
    "#{object.first_name} #{object.last_name}"
  end
end
